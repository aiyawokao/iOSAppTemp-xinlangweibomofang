//
//  SJStatusPhotosView.m
//  微博项目
//
//  Created by joe on 15/11/17.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJStatusPhotosView.h"
#import "SJPhoto.h"
#import "SJStatusPhotoView.h"

#define SJStatusPhotoWH 70
#define SJStatusPhotoMargin 10
#define SJStatusPhotoMaxCol(count) ((count == 4)?2:3) 

@implementation SJStatusPhotosView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    // 创建足够多的图片控件
    while (self.subviews.count < photosCount) {
        SJStatusPhotoView *photoView = [[SJStatusPhotoView alloc]init];
        [self addSubview:photoView];
    }
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        SJStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) {// 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
            
        } else {
            // 隐藏
            photoView.hidden = YES;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = SJStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        SJStatusPhotoView *photoView = self.subviews[i];
        int cols = i % maxCol;
        photoView.x = cols * (SJStatusPhotoWH + SJStatusPhotoMargin);
        int rows = i / maxCol;
        photoView.y = rows * (SJStatusPhotoWH + SJStatusPhotoMargin);
        photoView.width = SJStatusPhotoWH;
        photoView.height = SJStatusPhotoWH;

    }
    
}


+ (CGSize)sizeWithCount:(NSUInteger)count
{
    // 这是做服务器开发总结出的 计算多少列、多少行的公式 记住！！！！！！！！！！！！！！！！！
    // 最大列数（一行最多有多少列）
    NSUInteger maxCols = SJStatusPhotoMaxCol(count);
    // 列数
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * SJStatusPhotoWH + (cols - 1) * SJStatusPhotoMargin;
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * SJStatusPhotoWH + (rows - 1) * SJStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}


@end
