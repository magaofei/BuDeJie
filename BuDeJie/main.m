//
//  main.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/1/16.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

/* 
 1. 创建UIApplication (1.打开网页，发短信，打电话 2.设置应用程序提醒数字 3.设置联网状态 4.设置状态栏
 2. 创建AppDelegate代理对象，并且称为UIApplication代理，(监听整个App生命周期，处理内存警告)
 3. 开启主运行循环，保证程序一直运行(Runloop)，主线程有一个runloop自动开启
 4. 加载Info.plist文件，判断是否指定了Main.Storyboard 
 
 

 */
