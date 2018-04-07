//
//  MKTabBar.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKTabBar.h"

#import "UIView+MKFrame.h"

@interface MKTabBar ()

@property (nonatomic, strong) UIButton *tabBarPulishButton;

@property (nonatomic, strong) UIControl *previoudClickedTabBarButton;

@end

@implementation MKTabBar

- (UIButton *)tabBarPulishButton {
    if (_tabBarPulishButton == nil) {
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [publishButton sizeToFit];
        _tabBarPulishButton = publishButton;
        [self addSubview:publishButton];
    }
    return _tabBarPulishButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.items.count + 1;
    // tabBar的父类是UIView，所以这里可以用self
    CGFloat btnW = self.mk_width / count;
    CGFloat btnH = self.mk_height;
    CGFloat btnX = 0;
    // 布局 tabBarButton  重新修改每个tabBar的布局
    NSInteger i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        // 私有方法，不能使用 [UITabBarButton class]
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            
            if (i== 0 && self.previoudClickedTabBarButton == nil) {
                self.previoudClickedTabBarButton = tabBarButton;
            }
            // 遇到发布按钮时跳过
            if (i == 2) {
                i += 1;
            }
            
            // 设置每个tabBar的位置
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
            
            // 监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    // 设置发布按钮布局
    self.tabBarPulishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    
}

// TabBar的重复点击
// 方案1
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    if (self.previoudClickedTabBarButton == tabBarButton) {
        MKFunc;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MKTabBarButtonDidRepeatClickNotification object:nil ];
    }
    
    self.previoudClickedTabBarButton = tabBarButton;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
