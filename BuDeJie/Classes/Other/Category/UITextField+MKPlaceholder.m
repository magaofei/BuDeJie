//
//  UITextField+MKPlaceholder.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "UITextField+MKPlaceholder.h"
#import <objc/message.h>

@implementation UITextField (MKPlaceholder)


/**
 为了能够让在外界调用普通的方法，self.placeholder，我们利用runtime实现交换
 */
+ (void)load {
    // 交换方法
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    
    Method setMK_PlaceholderMethod = class_getInstanceMethod(self, @selector(setMK_Placeholder:));
    
    // 交换他们两个
    method_exchangeImplementations(setPlaceholderMethod, setMK_PlaceholderMethod);
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    //  问题：先设置占位文字颜色，没有效果 --> 占位文字Label拿不到
    //  解决：保存起来
    //  解决方法：给成员属性赋值 runtime给系统的类添加成员属性
    //  添加成员属性
    objc_setAssociatedObject(self, @"_placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 获取占位文字Label控件
    
    /*
     KVC
     
     当一个对象调用setValue:forKey: 方法时,方法内部会做以下操作:
     1.判断有没有指定key的set方法,如果有set方法,就会调用set方法,给该属性赋值
     2.如果没有set方法,判断有没有跟key值相同且带有下划线的成员属性(_key).如果有,直接给该成员属性进行赋值
     3.如果没有成员属性_key,判断有没有跟key相同名称的属性.如果有,直接给该属性进行赋值
     4.如果都没有,就会调用 valueforUndefinedKey 和setValue:forUndefinedKey:方法
     
     */
    
    
    
    // 问题：必须先设置占位文字颜色，不设置就没有效果 --> 因为占位文字Label拿不到
    // 1. 保存起来
    // 设置占位文字颜色 每次设置占位文字后，再难道之前保存占位文字颜色，重新设置
    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, @"_placeholderColor");
}


- (void)setMK_Placeholder:(NSString *)placeholder {
    // 方法已经 交换 实际上调用的是 placeholderColor
    [self setMK_Placeholder:placeholder];
//    self.placeholder = placeholder;
    self.placeholderColor = self.placeholderColor;
}



@end
