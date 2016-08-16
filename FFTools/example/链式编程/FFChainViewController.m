//
//  FFChainViewController.m
//  FFTools
//
//  Created by 方春高 on 16/8/16.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFChainViewController.h"
typedef NS_OPTIONS(NSUInteger, FFCaculatorMaker) {
    FFCaculatorMakerAdd = 0,
    FFCaculatorMakerSub ,                  // used when UIControl isHighlighted is set
    FFCaculatorMakerMui ,
    FFCaculatorMakerDiv                     // flag usable by app (see below)
};

@interface FFChainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelResult;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonNuns;
@property (nonatomic,assign)NSInteger numFirst;
@property (nonatomic,assign)NSInteger numSecond;
//注意此处是strong,不是copy ==> 因为copy 只是copy string 不是Mustring 所以虽然stringFirstNum 定义成了NSMutableString,但是实际上还是 NSString，所以在用append 方法的时候会崩溃，不信你自己试验
@property (nonatomic,strong) NSMutableString *stringFirstNum;
@property (nonatomic,strong) NSMutableString *stringSectionNum;
@property (nonatomic,assign) BOOL isFirstNum;
@property (nonatomic,assign) BOOL isSectionNum;
@property (nonatomic,assign) FFCaculatorMaker type;
@end
@implementation FFChainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"体验链式编程思想-计算器";
    self.isFirstNum = YES;
    self.isSectionNum = NO;
    //函数式编程判断两个数是否相等
    CaculatorMaker *mgr = [CaculatorMaker new];
   __block BOOL isEq;
    [[mgr caculator:^NSUInteger(NSUInteger result) {
        result += 7;
        result *= 5;
        return result;
    }]equle:^BOOL(NSUInteger result) {
        isEq = (result == 10);
        return result == 10;
    }];
    NSLog(@"++++ %d",isEq);
}
//结果
- (IBAction)buttonClickResult:(UIButton *)sender {
    //计算
    NSInteger num1 = self.stringFirstNum.integerValue;
    NSInteger num2 = self.stringSectionNum.integerValue;
    NSUInteger myResult = [NSObject makeCaulators:^(CaculatorMaker *make) {
        switch ( self.type ) {
            case FFCaculatorMakerAdd:
                make.add(num1).add(num2);
                break;
            case FFCaculatorMakerSub:
                make.add(num1).sub(num2);
                break;
            case FFCaculatorMakerMui:
                make.add(1).muilt(num1).muilt(num2);
                break;
            case FFCaculatorMakerDiv:
                make.add(num1).divide(num2);
                break;
            default:
                break;
        }
    }];
    self.labelResult.text = [NSString stringWithFormat:@"%zd",myResult];
    //结束之后清零
    self.isFirstNum = YES;
    self.isSectionNum = NO;
    self.stringFirstNum = @"".mutableCopy;
    self.stringSectionNum = @"".mutableCopy;
}

- (IBAction)buttonSign:(UIButton *)sender {
        self.isFirstNum = NO;
    self.isSectionNum = YES;
    self.type = sender.tag; //偷懒
}

//数字的按键
- (IBAction)buttonOnclickNun:(UIButton *)sender {
    if (self.isFirstNum) {
        if (!(sender.tag == 0 && self.stringFirstNum.length < 1)) {
            //拼接
            [self.stringFirstNum appendString:[NSString stringWithFormat:@"%zd",sender.tag]];
            NSLog(@"======= %zd",self.stringFirstNum.integerValue);
        }
    }
    if (self.isSectionNum) {
        if (!(sender.tag == 0 && self.stringSectionNum.length < 1)) {
            //拼接
            [self.stringSectionNum appendString:[NSString stringWithFormat:@"%zd",sender.tag]];
            NSLog(@"======= %zd",self.stringSectionNum.integerValue);
        }
    }
}

-(NSMutableString *)stringFirstNum {
    if (!_stringFirstNum) {
        _stringFirstNum = [NSMutableString string];
    }
    return _stringFirstNum;
}

-(NSString *)stringSectionNum {
    if (!_stringSectionNum) {
        _stringSectionNum = [NSMutableString string];
    }
    return _stringSectionNum;
}

@end

@implementation NSObject(Caulator)

+ (NSInteger)makeCaulators:(void(^)(CaculatorMaker*make))block {
    CaculatorMaker *mgr = [CaculatorMaker new];
    block(mgr);
    return mgr.result;
}

@end
