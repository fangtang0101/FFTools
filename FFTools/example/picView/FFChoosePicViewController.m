//
//  FFChoosePicViewController.m
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFChoosePicView.h"
#import "FFChoosePicViewController.h"

@interface FFChoosePicViewController ()<FFChoosePicViewDelegate>
@property (nonatomic,strong) NSMutableArray *arrayPics;
@property (nonatomic,strong) FFChoosePicView *viewPic;
@end

@implementation FFChoosePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加图片组件展示";
    [self creatPicView];
}
-(void)creatPicView {
    if (self.viewPic) {
        [self.viewPic removeFromSuperview];
        self.viewPic = nil;
    }
    
    self.viewPic = [FFChoosePicView creatUploadPicViewIsNeedChange:YES HoldVC:self];
    self.viewPic.maxCountPic = 3;
    self.viewPic.backgroundColor = [UIColor clearColor];
    self.viewPic.delegate = self;
    [self.view addSubview:self.viewPic];
    self.viewPic.frame = CGRectMake(0, 0, SCREENSIZE.width - 30, 100);
    [self.viewPic setUpSpaceWidthOutside:0 spaceWidthInside:5 widthPicViewContainer:SCREENSIZE.width - 20];
    [self.viewPic reSortPositionWithArrayPic:self.arrayPics];
    
    self.viewPic.backgroundColor = [UIColor redColor];
    self.viewPic.frame = CGRectMake(0, 100, SCREENSIZE.width, 100);
    
}

-(NSMutableArray *)arrayPics {

    if (!_arrayPics) {
        _arrayPics = [NSMutableArray array];
    }
    return _arrayPics;
}


@end
