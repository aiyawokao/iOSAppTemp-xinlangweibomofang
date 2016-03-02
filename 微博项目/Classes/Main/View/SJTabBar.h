//
//  SJTabBar.h
//  微博项目
//
//  Created by joe on 15/10/10.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJTabBar;

@protocol SJTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(SJTabBar *)tabBar;
@end


@interface SJTabBar : UITabBar
@property (nonatomic,weak) id<SJTabBarDelegate> delegate;

@end
