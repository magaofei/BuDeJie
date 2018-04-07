//
//  MKSubTagItem.h
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/7.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKSubTagTopListItem;

@interface MKSubTagItem : NSObject

// 2017年2月7日下午7:03 百思不得姐 API已经更新


/**
 存放top_list模型的数量
 */
@property (nonatomic, strong) NSArray *topLists;


- (instancetype)initWithDictonaty:(NSDictionary *)dict;


@end
