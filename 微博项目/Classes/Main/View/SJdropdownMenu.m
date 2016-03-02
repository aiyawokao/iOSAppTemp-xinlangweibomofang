//
//  SJdropdownMenu.m
//  微博项目
//
//  Created by joe on 15/10/9.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJdropdownMenu.h"

@interface SJdropdownMenu()
@property (nonatomic,weak)UIImageView *containerView;
@end

@implementation SJdropdownMenu

- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc]init];
//        containerView.width = 217;
//        containerView.height = 217;
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;// 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
            }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc]init];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    
    // 调整内容的宽度
    // content.width = self.containerView.width - 2 * content.x;
    
    // 调整灰色的高度 
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    // 调整灰色的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
    
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)showFrom:(UIView *)from
{
    // 获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加自己到窗口
    [window addSubview:self];
    // 设置尺寸
    self.frame = window.bounds;
    // 调整灰色图片的位置
    
    // 默认情况下，frame是以父控件的左上角为坐标原点!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // 转换坐标系    （比较实用）
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    // 通知外界，自己显示啦
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }

    
}

- (void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // SJLog(@"touchesBegan");
    [self dismiss];
}

@end
