//
//  ZYPhotoAlbumModel.m
//  多选图片
//
//  Created by 赵越 on 16/2/22.
//  Copyright © 2016年 赵越. All rights reserved.
//

#import "ZYPhotoAlbumModel.h"

@implementation ZYPhotoAlbumModel
- (NSMutableArray *)photoArray{
    if (!_photoArray){
        _photoArray = [[NSMutableArray alloc]init];
    }
    return _photoArray;
}

@end

@implementation ZYPhotoAlAssetModel

- (void)setPhotoURL:(NSURL *)photoURL{
    _photoURL = [photoURL copy];
    ALAssetsLibrary *libiary = [[ALAssetsLibrary alloc]init];
    // 设置图片url 时,获取相片的封面图 并放置到本model中缓存
    [libiary assetForURL:photoURL resultBlock:^(ALAsset *asset) {
        self.thumbsImage = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    } failureBlock:^(NSError *error) {
        
    }];
}

@end
