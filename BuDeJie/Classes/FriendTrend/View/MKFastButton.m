//
//  MKFastButton.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKFastButton.h"
#import "UIView+MKFrame.h"


@implementation MKFastButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/**
 
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    // 设置图片位置
    self.imageView.mk_y = 0;
    self.imageView.mk_centerX = self.mk_width * 0.5;
    
    // 设置标题位置
    [self.titleLabel sizeToFit];
    
    self.titleLabel.mk_y = self.mk_height - self.titleLabel.mk_height;
    self.titleLabel.mk_centerX = self.mk_width * 0.5;
    
    // 计算文字宽度， 设置label的宽度
    
}

@end
