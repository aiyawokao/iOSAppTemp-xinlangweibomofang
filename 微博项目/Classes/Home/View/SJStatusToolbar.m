//
//  SJStatusToolbar.m
//  微博项目
//
//  Created by joe on 15/11/13.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJStatusToolbar.h"
#import "SJStatus.h"

@interface SJStatusToolbar()

/** 里面存放所有的按钮 */
@property (nonatomic,strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic,strong) NSMutableArray *dividers;

@property (nonatomic,weak) UIButton *repostBtn;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,weak) UIButton *attitudeBtn;

@end

@implementation SJStatusToolbar

- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

+(instancetype)toolbar
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        // 添加按钮
        self.repostBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        // 添加分割线
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}

/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

- (UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon
{
    UIButton *Btn = [[UIButton alloc]init];
    [Btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    Btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    Btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:Btn];
    [self.btns addObject:Btn];
    
    return Btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮的frame
    NSUInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
    } 
    
    // 设置分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }

}

- (void)setStatus:(SJStatus *)status
{
    _status = status;
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
    
}

- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) {// 数字不为0
        if (count < 10000) {// 数字不足一万，则直接显示整数： 比如 199 9933等
            title = [NSString stringWithFormat:@"%d",count];
        } else {// 达到一万，则显示xx.x万，不能有xx.0万的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            // 把字符串中的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

    }
        [btn setTitle:title forState:UIControlStateNormal];

}

@end
