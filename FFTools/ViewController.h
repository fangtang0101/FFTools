//
//  ViewController.h
//  FFTools
//
//  Created by 春高方 on 16/7/23.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface FFModelVC : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *nameVC;

+(instancetype)ModelVCWithtitle:(NSString *)title nameVC:(NSString*)nameVC;
@end

