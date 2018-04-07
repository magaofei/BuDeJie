//
//  MKSquareCell.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/9.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKSquareCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MKSquareItem.h"

@interface MKSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MKSquareCell

- (void)setItem:(MKSquareItem *)item {
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
