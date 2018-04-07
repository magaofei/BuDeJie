//
//  MKFastLogin.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKFastLoginView.h"

@implementation MKFastLoginView

+ (instancetype)fastLoginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
