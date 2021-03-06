//
//  AGXAssetPickerController.h
//  AGXWidget
//
//  Created by Char Aznable on 2018/1/19.
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

#ifndef AGXWidget_AGXAssetPickerController_h
#define AGXWidget_AGXAssetPickerController_h

#import "AGXPhotoCommon.h"
#import "AGXPhotoModel.h"

@class AGXAssetPickerController;

@protocol AGXAssetPickerControllerDelegate <NSObject, AGXPhotoPickerSubControllerDelegate>
@required
- (void)assetPickerController:(AGXAssetPickerController *)assetPicker didSelectIndex:(NSInteger)index inAssetModels:(NSArray<AGXAssetModel *> *)assetModels;
@end

@interface AGXAssetPickerController : AGXPhotoPickerSubController
@property (nonatomic, AGX_WEAK)     id<AGXAssetPickerControllerDelegate> delegate;
@property (nonatomic, AGX_STRONG)   AGXAlbumModel *albumModel;
@property (nonatomic, assign)       NSUInteger columnNumber; // default 4
@property (nonatomic, assign)       BOOL allowPickingVideo; // default NO
@property (nonatomic, assign)       BOOL allowPickingGif; // default NO
@property (nonatomic, assign)       BOOL allowPickingLivePhoto; // default NO
@property (nonatomic, assign)       BOOL sortByCreateDateDescending; // default NO
@property (nonatomic, assign)       BOOL allowAssetPreviewing; // default YES
@property (nonatomic, assign)       CGFloat pickingImageScale; // default UIScreen.mainScreen.scale
@property (nonatomic, assign)       CGSize pickingImageSize; // default UIScreen.mainScreen.bounds.size
@end

#endif /* AGXWidget_AGXAssetPickerController_h */
