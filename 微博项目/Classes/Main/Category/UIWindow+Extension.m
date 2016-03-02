//
//  UIWindow+Extension.m
//  微博项目
//
//  Created by joe on 15/10/15.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "SJTabbarViewController.h"
#import "SJNewFeatureViewController.h"

@implementation UIWindow (Extension)

+ (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    // 上次使用的版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    // 当前软件的版本号（从info.plist文件中获得）
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        window.rootViewController = [[SJTabbarViewController alloc]init];
        
    } else {
        window.rootViewController = [[SJNewFeatureViewController alloc]init];
        
        // 将当前版本号存入沙盒
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}
@end
