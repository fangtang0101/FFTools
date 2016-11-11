//
//  FFToastWidget.m
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFToastWidget.h"

@interface FFToastWidget()
@property (weak, nonatomic) IBOutlet UIView *viewWrapper;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (nonatomic, assign) FFToastDurationType duration;
@end

@implementation FFToastWidget
-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.viewWrapper.layer.cornerRadius = 8.;
    self.viewWrapper.layer.masksToBounds = YES;
    self->showMask = NO;
}

-(void)show{
    [self showWithAnimationType:FFWidgetAnimationFading];
}

+(void)showToastMessage:(NSString*)message{
    //备注:当请求返回的是nil，去展示的时候，会有bug，此处是为了解决这个bug
    if (message == nil) {
        message = @"请求失败";
    }
    [self showToastMessage:message during:FFToastDurationShort];
}

+(void)showToastMessage:(NSString*)message during:(FFToastDurationType)duration{
    FFToastWidget* widget = [FFToastWidget extractSelfByXib];
    widget.labelText.text = message;
    widget.duration = duration;
    [widget show];
}

-(void)prepareForShow{
    [super prepareForShow];
    unsigned int secodes = 0;
    switch (self.duration) {
        case FFToastDurationLong:
            secodes = 3;
            break;
        case FFToastDurationShort:
        default:
            secodes = 1;
            break;
    }
    //  这个闹钟会hold住当前控件，直到被调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(secodes * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}

@end

//*************************************

@implementation UIView(FF)
+ (id)extractSelfByXib{
    Class targetViewClass = [self class];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(targetViewClass) owner:nil options:nil];
    
    for (UIView *view in views) {
        if ([view isMemberOfClass:targetViewClass]) {
            return view;
        }
    }
    return nil;
}
@end
