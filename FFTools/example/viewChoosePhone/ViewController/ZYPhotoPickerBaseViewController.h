//
//  ZyPhotoPickerBaseViewController.h
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYImagePickerViewController;
@interface ZYPhotoPickerBaseViewController : UIViewController
{
    @protected
    NSUInteger haveSelectedNumber;
}
@property (nonatomic, strong) ZYImagePickerViewController *naviController;
@property (nonatomic, strong) UIBarButtonItem *rightCloseButton;
@property (nonatomic, assign) NSUInteger maxSelectNumber;

@end
