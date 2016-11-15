//
//  ZYPhotoPreviewController.h
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//

#import "ZYPhotoPickerBaseViewController.h"

@interface ZYPhotoPreviewController : ZYPhotoPickerBaseViewController
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic, assign, getter=isSelectedMode) BOOL selectedMode;
@end
