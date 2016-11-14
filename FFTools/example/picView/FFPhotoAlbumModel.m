//
//  FFPhotoAlbumModel.m
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFPhotoAlbumModel.h"

@implementation FFPhotoAlbumModel

- (NSMutableArray *)photoArray{
    if (!_photoArray){
        _photoArray = [[NSMutableArray alloc]init];
    }
    return _photoArray;
}

@end


@implementation FFPhotoAlAssetModel

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
