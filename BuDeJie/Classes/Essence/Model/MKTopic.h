//
//  MKTopic.h
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/16.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKTopic : NSObject


/**
 用户的名字
 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *profile_image;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, assign) NSInteger ding;

@property (nonatomic, assign) NSInteger cai;

@property (nonatomic, assign) NSInteger repost;

@property (nonatomic, assign) NSInteger comment;

@end
