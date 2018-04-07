//
//  MKLoginRegisterViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKLoginRegisterViewController.h"
#import "MKLoginRegisterView.h"
#import "UIView+MKFrame.h"
#import "MKFastLoginView.h"

@interface MKLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

/**
 改约束， 不要直接改frame
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation MKLoginRegisterViewController

- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    // 平移中间view  //判断值现在是注册还是登录
    _leadCons.constant =  _leadCons.constant == 0 ? - self.middleView.mk_width * 0.5 : 0;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

/**
 
 1.划分结构 (顶部 中间 底部) 占位视图  //  
  越复杂的界面 越要封装（复用）
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // 创建登录的View
    MKLoginRegisterView *loginView = [MKLoginRegisterView loginView];
    
    // 添加到中间的View
    [self.middleView addSubview:loginView];
    
    // 界面相似，业务逻辑差不多 可以 放在同一个xib中
    
    // 添加注册界面
    MKLoginRegisterView *registerView = [MKLoginRegisterView registerView];
    
    
    
    [self.middleView addSubview:registerView];
    
    
    // 添加底部的View
    MKFastLoginView *fastLoginView = [MKFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
    
    //  屏幕适配 的细节
    
    //  1.一个View从xib加载，需不需要再重新固定尺寸  一定要再重新设置一下
    //  2.开发中一般在viewDidLayoutSubviews布局子控件
    
    
}

// 在viewDidLayoutSubviews 布局子控件
// 这个方法里才会根据布局调整控件的尺寸  在ViewDidLoad中布局是没有效果的
- (void)viewDidLayoutSubviews {
    
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    MKLoginRegisterView *loginView = [self.middleView.subviews firstObject];
    loginView.frame = CGRectMake(0, 0, self.middleView.mk_width * 0.5, self.middleView.mk_height);
    
    MKLoginRegisterView *registerView = [self.middleView.subviews lastObject];
    // 重新再确定一下
    registerView.frame = CGRectMake(self.middleView.mk_width * 0.5, 0, self.middleView.mk_width * 0.5, self.middleView.mk_height);  // 让他在右边
    
    MKFastLoginView *fastLoginView = [self.bottomView.subviews firstObject];
    fastLoginView.frame = self.bottomView.bounds;
    
    
    //
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
