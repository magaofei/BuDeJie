//
//  MKEssenceViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/1/16.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKEssenceViewController.h"
#import "UIBarButtonItem+MKItem.h"
#import "UIView+MKFrame.h"
#import "MKTitleButton.h"

#import "MKAllViewController.h"
#import "MKVideoViewController.h"
#import "MKPictureViewController.h"
#import "MKVoiceViewController.h"
#import "MKWordViewController.h"

#import "MKTopic.h"



/**
 UIBarButtonItem：描述按钮具体的内容
 UINavigationItem：设置导航条上内容（左边，右边，中间）
 TabBarItem：设置TabBar上按钮内容（TabBarButton）
 */


/**
 UIButton 按钮的状态
 1.UIControlStateNormal
    这种状态下的按钮可以接收点击事件
 2.UIControlStateHighlighted
   当按住按钮不松开时就能达到这种状态
    这种状态下的按钮可以接收事件
 3.UIControlStateDisabled
    button.enabled = NO;   // 进入UIControlStateDisabled状态
    这种状态下的按钮无法接收点击事件
 4.UIControlStateSelected
    button.selected = YES; // 进入UIControlStateSelected状态
 
 二、让按钮无法点击的2种状态
 1.button.enabled = NO; 会进入UIControlStateDisabled状态
 2.button.userInteractionEnabled = NO 不会进入UIControlStateDisabled状态
 */


/**
 名字叫attributes并且是NSDictionary *类型的参数，它的key一般都有以下规律
 iOS7及之后
 1.所有的key来源于：NSAttributedString.h
 2.格式基本都是：NS***NSStrokeColorAttributeName
 iOS7之前
 1.所有key都来源于：UIStringDrawing.h
 2.格式基本都是：UITextAttribute***
 */
@interface MKEssenceViewController () <UIScrollViewDelegate>


/**
 标题栏
 */
@property (nonatomic, strong) UIView *titleView;


/**
 记录上一次点击的标题按钮
 */
@property (nonatomic, strong) UIButton *previousClickedButton;

@property (nonatomic, strong) UIView *titleUnderline;


/**
 用来存放所有子控制器View
 */
@property (nonatomic, strong) UIScrollView *childVCScrollView;

@end

@implementation MKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor redColor];
    
    // 初始化子控制器
    [self setupAllChildVCs];
    
    [self setupNavBar];
    // 左边按钮
    
    // 右边按钮
    
    // titleView
    
    // scrollView
    [self setupScrollView];
    // 标题栏
    [self setupTitlesView];
    
    // 标题栏按钮
    [self setupTitleButtons];
    // 标题下划线
    
    [self setupTitleUnderline];
    
    [self addChildViewIntoScrollView:0];
    
}

// 添加到子控制器
- (void)setupAllChildVCs {
    [self addChildViewController:[[MKAllViewController alloc] init]];
    [self addChildViewController:[[MKPictureViewController alloc] init]];
    [self addChildViewController:[[MKVideoViewController alloc] init]];
    [self addChildViewController:[[MKVoiceViewController alloc] init]];
    [self addChildViewController:[[MKWordViewController alloc] init]];
}

- (void)setupTitleUnderline {
    
    // 标题按钮
    MKTitleButton *firstButton = self.titleView.subviews[0];
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.mk_height = 2;
    titleUnderline.mk_y = self.titleView.mk_height - titleUnderline.mk_height;
    titleUnderline.mk_width = 0;
    titleUnderline.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    _titleUnderline = titleUnderline;
    [self.titleView addSubview:titleUnderline];
    
    // 刚进来时没有文字，我们让他强制计算
    [firstButton.titleLabel sizeToFit];  // 让label根据文字内容计算尺寸
//    [self titleButtonClick:firstButton];
    
    // 防止刚开始出现动画效果
    firstButton.selected = YES;
    self.previousClickedButton = firstButton;
    self.titleUnderline.mk_width = firstButton.titleLabel.mk_width - 10;
    self.titleUnderline.mk_centerX = firstButton.mk_centerX;
    
    
}

// bundle NSString *file = [[NSBundle mainBundle] pathForResource:"test.bundle/Test" ofType:@"png"];

- (void)setupTitleButtons {
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titleView.mk_width / 5;
    CGFloat titleButtonH = self.titleView.mk_height;
    
    // 创建5个标题按钮
    for (NSInteger i = 0; i < 5; i++) {
        MKTitleButton *titleButton = [[MKTitleButton alloc] init];
        [self.titleView addSubview:titleButton];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

// 最终方案：设置Normal和selected状态下的颜色，最终控制Selected和Normal状态切换颜色
// 高亮和选中发生后会变成normal
// 点击TitleButton时滚动ScrollView
- (void)titleButtonClick:(UIButton *)titleButton {
    
    // 重复点击了标题按钮
    if (self.previousClickedButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKTitleButtonDidRepeatClickNotification object:nil];

    }
    
    
    
    // 顺序不能变动
    self.previousClickedButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedButton = titleButton;
    MKFunc;
    NSInteger indexTitleBtn = [self.titleView.subviews indexOfObject:titleButton];

    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        attributes[NSFontAttributeName] = titleButton.titleLabel.font;
//        self.titleUnderline.mk_width = [titleButton.currentTitle sizeWithAttributes:attributes].width;
        
        self.titleUnderline.mk_width = titleButton.titleLabel.mk_width - 10;
        
        self.titleUnderline.mk_centerX = titleButton.mk_centerX;
        
        // 点击按钮时 切换控制器 通过TitleView的subView来取到index
        CGFloat offsetX = self.childVCScrollView.mk_width * indexTitleBtn;
        self.childVCScrollView.contentOffset = CGPointMake(offsetX, self.childVCScrollView.contentOffset.y);
        
        // 在动画结束时添加子控制器的View
    } completion:^(BOOL finished) {
        [self addChildViewIntoScrollView:indexTitleBtn];
    }];
    // contentOffset.x = 内容的最左边 - frame的最左边
    
    // 设置index位置对应TableView.scrollsToTop = YES，其他都设置为NO
    NSInteger count = self.childViewControllers.count;
    for (NSUInteger i = 0; i < count; i ++) {
        UIViewController *childVC = self.childViewControllers[i];
        // 如果View还没有被创建就不用去处理, 不然如果访问子控制器的View的话就会加载子控制器
        if (!childVC.isViewLoaded) {
            continue;
        }
        
        UIScrollView *scrollView = (UIScrollView *)childVC.view;
        // UITableView 也是ScrollView
        if (![scrollView isKindOfClass:[UIScrollView class]]) {
            continue;
        }
        
        // 标题按钮对应的子控制器
        scrollView.scrollsToTop = (i == indexTitleBtn);
        
        
    }
    
    
}

#pragma mark - scrollView childViewControllers
// UIButton里面的Label是懒加载的 
// 设置子控制器
- (void)setupScrollView {
    // 不允许自动修改UIScrollView的内边距  UITableViewController 默认的y值是20 因为iOS7之前的UIViewController都是从20开始的
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIScrollView *childVCScrollView = [[UIScrollView alloc] init];
    childVCScrollView.backgroundColor = [UIColor greenColor] ;
    childVCScrollView.frame = self.view.bounds;
    [self.view addSubview:childVCScrollView];
    _childVCScrollView = childVCScrollView;
    childVCScrollView.delegate = self;
    // 系统会让ScrollView里面的内容往下挪 64
    childVCScrollView.scrollsToTop = NO;  // 点击状态栏的时候，scrollView不会滚动顶部
    // 加载bundle里面的图片需要加上bundle的文件名，格式：bundle文件名/图片名
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = childVCScrollView.mk_width;
    CGFloat scrollViewH = childVCScrollView.mk_height;
//    for (NSInteger i = 0; i < count; i++) {
//        // 取出子控制器的View
//        UIView *childVCView = self.childViewControllers[i].view;
////        childVCView.mk_x = i * scrollView.mk_width;
////        childVCView.mk_y = 0;
////        childVCView.mk_height = scrollViewH;
//        childVCView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
//        [childVCScrollView addSubview:childVCView];
//    }
    
    // 如果向做到全屏穿透效果（顶部和底部Bar透明效果）就不能限制TableView的大小
    // 1.tableView的尺寸必须要占据整个屏幕
    // 2.添加ContentInset到TableView上
    // 不允许scrollView进行上下滚动
    childVCScrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    childVCScrollView.pagingEnabled = YES;
    childVCScrollView.showsHorizontalScrollIndicator = NO;
    childVCScrollView.showsVerticalScrollIndicator  = NO;
    
}

#pragma mark - scrollViewDelegate
// 滚动ScrollView时点击TitleButton
// 当用户松开ScrollView 滑动结束时调用这个方法 ScrollView停止滚动的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.mk_width;
    
    // 点击对应的标题按钮
    MKTitleButton *titleButton = self.titleView.subviews[index];
    [self titleButtonClick:titleButton];
}

- (void)setupTitlesView {
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor blueColor];
    titleView.frame = CGRectMake(0, 64, self.view.mk_width, 35);
    //
    // titleView.alpha = 0.5  不能这样设置，否则就使子控件继承透明度
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.96];
    _titleView = titleView;
    [self.view addSubview:titleView];
    
}

#pragma mark - 设置导航条
- (void)setupNavBar {
    // 左边按钮
    // 不能直接通过CustomView的方式添加Button 否则会扩大点击区域
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:self action:@selector(gameButtonClick)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"navigationButtonRandomN"] highlightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:self action:@selector(gameButtonClick)];
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}


/**
 添加第index个子控制器的View到ScrollView中
 */
- (void)addChildViewIntoScrollView:(NSUInteger)index {
    
    // 取出index位置对应的子控制器
    UIView *childViewControllerView = self.childViewControllers[index].view;
    // 判断有没有加过
    if (childViewControllerView.superview) {
        return;
    }
    
    CGFloat scrollViewW = self.childVCScrollView.mk_width;
    // 设置子控制器View的frame
    childViewControllerView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.childVCScrollView.mk_height);
    [self.childVCScrollView addSubview:childViewControllerView];
}





- (void)gameButtonClick {
    MKFunc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
