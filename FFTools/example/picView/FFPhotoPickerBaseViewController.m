//
//  FFPhotoPickerBaseViewController.m
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFPhotoPickerBaseViewController.h"

@interface FFPhotoPickerBaseViewController ()

@end

@implementation FFPhotoPickerBaseViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self didRotateFromInterfaceOrientation:self.interfaceOrientation];
#warning TODO
    NSUInteger maxSelectNumber = 3;
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

- (FFImagePickerViewController *)naviController {
    return (FFImagePickerViewController *)self.navigationController;
}

- (UIBarButtonItem *)rightCloseButton {
    if (!_rightCloseButton){
        _rightCloseButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(closeSelf:)];
    }
    return _rightCloseButton;
}

@end
