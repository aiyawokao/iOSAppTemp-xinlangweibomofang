//
//  SJStatusPhotoView.h
//  微博项目
//
//  Created by joe on 15/11/20.
//  Copyright © 2015年 joe. All rights reserved.
//  保存的是一张图片

#import <UIKit/UIKit.h>
@class SJPhoto;


@interface SJStatusPhotoView : UIImageView
@property (nonatomic,strong) SJPhoto *photo;

@end
