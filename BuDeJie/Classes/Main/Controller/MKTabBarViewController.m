//
//  MKTabBarViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKTabBarViewController.h"
#import "MKEssenceViewController.h"
#import "MKNewViewController.h"
#import "MKMeViewController.h"
#import "MKFriendTrendViewController.h"
#import "MKPublishViewController.h"
#import "MKNavigationViewController.h"

#import "UIImage+MKImage.h"
#import "MKTabBar.h"

@interface MKTabBarViewController ()

@end

@implementation MKTabBarViewController

// 只会调用一次
+ (void)load {
    // 获取所有的tabbarItem
    /*
        appearance:
        只要遵守了UIAppearance协议，还要实现这个方法，
        哪些属性可以通过appearance设置，只有被UI_APPEARANCE_SELECTOR修饰的属性方法才可以使用
        只能在控件显示之前才有作用 
        夜间模式
     */
//    UITabBarItem *item = [UITabBarItem appearance]; 开发中很少使用
    
    // 获取哪个类中的TabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    /**
     设置按钮选中标题的颜色:富文本，表述一个文字颜色，字体，阴影，空心，图文混排
     创建一个描述文本属性的字典
     */
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸：只有正常状态下才有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}


// 注意：可能会调用多次
+ (void)initialize {
    if (self == [MKTabBarViewController class]) {
        
    }
}


/*  2017年2月6日下午4:34
 1. 选中的图片被渲染  -> iOS7后默认TabBar上按钮图片都会被渲染， 1 修改图片 2修改代码 ✔️
 2. 选中标题颜色：黑色 ✔️ 标题字体大 ✔️  -> 对应子控制器的tabbar的Item
 
 3. 发布按钮显示不出来 分析: 
    解决：不能修改图片尺寸，效果：让发布图片居中  高亮状态达不到
    系统的TabBarButton没有提供高亮图片状态，因此做不了实例程序效果
 4. 最终方案：调整TabBar上按钮位置，平均分成5等分，把加号按钮显示在中间就好了
    调整系统自带控件的子控件的位置 --> 自定义TabBar 
    研究下，系统的TabBarButton什么时候添加到self.tabBar，在ViewWillAppear
 
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAllChildViewController];
    [self setupAllTitleButton];
    
    [self setupTabBar];
    
    
}


// 更换系统tabBar
- (void)setupTabBar {
    
    // UIBarButtonItem: 描述按钮具体的内容
    // navigationItem：设置导航条上内容(左边，右边，中间)
    // tabBarItem: 设置TabBar上按钮内容(tabBarButton)
    
    MKTabBar *tabBar = [[MKTabBar alloc] init];
//    self.tabBar = tabBar;   ReadOnly
    // KVC 先找setter   再找属性  再找_tabBar  直接通过属性名
    [self setValue:tabBar forKey:@"tabBar"];
    
}

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController {
    // 2.1 添加子控制器（5个控制器）自定义控制器 划分项目文件结构 2017年2月6日上午10:27
    
    MKEssenceViewController *essenceVC = [[MKEssenceViewController alloc] init];
    MKNavigationViewController *navEssence = [[MKNavigationViewController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:navEssence];
    
    MKNewViewController *newVC = [[MKNewViewController alloc] init];
    MKNavigationViewController *navNew = [[MKNavigationViewController alloc] initWithRootViewController:newVC];
    [self addChildViewController:navNew];
    
//    MKPublishViewController *publichVC = [[MKPublishViewController alloc] init];
//    [self addChildViewController:publichVC];
    
    MKFriendTrendViewController *friendVC = [[MKFriendTrendViewController alloc] init];
    MKNavigationViewController *navFriend = [[MKNavigationViewController alloc] initWithRootViewController:friendVC];
    [self addChildViewController:navFriend];
    
    UIStoryboard *meStoryboard = [UIStoryboard storyboardWithName:NSStringFromClass([MKMeViewController class]) bundle:nil];
    // 加载Me的storyBoard
    MKMeViewController *meVC = [meStoryboard instantiateInitialViewController];
    MKNavigationViewController *navMe = [[MKNavigationViewController alloc] initWithRootViewController:meVC];
    [self addChildViewController:navMe];
}


- (void)setupAllTitleButton {
    // 2.2 设置TabBar的内容 -> 由对应的子控制器 2017年2月6日上午10:28
    
    // 精华
    MKNavigationViewController *navEssence = self.childViewControllers[0];
    navEssence.tabBarItem.title = @"精华";
    navEssence.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    navEssence.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    
    // 新帖
    MKNavigationViewController *navNew = self.childViewControllers[1];
    navNew.tabBarItem.title = @"新帖";
    navNew.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    navNew.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    // 发布
//    UIViewController *publichVC = self.childViewControllers[2];
//    publichVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
//    publichVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
//    // 设置图片位置
//    publichVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    // 关注
    MKNavigationViewController *navFriend = self.childViewControllers[2];
    navFriend.tabBarItem.title = @"关注";
    navFriend.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    navFriend.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    // 我
    MKNavigationViewController *navMe = self.childViewControllers[3];
    navMe.tabBarItem.title = @"我";
    navMe.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    navMe.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
