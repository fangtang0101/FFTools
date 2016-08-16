//
//  FFHeaderScollerViewController.m
//  FFTools
//
//  Created by 方春高 on 16/8/11.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFHeaderScollerViewController.h"

@interface FFHeaderScollerViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewContariner;
@property (weak, nonatomic) IBOutlet UITableView *tableViewList;

@end

@implementation FFHeaderScollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    
    
//    self.topViewContariner.constant = -30;
    
//    self.tableViewList.scrollEnabled = NO;
//
//    UIImageView *viewHeader =  [[UIImageView alloc]init];
//    viewHeader.frame = CGRectMake(0, 0, 100, 100);
//    viewHeader.backgroundColor = [UIColor redColor];
//    self.tableViewList.tableHeaderView = viewHeader;
//    
//    viewHeader.image = [UIImage imageNamed:@"1.jpg"];
//    
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    
//    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
//    
//    self.tableViewList.separatorEffect = vibrancyEffect;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate 协议方法
#pragma mark -- tableViewDelegate

//每个section中有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
 
}
  static  NSString *cellString = @"cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellString];
    }
    cell.textLabel.text = @"women";
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat heightY = scrollView.contentOffset.y;
    
    if (heightY > 100) {
        [scrollView setContentOffset:CGPointMake(0, heightY*0.5)];
    }
    
    
    
    NSLog(@"==%f",scrollView.contentOffset.y);
    
//    CGFloat height11 = -120 ;
//    
//    if (scrollView.contentOffset.y > 0) { //上提
//        
//        CGFloat height = 0;
//        
//        height = scrollView.contentOffset.y > 120 ? 120 :  scrollView.contentOffset.y;
//        
//        //        self.heightViewImage.constant = (120 - height);
//        NSLog(@"++++++ height %f",height);
//        //        self.topImageView.constant = -height;
//        
////        self.topViewContariner.constant = -height;
//        
//    }else{ //下拉
//        
//        NSLog(@"---");
//        
//    }
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {


    NSLog(@"scrollViewWillEndDragging");
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesBegan");


}






@end
