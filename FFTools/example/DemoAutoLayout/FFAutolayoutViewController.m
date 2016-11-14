//
//  FFAutolayoutViewController.m
//  FFTools
//
//  Created by Administrator on 16/9/13.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFAutolayoutViewController.h"

@interface FFAutolayoutViewController ()
@end

@implementation FFAutolayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FFAutolayoutViewController";
    
    UIView* logoImageView = [UIView new];
    logoImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:logoImageView];
        logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //logoImageView左侧与父视图左侧对齐
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:10.0f];
    
    //logoImageView右侧与父视图右侧对齐
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-10.0f];
    
    //logoImageView顶部与父视图顶部对齐
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:200.0f];
    
//    //logoImageView高度为父视图高度一半
//    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0.0f];
    
        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0.5f constant:120.f];
    
//    //nameLabel高度为20
//    NSLayoutConstraint* nameLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20.0f];
    
    //iOS 6.0或者7.0调用addConstraints
//    [self.view addConstraints:@[leftConstraint, rightConstraint, topConstraint, heightConstraint]];
    
    //iOS 8.0以后设置active属性值
    leftConstraint.active = YES;
    rightConstraint.active = YES;
    topConstraint.active = YES;
    heightConstraint.active = YES;
    
//    [self.view addConstraints:@[leftConstraint,rightConstraint,topConstraint,heightConstraint]];
    
}

@end
