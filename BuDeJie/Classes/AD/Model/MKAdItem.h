//
//  MKAdItem.h
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/7.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
// w_picurl, ori_curl:跳转到广告界面 ,w,h
@interface MKAdItem : NSObject


/**
 广告地址
 */
@property (nonatomic, copy) NSString *w_picurl;

/**
 点击广告跳转的界面
 */
@property (nonatomic, copy) NSString *ori_curl;


@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@end
