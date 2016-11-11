//
//  FFChoosePicView.m
//  FFTools
//
//  Created by Administrator on 16/11/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFChoosePicView.h"

@interface FFChoosePicView()

@property (nonatomic,strong)NSMutableArray *arrayPicViews;
@property (nonatomic,assign) BOOL isFull;//图片是否满了
@property (nonatomic,strong) NSMutableArray *arrayAllViews;
@property (nonatomic,assign) BOOL isUpload;
@property (nonatomic,assign) BOOL isNeedChange;
@property (nonatomic,assign) CGFloat spaceWidthOutside ;
@property (nonatomic,assign) CGFloat spaceWidthInside ;
@property (nonatomic,assign) CGFloat widthPicViewContainer;

@end

@implementation FFChoosePicView

#define spaceWidth 5
#define spaceHeight 5
#define viewRight (self.widthPicViewContainer)
#define pictuerHeight 90

+(instancetype)creatUploadPicViewIsNeedChange:(BOOL)isNeedChange
{
//    FFChoosePicView *VC = [[[NSBundle mainBundle] loadNibNamed:@"FFChoosePicView" owner:nil options:nil] lastObject];
    FFChoosePicView *VC = [[FFChoosePicView alloc]initWithFrame:CGRectMake(0, 100, SCREENSIZE.width, 120)];
    VC.isNeedChange = isNeedChange;
    VC.spaceWidthOutside = 15;
    VC.spaceWidthInside = 5;
    VC.widthPicViewContainer = SCREENSIZE.width - 30 ;
    VC.maxCountPic = 6;
    return VC;
}


- (void)setUpSpaceWidthOutside:(CGFloat)spaceWidthOutside spaceWidthInside:(CGFloat)spaceWidthInside  widthPicViewContainer:(CGFloat)widthPicViewContainer;
{
    if (spaceWidthOutside >= 0) {
        self.spaceWidthOutside = spaceWidthOutside;
    }
    if (self.spaceWidthInside >= 0) {
        self.spaceWidthInside = spaceWidthInside;
    }
    if (self.widthPicViewContainer) {
        self.widthPicViewContainer = widthPicViewContainer;
        
        
    }
}

//重新排序
- (void)reSortPositionWithArrayPic:(NSMutableArray *)arrayPic {
    
    self.isFull =  arrayPic.count >= self.maxCountPic ? YES :NO;
    self.arrayPicViews = arrayPic;
    
    CGFloat  viewW = ((self.widthPicViewContainer - self.spaceWidthOutside*2) -  2*self.spaceWidthInside)/3;
    if (self.isNeedChange) {
        if (arrayPic.count < self.maxCountPic ) { //如果不足6个，加上btn
            UIButton *btn = [[UIButton alloc]init];
            [btn setBackgroundImage:[UIImage imageNamed:@"hzgl_zljl_tjtp.png"] forState:UIControlStateNormal];
            [self addSubview:btn];
            btn.frame = CGRectZero;
            btn.height = viewW;
            btn.width  = viewW;
            [btn addTarget:self action:@selector(onClickAddPic:) forControlEvents:UIControlEventTouchUpInside];
            [self.arrayAllViews addObject:btn];
        }
    }
    
    NSMutableArray *array = [NSMutableArray array];
    CGFloat count = arrayPic.count >= self.maxCountPic  ? self.maxCountPic  :arrayPic.count;
    [array addObjectsFromArray:[self.arrayPicViews subarrayWithRange:NSMakeRange(0,count)]];
    
    for (int index=0; index < array.count; index ++) {
        UIView* viewObj = array[index];
        [self addSubview:viewObj];
        [viewObj drawBoarderWithColor:nil cornerRadius:5.0 borderWidt:0];
        //计算宽度
        viewObj.frame = CGRectZero;
        viewObj.height = viewW;
        viewObj.width  = viewW;
        [self.arrayAllViews addObject:viewObj];
    }
    [self reSortViews];
}

//重新排序
-(void)reSortViews{
    //重新给标签排序，主要就是frame
    for (int i = 0; i < self.arrayAllViews.count; i ++) {
        UIView * buttonCurrent  = (UIButton *)self.arrayAllViews[i];
        UIView * buttonPrevious ; //上一个button
        if (0 == i) {
            buttonCurrent.left = 0;
            buttonCurrent.top  = 0;
        }
        else{
            buttonPrevious = self.arrayAllViews[i-1];
            buttonCurrent.left = buttonPrevious.right + self.spaceWidthInside;
            buttonCurrent.top = buttonPrevious.top;
            //检查是否右侧出界
            if (buttonCurrent.right > (viewRight + 10)) {
                //往下一行
                buttonCurrent.left = 0;
                buttonCurrent.top = buttonPrevious.bottom + spaceHeight;
            }
        }
        buttonCurrent.tag = self.isFull ? i : (i - 1);
        if (self.isNeedChange) {
            [self creatDeleteButtonWithPicview:buttonCurrent];
        }
    }
    UIView * buttonLast  = self.arrayAllViews.lastObject;
    self.heightPicView =  buttonLast.bottom ;
}

//增加删除的按钮
-(void)creatDeleteButtonWithPicview:(UIView*)picview {
    if ([picview isKindOfClass:[UIButton class]]) {
        return;
    }
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = picview.tag;
    [btn setBackgroundImage:[UIImage imageNamed:@"hzgl_zljl_delete.png"] forState:UIControlStateNormal];
    [self addSubview:btn];
    btn.frame = CGRectMake(picview.right - 25, picview.bottom - 25, 25, 25);
    [btn addTarget:self action:@selector(onClickDeletePic:) forControlEvents:UIControlEventTouchUpInside];
}

//删除图片
-(void)onClickDeletePic:(UIButton* )btn {
    
    NSString *urlDelete = nil;
    NSNumber* pictureId = nil;
    
    NSObject *obj =  self.arrayPicViews[btn.tag];
    if ([obj isKindOfClass:[UIImageView class]]) {
        UIImageView *viewImage = (UIImageView*)obj;
        if (viewImage.imageURLString) {
            urlDelete = viewImage.imageURLString;
//            pictureId = viewImage.pictureId;
        }
    }
    //删除图片
    [self.delegate uploadPicviewDelegatePicIndex:btn.tag pictureId:pictureId];
}
//增加一张图片
-(void)onClickAddPic:(UIButton* )btn {
//    [self.delegate uploadPicviewAddPic];
    
//    self.actionManager = [[LYHMultipleActionSheetManager alloc]init];
//    NSUInteger count = MaxCountPic - self.arraypics.count;
//    [LYHClientConfiguration sharedConfiguration].maxSelectNumberPhoto = count > 0 ? count : 0;
//    __weak __typeof(self)weakSelf = self;
//    self.actionManager.actionManagerBlock = ^(UIImage *image) {
//        LYHImageView *imageView = [[LYHImageView alloc]init];
//        imageView.image = image;
//        [imageView fillImageUrlString:nil];
//        [weakSelf.arraypics addObject:imageView];
//        [weakSelf fillCellPicWithArrayPics:weakSelf.arraypics];
//        [weakSelf.tableViewContents reloadData];
//    };
//    [self.actionManager openCameraAndPhotoLibrarySheetWithViewController:self];
    
}

-(void)layoutSubviews {
    self.height = self.arrayPicViews.count <3 ? 120 : 300;
}

- (NSMutableArray *)arrayPicViews {
    if (!_arrayPicViews) {
        _arrayPicViews = [NSMutableArray array];
    }
    return _arrayPicViews;
}

-(NSMutableArray *)arrayAllViews {
    if (!_arrayAllViews) {
        _arrayAllViews = [NSMutableArray array];
    }
    return _arrayAllViews;
}

@end

//***************************************************** 扩展 **********************************

@implementation UIView(FF)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)drawBoarderWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius borderWidt:(CGFloat)borderWidth{
    if (cornerRadius > 0) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
    }
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
    if (borderWidth >0) {
        self.layer.borderWidth=borderWidth;
    }
}

@end

@implementation UIImageView(FF)

static NSString * FFImageURLString = @"FFImageURLString";

- (NSString *)imageURLString {
    return objc_getAssociatedObject(self, &FFImageURLString);
}

- (void)setImageURLString:(NSString *)imageURLString{
    objc_setAssociatedObject(self, &FFImageURLString, FFImageURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end




