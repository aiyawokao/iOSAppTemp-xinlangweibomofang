//
//  SJEmotionTabBar.h
//  微博项目
//
//  Created by joe on 15/11/25.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SJEmotionTabBarButtonType:NSUInteger {
    SJEmotionTabBarButtonTypeRecent,//最近
    SJEmotionTabBarButtonTypeDefault,// 默认
    SJEmotionTabBarButtonTypeEmoji,// Emoji
    SJEmotionTabBarButtonTypeLxh,// 浪小花
} SJEmotionTabBarButtonType;

@class SJEmotionTabBar;

@protocol SJEmotionTabBardelegate <NSObject>

@optional
- (void)emotionTabBar:(SJEmotionTabBar *)tabBar didSelectButton:(SJEmotionTabBarButtonType)buttonType;

@end

@interface SJEmotionTabBar : UIView
@property (nonatomic,weak) id<SJEmotionTabBardelegate> delegate;

@end
