//
//  SJEmotionTabBar.m
//  微博项目
//
//  Created by joe on 15/11/25.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionTabBar.h"
#import "SJEmotionTabBarButton.h"

@interface SJEmotionTabBar ()
@property (nonatomic,weak) SJEmotionTabBarButton *selectedBtn;

@end
@implementation SJEmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:SJEmotionTabBarButtonTypeRecent];
        [self btnClick:[self setupBtn:@"默认" buttonType:SJEmotionTabBarButtonTypeDefault]];
        [self setupBtn:@"Emoji" buttonType:SJEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:SJEmotionTabBarButtonTypeLxh];

    }
    return self;
}

- (SJEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(SJEmotionTabBarButtonType)buttonType
{
    // 创建按钮 
    SJEmotionTabBarButton *btn = [[SJEmotionTabBarButton alloc]init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = buttonType;
        
    // 设置按钮背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled] ;
    
    [self addSubview:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        SJEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
    }

}

-(void)setDelegate:(id<SJEmotionTabBardelegate>)delegate
{
    _delegate = delegate;
    // 选中默认按钮
    [self btnClick:(SJEmotionTabBarButton *)[self viewWithTag:SJEmotionTabBarButtonTypeDefault]];
}

- (void)btnClick:(SJEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
}

@end
