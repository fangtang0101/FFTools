//
//  ZYImagePickerViewController.m
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//
#import "FFRootView.h"
#import "ZYImagePickerViewController.h"
#import "ZYPhotoAlbumListViewController.h"

@interface ZYImagePickerViewController ()
@property (nonatomic, strong) ZYPhotoAlbumListViewController *albumListController;
@end

@implementation ZYImagePickerViewController

- (instancetype)init{
    self = [super initWithRootViewController:self.albumListController];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏样式
    [self settingNavigationBar];
}

- (void)settingNavigationBar{
    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#49484C" alpha:.95]] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:19]};

    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (ZYPhotoAlbumListViewController *)albumListController {
    if (!_albumListController){
        _albumListController = [[ZYPhotoAlbumListViewController alloc]init];
    }
    return _albumListController;
}

@end
