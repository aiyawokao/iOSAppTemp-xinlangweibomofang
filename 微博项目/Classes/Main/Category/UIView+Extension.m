//
//  UIView+Extension.m
//  微博项目
//
//  Created by joe on 15/9/16.
//  Copyright (c) 2015年 joe. All rights reserved.
//


#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)centerX
{
    return self.center.x;
}


-(CGFloat)y
{
    return self.frame.origin.y;
}

-(CGFloat)centerY
{
    return self.center.y;
}


-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size =size;
    self.frame =frame;
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin =origin;
    self.frame = frame;
}

-(CGPoint)origin
{
    return self.frame.origin;
}

@end
