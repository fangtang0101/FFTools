//
//  FFMultipleActionSheetManger.m
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFMultipleActionSheetManger.h"

@implementation FFMultipleActionSheetManger

- (void)locationPics {
    FFImagePickerViewController *pickerController = [[FFImagePickerViewController alloc]init];
    pickerController.pickerDelegate = self->actionShowViewController;//随他警报吧
    [self->actionShowViewController presentViewController:pickerController animated:YES completion:nil];
}

@end
