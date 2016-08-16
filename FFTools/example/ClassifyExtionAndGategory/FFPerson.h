//
//  FFPerson.h
//  Class ExtensionAndCategory
//
//  Created by 方春高 on 16/8/11.
//  Copyright © 2016年 方春高. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFPerson : NSObject

@property (nonatomic,copy) NSString *nameManin;

@end

//运用Class Extion 来分别 声明变量，在后面用的时候回比较清晰
@interface FFPerson () //work

@property (nonatomic,copy) NSString *nameWork;

@end

@interface FFPerson () //Live

@property (nonatomic,copy) NSString *nameLive;

@end

//备注： 个人认为 此处的很多 设计 都是 为了  设计API 给别人用的时候考虑的比较多，若你只是单独的自己的项目用，用处不大






