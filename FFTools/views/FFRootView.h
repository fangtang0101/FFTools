//
//  FFRootView.h
//  FFTools
//
//  Created by 方春高 on 16/7/29.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
typedef void (^ZYBigPhotoLoadFinish)(UIImage *image , NSInteger imageSize);

@interface FFRootView : UIView

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

-(void)drawBoarderWithColor:(UIColor*)color;
- (void)drawBoarderWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius borderWidt:(CGFloat)borderWidth;
@end

@interface UIColor (ZYAddition)

+ (UIColor *) colorWithHexString:(NSString *)color;
+ (UIColor *) colorWithHexString:(NSString *)color alpha:(float)opacity;
@end

@interface UIImage (ZYAddition)
/**
 *  通过颜色创建image对象
 *
 *  @param color 颜色
 *
 *  @return UIImage对象
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end

@interface UIImageView (ZYAddition)
/**
 *  通过图片url加载大图(多线程加载)
 *
 *  @param alassetURL  图片在相册的url
 *  @param placeImage  占位图
 *  @param finishBlock 完成后回调的block
 */
- (void)loadLibraryBigImage:(NSURL *)alassetURL placeImage:(UIImage *)placeImage finishBlock:(ZYBigPhotoLoadFinish)finishBlock;
@end
