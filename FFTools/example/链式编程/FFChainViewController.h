//
//  FFChainViewController.h
//  FFTools
//
//  Created by 方春高 on 16/8/16.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFRootViewController.h"

#import "CaculatorMaker.h"

@interface FFChainViewController : FFRootViewController

@end
@interface NSObject(Caulator)
//参数block 返回值为make
+ (NSInteger)makeCaulators:(void(^)(CaculatorMaker*make))block;
@end