//
//  MKSubTagItem.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/7.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKSubTagItem.h"
#import "MKSubTagTopListItem.h"

@implementation MKSubTagItem

- (instancetype)initWithDictonaty:(NSDictionary *)dict {
    MKSubTagItem *subTagItem = [[[self class] alloc] init];
    
    
    
    subTagItem.topLists = [MKSubTagTopListItem modelArrayFromDictArray:[dict objectForKey:@"top_list"]];
    
    
    
    return subTagItem;
}

@end
