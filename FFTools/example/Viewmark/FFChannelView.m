//
//  FFChannelView.m
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFChannelView.h"

#define colorUnSeclected [UIColor whiteColor]
#define colorHasSeclected [UIColor colorWithRed:0x61/255.0 green:0xbb/255.0  blue:0xf4/255.0  alpha:1]

#define colorTItleHasSeclected [UIColor whiteColor]
#define colorTItleUnSeclected [UIColor colorWithRed:0x66/255.0 green:0x66/255.0  blue:0x66/255.0  alpha:1]

#define colorBoarder [UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0  blue:0xdd/255.0  alpha:1]

#define topSpace 15
#define leftSpace 10
#define  middleSpace 5

#define SCREENSIZE [UIScreen mainScreen].bounds.size

@interface FFChannelView()
@property (nonatomic,strong) NSMutableArray *arrayChannel;
@property (nonatomic,strong) NSMutableArray *arrayButtons;
@property (nonatomic,assign) CGFloat heightCell;
@end

@implementation FFChannelView

-(void)setDataSourceWithArray:(NSMutableArray *)arraySouce {
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i < arraySouce.count; i ++) {
        NSString *string =arraySouce[i];
        FFChannelModel *model = [FFChannelModel new];
        model.name = string;
        model.idValue = i ;
        model.isSelected = NO;
        [array addObject:model];
    }
    self.arrayChannel = array;
    
}

- (void)setArrayChannel:(NSMutableArray *)arrayChannel {

    [self.arrayButtons removeAllObjects];
    
    _arrayChannel = arrayChannel;

    for ( FFChannelModel * model in arrayChannel) {
        UIButton * btn =   [self prepareButtonWithTitle:model.name channelId:model.idValue isSelected:model.isSelected];
        [self addSubview:btn];
        [self.arrayButtons addObject:btn];
    }
    [self sortArrayButton];
}

//重新排序
-(void)sortArrayButton {
    for (int i = 0; i < self.arrayButtons.count ; i ++) {
        UIButton *btnCurrent =  self.arrayButtons[i];
        UIButton *btnLast ;//上一个btn
        if (0 == i) {
            btnCurrent.left = leftSpace;
            btnCurrent.top = topSpace;
        }else{
            btnLast =  self.arrayButtons[i-1];
            btnCurrent.left = btnLast.right + middleSpace;
            btnCurrent.top = btnLast.top;
            //检查是否 过界限
            if (btnCurrent.right > SCREENSIZE.width - 10) { //新的一行
                btnCurrent.left = leftSpace;
                btnCurrent.top = btnLast.bottom + topSpace;
            }
        }
        [self setButtonStyleButtont:btnCurrent];
        //最后一个记录高度 （最后一个）
        if (i == self.arrayButtons.count -1) {
            self.heightCell = 0;
            self.heightCell = btnCurrent.bottom + 15;
        }
    }
}

- (UIButton*)prepareButtonWithTitle:(NSString*)title channelId:(NSUInteger) channelId isSelected:(BOOL)isSelected {
    UIButton* result = [[UIButton alloc] init];
    [result setTitle:title forState:UIControlStateNormal];
    result.tag = channelId;
    result.selected = isSelected;

    UIColor * colorBoarderbtn = colorBoarder;
    result.layer.borderColor = colorBoarderbtn.CGColor;
    result.layer.borderWidth = 1;
    result.titleLabel.font = [UIFont systemFontOfSize:13];
    [result addTarget:self action:@selector(chooseChannel:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonStyleButtont:result];
    result.left = 0;
    result.top = 0;
    //字体自适应宽度高度(外框将button里面的文字紧紧包围)
    [result sizeToFit];
    result.width+=30;
    result.height = 30;
    return result;
}

- (void)chooseChannel:(UIButton *)btn {
    
    //抖动效果
    CALayer*viewLayer=[btn layer];
    CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration=0.2;
    animation.repeatCount = 2;
    animation.autoreverses=YES;
    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                         
                         (viewLayer.transform, -0.08, 0.0, 0.0, 0.03)];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                       
                       (viewLayer.transform, 0.08, 0.0, 0.0, 0.03)];
    [viewLayer addAnimation:animation forKey:@"wiggle"];
    
    //    CATransition *animation = [CATransition animation];
    //    [animation setDuration:0.7f]; //动画持续的时间
    //    /*动画速度,何时快、慢
    //     (
    //     kCAMediaTimingFunctionLinear 线性（匀速）|
    //     kCAMediaTimingFunctionEaseIn 先慢|
    //     kCAMediaTimingFunctionEaseOut 后慢|
    //     kCAMediaTimingFunctionEaseInEaseOut 先慢 后慢 中间快|
    //     kCAMediaTimingFunctionDefault 默认|
    //     )
    //     */
    //    [animation setTimingFunction:[CAMediaTimingFunction
    //                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    //
    //    /*动画效果
    //     (
    //     kCATransitionFade淡出|
    //     kCATransitionMoveIn覆盖原图|
    //     kCATransitionPush推出|
    //     kCATransitionReveal底部显出来
    //     )
    //     */
    //    [animation setType:kCATransitionReveal];
    //    /*动画方向
    //     (
    //     kCATransitionFromRight|
    //     kCATransitionFromLeft|
    //     kCATransitionFromTop|
    //     kCATransitionFromBottom
    //     )
    //     */
    //    [animation setSubtype: kCATransitionFromBottom];
    //    [btn.layer addAnimation:animation forKey:@"Reveal"];
    ////    还有一种设置动画类型的方法，不用setSubtype，只用setType
    //    [animation setType:@"oglFlip"];
    
    btn.selected = !btn.selected;
    [self setButtonStyleButtont:btn];
    if (btn.isSelected) {
        if ([self.delegate respondsToSelector:@selector(channelView:didSelectChannelModel:)]) {
            [self.delegate channelView:self didSelectChannelModel:self.arrayChannel[btn.tag]];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(channelView:didDeleteChannelModel:)]) {
            [self.delegate channelView:self didDeleteChannelModel:self.arrayChannel[btn.tag]];
        }
    }
}


- (void)setButtonStyleButtont:(UIButton *)btn {
    UIColor * colorBackGround = btn.isSelected ?  colorHasSeclected : colorUnSeclected ;
    UIColor * colorTitle = btn.isSelected ?  colorTItleHasSeclected : colorTItleUnSeclected ;
    btn.backgroundColor = colorBackGround;
    [btn setTitleColor:colorTitle forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.height/2;
    
    //选中的情况下，borderWith 不需要显示 V2.01
    CGFloat width ;
    width = btn.isSelected ? 0 : 1 ;
    btn.layer.borderWidth = width;
}

- (NSArray *)getAllHasSelectedChannal {
    NSMutableArray* result = [[NSMutableArray alloc] init];
    FFChannelModel* model = nil;
    for (UIButton* button in self.arrayButtons) {
        if (button.isSelected) {
            model = [[FFChannelModel alloc] init];
            model.name = button.currentTitle;
            model.idValue = button.tag;
            model.isSelected = YES;
            [result addObject:model];
        }
    }
    return result;
}
-(NSMutableArray *)arrayButtons {

    if (!_arrayButtons) {
        _arrayButtons = [NSMutableArray array];
    }
    return _arrayButtons;
}




@end

//***************************************************** 扩展 **********************************

@implementation UIView(FF)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)drawBoarderWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius borderWidt:(CGFloat)borderWidth{
    if (cornerRadius > 0) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
    }
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
    if (borderWidth >0) {
        self.layer.borderWidth=borderWidth;
    }
}

@end

@implementation FFChannelModel



@end
