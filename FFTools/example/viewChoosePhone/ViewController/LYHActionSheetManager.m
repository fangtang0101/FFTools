//
//  LYHActionSheetManager.m
//  Liangyihui
//
//  Created by 赵越 on 16/2/23.
//  Copyright © 2016年 Liangyihui. All rights reserved.
//

#import "LYHActionSheetManager.h"
//#import "LYHRootViewController.h"

@interface LYHActionSheetManager ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//@property (nonatomic, strong) LYHRootViewController *actionShowViewController;
@property (nonatomic, strong) UIView *actionShowView;
@end

@implementation LYHActionSheetManager

- (instancetype)init {
    if (self = [super init]) {
        self.uploadImageType = LYHUploadImageTypeHeadImage;
    }
    return self;
}

- (void)openCameraAndPhotoLibrarySheetWithViewController:(UIViewController *)viewController {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",  @"相册", nil];
    self->actionShowViewController = viewController;
    self.actionShowView = viewController.view;
    [actionSheet showInView:viewController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0://相机
            [self takePhoto];
            break;
        case 1://相册
            [self locationPics];
            break;
        default:
            break;
    }
}

- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
//        picker.allowsEditing = YES;//设置拍照后的图片可被编辑
        picker.sourceType = sourceType;
        [self->actionShowViewController presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)locationPics {
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else {
            data = UIImagePNGRepresentation(image);
        }
        if (self.actionManagerBlock) {
            self.actionManagerBlock(image);
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
