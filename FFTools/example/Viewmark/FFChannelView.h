//
//  FFChannelView.h
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFRootView.h"

@interface FFChannelModel : NSObject
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger idValue;
@property (nonatomic, assign) BOOL isSelected;
@end

@class FFChannelView;
@protocol FFChannelViewDelegate <NSObject>
//选中的 频道
- (void)channelView:(FFChannelView *)channelView didSelectChannelModel:(FFChannelModel*)channelModel;
//取消 频道
- (void)channelView:(FFChannelView *)channelView didDeleteChannelModel:(FFChannelModel*)channelModel;
@end

@interface FFChannelView : FFRootView
@property (nonatomic,strong) id<FFChannelViewDelegate> delegate;
-(void)setDataSourceWithArray:(NSMutableArray *)arraySouce;
- (NSArray *)getAllHasSelectedChannal;
@end

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


