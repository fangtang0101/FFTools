//
//  FFChoosePicView.h
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//
#import <objc/runtime.h>
#import "FFRootView.h"

#define SCREENSIZE [UIScreen mainScreen].bounds.size

@protocol FFChoosePicViewDelegate <NSObject>

- (void)uploadPicviewDelegatePicIndex:(NSUInteger)index  pictureId:(NSNumber*)pictureId;
- (void)uploadPicviewAddPic;

@end

@interface FFChoosePicView : FFRootView

@property (nonatomic,assign) CGFloat heightPicView;

@property (nonatomic,assign) NSUInteger maxCountPic;

@property (nonatomic,weak)id<FFChoosePicViewDelegate>delegate;

+(instancetype)creatUploadPicViewIsNeedChange:(BOOL)isNeedChange HoldVC:(UIViewController*)holdVC;

- (void)reSortPositionWithArrayPic:(NSMutableArray *)arrayPic;

- (void)setUpSpaceWidthOutside:(CGFloat)spaceWidthOutside spaceWidthInside:(CGFloat)spaceWidthInside  widthPicViewContainer:(CGFloat)widthPicViewContainer;


@end

//***************************************************** 扩展 **********************************
@interface UIView(FF)
//下面全部是获取UIView的x，y，w，h=================================================
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

- (void)drawBoarderWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius borderWidt:(CGFloat)borderWidth;

@end

@interface UIImageView(FF)
//运行时动态添加的属性
@property(nonatomic, copy)NSString *imageURLString;

@end
