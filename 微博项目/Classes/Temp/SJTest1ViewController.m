//
//  SJTest1ViewController.m
//  微博项目
//
//  Created by joe on 15/9/16.
//  Copyright (c) 2015年 joe. All rights reserved.
//

#import "SJTest1ViewController.h"
#import "SJTest2ViewController.h"

@interface SJTest1ViewController ()

@end

@implementation SJTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    // 设置尺寸
////    CGSize size = backBtn.currentBackgroundImage.size;
////    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
//    backBtn.size = backBtn.currentBackgroundImage.size;
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
//    // 设置尺寸
//    //    CGSize size = backBtn.currentBackgroundImage.size;
//    //    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
//    moreBtn.size = moreBtn.currentBackgroundImage.size;
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];

}

//- (void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)more
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SJTest2ViewController *test2 = [[SJTest2ViewController alloc]init];
    test2.title = @"测试2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
