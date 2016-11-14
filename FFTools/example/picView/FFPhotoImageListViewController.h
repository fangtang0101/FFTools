//
//  FFPhotoImageListViewController.h
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFPhotoPickerBaseViewController.h"

@class FFPhotoAlbumModel;
@interface FFPhotoImageListViewController : FFPhotoPickerBaseViewController
@property (nonatomic, strong) FFPhotoAlbumModel *model;
@end
