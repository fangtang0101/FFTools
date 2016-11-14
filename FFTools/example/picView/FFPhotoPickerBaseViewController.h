//
//  FFPhotoPickerBaseViewController.h
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFImagePickerViewController.h"
@interface FFPhotoPickerBaseViewController : UIViewController

{
@protected
    NSUInteger haveSelectedNumber;
}
@property (nonatomic, strong) FFImagePickerViewController *naviController;
@property (nonatomic, strong) UIBarButtonItem *rightCloseButton;
@property (nonatomic, assign) NSUInteger maxSelectNumber;


@end
