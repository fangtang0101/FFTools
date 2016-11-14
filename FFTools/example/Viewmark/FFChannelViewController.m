//
//  FFChannelViewController.m
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFChannelView.h"
#import "FFChannelViewController.h"

@interface FFChannelViewController ()<FFChannelViewDelegate>

@end

@implementation FFChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"标签 view";
    
    
    NSArray *arraySource = @[@"标签1",@"标签2",@"标签3",@"阿斯顿法国那棵树的",@"爱的色放如果",@"李会计",@"运河",@"热敷的",@"给3",@"上岛咖啡",@"我们",@"你么",@"他么"];
    
    FFChannelView *viewChannel = [[FFChannelView alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    [viewChannel setDataSourceWithArray:arraySource.mutableCopy];
    viewChannel.delegate = self;
    
    [self.view addSubview:viewChannel];
    
}

//选中的 频道
- (void)channelView:(FFChannelView *)channelView didSelectChannelModel:(FFChannelModel*)channelModel{

}
//取消 频道
- (void)channelView:(FFChannelView *)channelView didDeleteChannelModel:(FFChannelModel*)channelModel{

}
@end
