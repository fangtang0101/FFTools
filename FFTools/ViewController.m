//
//  ViewController.m
//  FFTools
//
//  Created by 春高方 on 16/7/23.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "ViewController.h"
#import "FFStringViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewList;
@property (nonatomic,strong) NSMutableArray *arrayList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewList.rowHeight = 44;
//    self.arrayList = @[@"string的用法汇总",@"这是第二个"].mutableCopy;
    
    [self.arrayList addObject:[FFModelVC ModelVCWithtitle:@"string的用法汇总" nameVC:@"FFStringViewController"]];
    
    
    
    
    //注册 是用在 cell里面的，傻了吧
//    [self.tableViewList registerClass:[ViewController class] forCellReuseIdentifier:@"list"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

static  NSString *stringCell = @"cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFModelVC *model = self.arrayList[indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.nameVC;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *stringVC = ((FFModelVC*)self.arrayList[indexPath.row]).nameVC;
    
    
    UIViewController *VC = [[NSClassFromString(stringVC) alloc]init];
    
    FFStringViewController *VCMy  = [[FFStringViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - setter And getter
-(NSMutableArray *)arrayList {
    
    if (!_arrayList) {
        _arrayList = [NSMutableArray array];
    }
    return _arrayList;

}


@end


@implementation FFModelVC

+(instancetype)ModelVCWithtitle:(NSString *)title nameVC:(NSString*)nameVC {
    
    FFModelVC *obj = [[FFModelVC alloc]init];
    obj.title = title;
    obj.nameVC = nameVC;
    return obj;

}


@end
