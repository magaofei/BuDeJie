//
//  MKAllViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/13.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKAllViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "MKTopic.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD.h>

@interface MKAllViewController () <UIScrollViewDelegate>




@property (nonatomic, assign) NSInteger dataCount;

// 下拉刷新控件里的名字
@property (nonatomic, strong) UILabel *tableViewFooterRefreshLabel;

// 下拉刷新控件View
@property (nonatomic, strong) UIView *tableViewFooterRefreshView;

// 上拉刷新控件里的名字
@property (nonatomic, strong) UILabel *tableViewHeaderRefreshLabel;

// 上拉刷新控件View
@property (nonatomic, strong) UIView *tableViewHeaderRefreshView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *topics;

/**
 当前最后一条帖子数据的描述信息，用来加载下一页数据
 */
@property (nonatomic, copy) NSString *maxTime;


/**
 上拉刷新控件是否正在刷新
 */
@property (nonatomic, assign) BOOL footerRefreshing;

/**
 下拉刷新控件是否正在刷新
 */
@property (nonatomic, assign) BOOL headerRefreshing;





@end

@implementation MKAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.contentInset = UIEdgeInsetsMake(MKNavBarMaxH + MKTitlesViewH, 0, MKTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    // 重复点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:MKTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:MKTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
    
    self.dataCount = 5 ;
    [self headerBeginRefresh];

}

- (void)setupRefresh {
    
    // header
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, -50, self.tableView.mk_width, 50);
    self.tableViewHeaderRefreshView = headerView;
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.frame = headerView.bounds;
    [headerView addSubview:headerLabel];
    _tableViewHeaderRefreshLabel = headerLabel;
    // 不能写成headerView
    [self.tableView addSubview:headerView];
    
    
    
    // footer
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.mk_width, 35);
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [UIColor blackColor];
    footerLabel.frame = footerView.bounds;
    [footerView addSubview:footerLabel];
    _tableViewFooterRefreshLabel = footerLabel;
    self.tableView.tableFooterView = footerView;
    
}

#pragma mark - TabBar重复点击
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)tabBarButtonDidRepeatClick {
    // 重复点击的不是精华按钮 return
    /// 控制器的view不再window上面, 说明重复点击的不是这个按钮
    if (self.view.window == nil) {
        return;
    }
    
    // 显示在正中间的不是AllViewController return
    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    
    [self headerBeginRefresh];
    MKFunc;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    MKTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;

    return cell;
}


/**
 当用户松开scrollView时调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.headerRefreshing) {
        return;
    }
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.tableViewHeaderRefreshView.mk_height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        [self headerBeginRefresh];
         }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    // 处理header
    [self headerRefresh];
    
    // 处理footer
    [self footerRefresh];
}

- (void)headerRefresh {
    
    if (self.headerRefreshing) {
        return;
    }
    // 当ScrollView的偏移量Y值 <= offsetY时，代表header已经完全出现
    CGFloat offsetY = - (self.tableView.contentInset.top + self.tableViewHeaderRefreshView.mk_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        self.tableViewHeaderRefreshLabel.text = @"松开立即刷新";
        
    } else {
        self.tableViewHeaderRefreshLabel.text = @"下拉可以刷新";
    }

}

- (void)footerRefresh {
    // 还没有任何内容的时候，不需要刷新
    if (self.tableView.contentSize.height == 0) {
        return;
    }
    
    // 如果正在刷新，直接返回
    if (self.footerRefreshing == YES) {
        return;
    }
    
    // 当ScrollView的偏移量y值 >= OffsetY时，代表footer已经完全出现
    // contentOffset.y = 内容高度+底部内边距-frame高度
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.mk_height - self.tableView.tableFooterView.mk_height * 2;
    // footer完全出现，并且是往下拖拽 防止数据量少时触发
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        [self footerBeginRefresh];
    }

}

#pragma mark - header
- (void)headerBeginRefresh {
    // 如果下拉刷新正在刷新，直接返回
    if (self.headerRefreshing) {
        return;
    }
    
    self.tableViewHeaderRefreshLabel.text = @"正在加载中";
    self.headerRefreshing = YES;
//    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y - self.tableViewHeaderRefreshView.mk_height);
    
    // 增加内边距
    [UIView animateWithDuration:0.4 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.tableViewHeaderRefreshView.mk_height;
        self.tableView.contentInset = inset;
        
        // 修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - inset.top);
    }];
    
    [self loadNewTopics];
}


/**
 下拉刷新数据
 */
- (void)loadNewTopics {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    parameters[@"mintime"] = @"1440496442";
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (responseObject) {
            // 字典数组 -> 模型
            NSMutableArray *newTopics = [MKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            if (self.topics) {
                [self.topics insertObjects:newTopics atIndexes:[NSIndexSet indexSetWithIndex:0]];
            } else {
                self.topics = newTopics;
            }
            // 存储maxTime
            self.maxTime = responseObject[@"info"][@"maxtime"];
            [self.tableView reloadData];
            
            [self headerEndRefresh];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后重试"];
        [self headerEndRefresh];
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.dataCount = 20;
//        [self.tableView reloadData];
//        
//        [self headerEndRefresh];
//    });

}


/**
 上拉刷新加载更多数据
 */
- (void)loadMoreTopics {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    parameters[@"maxtime"] = self.maxTime;
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.maxTime = responseObject[@"info"][@"maxtime"];

        if (responseObject) {
            // 字典数组 -> 模型
            NSArray *moreTopics = [MKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.topics addObjectsFromArray:moreTopics];
            
            [self.tableView reloadData];
            
            [self footerEndRefresh];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后重试"];
        [self footerEndRefresh];
    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        // 模拟请求数据返回
//        self.dataCount += 12;
//        [self.tableView reloadData];
//        [self footerEndRefresh];
//        
//    });
}



- (void)headerEndRefresh {
    self.tableViewHeaderRefreshLabel.text = @"下拉可以刷新";
    self.headerRefreshing = NO;
    // 结束刷新
    // 减少内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.tableViewHeaderRefreshView.mk_height;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark - footer
- (void)footerBeginRefresh {
    
    // 如果下拉刷新正在刷新，直接返回
    if (self.footerRefreshing) {
        return;
    }
    // 进入刷新状态
    self.tableViewFooterRefreshLabel.text = @"正在加载更多数据";
    self.footerRefreshing = YES;
    
    [self loadMoreTopics];

}

- (void)footerEndRefresh {
    // 结束刷新
    self.footerRefreshing = NO;
    self.tableViewFooterRefreshLabel.text = @"上拉可以加载更多";

}




@end
