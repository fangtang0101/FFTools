//
//  CaculatorMaker.m
//  FFTools
//
//  Created by 方春高 on 16/8/16.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

-(CaculatorMaker *(^)(NSUInteger))add {
    
    CaculatorMaker *(^block)(NSUInteger) = ^CaculatorMaker *(NSUInteger value){
        _result += value;
        return self;
    };
    return block;
}

-(CaculatorMaker *(^)(NSUInteger))sub {
    CaculatorMaker *(^block)(NSUInteger) = ^CaculatorMaker *(NSUInteger value){
        _result -= value;
        return self;
    };
    return block;
}

-(CaculatorMaker *(^)(NSUInteger))muilt {
    CaculatorMaker *(^block)(NSUInteger) = ^CaculatorMaker *(NSUInteger value){
        _result *= value;
        return self;
    };
    return block;
}
-(CaculatorMaker *(^)(NSUInteger))divide {
    CaculatorMaker *(^block)(NSUInteger) = ^CaculatorMaker *(NSUInteger value){
        _result /= value;
        return self;
    };
    return block;
}

- (CaculatorMaker *)caculator:(NSUInteger(^)(NSUInteger result))caculator {
    if (caculator) {
       _result = caculator(_result);
    }
    return self;
}

- (CaculatorMaker*)equle:(BOOL(^)(NSUInteger result))operation {
    if (operation) {
        operation(_result);
    }
    return self;
}





@end
