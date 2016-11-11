//
//  FFToastViewController.m
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFToastWidget.h"
#import "FFToastViewController.h"

@interface FFToastViewController ()

@end

@implementation FFToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一个toast自述";
    [FFToastWidget showToastMessage:@"我是一个 toast" ];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FFToastWidget showToastMessage:@"我是一个 toast,此时我应该会是很长很长的一段文字，不知道说些什么，哈哈，应该是会自动换行的，主要用于简单的提示语" during:FFToastDurationLong];
    });
}


@end
