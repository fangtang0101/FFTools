//
//  FFRootWidget.m
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFRootWidget.h"

@interface FFRootWidget()
/**
 *  widget的视觉效果的背景
 */
@property (nonatomic, weak) FFRootView* viewBackground;

@property (nonatomic, weak) FFRootView* viewContainer;

@property (nonatomic, assign) FFWidgetAnimationType animationType;

@property (nonatomic, strong) UIWindow* windowHolder;


/**
 *  是否在接受事件--10.21
 */
@property (nonatomic, assign) BOOL readyForEvents;

/**
 *  正在进行编辑的视图。如果非空，则有一个textfield正在进行编辑
 */
@property (nonatomic, weak) UIView* viewEditing;

/**
 *  键盘的frame。如果是zero，则表示当前键盘并没有展示出来
 */
@property (nonatomic, assign) CGRect frameKeyboard;

@property (nonatomic, assign) CGFloat adaptOffset;


@end

@implementation FFRootWidget

- (void)dealloc {
    //手势引用问题
    [self.viewContainer removeFromSuperview];
    self.viewContainer = nil;
    //销毁通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)awakeFromNib {
    self->showMask = YES;
    self->dismissWhenBlankPress = YES;
    self.readyForEvents = YES;
}

//妹的，凭什么只能xib可以浮层，我手写不写么，就要加一个
-(instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self->showMask = YES;
    self->dismissWhenBlankPress = YES;
    self.readyForEvents = YES;
    return self;
}

-(void)prepareForShow{
    UIWindow* showWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    showWindow.windowLevel = UIWindowLevelStatusBar - 1;
    
    if (self->showMask) {
        FFRootView* mask = [[FFRootView alloc] initWithFrame:showWindow.bounds];
        mask.backgroundColor = [UIColor colorWithWhite:0. alpha:.6];
        [showWindow addSubview:mask];
        self.viewBackground = mask;
        //  设置为完全透明因为不希望控件所在的window一展示就黑屏
        self.viewBackground.alpha = 0.;
    }
    FFRootView* viewContainer = [[FFRootView alloc] initWithFrame:showWindow.bounds];
    viewContainer.backgroundColor = [UIColor clearColor];
    [showWindow addSubview:viewContainer];
    self.viewContainer = viewContainer;
    
    if (self->dismissWhenBlankPress) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBlankPressed:)];
        [viewContainer addGestureRecognizer:tap];
    }
    
    [showWindow makeKeyAndVisible];
    self.windowHolder = showWindow;
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)cleanForHide{
    // 从现在开始，再也不接受事件
    self.readyForEvents = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 释放window。window上的所有东西会跟着灰飞烟灭 T-T
    [self.windowHolder resignKeyWindow];
    //V2.1.3 这个bug太深了
    self.windowHolder.hidden = YES;
    [self.windowHolder removeFromSuperview];
    self.windowHolder = nil;
}

/**
 *  展示页面
 *
 *  @param animationType 展示页面的动画形式
 */
-(void)showWithAnimationType:(FFWidgetAnimationType)animationType
{
    if (!self.readyForEvents) {
        return;
    }
    
    self.readyForEvents = NO;
    self.animationType = animationType;
    
    [self prepareForShow];
    
    //  控件的动画前状态
    //  跟hide前的状态一模一样
    __block CGRect widgetFrame = self.viewContainer.bounds;
    CGFloat iniAlpha = 1.;
    
    switch (self.animationType) {
        case FFWidgetAnimationFromTop:
            widgetFrame.origin.y = -1 * widgetFrame.size.height;
            break;
        case FFWidgetAnimationFromBottom:
            widgetFrame.origin.y = widgetFrame.size.height;
            break;
        case FFWidgetAnimationFading:
            iniAlpha = 0;
            break;
        case FFWidgetAnimationNone:
            break;
    }
    
    self.frame = widgetFrame;
    self.alpha = iniAlpha;
    [self.viewContainer addSubview:self];
    
    //  准备好了动画前的状态。准备做动画了……
    
    void(^animationBlock)(void) = ^(void) {
        [UIView animateWithDuration:.3 animations:^{
            widgetFrame.origin.y = 0;
            
            self.alpha = 1.;
            self.frame = widgetFrame;
        } completion:^(BOOL finished) {
            self.readyForEvents = YES;
            //发送评论专用，其他控件勿动
            [[NSNotificationCenter defaultCenter] postNotificationName:@"inputStart" object:nil];
        }];
    };
    
    if (self->showMask) {
        [UIView animateWithDuration:.2 animations:^{
            self.viewBackground.alpha = 1.;
        } completion:^(BOOL finished) {
            animationBlock();
        }];
    }else{
        animationBlock();
    }
}

-(void)show{
    if (self) {
        [self.superview removeFromSuperview];
        return;
    }
    
    [self showWithAnimationType:FFWidgetAnimationNone];
}

-(void)hide{
    
    //    [self.viewContainer removeFromSuperview];
    
    [self hideThenAction:nil];
}

-(void)hideThenAction:(void (^)(void))action{
    if (!self.readyForEvents) {
        return;
    }
    
    self.readyForEvents = NO;
    
    //  如果在输入的，结束编辑
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    //  控件的动画前状态
    //  跟show前的状态一模一样
    CGRect widgetFrame = self.frame;
    CGFloat iniAlpha = 1.;
    switch (self.animationType) {
        case FFWidgetAnimationFromTop:
            widgetFrame.origin.y = -1 * widgetFrame.size.height;
            break;
        case FFWidgetAnimationFromBottom:
            widgetFrame.origin.y = widgetFrame.size.height;
            break;
        case FFWidgetAnimationFading:
            iniAlpha = 0;
            break;
        case FFWidgetAnimationNone:
            break;
    }
    
    void(^cleanBlock)(void) = ^() {
        if (action) {
            action();
        }
        
        [self cleanForHide];
        //        [self.viewContainer removeFromSuperview];
        //        self.viewContainer = nil;
        [self removeFromSuperview];
    };
    
    
    [UIView animateWithDuration:.3 animations:^{
        self.frame = widgetFrame;
        self.alpha = iniAlpha;
    } completion:^(BOOL finished) {
        if (self->showMask) {
            [UIView animateWithDuration:.2 animations:^{
                self.viewBackground.alpha = 0.;
            } completion:^(BOOL finished) {
                cleanBlock();
            }];
        }else{
            cleanBlock();
        }
    }];
}

/**
 *  点击背景rootview隐藏
 *
 *  @param sender <#sender description#>
 */
-(void)onBlankPressed:(id)sender{
    [self hide];
}



#pragma mark - keyboard related

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    UIView* redirectView = [self willAdaptForView:textField];
    
    if (self.viewEditing == redirectView) {
        return;
    }
    
    self.viewEditing = redirectView;
    
    if (!CGRectIsEmpty(self.frameKeyboard)) {
        [self adapterInput];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.viewEditing = nil;
}

#pragma mark - 键盘通知回调
- (void)keyboardDidShow:(NSNotification*)aNotification{
    //  如果不是主window，则不响应这事件
    if (!self.window.isKeyWindow) {
        return;
    }
    
    CGRect keyboardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (CGRectEqualToRect(keyboardFrame, self.frameKeyboard)) {
        return;
    }
    
    self.frameKeyboard = keyboardFrame;
    
    if (self.viewEditing != nil) {
        [self adapterInput];
    }
}

-(void)keyboardDidHide:(NSNotification*)aNotification{
    //  如果不是主window，则不响应这事件
    
    if (!self.window.isKeyWindow) {
        return;
    }
    
    self.frameKeyboard = CGRectZero;
    
    if(self.adaptOffset != 0){
        [self recoverAdaptWithTotalHeightOffset:self.adaptOffset];
    }
    
    self.adaptOffset = 0;
}

/**
 *  调整输入视图。
 *
 *  @param offset 应该调整的距离。正数表示应该往下调整。负数应该往上调整。
 *
 *  @return 调整了多少值
 */
-(CGFloat)adaptInputWithHeightOffset:(CGFloat)offset{
    [UIView animateWithDuration:.2 animations:^{
        CGRect myFrame = self.frame;
        myFrame.origin.y += offset;
        self.frame = myFrame;
    }];
    
    return offset;
}

-(void)recoverAdaptWithTotalHeightOffset:(CGFloat)offset{
    [UIView animateWithDuration:.2 animations:^{
        CGRect myFrame = self.frame;
        myFrame.origin.y -= offset;
        self.frame = myFrame;
    }];
}

-(BOOL)shouldAdapt{
    CGRect textFieldRect = [self.viewEditing.window convertRect:self.viewEditing.bounds fromView:self.viewEditing];
    CGRect visibleRect = [self.window convertRect:self.bounds fromView:self];
    
    // 输入框和界面的交集，结果应该是输入框
    CGRect common0 = CGRectIntersection(textFieldRect, visibleRect);
    // 上述交集和键盘的交集，应该是空
    CGRect common1 = CGRectIntersection(common0, self.frameKeyboard);
    
    return CGRectEqualToRect(common0, textFieldRect) && CGRectIsEmpty(common1);
}

-(void)adapterInput{
    if ([self shouldAdapt]) {
        return;
    }
    
    CGRect textFieldRect = [self.viewEditing.window convertRect:self.viewEditing.bounds fromView:self.viewEditing];
    CGFloat offset = self.frameKeyboard.origin.y - textFieldRect.origin.y - textFieldRect.size.height - 8.;
    self.adaptOffset += [self adaptInputWithHeightOffset:offset];
}

-(UIView*)willAdaptForView:(UIView*)aView{
    return aView;
}



@end
