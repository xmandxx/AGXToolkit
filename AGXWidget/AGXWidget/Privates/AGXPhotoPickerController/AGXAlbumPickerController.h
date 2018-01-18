//
//  AGXAlbumPickerController.h
//  AGXWidget
//
//  Created by Char Aznable on 2018/1/17.
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

#ifndef AGXWidget_AGXAlbumPickerController_h
#define AGXWidget_AGXAlbumPickerController_h

#import <UIKit/UIKit.h>
#import <AGXCore/AGXCore/AGXArc.h>
#import "AGXPhotoModel.h"

@protocol AGXAlbumPickerControllerDataSource;
@protocol AGXAlbumPickerControllerDelegate;

@interface AGXAlbumPickerController : UIViewController
@property (nonatomic, AGX_WEAK) id<AGXAlbumPickerControllerDataSource> dataSource;
@property (nonatomic, AGX_WEAK) id<AGXAlbumPickerControllerDelegate> delegate;
@property (nonatomic, copy)     UIColor *selectedCountColor; // default 4cd864
@end

@protocol AGXAlbumPickerControllerDataSource <NSObject>
@required
- (NSArray<AGXAssetModel *> *)albumPickerControllerSelectedModels:(AGXAlbumPickerController *)albumPicker;
@end

@protocol AGXAlbumPickerControllerDelegate <NSObject>
@required
- (void)albumPickerControllerDidCancel:(AGXAlbumPickerController *)albumPicker;
- (void)albumPickerController:(AGXAlbumPickerController *)albumPicker didSelectAlbumModel:(AGXAlbumModel *)albumModel;
@end

#endif /* AGXWidget_AGXAlbumPickerController_h */