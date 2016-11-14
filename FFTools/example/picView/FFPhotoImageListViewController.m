//
//  FFPhotoImageListViewController.m
//  FFTools
//
//  Created by Administrator on 16/11/14.
//  Copyright © 2016年 春高方. All rights reserved.
//
#import "FFPhotoAlbumModel.h"
#import "FFPhotoImageListViewController.h"

#define imageListCellHeight (self.view.bounds.size.width-20)/4

static NSString *const photoCellIdentifier = @"photoCellIdentifier";

@protocol  FFPhotoImageListCellDelegate ;

//*************************************** cell st **************************

@interface FFPhotoImageListCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, weak) id<FFPhotoImageListCellDelegate> delegate;
@property (nonatomic, strong) FFPhotoAlAssetModel *assetModel;
@end

@protocol FFPhotoImageListCellDelegate <NSObject>

- (void)zweiPhotoListCellDidSelected:(FFPhotoImageListCell*)cell;

@end

@implementation FFPhotoImageListCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.thumbImageView];
        [self.contentView addSubview:self.selectButton];
    }
    return self;
}

- (void)selectAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zweiPhotoListCellDidSelected:)]) {
        [self.delegate zweiPhotoListCellDidSelected:self];
    }
}


-(void)setAssetModel:(FFPhotoAlAssetModel *)assetModel {
    _assetModel = assetModel;
    self.thumbImageView.image = assetModel.thumbsImage;
    self.selectButton.selected = assetModel.isSelected;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thumbImageView.frame = self.contentView.frame;
    _selectButton.frame = CGRectMake(self.contentView.frame.size.width-25, 5, 20, 20);
}

- (UIImageView *)thumbImageView {
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc]init];
        _thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbImageView.layer.masksToBounds = YES;
    }
    return _thumbImageView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"pic_select"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"pic_select_click"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

@end

//*************************************** cell end **************************


@interface FFPhotoImageListViewController ()

@end

@implementation FFPhotoImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
