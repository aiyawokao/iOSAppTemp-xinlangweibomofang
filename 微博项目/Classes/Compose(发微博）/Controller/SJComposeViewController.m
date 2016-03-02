//
//  SJComposeViewController.m
//  微博项目
//
//  Created by joe on 15/11/20.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJComposeViewController.h"
#import "SJAccountTool.h"
#import "SJAccount.h"
#import "SJEmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "SJComposeToolBar.h"
#import "SJComposePhotosView.h"
#import "SJEmotionKeyboard.h"
#import "SJEmotion.h"
#import "NSString+Emoji.h"



@interface SJComposeViewController ()<UITextViewDelegate,SJComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 输入控件 */
@property (nonatomic,weak)SJEmotionTextView * textView;
/** 键盘上面的工具条 */
@property (nonatomic,weak) SJComposeToolBar *toolbar;
/** 相册 （存放拍照或者从相册中选择的图片） */
@property (nonatomic,weak) SJComposePhotosView *photosView;
#warning 一定要用强指针，保证键盘不会被销毁
/** 表情键盘 */
@property (nonatomic,strong) SJEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic,assign) BOOL switchingKeyboard;
@end

@implementation SJComposeViewController

#pragma mark - 懒加载
- (SJEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[SJEmotionKeyboard alloc]init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;// 216是键盘标准尺寸
    }
    return _emotionKeyboard;
}


#pragma mark - 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏
    [self setupNav];
    // 添加输入控件
    [self setupTextView];
    // 添加工具条
    [self setupComposeToolBar];
    // 添加相册
    [self setupPhotosView];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 成为第一响应者（能输入文本的控件成为第一响应者，就会弹出相应的键盘）
    [self.textView becomeFirstResponder];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 初始化方法
/**
 * 添加相册
 */
- (void)setupPhotosView
{
    SJComposePhotosView *photosView = [[SJComposePhotosView alloc]init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;// 高度可以随便指定
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}


/**
 * 添加工具条
 */
- (void)setupComposeToolBar
{
    SJComposeToolBar *toolbar = [[SJComposeToolBar alloc]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    // inputAccessoryView 设置显示在键盘顶部的内容  inputView设置键盘
//    self.placeholderTextView.inputAccessoryView = toolbar;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 * 设置导航栏
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [SJAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        
        UILabel *titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
        
    } else {
        self.title = prefix;
    }
}

/**
 * 添加输入控件
 */
- (void)setupTextView
{
    SJEmotionTextView *textView = [[SJEmotionTextView alloc]init];
    // 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享你的新鲜事儿...";
//    textView.placeholderColor = [UIColor orangeColor];
    [self.view addSubview:textView];
    self.textView = textView;// 不要忘记赋值
    
    // 监听文字改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 监听键盘显示通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidSelect:) name:@"SJEmotionDidSelectNotification" object:nil];
}

#pragma mark - 监听方法

/**
 * 表情选中了
 */
- (void)emotionDidSelect:(NSNotification *)notification
{
    SJEmotion *emotion = notification.userInfo[@"selectEmotion"];
    
    [self.textView insertEmotion:emotion];
    
}


- (void)keyboardWillChangFrame:(NSNotification *)notification
{
    // 如果正在切换键盘就返回
    if (self.switchingKeyboard) return;
    
//    SJLog(@"%@",notification);
    NSDictionary *userInfo = notification.userInfo;
    // 动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        // 工具条的y值
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y =  keyboardF.origin.y - self.toolbar.height;
        }
    }];
    
}

- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if (self.photosView.photos.count) {// 发送有图片的微博
        [self sendWithImage];
    } else {// 发送没有图片的微博
        [self sendWithoutImage];
    }
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];

}

/**
 * 发送有图片的微博
 */
- (void)sendWithImage
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    SJAccount *account = [SJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"text.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}

/**
 * 发送没有图片的微博
 */
- (void)sendWithoutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    SJAccount *account = [SJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    
}

#pragma mark - UITextViewDelegate代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - SJComposeToolBarDelegate
- (void)composeToolBar:(SJComposeToolBar *)toolbar didClickButton:(SJComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case SJComposeToolBarButtonTypeCamera:// 拍照
//            SJLog(@"-- 拍照");
            [self openCamera];
            break;
            
        case SJComposeToolBarButtonTypePicture:// 相册
//            SJLog(@"-- 相册");
            [self openAlbum];

            break;
        case SJComposeToolBarButtonTypeMention:// @
            SJLog(@"-- @");

            break;
        case SJComposeToolBarButtonTypeTrend:// #
            SJLog(@"-- #");

            break;
        case SJComposeToolBarButtonTypeEmotion:// 表情
            SJLog(@"-- 表情");
            [self switchKeyboard];
            break;
    }
}

#pragma mark - 其他方法
/**
 * 切换表情键盘
 */
- (void)switchKeyboard
{
    // self.placeholderTextView.inputView = nil 代表使用的是系统自带的键盘
    if (self.textView.inputView == nil) {// 切换为自定义的表情键盘
        self.textView.inputView = self.emotionKeyboard;
        
        // 显示键盘按钮
        self.toolbar.showKeyboardButton = YES;
        
    } else {// 切换回系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情按钮
        self.toolbar.showKeyboardButton = NO;
        
    }
    // 开始切换键盘
    self.switchingKeyboard = YES;
    
    // 退出键盘的方式
    [self.textView endEditing:YES];
//    [self.placeholderTextView resignFirstResponder];
//    [self.view.window endEditing:YES];
//    [self.view endEditing:YES];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
        // 结束切换键盘
        self.switchingKeyboard = NO;
    });
}


- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework框架，可以获得手机上所有的相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];

}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];

}

#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就会调用（拍照完毕或者从相册中选好图片）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    // info中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 添加图片到photosView中
    [self.photosView addPhoto:image];

}

@end
