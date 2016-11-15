//
//  ZYImagePickerViewController.h
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYImagePickerDelegate;
@interface ZYImagePickerViewController : UINavigationController
@property (nonatomic, weak) id <ZYImagePickerDelegate> pickerDelegate;
@end

@protocol ZYImagePickerDelegate <NSObject>
/**
 *  代理方法 - 选择完成后回调
 *
 *  @param picker     选择器对象
 *  @param imageArray 图片数组 元素为UIImage
 */
- (void)zweiImagePicker:(ZYImagePickerViewController *)picker didSelectedImages:(NSArray <UIImage *>*)imageArray;

@end
