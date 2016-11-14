//
//  FFPhotoAlbumModel.h
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class FFPhotoAlAssetModel;


@interface FFPhotoAlbumModel : NSObject

@property (nonatomic, copy) NSData *thumbImageData;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, assign) NSInteger albumCount;
@property (nonatomic, strong) NSMutableArray *photoArray;

@end

@interface FFPhotoAlAssetModel: NSObject
@property (nonatomic, copy) NSURL *photoURL;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, strong) UIImage *thumbsImage;
@property (nonatomic, strong) UIImage *detailImage;
@property (nonatomic, assign) NSInteger oriaginalSize;

@end
