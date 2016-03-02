//
//  SJNewFeatureViewController.m
//  微博项目
//
//  Created by joe on 15/10/12.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJNewFeatureViewController.h"
#import "SJTabbarViewController.h"

#define SJNewFeatureCount 4

@interface SJNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation SJNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建一个scrollView，显示所有新特性的图片
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:scrollView];
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    
    for (int i = 0; i < SJNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        // 显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView,就往里面添加内容
        if (i == SJNewFeatureCount - 1 ) {
            [self setupLastImageView:imageView];
        }
    }
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么将这个方向上对应的尺寸值设为0即可
    scrollView.contentSize = CGSizeMake(SJNewFeatureCount * scrollView.width, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 4. 添加pageControl：分页，用来显示当前是第几页
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = SJNewFeatureCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253 green:98 blue:42 alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189 green:189 blue:189 alpha:1];
    pageControl.centerX = 0.5 * scrollW;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

// 初始化最后一个Imageview
- (void)setupLastImageView:(UIImageView *)ImageView
{
    // 允许imageView与用户交互
    ImageView.userInteractionEnabled = YES;
    // 1.分享给大家（checkbox)
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = ImageView.width * 0.5;
    shareBtn.centerY = ImageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [ImageView addSubview:shareBtn];
    
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = ImageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    
    [ImageView addSubview:startBtn];
    
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    // 切换到SJTabBarController
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[SJTabbarViewController alloc]init];
    
}

@end
