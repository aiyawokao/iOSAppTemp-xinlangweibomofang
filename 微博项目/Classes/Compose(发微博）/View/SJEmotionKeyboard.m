
//
//  SJEmotionKeyboard.m
//  微博项目
//
//  Created by joe on 15/11/25.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionKeyboard.h"
#import "SJEmotionListView.h"
#import "SJEmotionTabBar.h"
#import "SJEmotion.h"
#import "MJExtension.h"


@interface SJEmotionKeyboard()<SJEmotionTabBardelegate> 
/** 正在显示的表情内容的一个控件 */
@property (nonatomic,weak) UIView *showingListView;
/** 表情内容 */
@property (nonatomic,strong) SJEmotionListView *recentListView;
@property (nonatomic,strong) SJEmotionListView *defaultListView;
@property (nonatomic,strong) SJEmotionListView *emojiListView;
@property (nonatomic,strong) SJEmotionListView *lxhListView;

/** tabbar */
@property (nonatomic,weak) SJEmotionTabBar *tabBar;

@end

@implementation SJEmotionKeyboard

#pragma mark - 懒加载
- (SJEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[SJEmotionListView alloc]init];
    }
    return _recentListView;
}
- (SJEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[SJEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        // 字典数组--》模型数组
        self.defaultListView.emotions = [SJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}
- (SJEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[SJEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        // 字典数组--》模型数组
        self.emojiListView.emotions = [SJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;

}
- (SJEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[SJEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        // 字典数组--》模型数组
        self.lxhListView.emotions = [SJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}



#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        SJEmotionTabBar *tabBar = [[SJEmotionTabBar alloc]init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 1 tabBar
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    // 2 容纳表情内容的一个控件 contentView
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    
}

#pragma mark - SJEmotionTabBardelegate
- (void)emotionTabBar:(SJEmotionTabBar *)tabBar didSelectButton:(SJEmotionTabBarButtonType)buttonType
{
    // 移除之前显示的控件
    [self.showingListView removeFromSuperview];
    // 根据按钮类型，切换contentView上的listView
    switch (buttonType) {
        case SJEmotionTabBarButtonTypeRecent:{// 最近
            [self addSubview:self.recentListView];
            
            break;
        }
        case SJEmotionTabBarButtonTypeDefault:{// 默认
            [self addSubview:self.defaultListView];

            break;
        }
        case SJEmotionTabBarButtonTypeEmoji:{// Emoji
            [self addSubview:self.emojiListView];

            break;
        }
        case SJEmotionTabBarButtonTypeLxh:{// 浪小花
            [self addSubview:self.lxhListView];

            break;
        }
    }
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 重新计算子控件的frame
    [self setNeedsLayout];
}



@end
