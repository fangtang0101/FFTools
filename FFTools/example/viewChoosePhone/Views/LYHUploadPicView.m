//
//  LYHUploadPicView.m
//  Liangyihui
//
//  Created by 方春高 on 16/2/23.
//  Copyright © 2016年 Liangyihui. All rights reserved.
//

#import "LYHUploadPicView.h"
#import "LYHImageView.h"

@interface LYHUploadPicView()
@property (nonatomic,strong)NSMutableArray *arrayPicViews;
@property (nonatomic,assign) BOOL isFull;//图片是否满了
@property (nonatomic,strong) NSMutableArray *arrayAllViews;
@property (nonatomic,assign) BOOL isUpload;
@property (nonatomic,assign) BOOL isNeedChange;

@property (nonatomic,assign) CGFloat spaceWidthOutside ;
@property (nonatomic,assign) CGFloat spaceWidthInside ;
@property (nonatomic,assign) CGFloat widthPicViewContainer;

@end

@implementation LYHUploadPicView
#define spaceWidth 5
#define spaceHeight 5
#define viewRight (self.widthPicViewContainer)
#define pictuerHeight 90


+(instancetype)creatUploadPicViewIsNeedChange:(BOOL)isNeedChange
{
    LYHUploadPicView *VC = [[[NSBundle mainBundle] loadNibNamed:@"LYHUploadPicView" owner:nil options:nil] lastObject];
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
    
    [self.arrayAllViews removeAllObjects];
    

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
    [picview addSubview:btn];
    btn.frame = CGRectMake(picview.width - 25, picview.height - 25, 25, 25);
    [btn addTarget:self action:@selector(onClickDeletePic:) forControlEvents:UIControlEventTouchUpInside];
    picview.userInteractionEnabled = YES;
}

//删除图片
-(void)onClickDeletePic:(UIButton* )btn {
    
  NSString *urlDelete = nil;
  NSNumber* pictureId = nil;
    
  NSObject *obj =  self.arrayPicViews[btn.tag];
    
    if ([obj isKindOfClass:[LYHImageView class]]) {
        LYHImageView *viewImage = (LYHImageView*)obj;
//        if (viewImage.imageURLString) {
            urlDelete = viewImage.imageURLString;
            pictureId = viewImage.pictureId;

        [((LYHImageView*)obj) removeFromSuperview];
        
        [self.arrayAllViews removeObject:obj];
        [self.arrayPicViews removeObject:obj];
        
            //删除
//          [self.arrayPicViews removeObjectAtIndex:btn.tag];
            [self reSortPositionWithArrayPic:self.arrayPicViews];
        [self setNeedsLayout];
        [self setNeedsDisplay];
//        }
    }
    //删除图片
//    [self.delegate uploadPicviewDelegatePicIndex:btn.tag pictureId:pictureId];
}

-(NSMutableArray *)getAllPic {
    
    return self.arrayPicViews;

}
//增加一张图片
-(void)onClickAddPic:(UIButton* )btn {
    [self.delegate uploadPicviewAddPic];
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
