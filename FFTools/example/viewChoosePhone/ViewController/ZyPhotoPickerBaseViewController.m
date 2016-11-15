//
//  ZyPhotoPickerBaseViewController.m
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//

#import "ZYPhotoPickerBaseViewController.h"
#import "ZYImagePickerViewController.h"

@interface ZYPhotoPickerBaseViewController ()

@end

@implementation ZYPhotoPickerBaseViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self didRotateFromInterfaceOrientation:self.interfaceOrientation];
    NSUInteger maxSelectNumber = 3;
#warning TODO
    self.maxSelectNumber = maxSelectNumber > 0 ? maxSelectNumber : LONG_MAX;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = self.rightCloseButton;
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)closeSelf:(id)sender {
    [self.naviController dismissViewControllerAnimated:YES completion:nil];
}

- (ZYImagePickerViewController *)naviController {
    return (ZYImagePickerViewController *)self.navigationController;
}

- (UIBarButtonItem *)rightCloseButton {
    if (!_rightCloseButton){
        _rightCloseButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(closeSelf:)];
    }
    return _rightCloseButton;
}

@end
