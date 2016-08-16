//
//  FFOther.m
//  Class ExtensionAndCategory
//
//  Created by 方春高 on 16/8/11.
//  Copyright © 2016年 方春高. All rights reserved.
//

#import "FFOther.h"

@implementation FFOther

-(void)canGetPersonPasswordWith:(FFPerson *)person {
    //备注: 此处的password FFPerson 的私有属性，导入 FFPerson.h 文件 就找不到
    NSString *myPassWord = person.passWord;
}

@end
