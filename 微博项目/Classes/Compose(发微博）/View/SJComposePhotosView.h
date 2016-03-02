//
//  SJComposePhotosView.h
//  微博项目
//
//  Created by joe on 15/11/24.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;
//- (NSArray *)photos;
@property (nonatomic,strong,readonly)NSMutableArray *photos;

@end
