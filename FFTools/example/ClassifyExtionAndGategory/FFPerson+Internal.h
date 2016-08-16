//
//  FFPerson+Internal.h
//  Class ExtensionAndCategory
//
//  Created by 方春高 on 16/8/11.
//  Copyright © 2016年 方春高. All rights reserved.
//

#import "FFPerson.h"

@interface FFPerson (Internal)

@end

//备注: 此处为 在 category中 再次使用 Class Extension
@interface FFPerson ()

@property (nonatomic,assign)NSString *passWord;

@end
