//
//  LYHMultipleActionSheetManager.m
//  Liangyihui
//
//  Created by 赵越 on 16/2/24.
//  Copyright © 2016年 Liangyihui. All rights reserved.
//

#import "LYHMultipleActionSheetManager.h"
//#import "LYHRootViewController.h"

@implementation LYHMultipleActionSheetManager

- (void)locationPics {
    ZYImagePickerViewController *pickerController = [[ZYImagePickerViewController alloc]init];
    pickerController.pickerDelegate = self->actionShowViewController;//随他警报吧
    [self->actionShowViewController presentViewController:pickerController animated:YES completion:nil];
}

@end
