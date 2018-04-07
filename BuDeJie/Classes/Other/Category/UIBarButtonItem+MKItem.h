//
//  UIBarButtonItem+MKItem.h
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MKItem)

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage addTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage addTarget:(id)target action:(SEL)action title:(NSString *)title;
@end
