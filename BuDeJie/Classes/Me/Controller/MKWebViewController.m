//
//  MKWebViewController.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/9.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKWebViewController.h"
#import <WebKit/WebKit.h>
@interface MKWebViewController ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *homeItem;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation MKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    WKWebView *webView = [[WKWebView alloc] init];
    _webView = webView;
    [self.contentView addSubview:webView];
    
    // 展示网页
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // KVO 监听属性改变
    /*
     Observer:观察者
     KeyPath:观察webView哪个属性
     options:NSKeyValueObservingOptionNew观察新值改变
     KVO 注意点：一定要记得移除
     */
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.backItem.enabled = NO;
    self.forwardItem.enabled = NO;
    
    
}

// 只要观察对象属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

// 在这里设置子控件的位置
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _webView.frame = self.contentView.bounds;
//    _toolBarView.frame = CGRectMake(0, _webView.frame.origin.y - 44, _webView.frame.size.width, 44);
    
    
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
    
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)goHome:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [self.webView loadRequest:request];
}

- (IBAction)reload:(id)sender {
    [self.webView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    
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
