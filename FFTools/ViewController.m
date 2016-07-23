//
//  ViewController.m
//  FFTools
//
//  Created by 春高方 on 16/7/23.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewList;
@property (nonatomic,strong) NSMutableArray *arrayList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableViewList.rowHeight = 44;
    
    self.arrayList = @[@"这是第一个",@"这是第二个"].mutableCopy;
    //注册 是用在 cell里面的，啥了吧
//    [self.tableViewList registerClass:[ViewController class] forCellReuseIdentifier:@"list"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayList.count;
}

static  NSString *stringCell = @"cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = self.arrayList[indexPath.row];
    return cell;

}


@end
