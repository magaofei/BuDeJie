//
//  AppDelegate.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/1/16.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "AppDelegate.h"

#import "MKTabBarViewController.h"
#import "MKADViewController.h"



/**
 优先级 LaunchScreen > Launch Image
 在Xcode配置了不起作用，1. 清空Xcode缓存   2. 直接删掉程序， 重新运行
 如果通过LaunchImage设置启动界面，那么屏幕的可视范围由图片决定
 必须提供各种尺寸的图片
 
 LaunchScreen: Xcode6开始才有
 好处: 1.自动识别当前真机或者模拟器的尺寸   2，只需让美工提供一个可拉伸图片
 3，展示更多的东西
 
 LaunchScreen底层实现： 界面做了个截屏，生成一张图片作为启动界面
 */


/**
 项目架构搭建：主流结构（UITabBarController + 导航控制器）
 */


/**
 AD 广告
 不能设置LaunchScreen的ViewController ，因为LaunchScreen只是一个截屏
 
 每次程序启动的时候进入广告界面
 1. 启动的时候，去加个广告界面
 2. 启动完成的时候，加个广告界面（展示了启动图片）
 
    1.程序一启动就进入广告界面，窗口的根控制器设置为广告控制器
    2.直接往窗口上再加上一个广告界面，等几秒过去了，再去广告界面移除
 */
@interface AppDelegate ()

@end

@implementation AppDelegate

// 封装 --> 方便以后去维护代码

// 程序启动的时候就会调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1. 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 2. 设置根控制器
    MKTabBarViewController *tabBarVC = [[MKTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    // 广告 暂时不用
//    MKADViewController *adVC = [[MKADViewController alloc] init];
//    // init --> initWithNibName
//    self.window.rootViewController = adVC;
    
    // 3. 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
