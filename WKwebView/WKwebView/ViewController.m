//
//  ViewController.m
//  WKwebView
//
//  Created by sududa on 2017/11/14.
//  Copyright © 2017年 sududa. All rights reserved.
//
#define SCREENWIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)
#define LOADURL (@"https://www.baidu.com")
#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (strong,nonatomic) WKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self webView];
 
}
#pragma mark - WKNavigationDelegat 加载的状态回调
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
     NSLog(@"开始加载");
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
    NSLog(@"内容开始返回");
}
//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面加载完成");
}

//页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
     NSLog(@"页面加载失败");
}
// 页面跳转的代理
//接收到服务器跳转请求之后跳转
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"跳转到其他的服务器");
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *string = webView.URL.absoluteString;
    NSLog(@"是否允许这个跳转");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%@",message);
    completionHandler();
}


-(WKWebView *)webView
{
    if (!_webView)
    {
        _webView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT-83)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate  =self ;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:LOADURL]]];
        [self.view addSubview:_webView];
        
    }
    return _webView ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
