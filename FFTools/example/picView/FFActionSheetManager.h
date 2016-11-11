//
//  FFActionSheetManager.h
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FFActionSheetManager : NSObject{
@protected
     UIViewController*actionShowViewController;
}
@property (nonatomic, copy) void (^actionManagerBlock)(UIImage *image);//处理完成的block

- (void)openCameraAndPhotoLibrarySheetWithViewController:(UIViewController *)viewController;

@end
