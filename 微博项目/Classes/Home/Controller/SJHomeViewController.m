//
//  SJHomeViewController.m
//  微博项目
//
//  Created by joe on 15/9/15.
//  Copyright (c) 2015年 joe. All rights reserved.
//

#import "SJHomeViewController.h"
#import "SJdropdownMenu.h"
#import "SJTitleMenuViewController.h"
#import "SJHttpTool.h"
#import "SJAccountTool.h"
#import "SJAccount.h"
#import "SJTitleButton.h"
#import "UIImageView+WebCache.h"
#import "SJUser.h"
#import "SJStatus.h"
#import "MJExtension.h"
#import "SJLoadMoreFooter.h"
#import "SJStatusCell.h"
#import "SJStatusFrame.h"

@interface SJHomeViewController ()<SJDropdownMenuDelegate>

/**
 *  微博数组（里面都是SJStatusFrame模型，一个SJStatusFrame代表一条微博）
 */
@property (nonatomic,strong)NSMutableArray *statusFrames;

@end

@implementation SJHomeViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:211 green:211 blue:211 alpha:1.0];
    
    // 设置导航栏内容
    [self setupNav];
    // 获取用户信息（昵称）
    [self setupUserInfo];
    
    // 加载最新微博数据  ?????????????????????????????????????
    // [self loadNewStatus];
    
    // 集成下拉刷新控件
    [self setupDownRefresh];
    // 集成上拉刷新控件
    [self setupUpRefresh];
    
//    // 获取未读数
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    // 更改runloop的模式，即便主线程正在处理别的事件，也会抽时间处理timer的
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
   
}

/**
 * 获取未读数
 */
- (void)setupUnreadCount
{
    // 1.拼接请求参数
    SJAccount *account = [SJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 2.发送请求
    [SJHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        // SJLog(@"%@",responseObject);
        //        // 拿到微博的未读数
        //        int status = [responseObject[@"status"] intValue];
        //        // 设置提醒数字 右上角的小角标 badgeValue 是NSString类型的 要转换一下
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",status];
        
        // NSNumber --> NSString  直接调用NSNumber的 description方法就可以了
        NSString *status = [json[@"status"] description];
        if ([status isEqualToString:@"0"]) {// 如果是未读数是0，得清空，没必要显示上去
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            
        } else {// 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
            
        }
    } failure:^(NSError *error) {
        SJLog(@"请求失败--%@",error);

    }];
}

/**
 *  集成上拉刷新控件
 */
- (void)setupUpRefresh
{
    SJLoadMoreFooter *footer = [SJLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}

/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    // 1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    // 只有用户通过手动下拉刷新，才会触发 UIControlEventValueChanged 事件
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    // 2.马上进入刷新事件（仅仅是显示刷新状态，并不会触发 UIControlEventValueChanged 事件
    [control beginRefreshing];
   
    // 3.马上加载数据
    [self loadNewStatus:control];
    
}

/** 将SJStatus数组 转换成 SJStatusFrame 数组 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (SJStatus *status in statuses) {
        SJStatusFrame *f = [[SJStatusFrame alloc]init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}


/**
 *  UIRefreshControl进入刷新状态，加载最新数据
 */

- (void)loadNewStatus:(UIRefreshControl *)control
{
    // SJLog(@"refreshStateChange----");
    // 1.拼接请求参数
    SJAccount *account = [SJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    // 取出最前面的微博
    SJStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        // since_id 	false 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        // 若返回此参数，则返回ID比 since_id大的微博（即时间上比since_id晚的微博）
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    // 2.发送请求
    [SJHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        // SJLog(@"请求成功————%@",responseObject);
        
        // 将 微博字典数组 转为 微博模型数组
        NSArray *newStatuses = [SJStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 将SJStatus数组 转换成 SJStatusFrame 数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        
        // 将最新的微博数据添加到总数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [control endRefreshing];// 记住 在请求失败时也要做下 结束刷新 的处理
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(NSError *error) {
        SJLog(@"请求失败—————%@",error);
        // 结束刷新
        [control endRefreshing];
    }];

}


/**
 *  显示最新微博的数量
 */
- (void)showNewStatusCount:(NSUInteger)count
{
    // 刷新成功（清除提示角标数字）
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // 1.创建label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    // 2.设置label的其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，请稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    // 3.添加label
    label.y = 64 - label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    CGFloat duration = 1.0;// 动画的时间
    [UIView animateWithDuration:duration animations:^{
        // label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;// 延迟1秒
        // UIViewAnimationOptionCurveLinear ：（线性）匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            // label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

/**
 * 加载更多微博数据
 */
- (void)loadMoreStatus
{
    // https://api.weibo.com/2/statuses/friends_timeline.json
    // 1.拼接请求参数
    SJAccount *account = [SJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博(ID最大的微博）
    SJStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若返回此参数，则返回ID小于或等于max_id的微博，默认是0
        // id这种数据一般都是数值比较大的，若转成整数的话，最好用long long 类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    

    // 2.发送请求
    [SJHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        // SJLog(@"请求成功————%@",responseObject);
        
        // 获得 微博字典数组
        // NSArray *dictArray = responseObject[@"statuses"];
        
        // 将 微博字典数组 转为 微博模型数组
        NSArray *newStatuses = [SJStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 将SJStatus数组 转换成 SJStatusFrame 数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        // 将最新的微博数据添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        SJLog(@"请求失败—————%@",error);
    }];
}


/**
 // 获取用户信息（昵称）
 */
-(void)setupUserInfo
{
    // 参数：
    // https://api.weibo.com/2/users/show.json
    // access_token 	false 	string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid 	false 	int64 	需要查询的用户ID。
    
    // 1.拼接请求参数
    SJAccount *account = [SJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    
    // 2.发送请求
    [SJHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        // SJLog(@"请求成功————%@",responseObject);
        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 设置名字
        SJUser *user = [SJUser objectWithKeyValues:json];// 字典转模型！！！！！！！！
        // NSString *name = responseObject[@"name"];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒
        account.name = user.name;
        [SJAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        SJLog(@"请求失败—————%@",error);
    }];
}
 
/**
 // 设置导航栏内容
*/
-(void)setupNav
{
    // 设置导航栏上的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间标题按钮 */
    
    SJTitleButton *titleButton = [[SJTitleButton alloc]init];
    
    
    NSString *name = [SJAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 140, 0, 0);
//    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    // 监听标题按钮点击事件
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;


}

/**
 标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    // 创建下拉菜单
    SJdropdownMenu *menu = [SJdropdownMenu menu];
    
    // 设置代理
    menu.delegate = self;
    // 设置内容
    // menu.content = [UIButton buttonWithType:UIButtonTypeContactAdd];
    // menu.content = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
    
    SJTitleMenuViewController *vc = [[SJTitleMenuViewController alloc]init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;

    
    // 显示
    [menu showFrom:titleButton];
    
    
    
    
//    [menu dismiss];
//    // 获得当前显示在屏幕上最上面的window
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    
//    // 增加蒙板，可以使后面的按钮、屏幕都不能点击
//    UIView *cover = [[UIView alloc]init];
//    cover.backgroundColor = [UIColor clearColor];
//    cover.frame = window.bounds;
//    [window addSubview:cover];
//    
//    // 添加带箭头突起的下拉菜单
//    UIImageView *dropdownMenu = [[UIImageView alloc]init];
//    dropdownMenu.width = 217;
//    dropdownMenu.height = 217;
//    dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
//    
//    [cover addSubview:dropdownMenu];

 }

- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
}



#pragma mark - SJDropdownMenuDelegate 代理方法

// 下拉菜单被销毁
-(void)dropdownMenuDidDismiss:(SJdropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向下
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.selected = NO;

}

// 下拉菜单显示
-(void)dropdownMenuDidShow:(SJdropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向上
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleButton.selected = YES;

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1、创建单元格
    SJStatusCell *cell = [SJStatusCell cellWithTableView:tableView];
    
    // 2、拿到cell的数据模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // scrollView  == self.tableView == self.view
    // 如果tableview还没有数据，就直接返回
    if(self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) {// 最后一个cell完全进入视野范围内
        // 显示footerView
        self.tableView.tableFooterView.hidden = NO;
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

@end
