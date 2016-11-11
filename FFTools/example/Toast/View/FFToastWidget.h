//
//  FFToastWidget.h
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFRootWidget.h"
#import "FFRootView.h"

typedef NS_ENUM(NSUInteger, FFToastDurationType){
    FFToastDurationLong,
    FFToastDurationShort,
};

@interface FFToastWidget : FFRootWidget

/**
 *  展示长时的消息
 *
 *  @param message 展示的消息
 */
+(void)showToastMessage:(NSString*)message;

/**
 *  按时间展示消息
 *
 *  @param message  展示的消息
 *  @param duration 消息生命长度
 */
+(void)showToastMessage:(NSString*)message during:(FFToastDurationType)duration;

@end

@interface UIView (FF)
+ (id)extractSelfByXib;
@end



