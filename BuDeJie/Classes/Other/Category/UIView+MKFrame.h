//
//  UIView+MKFrame.h
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    写分类:避免根其他开发者产生冲突
 */
@interface UIView (MKFrame)

@property CGFloat mk_width;
@property CGFloat mk_height;
@property CGFloat mk_x;
@property CGFloat mk_y;
@property CGFloat mk_centerX;
@property CGFloat mk_centerY;

@end
