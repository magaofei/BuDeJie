//
//  MKNavigationViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKNavigationViewController.h"
#import "UIBarButtonItem+MKItem.h"

@interface MKNavigationViewController () <UIGestureRecognizerDelegate>

@end


/**
 搭建基本结构 --> 设置底部条 --> 设置顶部条 --> 设置顶部条标题字体 --> 处理导航控制器业务逻辑 
 */
@implementation MKNavigationViewController

+ (void)load {
    // 拿到所有的 UINavigationBar 目的是要统一修改所有的Nav标题
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 设置导航条标题
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.interactivePopGestureRecognizer.delegate = self;
    // 为导航控制器添加全屏滑动手势 私有方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    // 控制手势什么时候触发，只有非根控制器才需要触发  防止假死状态
    pan.delegate = self;
    
    // 禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

// 设置所有控制器跳转后的返回按钮，在push之前设置
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 滑动返回失效 --> 分析：把系统的返回按钮覆盖 --> 手势失效(1, 手势被清空 2 可能手势代理做了一些事情导致手势失效)
    
    // 判断是否为非根控制器
    if (self.childViewControllers.count > 0) {
        // 设置返回按钮
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithNormalImage:[UIImage imageNamed:@"navigationButtonReturn"] highlightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(backBtnClick) title:@"返回"];
//        MKLog(@"%@", self.interactivePopGestureRecognizer);
    }
    
    // 全屏滑动调用的方法
    // <UIScreenEdgePanGestureRecognizer: 0x1004041a0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x100335da0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x10040f8a0>)>>
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)backBtnClick {
    [self popViewControllerAnimated:YES];
}

// 判断是否为非根控制器，以确定需要滑动返回
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
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
