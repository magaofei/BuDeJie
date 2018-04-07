//
//  MKLoginRegisterView.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKLoginRegisterView.h"


@interface MKLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;



@end

@implementation MKLoginRegisterView


+ (instancetype)loginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


// 登录图片被拉伸了
// 调用这个方法时，已经拿到了Xib中的所有设置
- (void)awakeFromNib {
    [super awakeFromNib];
    // 让按钮的背景图片不要被拉伸
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
