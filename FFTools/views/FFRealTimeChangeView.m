//
//  FFRealTimeChangeView.m
//  FFTools
//
//  Created by 方春高 on 16/7/29.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFRealTimeChangeView.h"

IB_DESIGNABLE//一定要在@implementation上方 (告诉xib 上面渲染视图的颜色和其他)
@implementation FFRealTimeChangeView

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBordorWidth:(CGFloat)bordorWidth {
    _bordorWidth = bordorWidth;
    self.layer.borderWidth = _bordorWidth;
}

- (void)setBordorColor:(UIColor *)bordorColor {
    _bordorColor = bordorColor;
    self.layer.borderColor = [_bordorColor CGColor];
}

@end
