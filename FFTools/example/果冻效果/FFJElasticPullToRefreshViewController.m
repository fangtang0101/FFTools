//
//  FFJElasticPullToRefreshViewController.m
//  FFTools
//
//  Created by 方春高 on 16/7/29.
//  Copyright © 2016年 春高方. All rights reserved.
//

#import "FFJElasticPullToRefreshViewController.h"
#import "UIScrollView+JElasticPullToRefresh.h"

@interface FFJElasticPullToRefreshViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableViewIElastic;
@end

@implementation FFJElasticPullToRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    JElasticPullToRefreshLoadingViewCircle *loadingViewCircle = [[JElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingViewCircle.tintColor = [UIColor whiteColor];
    
    __weak __typeof(self)weakSelf = self;
    [self.tableViewIElastic addJElasticPullToRefreshViewWithActionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableViewIElastic stopLoading];
        });
    } LoadingView:loadingViewCircle];
    [self.tableViewIElastic setJElasticPullToRefreshFillColor:[UIColor colorWithRed:0.0431 green:0.7569 blue:0.9412 alpha:1.0]];
    [self.tableViewIElastic setJElasticPullToRefreshBackgroundColor:self.tableViewIElastic.backgroundColor];
}

- (void)dealloc {
    [self.tableViewIElastic removeJElasticPullToRefreshView];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    
    return cell;
}


@end
