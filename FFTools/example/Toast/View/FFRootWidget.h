//
//  FFRootWidget.h
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFRootView.h"

typedef NS_ENUM(NSUInteger, FFWidgetAnimationType){
    FFWidgetAnimationFromBottom,
    FFWidgetAnimationFromTop,
    FFWidgetAnimationFading,
    FFWidgetAnimationNone,
} ;

@interface FFRootWidget : FFRootView{

@protected
/**
 *  是否展示背景效果。
 */
BOOL showMask;

/**
 *  控件空白处被点击后是否收起控件
 */
BOOL dismissWhenBlankPress;
}
@property (nonatomic, strong) id getAnyObject;

/**
 *  使用动画的方式展示控件
 *
 *  @param animationType 动画的方式
 */
-(void)showWithAnimationType:(FFWidgetAnimationType)animationType;

/**
 *  收起之后做动作。
 *
 *  注意：收起之后，控件就不能再重用了。
 *
 *  @param action <#action description#>
 */
-(void)hideThenAction:(void (^)(void))action;

/**
 *  收起控件。请注意的是，动画跟展示的时候是相对应的。
 */
-(void)hide;
/**
 *  用控件的默认动画展示控件。子类可以重新实现然后使用不同的动画。
 *  比如，登录控件和toast控件用的默认动画就不一样。
 */
-(void)show;

/**
 *  展示之前做准备工作。如果子类要实现这方法，必须先要调用父类的方法。
 */
-(void)prepareForShow;

/**
 *  隐藏之前做准备工作。如果子类要实现这方法，必须在最后调用父类的方法。
 */
-(void)cleanForHide;

/**
 *  将要针对视图做调整。是否要重定向视图
 *
 *  @param aView 目标视图
 *
 *  @return 重定向的视图
 */
-(UIView*)willAdaptForView:(UIView*)aView;

/**
 *  键盘刚刚展示出来
 *
 *  @param aNotification 提醒这个动作的通知
 */
- (void)keyboardDidShow:(NSNotification*)aNotification;

/**
 *  键盘刚刚收回去
 *
 *  @param aNotification 提醒这个动作的通知
 */
-(void)keyboardDidHide:(NSNotification*)aNotification;


@end
