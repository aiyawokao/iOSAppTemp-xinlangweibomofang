//
//  SJEmotionListView.m
//  微博项目
//
//  Created by joe on 15/11/25.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionListView.h"
#import "SJEmotionPageView.h"


@interface SJEmotionListView ()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,weak)UIPageControl *pageControl;

@end

@implementation SJEmotionListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 1.scrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];

        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;

        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];

        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

// 根据emotions，创建对应个数的表情
-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = (emotions.count + SJEmotionPageSize - 1) / SJEmotionPageSize;
    
    // 1.页数
    self.pageControl.numberOfPages = count;
    // 2.创建用来显示每一页表情的控件（容器）
    for (int i = 0; i<count; i++) {
        SJEmotionPageView *pageView = [[SJEmotionPageView alloc]init];
        // 计算这一页的表情的范围
        NSRange range;
        range.location = i * SJEmotionPageSize;
        // left : 这一页剩余的表情个数
        NSUInteger left = emotions.count - range.location;
        if (left >= SJEmotionPageSize) {
            range.length = SJEmotionPageSize;
        } else {
            range.length = left;
        }
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
   
}

-(void)layoutSubviews
{
    // 1. pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        SJEmotionPageView *pageView = self.scrollView.subviews[i];
        
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;

    }
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNumber = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNumber + 0.5);// + 0.5是为了四舍五入
}



@end
