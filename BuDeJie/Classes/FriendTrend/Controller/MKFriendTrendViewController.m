//
//  MKFriendTrendViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/1/16.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKFriendTrendViewController.h"
#import "UIBarButtonItem+MKItem.h"
#import "MKLoginRegisterViewController.h"
#import "UITextField+MKPlaceholder.h"

@interface MKFriendTrendViewController ()

@end

@implementation MKFriendTrendViewController


/**
 点击登录注册按钮
 */
- (IBAction)clickLoginRegister:(UIButton *)sender {
    MKLoginRegisterViewController *loginVC = [[MKLoginRegisterViewController alloc] init];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
    
//    UITextField *test = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
//    test.borderStyle = UITextBorderStyleLine;
//    test.placeholderColor = [UIColor redColor];
//    test.placeholder = @"123";
//
//    [self.view addSubview:test];
    
}

#pragma mark - 设置导航条
- (void)setupNavBar {
    // 左边按钮
    // 不能直接通过CustomView的方式添加Button 否则会扩大点击区域
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] addTarget:self action:@selector(friendsRecommentClick)];
    
    
    // titleView
    self.navigationItem.title = @"我的关注";
}

- (void)friendsRecommentClick {
//    MKFunc;
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
