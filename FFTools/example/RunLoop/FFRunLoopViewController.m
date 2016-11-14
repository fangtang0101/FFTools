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
@property (nonatomic,strong) dispatch_source_t TimerGCD;

@property (nonatomic,strong) NSThread *threadSon;
@end

@implementation FFRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoopDemo";
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

#pragma mark -- GCD 中的Timer
- (IBAction)onClickGCDTimer:(UIButton *)sender {
    [self GCDTmier];
}

-(void)GCDTmier {
    //******* GCD 中的 timer 不会像 NSTImer 收到很多限制 ， （1.在子线程需要自己启动RunLoop 2. Mode 不一样 滚动Scorllview回收影响，此处的不会，牛逼）
    NSLog(@"方法名称log __func__ ---- %s",__func__);
    //GCD定时器方法
    
    //step 1. 创建
    //参数1.定时器类型 ，此处为DISPATCH_SOURCE_TYPE_TIMER （timer）
    //参数2.描述信息，线程ID
    //参数3.更详细的描述信息
    //参数4.队列，决定GCD定时器中的任务在哪个线程中执行
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    //step 2.设置定时器的参数（起始时间，间隔时间，精准度）
    //参数1.定时器对象
    //参数2.起始时间，DISPATCH_TIME_NOW 从此刻开始
    //参数3.  2.0  NSEC_PER_SEC（10的9次方， GCD中单位为纳秒）
    //参数4. 精准度 0 （决定精准）
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //step 3 设置定时器执行的任务
    dispatch_source_set_event_handler(timer, ^{
        //执行Timer里面的任务
        NSLog(@"此刻正在执行 GCD中的Timer任务");
        NSLog(@"Now Thread is --- %@",[NSThread currentThread]);
    });
    //step4. 执行timer
    dispatch_resume(timer);
    
    //备注此处需要有强引用，否则， GCDTimer 方法执行完结束，那么，timer 就被回收了，不起作用了
    self.TimerGCD = timer;
}

#pragma mark -- 模拟RunLoop 的循环过程
- (IBAction)runLoopOber:(UIButton *)sender {
    [NSThread detachNewThreadSelector:@selector(observerRunLoop) toTarget:self withObject:nil];
}

- (IBAction)onClickCreatSonThread:(UIButton *)sender {
    //创建 子线程
    self.threadSon = [[NSThread alloc]initWithTarget:self selector:@selector(task1) object:nil];
    [self.threadSon start];
}

- (IBAction)onClickother:(UIButton *)sender {
    [self performSelector:@selector(test2) onThread:self.threadSon withObject:self waitUntilDone:YES];
}
//子线程里的方法
-(void)task1 {
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //******************** 添加 监听 start  *********************************************
    CFRunLoopObserverRef obser = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"进入Runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"马上处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"马上处理Source事件");
                break;
            case kCFRunLoopBeforeWaiting:
            {
                NSLog(@"马上进入休眠状态");//此处可以 当RunLoop 闲的时候 去执行你程序中的其他的方法
                for (int i =  0; i < 10; i ++) {
                    sleep(1);
                    NSLog(@"RunLoop 将要进入休眠，睡毛线，起来嗨，执行循环-----%zd",i);
                }
                break;
            }
            case kCFRunLoopAfterWaiting:
                NSLog(@"从休眠状态唤起");
                break;
            case kCFRunLoopExit:
                NSLog(@"退出RunLoop");
                break;
            default:
                break;
        }
    });
    //2.添加监听者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), obser, kCFRunLoopDefaultMode);
    //************************** 添加监听 end  *********************************************

    //宝成runLoop 不退出
    //方法一 ：主要就是为了保证RunLoop 不退出（runLoop 里面要有 timer 或则 source 或则 per-- ）
    
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(test3) userInfo:nil repeats:YES];
    [runLoop addTimer:timer1 forMode:NSDefaultRunLoopMode];
    
    // 方法二 ：加port ，因为此处只是 为了保持线程的存在，所以，只要初始化一下就行 port （一般都是用这个方法，因为不占用资源）
//    [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    
    //默认runLoop 是没有开启的，需要我们手动开启

    [runLoop run];
    NSLog(@"----- RunLoop end------");
}

//添加监听者 的参数解释
-(void)observerRunLoop {
    
    NSRunLoop *current =  [NSRunLoop currentRunLoop];
    NSLog(@"Mothed----%s",__func__);
    [current run];
//    [self observerRunLoop];

    //1.创建监听者
   //参数1 CFAllocatorGetDefault 第一个参数用于分配该observer对象的内存空间
    //参数2 监听的状态 kCFRunLoopAllActivities 所有状态
    //参数3 用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行 YES
    //参数4 设置该observer的优先级 0
    //参数5 回调 返回当前RunLoop 的状态 ，以便你处理

    CFRunLoopObserverRef obser = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"进入Runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"马上处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"马上处理Source事件");
                break;
            case kCFRunLoopBeforeWaiting:
            {
                NSLog(@"马上进入休眠状态");
                for (int i =  0; i < 1000000; i ++) {
                    NSLog(@"RunLoop 将要进入休眠，睡毛线，起来嗨，执行循环-----%zd",i);
                }
                break;
            }
               
            case kCFRunLoopAfterWaiting:
                NSLog(@"从休眠状态唤起");
                break;
            case kCFRunLoopExit:
                NSLog(@"退出RunLoop");
                break;
            default:
                break;
        }
    });
    //2.添加监听者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), obser, kCFRunLoopDefaultMode);
//    NSLog(@"Mothed----%s",__func__);
}

-(void)test2 {
    NSLog(@"success=====在 子线程里面又 加了 任务");
}

-(void)test3 {
    //注意此处 休眠2秒 ,而当 RunLoop 进入块进入休眠状态的时候 ，执行了for 循环 ，所以，必须等for 循环 结束才行------> 也就是说RunLoop 中 先拿号 再排队单线程的 去按照 拿号一件件 去做事
    sleep(2);
    NSLog(@"test3---------%zd",arc4random() % 100);
}






@end
