//
//  CaculatorMaker.h
//  FFTools
//
//  Created by 方春高 on 16/8/16.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

@property (nonatomic,assign) NSUInteger result;

//返回值 为 block (block 为传入参数int 返回 CaculatorMaker)
-(CaculatorMaker *(^)(NSUInteger))add; //加法计算
-(CaculatorMaker *(^)(NSUInteger))sub;
-(CaculatorMaker *(^)(NSUInteger))muilt;
-(CaculatorMaker *(^)(NSUInteger))divide;

//下面为函数式编程的示例

- (CaculatorMaker *)caculator:(NSUInteger(^)(NSUInteger result))caculator;

- (CaculatorMaker*)equle:(BOOL(^)(NSUInteger result))operation;

@end
