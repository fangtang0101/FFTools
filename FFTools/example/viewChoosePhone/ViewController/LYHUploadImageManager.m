//
//  LYHUploadImageManager.m
//  Liangyihui
//
//  Created by 赵越 on 16/2/26.
//  Copyright © 2016年 Liangyihui. All rights reserved.
//

#import "LYHUploadImageManager.h"
//#import "LYHRootViewController.h"
//#import "LYHGetQiNiuUpLoadTokenRequest.h"
//#import "LYHGetQiNiuUpLoadTokenResponse.h"
//#import "LYHQiNiuUpLoadResponse.h"
//#import "LYHGetQiNiuPicUrlRequest.h"
//#import "LYHGetQiNiuPicUrlResponse.h"
//#import "QiniuSDK.h"

@interface LYHUploadImageManager()

@end

@implementation LYHUploadImageManager

//+ (void)uploadWithImages:(NSArray <UIImage *>*)images type:(LYHUploadImageType)type completeBlock:(UploadCompleteBlock)block {
//    for (NSUInteger i = 0; i < images.count; i++) {
//        UIImage *image = images[i];
//        [[LYHRootViewController new] goInsideWithProgressCreating:^LYHProgressViewProperties *{
//            return nil;
//        } requestCreating:^LYHRequest *{
//            LYHGetQiNiuUpLoadTokenRequest *request = [[LYHGetQiNiuUpLoadTokenRequest alloc]init];
//            request.picType = @(type);
////            request.topic = @"测试";
////            request.no = @(i);
//            return request;
//        } onSuccessful:^(id fetchedData) {
//            LYHGetQiNiuUpLoadTokenResponse *response = fetchedData;
//            QNUploadManager *upManager = [[QNUploadManager alloc]init];
//            NSData *data = UIImagePNGRepresentation(image);
//            [upManager putData:data key:response.qiniuKey token:response.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                LYHLog(@"%@", info);
//                LYHLog(@"%@", resp);
//                LYHLog(@"key,== %@",key);
//                
//                [[LYHRootViewController new] goInsideWithProgressCreating:^LYHProgressViewProperties *{
//                    return nil;
//                } requestCreating:^LYHRequest *{
//                    
//                    LYHGetQiNiuPicUrlRequest *request = [LYHGetQiNiuPicUrlRequest new];
//                    request.picKey = [NSString stringWithFormat:@"QuestionAnswer:%@", key];
//                    return request;
//                } onSuccessful:^(id fetchedData) {
//                    LYHGetQiNiuPicUrlResponse *response = fetchedData;
//                    block(response.picUrl);
//                } onFailed:^(LYHNetworkError *error) {
//                    LYHWarningAlertView(@"图片生成链接失败");
//                }];
//                
//            } option:nil];
//        } onFailed:^(LYHNetworkError *error) {
//            LYHWarningAlertView(@"图片上传失败");
//        }];
//    }
//}
//
//+ (void)uploadWithImages:(NSArray <UIImage *>*)images type:(LYHUploadImageType)type completeBlock:(UploadSuccessBlock)successBlock UploadFailedBlock:(UploadFailedBlock)failedBlock 
//{
//    NSMutableArray *arrayKeys = [NSMutableArray array];
//     __block int mark = 0;
//    for (NSUInteger i = 0; i < images.count; i++) {
//        UIImage *image = images[i];
//        
//        UIViewController *currentVC =   [LYHRootViewController topViewController];
//        LYHProgressView* progressView = [LYHProgressView extractSelfByXib];
//        [progressView setTitle:@"正在上传"];
//        progressView.center = currentVC.view.center;
//        [currentVC.view addSubview:progressView];
//        
//        [[LYHRootViewController new] goInsideWithProgressCreating:^LYHProgressViewProperties *{
//            LYHProgressViewProperties *properties = [LYHProgressViewProperties defaultProperties];
//            properties.title = [NSString stringWithFormat:@"正在上传第%zd张", i];
//            properties.cancelable = NO;
////          UIViewController *VC =   [LYHRootViewController topViewController];
////          properties.attachee = VC.view;
//            return properties;
//        } requestCreating:^LYHRequest *{
//            LYHGetQiNiuUpLoadTokenRequest *request = [[LYHGetQiNiuUpLoadTokenRequest alloc]init];
//            request.picType = @(type);
////            request.topic = @"ceshi";
////            request.no = @(i);
//            return request;
//        } onSuccessful:^(id fetchedData) {
//            LYHGetQiNiuUpLoadTokenResponse *response = fetchedData;
//            QNUploadManager *upManager = [[QNUploadManager alloc]init];
//            NSData *data = UIImagePNGRepresentation(image);
//            [upManager putData:data key:response.qiniuKey token:response.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                LYHLog(@"%@", info);
//                LYHLog(@" resp = %@", resp);
//                LYHLog(@"ley,== %@",key);
//                NSString *qiniuKey =  resp[@"qiniuKey"];
//                [arrayKeys addObject:qiniuKey];
//                if (mark == images.count - 1) {
//                    for (UIView *viewCurrent in currentVC.view.subviews) {
//                        if ([viewCurrent isKindOfClass:[LYHProgressView class]]) {
//                            [viewCurrent removeFromSuperview];
//                            break;
//                        }
//                    }
//                      successBlock(arrayKeys);
//                }
//                mark++ ;
//            } option:nil];
//        } onFailed:^(LYHNetworkError *error) {
//            for (UIView *viewCurrent in currentVC.view.subviews) {
//                if ([viewCurrent isKindOfClass:[LYHProgressView class]]) {
//                    [viewCurrent removeFromSuperview];
//                    break;
//                }
//            }
//            failedBlock(error);
//        }];
//    }
//}
//
//+ (void)uploadWithImages:(NSArray <UIImage *>*)images type:(LYHUploadImageType)type currentView:(UIView *)currentView completeBlock:(UploadSuccessBlock)successBlock UploadFailedBlock:(UploadFailedBlock)failedBlock;
//{
//    NSMutableArray *arrayKeys = [NSMutableArray array];
//    __block int mark = 0;
//    for (NSUInteger i = 0; i < images.count; i++) {
//        UIImage *image = images[i];
//        
//        LYHProgressView* progressView = [LYHProgressView extractSelfByXib];
//        [progressView setTitle:@"正在上传"];
//        progressView.center = currentView.center;
//        [currentView addSubview:progressView];
//        UIViewController *currentVC = [LYHRule getNearVCWithView:currentView];
//        
//        [[LYHRootViewController new] goInsideWithProgressCreating:^LYHProgressViewProperties *{
//            LYHProgressViewProperties *properties = [LYHProgressViewProperties defaultProperties];
//            properties.title = [NSString stringWithFormat:@"正在上传第%zd张", i];
//            properties.cancelable = NO;
//            properties.attachee = currentView;
//            return properties;
//        } requestCreating:^LYHRequest *{
//            LYHGetQiNiuUpLoadTokenRequest *request = [[LYHGetQiNiuUpLoadTokenRequest alloc]init];
//            request.picType = @(type);
////            request.topic = @"ceshi";
////            request.no = @(i);
//            return request;
//        } onSuccessful:^(id fetchedData) {
//            LYHGetQiNiuUpLoadTokenResponse *response = fetchedData;
//            QNUploadManager *upManager = [[QNUploadManager alloc]init];
//            NSData *data = UIImagePNGRepresentation(image);
//            [upManager putData:data key:response.qiniuKey token:response.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                
//                LYHLog(@"%@", info);
//                LYHLog(@" resp = %@", resp);
//                LYHLog(@"ley,== %@",key);
//                
//                NSString *qiniuKey =  resp[@"qiniuKey"];
//                if (qiniuKey.length > 0) { //安全检查
//                      [arrayKeys addObject:qiniuKey];
//                }
//                if (mark == images.count - 1) {
//                    for (UIView *viewCurrent in currentVC.view.subviews) {
//                        if ([viewCurrent isKindOfClass:[LYHProgressView class]]) {
//                            [viewCurrent removeFromSuperview];
//                            break;
//                        }
//                    }
//                    successBlock(arrayKeys);
//                }
//                mark++ ;
//            } option:nil];
//        } onFailed:^(LYHNetworkError *error) {
//            for (UIView *viewCurrent in currentVC.view.subviews) {
//                if ([viewCurrent isKindOfClass:[LYHProgressView class]]) {
//                    [viewCurrent removeFromSuperview];
//                    break;
//                }
//            }
//            failedBlock(error);
//        }];
//    }
//}



@end
