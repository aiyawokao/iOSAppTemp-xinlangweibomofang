//
//  SJStatusPhotoView.m
//  微博项目
//
//  Created by joe on 15/11/20.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "SJPhoto.h"

@interface SJStatusPhotoView()
@property (nonatomic,weak) SJStatusPhotoView *gifView;

@end

@implementation SJStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = (SJStatusPhotoView *)gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIViewContentModeScaleToFill,
//        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
//        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
//        UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
//        UIViewContentModeTop,
//        UIViewContentModeBottom,
//        UIViewContentModeLeft,
//        UIViewContentModeRight,
//        UIViewContentModeTopLeft,
//        UIViewContentModeTopRight,
//        UIViewContentModeBottomLeft,
//        UIViewContentModeBottomRight,
//        经验规律：
//        1、
//
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(SJPhoto *)photo
{
    _photo = photo;
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 显示/隐藏gif控件
//    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {
//        self.gifView.hidden = NO;
//    } else {
//        self.gifView.hidden = YES;
//    }
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}

@end
