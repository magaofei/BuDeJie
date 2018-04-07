//
//  MKSubTagViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/7.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "MKSubTagItem.h"
#import "MKSubTagCell.h"
#import "MKSubTagTopListItem.h"



@interface MKSubTagViewController ()

@property (nonatomic, strong) NSDictionary *subTag;

@property (nonatomic, strong) MKSubTagItem *subTagItem;

@property (nonatomic, strong) AFHTTPSessionManager *manager;




/**
 json推荐列表
 */
@property (nonatomic, strong) NSArray *topList;

@end

static NSString *ID = @"cell";

@implementation MKSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 展示标签数据 -> 请求数据（接口文档）
    
    //
    // 注册cell    没有注册的话不要忘记在xib中设置 Reuse
    [self.tableView registerNib:[UINib nibWithNibName:@"MKSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    
    [self loadData];
    
    self.title = @"推荐标签";
    
    /*
        头像变成圆角 1.设置头像圆角 2.裁剪图片
        处理数字
     */
    
    // 处理cell分割线 1.自定义分割线 2.系统属性(iOS8才支持)  3.万能方法(重写cell的setFrame) 了解TableView底层实现 
    // 2.通过系统属性， 清空TableView分割线内边距 清空cell的约束边缘
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    // tableView 底层实现
    // 1.首先把所有cell的位置全部计算好，保存
    // 2.当cell要显示的时候，就会拿到这个cell去设置frame
    // 实现：1.取消系统自带分割线  2.把TableView背景色设置为分割线的背景色， 3重写setFrame
    // 原理是：修改TableView的背景色为间隔线的颜色，然后减去一个像素的cell的高度，模拟实现效果
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:220/256.0 green:220/256.0 blue:221/256.0 alpha:1];
    
    // 提示用户当前正在加载数据 SVP
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    
    
}


/**
 界面即将消失时调用

 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 销毁指示器
    [SVProgressHUD dismiss];
    
    // 取消之前的请求
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
}

- (void)loadData {
    
    _manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"a"] = @"tag_recommend";
//    parameters[@"action"] = @"sub";
//    parameters[@"c"] = @"topic";
    
    // 必填
    parameters[@"a"] = @"friend_recommend";
    parameters[@"c"] = @"user";
    
    //  最新API
    //  http://api.budejie.com/api/api_open.php?a=friend_recommend&appname=bs0315&asid=00000000-0000-0000-0000-000000000000&c=user&client=iphone&device=iPhone%206S&from=ios&jbk=0&last_coord=&last_flag=list&market=&openudid=853afc2627f6bd3a31f91e371ff267a76ca12e25&pre=50&t=1486464598&udid=&ver=4.5.4
    
    // a
    [_manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (responseObject) {
            MKSubTagItem *item = [[MKSubTagItem alloc] initWithDictonaty:responseObject];
            // 传递模型
            _subTagItem = item;
        }
        
        [SVProgressHUD dismiss];
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
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

    return self.subTagItem.topLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MKFunc;
    MKSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 自定义cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MKSubTagCell class]) owner:nil options:nil] firstObject];
    }
    
    
    if (self.subTagItem) {
        MKSubTagTopListItem *item = self.subTagItem.topLists[indexPath.row];
        cell.item = item;
    }
    // 2.通过系统属性， 清空TableView分割线内边距 清空cell的约束边缘
    cell.layoutMargins = UIEdgeInsetsZero;
    
//    NSDictionary *item = topList[indexPath.row];
//    NSString *itemName = item[@"screen_name"];
//    cell.textLabel.text = itemName;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MKFunc;
    return 80;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
