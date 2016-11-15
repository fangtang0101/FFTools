//
//  LYHUploadImageManager.h
//  Liangyihui
//
//  Created by 赵越 on 16/2/26.
//  Copyright © 2016年 Liangyihui. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^UploadCompleteBlock)(NSString *);
typedef void(^UploadSuccessBlock)(NSMutableArray*);
typedef void(^UploadFailedBlock)(id);

typedef NS_ENUM(NSUInteger, LYHUploadImageType) {
    LYHUploadImageTypeHeadImage = 1,//头像
    LYHUploadImageTypeVerify,//验证材料
    LYHUploadImageTypeCaseOfSick,//病程
    LYHUploadImageTypeQa,//问答
    LYHUploadImageTypeFeedBack //反馈
};

@interface LYHUploadImageManager : NSObject

//+ (void)uploadWithImages:(NSArray <UIImage *>*)images type:(LYHUploadImageType)type completeBlock:(UploadCompleteBlock)block;
//
////zai present之后使用这个（主要就是为了菊花的展示）
//+ (void)uploadWithImages:(NSArray <UIImage *>*)images type:(LYHUploadImageType)type currentView:(UIView *)currentView completeBlock:(UploadSuccessBlock)successBlock UploadFailedBlock:(UploadFailedBlock)failedBlock;
//
////一般使用这个
//+ (void)uploadWithImages:(NSArray <UIImage *>*)images type:(LYHUploadImageType)type completeBlock:(UploadSuccessBlock)successBlock UploadFailedBlock:(UploadFailedBlock)failedBlock;
//


@end
