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


@property (weak, nonatomic) IBOutlet UISwitch *switchTimer2;
@property (weak, nonatomic) IBOutlet UILabel *labelTimer2;
@property (nonatomic,strong) NSTimer *timer2;
@property (nonatomic,assign) NSUInteger countTimer2;
@property (nonatomic,assign) NSUInteger countTimer3;

@property (nonatomic,assign) BOOL isMainThread;
@property (nonatomic,strong) NSRunLoop *currentLoop;
@property (nonatomic,strong) NSThread *threadTimer2;
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
    [self timer3];
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
    self.labelTimer1.text = [NSString stringWithFormat:@"run1Method %zd",self.countTimer];
        NSLog(@"running方法===== %zd", self.countTimer);
}

#pragma mark -- 下面的一个实验
- (IBAction)onlickSwitch2:(UISwitch *)sender {
    
    [self.timer2 invalidate];
    self.timer2 = nil;
    
    
    if (!self.timer2) {
        self.timer2 =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run2) userInfo:self repeats:YES];
    }
    if (sender.on) { //开关开了
 
    }
}
-(void)run2 {
    self.countTimer2 ++;
    self.labelTimer2.text = [NSString stringWithFormat:@"run2Method %zd",self.countTimer2];
    NSLog(@"running方法===== %zd", self.countTimer);
}
- (IBAction)onclickSegment2:(UISegmentedControl *)sender {
    
    self.switchTimer2.on = YES;
    
    if (sender.selectedSegmentIndex == 0) {
        [self.threadTimer2 cancel];
        self.threadTimer2 = nil;
        self.currentLoop = nil;
        [self onlickSwitch2:self.switchTimer2];
    }else{
        if (self.timer2) {
            [self.timer2 invalidate];
            self.timer2= nil;
        }
        if (!self.threadTimer2) {
            self.threadTimer2 = [[NSThread alloc]initWithTarget:self selector:@selector(sonThread) object:nil];
            [self.threadTimer2 start];
        }
//      [NSThread detachNewThreadSelector:@selector(sonThread) toTarget:self withObject:nil];
    }
}
//子线程里开启
-(void)sonThread {
    self.currentLoop = [NSRunLoop currentRunLoop];
    [self onlickSwitch2:self.switchTimer2];
    [self.currentLoop run];
}

-(void)timer3 {
    //timer 的方法 (注意此方法在主线程中 会自动执行)
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run3) userInfo:nil repeats:YES];
    // but 如果实在子线程中 写这个写这个方法，默认是 没有一个RunLoop 去执行这个方法，所以需要你自己手动写 一个RunLoop去执行这个
    
    [NSThread detachNewThreadSelector:@selector(newThread) toTarget:self withObject:nil];
    
}

-(void)newThread {
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run3) userInfo:nil repeats:YES];

    //可以试试把上面的打开，下面的注释，-->结论在子线程中 不能
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run3) userInfo:nil repeats:YES];
    [loop run];
    
}

-(void)run3 {
    self.countTimer3 ++;
    NSLog(@"running方法3===== %zd", self.countTimer3);
}

@end
