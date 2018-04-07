//
//  MKMeViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/1/16.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKMeViewController.h"
#import "UIBarButtonItem+MKItem.h"
#import "MKSettingViewController.h"
#import "MKSquareCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "MKSquareItem.h"
#import "UIView+MKFrame.h"

#import "MKWebViewController.h"

@interface MKMeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *squareItems;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

static NSString * const ID = @"cell";

// cols = 横列上的cell 数量
static NSInteger const cols = 4;
// 分割线
static CGFloat const margin = 1;
#define itemWH (MKScreenWidth - (cols - 1) * margin) / cols
//static CGFloat itemWH = (MKScreenWidth - (cols - 1) * margin) / cols;



@implementation MKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.backgroundColor = [UIColor colorWithRed:220/256.0 green:220/256.0 blue:221/256.0 alpha:1];
    [self setupNavBar];
    
    // 设置tableview底部视图
    [self setupFootView];
    
    // 展示方块数据  -->  查看接口文档
    [self loadData];
    
    // 跳转细节
    // 1.collectionView高度重新计算
    // 2.collectionView不需要滚动
    
    // 处理cell的间距 默认tableView分组样式，有额外头部和尾部间距
    
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", NSStringFromCGRect(cell.frame));
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
}
#pragma mark - 请求数据
- (void)loadData {
    
    // 1. 创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2. 拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    // 3. 发送请求
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dictArr = responseObject[@"square_list"];
        
        // 字典数组转换成模型数组
        _squareItems = [MKSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        // 处理数据
        [self resloveData];
        
        // 设置collectionView 计算collectionView 高度 = rows(行数) * itemWH
        // Rows = (count - 1) / cols + 1 万能公式
        // count不用减1 ？
        NSInteger itemCount = _squareItems.count;
        NSInteger rows = (itemCount - 1) / cols + 1;
        // 设置collectionView的高度
        self.collectionView.mk_height = rows * itemWH;
        // 设置TableView的滚动范围
        
        // 让tableview自己去计算collectionView的高度，解决方法就是重新设置
        self.tableView.tableFooterView = self.collectionView;
        [_collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
}

#pragma mark - 处理请求完成数据
-(void)resloveData {
    // 判断缺几个数据
    // cols每行个数 -  总个数 % 每行个数
    
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (NSInteger i = 0; i < exter; i++) {
            MKSquareItem *item = [[MKSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
    
}

#pragma mark - tableViewFootView
- (void)setupFootView {
    
    /*
     1.初始化要设置流水布局
     2.cell必须要注册
     3.cell必须自定义
     
     
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    // 设置默认的间隔
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 400) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.tableView.tableFooterView = collectionView;
    collectionView.scrollEnabled = NO;
    _collectionView = collectionView;
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MKSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

#pragma mark - UICollectionViewDataSource 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.squareItems.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 从缓存池取
    MKSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
    cell.item = self.squareItems[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转界面  push
    /*
     1.safari openURL :自带很多功能（进度条，刷新，前进，倒退），必须要跳出当前应用
     2.UIWebView（没有功能），在当前应用打开网页，并且有safari，自己实现，UIWebView不能实现进度条
     3.SASafariViewController:专门用来展示网页 需求：既想要在当前应用展示网页，又想要SAFARI功能
        导入#import <SafariServices/SafariServices.h>
        iOS9才能使用
     4.WKWebView:iOS8才有 UIWebView的升级版
     
    
    */
    
    MKSquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) {
        return;
    }
    
    
//    NSURL *url = [NSURL URLWithString:item.url];
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
//    safariVC.delegate = self;
////    self.navigationController.navigationBarHidden = YES;
////    [self.navigationController pushViewController:safariVC animated:YES];
//    // App 推荐使用Modal
//    [self.navigationController presentViewController:safariVC animated:YES completion:nil];
    
    // 创建网页控制器
    MKWebViewController *webVC = [[MKWebViewController alloc] init];
    webVC.urlStr = item.url;
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}

#pragma mark - 设置导航条
- (void)setupNavBar {
    // 左边按钮
    // 不能直接通过CustomView的方式添加Button 否则会扩大点击区域
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(nightBtnClick:)];
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(settingBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    
    
    // titleView
    self.navigationItem.title = @"我的";
 
}

//#pragma mark - safariDelegate 
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
//    [self.navigationController popViewControllerAnimated:YES];
//}



- (void)nightBtnClick:(UIButton *)button {
    button.selected = !button.selected;
    
}

- (void)settingBtnClick {
    MKSettingViewController *settingVC = [[MKSettingViewController alloc] init];
    // 必须要在跳转之前去设置
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
    
    
/**
    1. 隐藏底部tabBar
    2. 处理返回按钮样式
 */
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
