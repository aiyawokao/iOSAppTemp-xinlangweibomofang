//
//  SJStatusPhotosView.h
//  微博项目
//
//  Created by joe on 15/11/17.
//  Copyright © 2015年 joe. All rights reserved.
//  cell上面的配图相册（里面会显示1~9张图片, 里面都是SJStatusPhotoView）


#import <UIKit/UIKit.h>

@interface SJStatusPhotosView : UIView

@property (nonatomic,strong) NSArray *photos;

+ (CGSize)sizeWithCount:(NSUInteger)count;

@end
