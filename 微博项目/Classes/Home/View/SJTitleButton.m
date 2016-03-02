//
//  SJTitleButton.m
//  微博项目
//
//  Created by joe on 15/10/15.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJTitleButton.h"

#define SJMargin 5

@implementation SJTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //titleButton.backgroundColor = [UIColor redColor];
        // 设置图片和文字
        // 因为button的设置需要同时设置状态，所以用 set*** forState：*** 来设置！！！
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.width += SJMargin;
    [super setFrame:frame];
}


// 设置按钮内部imageView的frame
// contentRect 按钮的bounds

//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    
//}

// 设置按钮内部titleLabel的frame
// contentRect 按钮的bounds

//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是修改button内部titleLabel和imageView的位置，那么只需要在layoutSubviews中单独设置位置即可
    // 1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];// 自适应尺寸
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}



@end
