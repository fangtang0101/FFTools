//
//  FFPicChooseViewController.m
//  FFTools
//
//  Created by Administrator on 16/11/15.
//  Copyright © 2016年 春高方. All rights reserved.
//
#import "LYHUploadPicView.h"
#import "FFPicChooseViewController.h"
#import "LYHMultipleActionSheetManager.h"
#import "LYHImageView.h"

@interface FFPicChooseViewController ()<LYHUploadPicViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) LYHUploadPicView *viewUploadPic;
@property (nonatomic, strong) LYHMultipleActionSheetManager *actionManager;
@property (nonatomic,strong) NSMutableArray *arraypics;
@end

#define MaxCountPic 6

@implementation FFPicChooseViewController

#pragma mark life cycle      生命周期  =========================
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片选择器";
    [self fillCellPicWithArrayPics:self.arraypics];
}

#pragma mark private method   私有方法 ====================
//加载图片
- (void)fillCellPicWithArrayPics:(NSMutableArray *)arrayPics {
//    self.heightCellPic = 0.0;
    if (self.viewUploadPic) {
        [self.viewUploadPic removeFromSuperview];
        self.viewUploadPic = nil;
    }
    
    LYHUploadPicView *viewUploadPic = [LYHUploadPicView creatUploadPicViewIsNeedChange:YES];
    self.viewUploadPic = viewUploadPic;
    viewUploadPic.backgroundColor = [UIColor redColor];
    viewUploadPic.delegate = self;
    [self.view addSubview:viewUploadPic];
    viewUploadPic.frame = CGRectMake(0, 10, SCREENSIZE.width - 30, 100);
    [viewUploadPic setUpSpaceWidthOutside:0 spaceWidthInside:5 widthPicViewContainer:SCREENSIZE.width - 30];
    [viewUploadPic reSortPositionWithArrayPic:self.arraypics];
    CGFloat height = viewUploadPic.heightPicView ;
//    self.heightCellPic = height >1 ? (height +20):height;
}


#pragma mark event response  事件响应

#pragma mark delegate 协议方法
#pragma mark -- tableViewDelegate


- (void)uploadPicviewDelegatePicIndex:(NSUInteger)index  pictureId:(NSNumber*)pictureId {

}
- (void)uploadPicviewAddPic {
    
    if (self.actionManager) {
        self.actionManager = nil;
    }
    
    self.actionManager = [[LYHMultipleActionSheetManager alloc]init];
    NSUInteger count = MaxCountPic - self.arraypics.count;
//    [LYHClientConfiguration sharedConfiguration].maxSelectNumberPhoto = count > 0 ? count : 0;
    __weak __typeof(self)weakSelf = self;
    self.actionManager.actionManagerBlock = ^(UIImage *image) {
        LYHImageView *imageView = [[LYHImageView alloc]init];
        imageView.image = image;
//        [imageView fillImageUrlString:nil];
        [weakSelf.arraypics addObject:imageView];
        [weakSelf fillCellPicWithArrayPics:weakSelf.arraypics];
//        [weakSelf.tableViewContents reloadData];
    };
    [self.actionManager openCameraAndPhotoLibrarySheetWithViewController:self];
}


#pragma mark  getter setter ==============================

-(NSMutableArray *)arraypics{
    if (!_arraypics) {
        _arraypics = [NSMutableArray array];
        for (int i = 0 ; i < 1; i ++) {
            LYHImageView *view = [[LYHImageView alloc]init];
            view.image = [UIImage imageNamed:@"111.jpg"];
            [_arraypics addObject:view];
        }
    }
    return _arraypics;
}

@end
