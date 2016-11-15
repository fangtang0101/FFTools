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

@property (nonatomic,assign) CGFloat heightPicView;

@property (nonatomic,assign) NSUInteger maxCountPic;

@property (nonatomic,weak)id<LYHUploadPicViewDelegate>delegate;

+(instancetype)creatUploadPicViewIsNeedChange:(BOOL)isNeedChange;

- (void)reSortPositionWithArrayPic:(NSMutableArray *)arrayPic;

- (void)setUpSpaceWidthOutside:(CGFloat)spaceWidthOutside spaceWidthInside:(CGFloat)spaceWidthInside  widthPicViewContainer:(CGFloat)widthPicViewContainer;

@end
