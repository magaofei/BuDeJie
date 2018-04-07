//
//  UIImage+MKImage.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "UIImage+MKImage.h"

@implementation UIImage (MKImage)

+ (UIImage *)imageOriginalWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
