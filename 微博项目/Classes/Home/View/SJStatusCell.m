//
//  SJStatusCell.m
//  微博项目
//
//  Created by joe on 15/11/10.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJStatusCell.h"
#import "SJStatus.h"
#import "SJStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "SJUser.h"
#import "SJPhoto.h"
#import "SJStatusToolbar.h"
#import "NSString+Extension.h"
#import "SJStatusPhotosView.h"
#import "SJIconView.h"

@interface SJStatusCell()

/* 原创微博 */
/* 原创微博整体view */
@property (nonatomic,weak) UIView *originalView;
/* 头像 */
@property (nonatomic,weak) SJIconView *iconView;
/* 会员图标 */
@property (nonatomic,weak) UIImageView *vipView;
/* 配图 */
@property (nonatomic,weak) SJStatusPhotosView *photosView;
/* 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;
/* 时间 */
@property (nonatomic,weak) UILabel *timeLabel;
/* 来源 */
@property (nonatomic,weak) UILabel *sourceLabel;
/* 正文 */
@property (nonatomic,weak) UILabel *contentLabel;

/* 转发微博 */
/* 转发微博整体view */
@property (nonatomic,weak) UIView *retweetView;
/* 转发微博正文 + 昵称 */
@property (nonatomic,weak) UILabel *retweetContentLabel;
/* 转发微博配图 */
@property (nonatomic,weak) SJStatusPhotosView *retweetPhotosView;

/** 底部工具条 */
@property (nonatomic,weak) SJStatusToolbar *toolbar;

@end

@implementation SJStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    SJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[SJStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


//  cell 的初始化方法，一个cell只会调用一次  ！！！！！！！！！！！！！！！！！！！！！！
//  一般在这里添加所有可能要显示的子控件，以及子控件的一次性设置 ！！！！！！！！！！！！！

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 点击cell的时候不要变灰色（系统自带的点击变灰）
        self.selectionStyle = UITableViewCellSelectionStyleNone;
         
        // 初始化原创微博
        [self setupOriginalStatus];
    
        // 初始化转发微博
        [self setupRetweetedStatus];
        
        // 初始化工具条
        [self setupToolbar];

    }
    return self;
}

// 让所有cell都往下挪15
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += SJStatusCellMargin;
    [super setFrame:frame];
}
- (void)setupOriginalStatus
{
    /* 原创微博整体view */
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /* 头像 */
    SJIconView *iconView =[[SJIconView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /* 会员图标 */
    UIImageView *vipView =[[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /* 配图 */
    SJStatusPhotosView *photosView =[[SJStatusPhotosView alloc]init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    /* 昵称 */
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = SJStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /* 时间 */
    UILabel *timeLabel= [[UILabel alloc]init];
    timeLabel.font = SJStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /* 来源 */
    UILabel *sourceLabel =[[UILabel alloc]init];
    sourceLabel.font = SJStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /* 正文 */
    UILabel *contentLabel =[[UILabel alloc]init];
    contentLabel.font = SJStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;

}

- (void)setupRetweetedStatus
{
    /* 原创微博整体view */
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:1.0];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /* 正文 */
    UILabel *retweetContentLabel =[[UILabel alloc]init];
    retweetContentLabel.font = SJStatusCellRetweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;

    /* 配图 */
    SJStatusPhotosView *retweetPhotosView =[[SJStatusPhotosView alloc]init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    

}

- (void)setupToolbar
{
    SJStatusToolbar *toolbar = [SJStatusToolbar toolbar];
//    toolbar.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)setStatusFrame:(SJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    SJStatus *status = statusFrame.status;
    SJUser *user = status.user;
    
    /* 原创微博整体view */
    self.originalView.frame = statusFrame.originalViewF;
    
    /* 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    /* 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
        
    }
    /* 配图 */
    if (status.pic_urls.count){
        self.photosView.frame = statusFrame.photosViewF;
        // SJPhoto *photo = [status.pic_urls firstObject];
        // [self.photosView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photosView.photos = status.pic_urls;
         self.photosView.hidden = NO;
    }else {
        self.photosView.hidden = YES;
    }
    
    
    /* 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) +SJStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:SJStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + SJStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SJStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    
    /* 正文 */
    self.contentLabel.attributedText = status.attributedText;
    self.contentLabel.frame = statusFrame.contentLabelF;

    /* 转发微博 */
    
    if (status.retweeted_status) {
        
        SJStatus *retweeted_status = status.retweeted_status;
        SJUser *retweeted_status_user = status.retweeted_status.user;
        
        self.retweetView.hidden = NO;
        /** 转发微博整体view */
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 被转发微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发微博配图 */
        if (retweeted_status.pic_urls.count){
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;

            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            // SJPhoto *retweetPhoto = [retweeted_status.pic_urls firstObject];
            // [self.retweetPhotosView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
            self.retweetPhotosView.hidden = NO;
        }else {
            self.retweetPhotosView.hidden = YES;
        }
        
    } else {
        self.retweetView.hidden = YES;
    }
    
    /** 底部工具条 */
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
