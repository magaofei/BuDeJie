//
//  MKTitleButton.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/13.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKTitleButton.h"

@implementation MKTitleButton


/**
 指定构造方法：
 1.后面带有NS_DESIGNATED_INITIALIZER的方法，就是指定构造方法
 2.子类如果重写了父类的【特定构造方法】，那么必须用super调用父类的【特定构造方法】，不然会出现警告
 */
- (void)setHighlighted:(BOOL)highlighted {
    // 只要重写了这个方法，按钮就无法进入highlighted状态
    
}

//- (BOOL)isHighlighted {
//    return _highlighted;
//}

// 初始化子控件
// 调用init或者initWithFrame都会来
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 255 154 106
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
       
        [self setTitleColor:[UIColor colorWithRed:255/256.0 green:154/256.0 blue:106/256.0 alpha:1] forState:UIControlStateSelected];
    }
    
    return self;
}

// 布局子控件
-(void)layoutSubviews {
    [super layoutSubviews];
}
@end
