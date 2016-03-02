//
//  SJEmotionPageView.m
//  微博项目
//
//  Created by joe on 15/11/26.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionPageView.h"
#import "SJEmotion.h"
#import "NSString+Emoji.h"
#import "SJEmotionPopView.h"
#import "SJEmotionButton.h"

@interface SJEmotionPageView()
/** 点击表情弹出的放大镜 */
@property (nonatomic,strong) SJEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic,weak) UIButton *deleteButton;

@end

@implementation SJEmotionPageView

- (SJEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [SJEmotionPopView popView];
    }
    return _popView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}


-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (int i = 0; i<count; i++) {
        
        SJEmotionButton *btn = [[SJEmotionButton alloc]init];
        [self addSubview:btn];

        // 设置表情数据
        btn.emotion = emotions[i];
        // 监听表情按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.emotions.count;
    // 内边距
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2 * inset)/SJEmotionMaxCols;
    CGFloat btnH = (self.height - inset)/SJEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i + 1];// 0那个位置上放的是删除按钮，因为删除按钮是在initWithFrame：方法中创建的
        btn.width = btnW; 
        btn.height = btnH;
        btn.x = inset + (i%SJEmotionMaxCols) * btnW;
        btn.y = inset + (i/SJEmotionMaxCols) * btnH;
    }
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
    
    
}

/**
 * 删除按钮的点击
 */
-(void)deleteClick
{
    
}

/**
 * 表情按钮的点击
 */
-(void)btnClick:(SJEmotionButton *)btn
{
    // 给popView传数据
    self.popView.emotion = btn.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    // 计算被点击的按钮在window中的frame
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    
    self.popView.centerX = CGRectGetMidX(btnFrame);
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    
    // 等会让popview消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发送通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"selectEmotion"] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SJEmotionDidSelectNotification" object:nil userInfo:userInfo];
    
    
}




@end
