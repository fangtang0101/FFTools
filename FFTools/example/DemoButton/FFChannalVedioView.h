//
//  FFChannalVedioView.h
//  FFTools
//
//  Created by 春高方 on 16/8/30.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFChannalVedioView : UIView
+(instancetype)creatChannalVedioView;
-(void)setUpUIWith:(NSArray *)arrayDataSouce;

@end

@interface  FFChannalVedioModel:NSObject

+(instancetype)creatWithTitle:(NSString *)title isShow:(BOOL)isShow;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL isShow;

@end
