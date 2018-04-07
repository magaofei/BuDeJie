//
//  UIBarButtonItem+MKItem.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "UIBarButtonItem+MKItem.h"

@implementation UIBarButtonItem (MKItem)

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage addTarget:(id)target action:(SEL)action {
    
    UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // setImage与setBackgroundImage有什么区别？
    [barBtn setImage:normalImage forState:UIControlStateNormal];
    [barBtn setImage:highlightImage forState:UIControlStateHighlighted];
    [barBtn sizeToFit];
    [barBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 将button包装为UIView
    UIView *barBtnView = [[UIView alloc] initWithFrame:barBtn.bounds];
    [barBtnView addSubview:barBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barBtnView];
    return item;
    
}

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action {
    
    UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // setImage与setBackgroundImage有什么区别？
    [barBtn setImage:normalImage forState:UIControlStateNormal];
    [barBtn setImage:selectedImage forState:UIControlStateSelected];
    [barBtn sizeToFit];
    [barBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 将button包装为UIView
    UIView *barBtnView = [[UIView alloc] initWithFrame:barBtn.bounds];
    [barBtnView addSubview:barBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barBtnView];
    return item;
    
    
    
}

+ (UIBarButtonItem *)backItemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage addTarget:(id)target action:(SEL)action title:(NSString *)title{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:normalImage forState:UIControlStateNormal];
    [backButton setImage:highlightImage forState:UIControlStateHighlighted];
    
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitle:title forState:UIControlStateHighlighted];
    
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    // 左移
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}



@end
