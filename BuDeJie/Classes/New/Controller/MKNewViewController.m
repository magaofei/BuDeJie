//
//  MKNewViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/1/16.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKNewViewController.h"
#import "UIBarButtonItem+MKItem.h"
#import "MKSubTagViewController.h"

@interface MKNewViewController ()

@end

@implementation MKNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
}

#pragma mark - 设置导航条
- (void)setupNavBar {
    // 左边按钮
    // 不能直接通过CustomView的方式添加Button 否则会扩大点击区域
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(tagClick)];
    
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)tagClick {
    // 进入推荐标签界面
    MKSubTagViewController *subTag = [[MKSubTagViewController alloc] init];
    [self.navigationController pushViewController:subTag animated:YES];
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
