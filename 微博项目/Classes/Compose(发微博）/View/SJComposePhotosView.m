//
//  SJComposePhotosView.m
//  微博项目
//
//  Created by joe on 15/11/24.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJComposePhotosView.h"

@implementation SJComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

-(void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    // 存储图片
    [_photos addObject:photo];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        int cols = i % maxCol;
        photoView.x = cols * (imageWH + imageMargin);
        int rows = i / maxCol;
        photoView.y = rows * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
        
    }

}

//-(NSArray *)photos
//{
//    NSMutableArray *photos = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        [photos addObject:imageView.image];
//    }
//    return photos;
//}


@end
