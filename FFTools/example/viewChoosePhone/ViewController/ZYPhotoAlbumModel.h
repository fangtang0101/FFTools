//
//  ZYPhotoAlbumModel.h
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class ZYPhotoAlAssetModel;

@interface ZYPhotoAlbumModel: NSObject
@property (nonatomic, copy) NSData *thumbImageData;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, assign) NSInteger albumCount;
@property (nonatomic, strong) NSMutableArray *photoArray;

@end

@interface ZYPhotoAlAssetModel: NSObject
@property (nonatomic, copy) NSURL *photoURL;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, strong) UIImage *thumbsImage;
@property (nonatomic, strong) UIImage *detailImage;
@property (nonatomic, assign) NSInteger oriaginalSize;

@end
