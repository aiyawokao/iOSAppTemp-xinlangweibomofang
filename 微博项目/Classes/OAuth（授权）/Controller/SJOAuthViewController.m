//
//  SJOAuthViewController.m
//  微博项目
//
//  Created by joe on 15/10/13.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJOAuthViewController.h"
#import "SJAccount.h"
#import "SJAccountTool.h"
#import "UIWindow+Extension.h"
#import "SJHttpTool.h"


@interface SJOAuthViewController ()<UIWebViewDelegate>

@end

@implementation SJOAuthViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.用webView加载登陆页面（新浪提供的）
    // 请求地址：https://api.weibo.com/oauth2/authorize
    
    /* 请求参数 : client_id 263223174
                   redirect_uri
       */
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=263223174&redirect_uri=http://www.baidu.com"]; 
    
    // NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request ];
    webView.delegate = self;
//    SJLog(@"%@",request);
   
}

#pragma mark - webView代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    SJLog(@"webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    SJLog(@"webViewDidFinishLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // SJLog(@"shouldStartLoadWithRequest--%@", request.URL.absoluteString);
    // code=9f83f03664cab9b826096a108e27e6c4
    // 1.获得URL
    NSString *url = request.URL.absoluteString;
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {// 是回调地址
        
        // 截取code后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
//        SJLog(@"%@ %@",code,url);
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        return NO;
    }
    
    
    return YES;
}

// 利用code（授权成功后的request token）换取一个accessToken
- (void)accessTokenWithCode:(NSString *)code
{
//    // 1.请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"263223174";
    params[@"client_secret"] = @"5999d40922c7eb10f3b3ad81addf06e9";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    
     // 2.发送请求
    [SJHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        //将返回的账号字典数据 装成 模型，存入沙盒（一般面向字典比较头疼，要有很多key，思路一般是字典转模型）！！！！！！
                SJAccount *account = [SJAccount accountWithDict:json];
        
                // 存储账号信息 ！！！！！！！！！！！！！！！！！！！
                [SJAccountTool saveAccount:account];
        
                // 切换窗口的根控制器
                [UIWindow switchRootViewController];

    } failure:^(NSError *error) {
        SJLog(@"请求失败--%@",error);
    }];

}


@end
