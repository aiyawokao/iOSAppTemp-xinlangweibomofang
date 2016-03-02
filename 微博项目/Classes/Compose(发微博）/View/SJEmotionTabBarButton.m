//
//  SJEmotionTabBarButton.m
//  微博项目
//
//  Created by joe on 15/11/25.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionTabBarButton.h"

@implementation SJEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置按钮文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled]; 
        // 设置按钮字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}


-(void)setHighlighted:(BOOL)highlighted
{
    // 重写按钮的 setHighlighted: 方法， 按钮高亮所做的所有操作就都不存在啦
}


@end
