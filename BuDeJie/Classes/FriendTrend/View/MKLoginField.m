//
//  MKLoginField.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKLoginField.h"
#import "UITextField+MKPlaceholder.h"

@implementation MKLoginField

/*
 1.文本框光标变成白色
 2.文本框开始编辑的时候，占位文字颜色变成白色
 
 */


- (void)awakeFromNib {
    [super awakeFromNib];
    self.placeholderColor = [UIColor lightGrayColor];
    // 设置光标的颜色为白色
    self.tintColor = [UIColor whiteColor];
    
    // 监听文本框编辑  1.代理  2.通知 3.target
    // 不要自己称为自己的代理
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    // 最开始的文本颜色
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    
    // 快速设置占位文字颜色 --> 文本框占位文字可能是label --> 验证占位文字是Label --> 拿到label
    // 利用KVC --> 怎么知道它的属性？ 1.利用runtime 2.通过断点
//    _placeholderLabel
//    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor lightGrayColor];
    
}


/**
 文本框开始编辑 调用
 */
- (void)textBegin {
    // 设置占位文字颜色变成白色
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
//    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor whiteColor];
    
    self.placeholderColor = [UIColor whiteColor];
    
}


/**
 文本框结束编辑调用
 */
- (void)textEnd {
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
//    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderColor = [UIColor lightGrayColor];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
