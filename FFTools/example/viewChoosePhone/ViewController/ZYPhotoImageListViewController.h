//
//  ZYPhotoImageListViewController.h
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//

#import "ZYPhotoPickerBaseViewController.h"

@class ZYPhotoAlbumModel;
@interface ZYPhotoImageListViewController :ZYPhotoPickerBaseViewController
@property (nonatomic, strong) ZYPhotoAlbumModel *model;

@end
