//
//  LYHUploadPicView.h
//  Liangyihui
//
//  Created by 方春高 on 16/2/23.
//  Copyright © 2016年 Liangyihui. All rights reserved.
//

#import "LYHRootView.h"
#import "FFRootView.h"

@protocol LYHUploadPicViewDelegate <NSObject>

- (void)uploadPicviewDelegatePicIndex:(NSUInteger)index  pictureId:(NSNumber*)pictureId;
- (void)uploadPicviewAddPic;

@end

@interface LYHUploadPicView : LYHRootView
//获取整个view 的 高度
@property (nonatomic,assign) CGFloat heightPicView;

// 展示 图片的最高限额
@property (nonatomic,assign) NSUInteger maxCountPic;

@property (nonatomic,weak)id<LYHUploadPicViewDelegate>delegate;

//1. 初始化 方法 isNeedChange 默认 NO 如果为 Yes 那么就会没有删除 按钮 和 增加按钮（就是穿过来是多少图片，直接展示句ok）
+(instancetype)creatUploadPicViewIsNeedChange:(BOOL)isNeedChange;
// 2. 设置 数据源 arrayPic，所有的图片
- (void)reSortPositionWithArrayPic:(NSMutableArray *)arrayPic;

//可选 ，设置每个人图片展示的时候 的 间距 ，有默认的值
- (void)setUpSpaceWidthOutside:(CGFloat)spaceWidthOutside spaceWidthInside:(CGFloat)spaceWidthInside  widthPicViewContainer:(CGFloat)widthPicViewContainer;

// 获取  所有的 图片的方法
-(NSMutableArray *)getAllPic;

@end
