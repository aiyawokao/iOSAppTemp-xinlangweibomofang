//
//  SJTest2ViewController.m
//  微博项目
//
//  Created by joe on 15/9/16.
//  Copyright (c) 2015年 joe. All rights reserved.
//

#import "SJTest2ViewController.h"
#import "SJTest3ViewController.h"
@interface SJTest2ViewController ()

@end

@implementation SJTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    // 设置尺寸
//    //    CGSize size = backBtn.currentBackgroundImage.size;
//    //    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
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
//
//}
//
//- (void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)more
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SJTest3ViewController *test3 = [[SJTest3ViewController alloc]init];
    test3.title = @"测试3控制器";
    [self.navigationController pushViewController:test3 animated:YES];

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

