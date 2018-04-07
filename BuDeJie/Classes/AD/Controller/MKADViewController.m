//
//  MKADViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/7.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "MKAdItem.h"
#import <UIImageView+WebCache.h>
#import "MKTabBarViewController.h"


#define iPhone6P MKScreenHeight == 736
#define iPhone6 MKScreenHeight == 667
#define iPhone5 MKScreenHeight == 568
#define iPhone4 MKScreenHeight == 480

@interface MKADViewController ()


/**
 启动图
 */
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;

/**
 广告图的View
 */
@property (weak, nonatomic) IBOutlet UIView *adContentView;


/**
 广告跳过按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *jumpAdBtn;


/**
 广告
 */
@property (nonatomic, weak) UIImageView *adView;


/**
 模型
 */
@property (nonatomic, strong) MKAdItem *item;


/**
 广告时间定时器
 */
@property (nonatomic, weak) NSTimer *timer;


@end
static NSString *code2 = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

@implementation MKADViewController

- (UIImageView *)adView {
    if (_adView == nil) {
        UIImageView *adView = [[UIImageView alloc] init];
        [self.adContentView addSubview:adView];
        
        // 创建一个手势 实现点击按钮跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdPage)];
        [adView addGestureRecognizer:tap];
        // UIImageView默认不可被点击
        adView.userInteractionEnabled = YES;
        
        _adView = adView;
    }
    return _adView;
}


/**
 点击广告跳转界面
 */
- (void)tapAdPage {
    UIApplication *app = [UIApplication sharedApplication];
    
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
    
}


/**
    跳过广告
 */
- (IBAction)clickJumpAd:(UIButton *)sender {
    
    MKTabBarViewController *tabBar = [[MKTabBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    
    // 干掉定时器
    [self.timer invalidate];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.adContentView.backgroundColor = [UIColor clearColor];
    
    [self setupLaunchImage];
    
    // 加载广告数据  --> 拿到真实时间 --> 服务器 --> 查看接口文档 1.判断接口对不对 2.解析数据 (w_picurl,ori_curl:跳转到广告界面,w,h) --> 请求数据(AFN)
    
    [self loadAdData];
    
    // 注册cell
    
    
    
    
    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}


/**
 广告倒计时
 */
- (void)timeChange {
    // 倒计时
    static NSInteger i = 3;
    
    // 设置跳转按钮的文字 按钮需要设置为custom自定义，否则会闪烁
    [self.jumpAdBtn setTitle:[NSString stringWithFormat:@"跳过(%ld)",i] forState:UIControlStateNormal];
    
    if (i == 0) {
        // 销毁广告界面，进入主框架界面
        MKTabBarViewController *tabBar = [[MKTabBarViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
        
        // 干掉定时器
        [self.timer invalidate];
    }
    i--;
}

// cocoapods  管理第三方库
/*
 1.podfile 描述需要导入哪些框架 touch podfile   pod init
 2.打开podfile 描述 open podfile
 3.搜索需要导入框架描述 pod search
 4.安装第三方框架 pod install --no-repo-update
 
    --no-repo-update   Skip running 'pod repo update' before install
    podfile.Lock 第一次pod就会生成这个文件，描述当前导入框架版本
    pod install 根据podfile.lock 去加载， 第一次根据podfile文件加载
    pod update：去查看之前导入框架有没有新的版本，如果有新的版本就会去加载，并且更新pod.lock
    pod repo 管理第三方仓库的索引，去寻找框架有没有最新的版本
 
 */

//  广告接口
//  http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam

#pragma mark - 加载广告数据
- (void)loadAdData {
    
    
    
    // 1.创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // NSLocalizedDescription=Request failed: unacceptable content-type: text/html} 响应头
    // 服务器的Content-type 写的有问题 应该是JSON
    // 添加Content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    // 3.发送请求
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求数据 --> 解析数据（写成plist文件）-->设计模型 --> 字典转模型 --> 解析数据
//        NSLog(@"%@", responseObject);
        
        // 获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
        
        // 字典转模型
        self.item = [MKAdItem mj_objectWithKeyValues:adDict];
        
        // 避免请求不到数据
        if (self.item) {
            // 创建UIImageView展示图片
            CGFloat h = MKScreenWidth / _item.w * _item.h;
            self.adView.frame = CGRectMake(0, 0, MKScreenWidth, h);
            
            // 加载广告网页
            //        self.adContentView
            [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        }
        
        
        
        
        
        
        
//        [responseObject writeToFile:@"" atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MKLog(@"%@", error);
    }];
    
    
}

- (void)setupLaunchImage {
    if (iPhone6P) {  // 6p
        // 图片在Assets中不识别，直接放到目录下
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) {  // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) {  // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    } else if (iPhone4) {  // 4
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
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
