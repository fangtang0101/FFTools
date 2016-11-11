//
//  FFChannalVedioView.m
//  FFTools
//
//  Created by 春高方 on 16/8/30.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFChannalVedioView.h"

@interface FFChannalVedioView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width4;

@property (nonatomic,assign) BOOL bool1;
@property (nonatomic,assign) BOOL bool2;
@property (nonatomic,assign) BOOL bool3;
@property (nonatomic,assign) BOOL bool4;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@end
@implementation FFChannalVedioView

+(instancetype)creatChannalVedioView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FFChannalVedioView" owner:nil options:nil];
    return views.firstObject;
}


-(void)setUpUIWith:(NSArray *)arrayDataSouce {
    
    
    for (int i = 0; i< arrayDataSouce.count; i ++) {
        FFChannalVedioModel *model = arrayDataSouce[i];
        if (i == 0) {
            self.bool1 = model.isShow;
            [self.button1 setTitle:model.title forState:UIControlStateNormal];
        }
        if (i == 1) {
            self.bool2 = model.isShow;
                [self.button2 setTitle:model.title forState:UIControlStateNormal];
        }
        if (i == 2) {
            self.bool3 = model.isShow;
                [self.button3 setTitle:model.title forState:UIControlStateNormal];
        }
        if (i == 3) {
            self.bool4 = model.isShow;
                [self.button4 setTitle:model.title forState:UIControlStateNormal];
        }
    }

    
    NSInteger count = 0 ;
    if (self.bool1) {
        count ++;
    }
    if (self.bool2) {
        count ++;
    }
    if (self.bool3) {
        count ++;
    }
    if (self.bool4) {
        count ++;
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width/ count;
    self.width1.constant = self.bool1 == YES ? width : 0 ;
    self.width2.constant = self.bool2 == YES ? width : 0 ;
    self.width3.constant = self.bool3 == YES ? width : 0 ;
    self.width4.constant = self.bool4 == YES ? width : 0 ;

}


@end

@implementation FFChannalVedioModel

+(instancetype)creatWithTitle:(NSString *)title isShow:(BOOL)isShow {
    
    FFChannalVedioModel *model = [[FFChannalVedioModel alloc]init];
    model.title = title;
    model.isShow = isShow;
    return model;
    
}


@end
