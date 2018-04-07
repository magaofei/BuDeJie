//
//  MKSettingViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKSettingViewController.h"
#import "MKFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface MKSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) NSInteger totalSize;

@end
static NSString * const ID = @"cell";
@implementation MKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航条左边按钮
    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithNormalImage:[UIImage imageNamed:@"navigationButtonReturn"] highlightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(backBtnClick) title:@"返回"];
    self.title = @"设置";
    
    // 设置右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:0 target:self action:@selector(jump)];
    UITableView *tableView = [[UITableView alloc] init];
    _tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    

}

- (void)jump {
    
}

/*
   业务类：以后开发中用来专门处理某件事情，网络处理，缓存处理 
 
 */



//- (void)backBtnClick {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 计算缓存数据，计算整个应用程序缓存数据 --> 沙盒（cache） --> 获取cache文件夹尺寸
    
    
    
    // 获取default文件夹路径
//    NSString *defaultPath = [cachePath stringByAppendingPathComponent:@"default"];
    // 传入文件夹
    

    NSString *sizeStr = [self getSizeStr];
    cell.textLabel.text = sizeStr;
    return cell;
}

// 点击cell调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 清空缓存
    
    // 删除文件夹里面所有文件
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    BOOL success = false;
    success = [MKFileTool removeDirectoryPath:cachePath];
    if (success) {
        
        self.totalSize = 0;
    }
    
    [self.tableView reloadData];
    
    
    
}

// 缓存大小名称 拼接
- (NSString *)getSizeStr {
    // 获取cache文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    [SVProgressHUD showWithStatus:@"正在计算中..."];
    
    [MKFileTool getFileSize:cachePath completion:^(unsigned long long totalSize) {
        _totalSize = totalSize;
        
        [self.tableView reloadData];
    }];
    
    NSString *sizeStr = @"清除缓存";
    if (_totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = _totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%1.fMB)", sizeStr, sizeF];
    } else if (_totalSize > 1000) {
        // KB
        CGFloat sizeF = _totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%1.fKB)", sizeStr, sizeF];
    } else if (_totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%1.ldB)", sizeStr, _totalSize];
    }
    
//    [SVProgressHUD dismiss];
    
    return sizeStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
