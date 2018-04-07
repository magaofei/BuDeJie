//
//  UIView+MKFrame.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//  简洁   代替系统的self.frame属性

#import "UIView+MKFrame.h"

@implementation UIView (MKFrame)

- (void)setMk_height:(CGFloat)mk_height {
    CGRect rect = self.frame;
    rect.size.height = mk_height;
    self.frame = rect;
}

- (CGFloat)mk_height {
    return self.frame.size.height;
}

- (void)setMk_width:(CGFloat)mk_width {
    CGRect rect = self.frame;
    rect.size.width = mk_width;
    self.frame = rect;
}

- (CGFloat)mk_width {
    return self.frame.size.width;
}

- (void)setMk_x:(CGFloat)mk_x {
    CGRect rect = self.frame;
    rect.origin.x = mk_x;
    self.frame = rect;
}

- (CGFloat)mk_x {
    return self.frame.origin.x;
}

- (void)setMk_y:(CGFloat)mk_y {
    CGRect rect = self.frame;
    rect.origin.y = mk_y;
    self.frame = rect;
}

- (CGFloat)mk_y {
    return self.frame.origin.y;
}

- (void)setMk_centerX:(CGFloat)mk_centerX {
    CGPoint center = self.center;
    center.x = mk_centerX;
    self.center = center;
}

- (CGFloat)mk_centerX {
    return self.center.x;
}

- (void)setMk_centerY:(CGFloat)mk_centerY {
    CGPoint center = self.center;
    center.y = mk_centerY;
    self.center = center;
}

- (CGFloat)mk_centerY {
    return self.center.y;
}


@end
