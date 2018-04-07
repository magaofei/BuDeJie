//
//  MKSubTagTopListItem.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKSubTagTopListItem.h"

@implementation MKSubTagTopListItem


- (instancetype)initWithDictonaty:(NSDictionary *)dict {
    MKSubTagTopListItem *model = [[MKSubTagTopListItem alloc] init];
    model.screen_name = [dict objectForKey:@"screen_name"];
    model.fans_count = [dict objectForKey:@"fans_count"];
    model.header = [dict objectForKey:@"header"];
    
    return model;
}

+ (NSArray *)modelArrayFromDictArray:(NSArray *)array {
    
    NSMutableArray *models = [@[] mutableCopy];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MKSubTagTopListItem *model = [[MKSubTagTopListItem alloc] initWithDictonaty:obj];
        [models addObject:model];
    }];
    
    return models;
}

@end
