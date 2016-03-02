//
//  SJTabbarViewController.m
//  微博项目
//
//  Created by joe on 15/9/16.
//  Copyright (c) 2015年 joe. All rights reserved.
//

#import "SJTabbarViewController.h"
#import "SJHomeViewController.h"
#import "SJMessageCenterViewController.h"
#import "SJDiscoverViewController.h"
#import "SJProfileViewController.h"
#import "SJNavigationController.h"
#import "SJTabBar.h"
#import "SJComposeViewController.h"

@interface SJTabbarViewController ()<SJTabBarDelegate>

@end

@implementation SJTabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化子控制器
    SJHomeViewController *home = [[SJHomeViewController alloc]init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];

    SJMessageCenterViewController *messageCenter = [[SJMessageCenterViewController alloc]init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];

    SJDiscoverViewController *discover = [[SJDiscoverViewController alloc]init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];

    SJProfileViewController *profile = [[SJProfileViewController alloc]init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // 更换系统自带的tabbar  !!!!!!!!!!!!!!!!!!!!!!!
    // self.tabBar = [[SJTabBar alloc]init];
    SJTabBar *tabBar = [[SJTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.tabBar = tabBar;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是HWTabBarViewController
     说明，不用再设置tabBar.delegate = self;
     */
    
    /*
     1.如果tabBar设置完delegate后，再执行下面代码修改delegate，就会报错
     tabBar.delegate = self;
     
     2.如果再次修改tabBar的delegate属性，就会报下面的错误
     错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     错误意思：不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
     */

    
}

-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // UIViewController *childVc = [[UIViewController alloc]init];
    
    // 设置子控制器的文字
//    childVc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    // childVc.tabBarItem.title = title;// 设置tabbar的文字
    // childVc.navigationItem.title = title;// 设置navigationBar的文字
    // 以上两句可以合为一句
    childVc.title = title;// 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给传进来的小控制器包装一个导航控制器
    SJNavigationController *nav = [[SJNavigationController alloc]initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}

#pragma mark - SJTabBarDelegate 代理方法
-(void)tabBarDidClickPlusButton:(SJTabBar *)tabBar
{
    SJComposeViewController *compose = [[SJComposeViewController alloc]init];
    
    SJNavigationController *nav = [[SJNavigationController alloc]initWithRootViewController:compose];
    
    [self presentViewController:nav animated:YES completion:nil];
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
