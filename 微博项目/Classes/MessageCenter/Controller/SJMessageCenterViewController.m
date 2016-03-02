//
//  SJMessageCenterViewController.m
//  微博项目
//
//  Created by joe on 15/9/15.
//  Copyright (c) 2015年 joe. All rights reserved.
//

#import "SJMessageCenterViewController.h"
#import "SJTest1ViewController.h"

@interface SJMessageCenterViewController ()

@end

@implementation SJMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // style这个参数，用来设置背景样式，iOS7之前效果明显，iOS7之后由于采用扁平化设计，效果不明显啦
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    // 这个按钮不能点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    SJLog(@"SJMessageCenterViewController-viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)composeMsg
{
    NSLog(@"composeMsg");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Return the number of rows in the section.
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%ld",indexPath.row];
    return cell;
}

#pragma mark - 代理方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJTest1ViewController *test1 = [[SJTest1ViewController alloc]init];
    test1.title = @"测试1控制器";
    
    // 当test1控制器被push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
    // 当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
    // 整个操作由tabbarcontroller来完成
    test1.hidesBottomBarWhenPushed = YES;
    
    // NSLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:test1 animated:YES];
    
}



@end
