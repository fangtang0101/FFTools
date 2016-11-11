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
    
    [FFToastWidget showToastMessage:@"我是一个 toast，" ];
    
}


@end
