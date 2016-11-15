//
//  LYHActionSheetManager.h
//  Liangyihui
//
//  Created by 赵越 on 16/2/23.
//  Copyright © 2016年 Liangyihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYHUploadImageManager.h"
#import <UIKit/UIKit.h>

@class LYHRootViewController;

@interface LYHActionSheetManager : NSObject
{
    @protected
        UIViewController *actionShowViewController;
}
@property (nonatomic, copy) void (^actionManagerBlock)(UIImage *image);//处理完成的block
@property (nonatomic, assign) LYHUploadImageType uploadImageType;//默认是头像

- (void)openCameraAndPhotoLibrarySheetWithViewController:(UIViewController *)viewController;
@end
