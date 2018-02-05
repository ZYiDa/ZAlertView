//
//  ZAlertViewManager.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ZAlertViewManager.h"
#import "MsgPlaySound.h"
#import "UIColor+Hexadecimal.h"
#import "Constant.h"

#pragma mark === ZAlertView ===
@interface ZAlertView()
{
    BOOL isShow;
    BOOL isDismiss;
}
@property (nonatomic,assign) AlertViewType alertViewType;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel     *tipsLabel;

- (instancetype)init;
- (void)topAlertViewTypewWithType:(AlertViewType)type title:(NSString *)title;
- (void)show;
- (void)dismiss;

@end

@implementation ZAlertView

/**
 *左侧的类型icon
 */
- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
        _imageView.frame = CGRectMake(0, 0, Image_Width, Image_Width);
        _imageView.center = CGPointMake(Image_Center_X, Image_Center_Y);
        [self addSubview:_imageView];
    }
    return _imageView;
}

/**
 *右侧的提示信息label
 */
- (UILabel *)tipsLabel
{
    if (_tipsLabel == nil)
    {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.userInteractionEnabled = YES;
        _tipsLabel.frame = CGRectMake(Left_Offset, Bounce_X_Label, Screen_Width - Left_Offset - Right_Offset, TipLabelHeight);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.font = [UIFont boldSystemFontOfSize:Font_Size];
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

/**
 *初始化
 */
- (instancetype)init
{
    self = [super init];
    if (self){
        isShow = NO;
        isDismiss = NO;
        self.userInteractionEnabled = YES;
    }
    return self;
}


/**
 *根据type的不同，设置不同的UI参数
 */
- (void)topAlertViewTypewWithType:(AlertViewType)type title:(NSString *)title
{
    self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
    self.tipsLabel.text = title;

    NSArray *backColors = @[[UIColor whiteColor],
                            [UIColor colorWithHexString:@"#EE7942"],
                            [UIColor colorWithHexString:@"#d4237a"],
                            [UIColor colorWithWhite:0.02 alpha:0.9]];
    NSArray *textColors = @[[UIColor colorWithHexString:@"#1296db"],
                            [UIColor colorWithHexString:@"#ffffff"],
                            [UIColor whiteColor],
                            [UIColor colorWithHexString:@"#ffffff"]];
    NSArray *images      = @[[UIImage imageNamed:@"success"],
                             [UIImage imageNamed:@"error"],
                             [UIImage imageNamed:@"Alert"],
                             [UIImage imageNamed:@"net"]];
    self.backgroundColor = backColors[type];
    self.imageView.image = images[type];
    self.tipsLabel.textColor = textColors[type];
}

/**
 *提示窗出现的动画，Spring动画
 */
- (void)show
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:ShowAnimationTime
                          delay:0
         usingSpringWithDamping:0.8f
          initialSpringVelocity:1.f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //TODO:*************
                         weakSelf.center = CGPointMake(weakSelf.center.x, Self_Center_Y);
                         [[UIApplication sharedApplication].keyWindow bringSubviewToFront:weakSelf];
                     }
                     completion:^(BOOL finished) {
                     }];

}

/**
 *移除提示窗的动画
 */
- (void)dismiss
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:DissmissAnimationTime
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionTransitionCurlUp
                     animations:^{
                         weakSelf.center = CGPointMake(weakSelf.center.x, -Self_Center_Y);
                     }
                     completion:^(BOOL finished) {
                         [weakSelf removeFromSuperview];
                     }];

}


@end


#pragma mark === ZAlertViewManager ===
@interface ZAlertViewManager ()
{
    NSInteger dismisstime;

}
@property (nonatomic,assign) NSInteger dismissTimes;
@property (nonatomic,strong) NSTimer *dismisTimer;
@end

@implementation ZAlertViewManager

/**
 *创建伪单例，确保弹窗的唯一性
 */
+ (ZAlertViewManager *)shareManager
{
    static ZAlertViewManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[ZAlertViewManager alloc]init];
        shareManager.alertView = [[ZAlertView alloc]init];
        shareManager.alertView.userInteractionEnabled = YES;
    });
    return shareManager;
}

#pragma mark 显示弹窗
/**
 *每次弹窗出现前，先判断定时器对象是否已经销毁置空，如果没有，先销毁置空
 */
- (void)showWithType:(AlertViewType)type title:(NSString *)title
{
    __weak typeof(self) weakSelf = self;
    [self releaseTimer];//销毁置空定时器
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
        [weakSelf.alertView topAlertViewTypewWithType:type title:title];
        [weakSelf.alertView show];

        //加载提示音，可以在showVoice方法中修改声音类型
        [weakSelf showVoice];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAlertView)];
        tap.cancelsTouchesInView = NO;
        [weakSelf.alertView addGestureRecognizer:tap];
    });
}

/**
 *弹窗提示音
 */
- (void)showVoice
{
    MsgPlaySound *msgPlaySound = nil;
    //通知声音
    if (msgPlaySound != nil){
        msgPlaySound = nil;
    }
    msgPlaySound = [[MsgPlaySound alloc]initSystemSoundWithName:@"Tock" SoundType:@"caf"];
    [msgPlaySound play];
}

/**
 *立即移除弹窗，同时销毁定时器
 */
- (void)dismissAlertImmediately
{
    [self releaseTimer];
    [self.alertView dismiss];
}

/**
 *延时移除弹窗，之后销毁定时器
 */
- (void)dismissAlertWithTime:(NSInteger)time
{
    self.dismissTimes = time;

    if (self.dismisTimer != nil) {
        return;
    }
    self.dismisTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                      selector:@selector(dismisAlertWithTimer:)
                                                      userInfo:nil
                                                       repeats:YES];
}

/**
 *定时器方法
 */
- (void)dismisAlertWithTimer:(NSTimer *)timer
{
    NSLog(@"Timer:%ld",dismisstime);
    if (dismisstime > self.dismissTimes){
        [self.alertView dismiss];
        [self releaseTimer];
    }
    dismisstime += 1;
}

/**
 *销毁定时器对象
 *同时将定时器时间归零
 */
- (void)releaseTimer
{
    dismisstime = 0;//将时间重置为0
    [self.dismisTimer invalidate];
    self.dismisTimer = nil;
}

/**
 *弹窗上的tap手势，立即移除弹窗，同时销毁定时器
 */
- (void)tapAlertView
{
    [self.alertView dismiss];
    [self releaseTimer];
    if (self.didselectedAlertViewBlock) {
        self.didselectedAlertViewBlock();
    }
}

/**
 *block监听，传递信息
 */
- (void)didSelectedAlertViewWithBlock:(SelectedAlertView)didselectedAlertViewBlock
{
    self.didselectedAlertViewBlock = didselectedAlertViewBlock;
}
@end

