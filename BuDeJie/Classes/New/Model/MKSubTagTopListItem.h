//
//  MKSubTagTopListItem.h
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKSubTagTopListItem : NSObject

/**
 名称
 */
@property (nonatomic, copy) NSString *screen_name;


/**
 图片
 */
@property (nonatomic, copy) NSString *header;


/**
 订阅数
 */
@property (nonatomic, copy) NSString *fans_count;

+ (NSArray *)modelArrayFromDictArray:(NSArray *)array;

- (instancetype)initWithDictonaty:(NSDictionary *)dict;

@end
