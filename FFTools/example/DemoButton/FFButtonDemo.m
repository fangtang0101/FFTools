//
//  FFButtonDemo.m
//  FFTools
//
//  Created by 春高方 on 16/8/30.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFButtonDemo.h"
#import "FFChannalVedioView.h"

@interface FFButtonDemo ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width4;
@property (nonatomic,assign) BOOL bool1;
@property (nonatomic,assign) BOOL bool2;
@property (nonatomic,assign) BOOL bool3;
@property (nonatomic,assign) BOOL bool4;

@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation FFButtonDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FFChannalVedioView *viewChannal = [FFChannalVedioView creatChannalVedioView];
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[FFChannalVedioModel creatWithTitle:@"wo" isShow:YES]];
    [array addObject:[FFChannalVedioModel creatWithTitle:@"tt" isShow:YES]];
    [array addObject:[FFChannalVedioModel creatWithTitle:@"rrr" isShow:NO]];
    [array addObject:[FFChannalVedioModel creatWithTitle:@"uuuu" isShow:YES]];
    
    [viewChannal setUpUIWith:array.copy];
    
    viewChannal.frame = self.view2.bounds;
    [self.view2 addSubview:viewChannal];
    

    
    
    self.bool1 = YES;
    self.bool2 = YES;
     self.bool3 = NO;
     self.bool4 = YES;
    
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
 
    
//    count = self.bool1  ? count ++ : count;
//    count = self.bool2 == YES ? count ++ : count;
//    count = self.bool3 == YES ? count ++ : count;
//    count = self.bool4 == YES ? count ++ : count;


    CGFloat width = [UIScreen mainScreen].bounds.size.width/ count;
    
    self.width1.constant = self.bool1 == YES ? width : 0 ;
    self.width2.constant = self.bool2 == YES ? width : 0 ;
    self.width3.constant = self.bool3 == YES ? width : 0 ;
    self.width4.constant = self.bool4 == YES ? width : 0 ;
    


 
}


@end
