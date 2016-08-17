//
//  FFRunLoopViewController.m
//  FFTools
//
//  Created by 春高方 on 16/8/17.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFRunLoopViewController.h"

@interface FFRunLoopViewController ()
@property (nonatomic,strong) NSTimer *timer1;
@property (weak, nonatomic) IBOutlet UILabel *labelTimer1;
@property (weak, nonatomic) IBOutlet UISwitch *switchTimer1;
@property (nonatomic,assign) NSUInteger countTimer;
@property (nonatomic,copy) NSString *stringMode;
@end

@implementation FFRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoop试验";
    //解决 UITextField 的上部留白bug ios7
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//页面捕捉点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timer1];
}

- (IBAction)onclickSwitch:(UISwitch *)sender {
    
    [self.timer1 invalidate];
    self.timer1 = nil;
    if (!self.timer1) {
        self.timer1 =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(run1) userInfo:self repeats:YES];
    }
    if (sender.on) { //开关开了
        //NStimer 的这个方法是默认不会自己开启的
        NSString *mode ;
        mode = self.stringMode.length > 1 ? self.stringMode : NSDefaultRunLoopMode;
        [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:mode];
    }
}
- (IBAction)onclickSegment:(UISegmentedControl *)sender {

    if (sender.selectedSegmentIndex == 0) {
        self.stringMode = NSDefaultRunLoopMode;
    }else if (sender.selectedSegmentIndex == 1){
        self.stringMode = UITrackingRunLoopMode;
    }else if (sender.selectedSegmentIndex == 2){
        self.stringMode = NSRunLoopCommonModes;
    }
    
    self.switchTimer1.on = YES;
    
    [self onclickSwitch:self.switchTimer1];
}

-(void)run1 {
//    NSLog(@"当前线程%@  当前RunLoop%@",[NSThread currentThread],[NSRunLoop currentRunLoop]);
    self.countTimer ++;
    self.labelTimer1.text = [NSString stringWithFormat:@"runMethod %zd",self.countTimer];
        NSLog(@"running方法===== %zd", self.countTimer);
}

@end
