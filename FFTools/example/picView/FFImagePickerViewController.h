//
//  FFImagePickerViewController.h
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FFBigPhotoLoadFinish)(UIImage *image , NSInteger imageSize);

@protocol FFImagePickerDelegate;
@interface FFImagePickerViewController : UINavigationController

@property (nonatomic, weak) id <FFImagePickerDelegate> pickerDelegate;

/**
 *  代理方法 - 选择完成后回调
 *
 *  @param picker     选择器对象
 *  @param imageArray 图片数组 元素为UIImage
 */
- (void)zweiImagePicker:(FFImagePickerViewController *)picker didSelectedImages:(NSArray <UIImage *>*)imageArray;

@end

@interface UIImage(FF)

+ (UIImage *)createImageWithColor:(UIColor *)color;
@end

@interface UIImageView (FF)
/**
 *  通过图片url加载大图(多线程加载)
 *
 *  @param alassetURL  图片在相册的url
 *  @param placeImage  占位图
 *  @param finishBlock 完成后回调的block
 */
- (void)loadLibraryBigImage:(NSURL *)alassetURL placeImage:(UIImage *)placeImage finishBlock:(FFBigPhotoLoadFinish)finishBlock;
@end


@interface UIColor (FF)

+ (UIColor*)colorWithHexString:(NSString*)color alpha:(float)opacity;

@end


