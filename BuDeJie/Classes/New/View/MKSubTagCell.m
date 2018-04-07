//
//  MKSubTagCell.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/7.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKSubTagCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UILabel *numView;

@end



@implementation MKSubTagCell


// 更改cell的frame  修改它的高度
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 1;
    [super setFrame:frame];
}


- (void)setItem:(MKSubTagTopListItem *)item {
    _item = item;
    
    // 设置内容
    _nameView.text = item.screen_name;
//    _numView.text = item.fans_count;
    
    //  判断下有没有大于10000
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅", item.fans_count];
    NSInteger num = item.fans_count.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
    }
    
    _numView.text = numStr;
    

    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 滑动时会卡
//        //   1.开启图形上下文
//        // 比例因素:当前点与像素的比例  0自适应
//        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//        //   2.描述裁剪区域
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        //   3.设置裁剪区域
//        [path addClip];
//        //   4.画图片
//        [image drawAtPoint:CGPointZero];
//        //   5.取出图片
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        //   6.关闭上下文
//        UIGraphicsEndImageContext();
//        
//        _iconView.image = image;
    }];
}




/**
 从xib加载就会调用，只会调用一次
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 1.设置头像的圆角, 帧数问题 iOS9修复
    // 2.裁剪图片（生成新的图片 --> 图形上下文才能够生成新的图片）
    

    _iconView.layer.cornerRadius = 30;
    _iconView.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
