//
//  AGXImageManager.m
//  AGXWidget
//
//  Created by Char Aznable on 2018/1/16.
//  Copyright © 2018年 AI-CUC-EC. All rights reserved.
//

//
//  Modify from:
//  banchichen/TZImagePickerController
//

//  The MIT License (MIT)
//
//  Copyright (c) 2016 Zhen Tan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <AGXCore/AGXCore/AGXAdapt.h>
#import <AGXCore/AGXCore/AGXDirectory.h>
#import <AGXCore/AGXCore/NSObject+AGXCore.h>
#import <AGXCore/AGXCore/NSString+AGXCore.h>
#import <AGXCore/AGXCore/NSDate+AGXCore.h>
#import <AGXCore/AGXCore/UIImage+AGXCore.h>
#import "AGXImageManager.h"
#import "AGXWidgetLocalization.h"

#define AGXAssetImageScale (MIN([UIScreen mainScreen].scale, 2.0))

static const NSInteger PHAssetCollectionSubtypeSmartAlbumDeleted_AGX = 1000000201;

@singleton_implementation(AGXImageManager)

+ (PHAuthorizationStatus)authorizationStatus {
    if (PHAuthorizationStatusNotDetermined == [PHPhotoLibrary authorizationStatus]) {
        dispatch_semaphore_t semaphore_t = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_semaphore_signal(semaphore_t);
            }];
        });
        dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
    }
    return [PHPhotoLibrary authorizationStatus];
}

- (AGX_INSTANCETYPE)init {
    if (PHAuthorizationStatusAuthorized !=
        [AGXImageManager authorizationStatus]) return nil;

    if AGX_EXPECT_T(self = [super init]) {
        _assetMinSize = CGSizeMake(0, 0);
        _assetMaxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        CGFloat thumbWH = (AGX_ScreenWidth-12)/4*AGXAssetImageScale;
        _assetThumbSize = CGSizeMake(thumbWH, thumbWH);
    }
    return self;
}

- (void)dealloc {
    _delegate = nil;
    AGX_SUPER_DEALLOC;
}

#pragma mark - fetch methods

- (NSArray<AGXAlbumModel *> *)allAlbums {
    NSArray *albums = @[[PHAssetCollection fetchAssetCollectionsWithType:
                         PHAssetCollectionTypeAlbum subtype:
                         PHAssetCollectionSubtypeAlbumMyPhotoStream options:nil],

                        [PHAssetCollection fetchAssetCollectionsWithType:
                         PHAssetCollectionTypeSmartAlbum subtype:
                         PHAssetCollectionSubtypeAlbumRegular options:nil],

                        [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil],

                        [PHAssetCollection fetchAssetCollectionsWithType:
                         PHAssetCollectionTypeAlbum subtype:
                         PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil],

                        [PHAssetCollection fetchAssetCollectionsWithType:
                         PHAssetCollectionTypeAlbum subtype:
                         PHAssetCollectionSubtypeAlbumCloudShared options:nil]];
    NSMutableArray *allAlbums = NSMutableArray.instance;

    BOOL delegateResponds = [self.delegate respondsToSelector:
                             @selector(imageManager:canSelectAlbumWithName:fetchResultAssets:)];
    for (PHFetchResult<PHAssetCollection *> *fetchResult in albums) {
        for (PHAssetCollection *collection in fetchResult) {
            if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
            if (PHAssetCollectionSubtypeSmartAlbumAllHidden == collection.assetCollectionSubtype ||
                PHAssetCollectionSubtypeSmartAlbumDeleted_AGX == collection.assetCollectionSubtype) continue;

            PHFetchResult<PHAsset *> *fetchResult = [PHAsset fetchAssetsInAssetCollection:
                                                     collection options:[self prepareFetchOptions]];
            if (fetchResult.count < 1) continue;
            NSString *albumName = collection.localizedTitle;

            if (delegateResponds && ![self.delegate imageManager:self canSelectAlbumWithName:
                                      albumName fetchResultAssets:fetchResult]) continue;

            if ([self isCameraRollAlbum:collection]) {
                [allAlbums insertObject:
                 [AGXAlbumModel albumModelWithName:albumName
                                 fetchResultAssets:fetchResult] atIndex:0];
            } else {
                [allAlbums addObject:
                 [AGXAlbumModel albumModelWithName:albumName
                                 fetchResultAssets:fetchResult]];
            }
        }
    }
    return AGX_AUTORELEASE([allAlbums copy]);
}

- (AGXAlbumModel *)cameraRollAlbum {
    PHFetchResult<PHAssetCollection *> *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:
                                                       PHAssetCollectionTypeSmartAlbum subtype:
                                                       PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
        if (![self isCameraRollAlbum:collection]) continue;

        return [AGXAlbumModel albumModelWithName:collection.localizedTitle fetchResultAssets:
                [PHAsset fetchAssetsInAssetCollection:collection options:[self prepareFetchOptions]]];
    }
    return nil;
}

- (NSArray<AGXAssetModel *> *)allAssetsFromAlbum:(AGXAlbumModel *)album {
    return [self allAssetsFromFetchResult:album.result];
}

- (NSArray<AGXAssetModel *> *)allAssetsFromFetchResult:(PHFetchResult<PHAsset *> *)fetchResult {
    NSMutableArray *allAssets = NSMutableArray.instance;
    BOOL delegateResponds = [self.delegate respondsToSelector:@selector(imageManager:canSelectAsset:)];
    for (PHAsset *asset in fetchResult) {
        if (delegateResponds && ![self.delegate imageManager:self canSelectAsset:asset]) continue;

        AGXAssetModelMediaType mediaType = [self mediaTypeOfAsset:asset];
        if (!_allowPickingVideo && AGXAssetModelMediaTypeVideo == mediaType) continue;

        if (_hideWhenSizeUnfit && ![self isSizeFitAsset:asset]) continue;

        NSString *timeLength = (AGXAssetModelMediaTypeVideo == mediaType ?
                                [self formatTimeLengthOfAsset:asset] : nil);
        [allAssets addObject:
         [AGXAssetModel assetModelWithAsset:asset
                                  mediaType:mediaType timeLength:timeLength]];
    }
    return AGX_AUTORELEASE([allAssets copy]);
}

- (PHImageRequestID)imageForAsset:(PHAsset *)asset completion:(AGXImageManagerImageHandler)completion {
    return [self imageForAsset:asset width:0 completion:completion];
}

- (PHImageRequestID)imageForAsset:(PHAsset *)asset completion:(AGXImageManagerImageHandler)completion progressHandler:(AGXImageManagerProgressHandler)progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed {
    return [self imageForAsset:asset width:0 completion:completion progressHandler:progressHandler networkAccessAllowed:networkAccessAllowed];
}

- (PHImageRequestID)imageForAsset:(PHAsset *)asset width:(CGFloat)width completion:(AGXImageManagerImageHandler)completion {
    return [self imageForAsset:asset width:width completion:completion progressHandler:nil networkAccessAllowed:YES];
}

- (PHImageRequestID)imageForAsset:(PHAsset *)asset width:(CGFloat)width completion:(AGXImageManagerImageHandler)completion progressHandler:(AGXImageManagerProgressHandler)progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed {
    CGSize imageSize = [self imageSizeForAsset:asset width:width];
    __block UIImage *image;
    PHImageRequestOptions *option = PHImageRequestOptions.instance;
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    return [PHImageManager.defaultManager requestImageForAsset:asset targetSize:
            imageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:
            ^(UIImage *result, NSDictionary *info) {
                if (result) image = result;

                BOOL downloadFinined = (![info[PHImageCancelledKey] boolValue] && !info[PHImageErrorKey]);
                if (downloadFinined && result) {
                    !completion?:completion([UIImage imageFixedOrientation:result], info,
                                            [info[PHImageResultIsDegradedKey] boolValue]);
                }
                // Download image from iCloud
                if (info[PHImageResultIsInCloudKey] && !result && networkAccessAllowed) {
                    PHImageRequestOptions *options = PHImageRequestOptions.instance;
                    options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                        agx_async_main(!progressHandler?:progressHandler(progress, error, stop, info);)
                    };
                    options.networkAccessAllowed = YES;
                    options.resizeMode = PHImageRequestOptionsResizeModeFast;
                    [PHImageManager.defaultManager requestImageDataForAsset:asset options:options resultHandler:
                     ^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                         UIImage *resultImage = [UIImage image:[UIImage imageWithData:imageData scale:0.1]
                                                   scaleToSize:imageSize] ?: image;
                         !completion?:completion([UIImage imageFixedOrientation:resultImage], info, NO);
                     }];
                }
            }];
}

- (PHImageRequestID)coverImageForAlbum:(AGXAlbumModel *)album width:(CGFloat)width completion:(void (^)(UIImage *image))completion {
    PHAsset *asset = _sortByCreateDateDescending ? album.result.firstObject : album.result.lastObject;
    return [self imageForAsset:asset width:width completion:
            ^(UIImage *image, NSDictionary *info, BOOL isDegraded) {
                !completion?:completion(image);
            }];
}

- (PHImageRequestID)originalImageForAsset:(PHAsset *)asset completion:(AGXImageManagerImageHandler)completion {
    PHImageRequestOptions *option = PHImageRequestOptions.instance;
    option.networkAccessAllowed = YES;
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    return [PHImageManager.defaultManager requestImageForAsset:asset targetSize:
            PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:
            ^(UIImage *result, NSDictionary *info) {
                if ([info[PHImageCancelledKey] boolValue] || info[PHImageErrorKey] || !result) return;
                !completion?:completion([UIImage imageFixedOrientation:result], info,
                                        [info[PHImageResultIsDegradedKey] boolValue]);
            }];
}

- (PHImageRequestID)originalImageDataForAsset:(PHAsset *)asset completion:(AGXImageManagerImageDataHandler)completion {
    PHImageRequestOptions *option = PHImageRequestOptions.instance;
    option.networkAccessAllowed = YES;
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    return [PHImageManager.defaultManager requestImageDataForAsset:asset options:option resultHandler:
            ^(NSData *data, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                if ([info[PHImageCancelledKey] boolValue] || info[PHImageErrorKey] || !data) return;
                !completion?:completion(data, info, NO);
            }];
}

- (void)saveImage:(UIImage *)image completion:(void (^)(NSError *error))completion {
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        request.creationDate = [NSDate date];
    } completionHandler:^(BOOL success, NSError *error) {
        agx_async_main(!completion?:completion
                       (success?nil:
                        (error?:[NSError errorWithDomain:@"com.agxwidget.saveimageerrordomain"
                                                    code:-1 userInfo:nil]));)
    }];
}

- (PHImageRequestID)videoForAsset:(PHAsset *)asset completion:(AGXImageManagerVideoHandler)completion {
    return [self videoForAsset:asset completion:completion progressHandler:nil];
}

- (PHImageRequestID)videoForAsset:(PHAsset *)asset completion:(AGXImageManagerVideoHandler)completion progressHandler:(AGXImageManagerProgressHandler)progressHandler {
    PHVideoRequestOptions *option = PHVideoRequestOptions.instance;
    option.networkAccessAllowed = YES;
    option.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        agx_async_main(!progressHandler?:progressHandler(progress, error, stop, info);)
    };
    return [PHImageManager.defaultManager requestPlayerItemForVideo:asset options:option resultHandler:
            ^(AVPlayerItem *playerItem, NSDictionary *info) { !completion?:completion(playerItem, info); }];
}

- (PHImageRequestID)exportVideoForAsset:(PHAsset *)asset success:(AGXImageManagerVideoExportHandler)success failure:(AGXImageManagerVideoExportFailureHandler)failure {
    return [self exportVideoForAsset:asset presetName:AVAssetExportPreset640x480 success:success failure:failure];
}

- (PHImageRequestID)exportVideoForAsset:(PHAsset *)asset presetName:(NSString *)presetName success:(AGXImageManagerVideoExportHandler)success failure:(AGXImageManagerVideoExportFailureHandler)failure {
    PHVideoRequestOptions *options = PHVideoRequestOptions.instance;
    options.version = PHVideoRequestOptionsVersionOriginal;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    options.networkAccessAllowed = YES;
    return [PHImageManager.defaultManager requestAVAssetForVideo:asset options:options resultHandler:
            ^(AVAsset *avasset, AVAudioMix *audioMix, NSDictionary *info) {
                [self startExportVideoWithVideoAsset:(AVURLAsset *)avasset presetName:presetName
                                             success:success failure:failure];
            }];
}

#pragma mark - private methods

- (PHFetchOptions *)prepareFetchOptions {
    PHFetchOptions *options = PHFetchOptions.instance;
    if (!_allowPickingVideo) options.predicate =
        [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    if (_sortByCreateDateDescending) options.sortDescriptors =
        @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:
           !_sortByCreateDateDescending]];
    return options;
}

- (BOOL)isCameraRollAlbum:(PHAssetCollection *)collection {
    // 8.0.0 ~ 8.0.2
    return (NSOrderedDescending != AGX_SYSTEM_VERSION_COMPARE("8.0.2") ? PHAssetCollectionSubtypeSmartAlbumRecentlyAdded : PHAssetCollectionSubtypeSmartAlbumUserLibrary) == collection.assetCollectionSubtype;
}

- (AGXAssetModelMediaType)mediaTypeOfAsset:(PHAsset *)asset {
    if (asset.mediaType == PHAssetMediaTypeVideo) return AGXAssetModelMediaTypeVideo;
    if (asset.mediaType == PHAssetMediaTypeAudio) return AGXAssetModelMediaTypeAudio;
    if (asset.mediaType == PHAssetMediaTypeImage) {
        // if (asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) return AGXAssetModelMediaTypeLivePhoto;
        if ([[asset valueForKey:@"filename"] hasCaseInsensitiveSuffix:@"GIF"])
            return AGXAssetModelMediaTypeGif;
    }
    return AGXAssetModelMediaTypePhoto;
}

- (BOOL)isSizeFitAsset:(PHAsset *)asset {
    CGSize assetSize = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    return(BETWEEN(assetSize.width, _assetMinSize.width, _assetMaxSize.width) &&
           BETWEEN(assetSize.height, _assetMinSize.height, _assetMaxSize.height));
}

- (NSString *)formatTimeLengthOfAsset:(PHAsset *)asset {
    NSInteger duration = asset.duration;
    if (duration < 10) {
        return [NSString stringWithFormat:@"0:0%zd", duration];
    } else if (duration < 60) {
        return [NSString stringWithFormat:@"0:%zd", duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            return [NSString stringWithFormat:@"%zd:0%zd", min, sec];
        } else {
            return [NSString stringWithFormat:@"%zd:%zd", min, sec];
        }
    }
}

- (CGSize)imageSizeForAsset:(PHAsset *)asset width:(CGFloat)width {
    if (width <= 0) return _assetThumbSize;

    CGFloat aspectRatio = (CGFloat)asset.pixelWidth / (CGFloat)asset.pixelHeight;
    CGFloat pixelWidth = width * AGXAssetImageScale * 1.5;
    pixelWidth = pixelWidth * (aspectRatio > 1.8 ? aspectRatio : (aspectRatio < 0.2 ? 0.5 : 1));
    return CGSizeMake(pixelWidth, pixelWidth / aspectRatio);
}

- (void)startExportVideoWithVideoAsset:(AVURLAsset *)videoAsset presetName:(NSString *)presetName success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure {
    // Find compatible presets by video asset.
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];

    // Begin to compress video
    // Now we just compress to low resolution if it supports
    // If you need to upload to the server, but server does't support to upload by streaming,
    // You can compress the resolution to lower. Or you can support more higher resolution.
    if (![presets containsObject:presetName]) {
        !failure?:failure([NSString stringWithFormat:AGXWidgetLocalizedStringDefault
                           (@"AGXImagePickerController.unsupportedExportPresetFormat",
                            @"Unsupported export preset: %@"), presetName], nil);
        return;
    }

    AVAssetExportSession *session = AGX_AUTORELEASE([[AVAssetExportSession alloc]
                                                     initWithAsset:videoAsset presetName:presetName]);
    NSString *fileName = [NSString stringWithFormat:@"output-%@.mp4",
                          [[NSDate date] stringWithDateFormat:@"yyyy-MM-dd-HH:mm:ss-SSS"]];
    NSString *outputPath = AGXDirectory.temporary.filePath(fileName);
    session.outputURL = [NSURL fileURLWithPath:outputPath];
    // Optimize for network use.
    session.shouldOptimizeForNetworkUse = true;

    NSArray *supportedTypeArray = session.supportedFileTypes;
    if (supportedTypeArray.count == 0) {
        !failure?:failure(AGXWidgetLocalizedStringDefault
                          (@"AGXImagePickerController.unsupportedFileTypes",
                           @"Unsupported file types"), nil);
        return;
    }
    session.outputFileType = ([supportedTypeArray containsObject:AVFileTypeMPEG4]
                              ? AVFileTypeMPEG4 : supportedTypeArray[0]);
    AGXDirectory.temporary.createPathOfFile(fileName);

    AVMutableVideoComposition *videoComposition = [self fixedCompositionWithAsset:videoAsset];
    if (videoComposition.renderSize.width) { session.videoComposition = videoComposition; }

    // Begin to export video to the output path asynchronously.
    [session exportAsynchronouslyWithCompletionHandler:^(void) {
        agx_async_main
        (switch (session.status) {
            case AVAssetExportSessionStatusUnknown: {
                AGXLog(@"AVAssetExportSessionStatusUnknown");
            }   break;
            case AVAssetExportSessionStatusWaiting: {
                AGXLog(@"AVAssetExportSessionStatusWaiting");
            }   break;
            case AVAssetExportSessionStatusExporting: {
                AGXLog(@"AVAssetExportSessionStatusExporting");
            }   break;
            case AVAssetExportSessionStatusCompleted: {
                AGXLog(@"AVAssetExportSessionStatusCompleted");
                !success?:success(outputPath);
            }   break;
            case AVAssetExportSessionStatusFailed: {
                AGXLog(@"AVAssetExportSessionStatusFailed");
                !failure?:failure(AGXWidgetLocalizedStringDefault
                                  (@"AGXImagePickerController.videoExportFailed",
                                   @"Video export failed"), session.error);
            }   break;
            case AVAssetExportSessionStatusCancelled: {
                AGXLog(@"AVAssetExportSessionStatusCancelled");
                !failure?:failure(AGXWidgetLocalizedStringDefault
                                  (@"AGXImagePickerController.videoExportCancelled",
                                   @"Video export cancelled"), nil);
            }   break;
            default: break;
        })
    }];
}

- (AVMutableVideoComposition *)fixedCompositionWithAsset:(AVAsset *)videoAsset {
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    int degrees = [self degressFromVideoFileWithAsset:videoAsset];
    if (0 == degrees) return videoComposition;

    CGAffineTransform translateToCenter;
    CGAffineTransform mixedTransform;
    videoComposition.frameDuration = CMTimeMake(1, 30);
    AVAssetTrack *videoTrack = [videoAsset tracksWithMediaType:AVMediaTypeVideo][0];

    AVMutableVideoCompositionInstruction *roateInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    roateInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, videoAsset.duration);
    AVMutableVideoCompositionLayerInstruction *roateLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];

    if (90 == degrees) { // clockwise90°
        translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0.0);
        mixedTransform = CGAffineTransformRotate(translateToCenter, M_PI_2);
        videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.width);
        [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
    } else if (180 == degrees) { // clockwise180°
        translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
        mixedTransform = CGAffineTransformRotate(translateToCenter, M_PI);
        videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
        [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
    } else if (270 == degrees) { // clockwise270°
        translateToCenter = CGAffineTransformMakeTranslation(0.0, videoTrack.naturalSize.width);
        mixedTransform = CGAffineTransformRotate(translateToCenter, M_PI_2*3.0);
        videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.width);
        [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
    }

    roateInstruction.layerInstructions = @[roateLayerInstruction];
    videoComposition.instructions = @[roateInstruction];
    return videoComposition;
}

- (int)degressFromVideoFileWithAsset:(AVAsset *)asset {
    int degress = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if (tracks.count > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if (0 == t.a && 1.0 == t.b && -1.0 == t.c && 0 == t.d) {
            degress = 90; // Portrait
        } else if (0 == t.a && -1.0 == t.b && 1.0 == t.c && 0 == t.d) {
            degress = 270; // PortraitUpsideDown
        } else if (1.0 == t.a && 0 == t.b && 0 == t.c && 1.0 == t.d) {
            degress = 0; // LandscapeRight
        } else if (-1.0 == t.a && 0 == t.b && 0 == t.c && -1.0 == t.d) {
            degress = 180; // LandscapeLeft
        }
    }
    return degress;
}

@end
