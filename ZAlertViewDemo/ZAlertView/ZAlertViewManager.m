//
//  ZAlertViewManager.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ZAlertViewManager.h"
#import "MsgPlaySound.h"
@interface ZAlertViewManager ()
{
    NSInteger dismisstime;

}
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
    [self releaseTimer];//销毁置空定时器
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
        [self.alertView topAlertViewTypewWithType:type title:title];
        [self.alertView show];

        //加载提示音，可以在showVoice方法中修改声音类型
        [self showVoice];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAlertView)];
        tap.cancelsTouchesInView = NO;
        [self.alertView addGestureRecognizer:tap];
    });
}

/**
 *弹窗提示音
 */
- (void)showVoice
{
    MsgPlaySound *msgPlaySound = nil;
    //通知声音
    if (msgPlaySound != nil)
    {
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

    if (self.dismisTimer == nil)
    {
        self.dismisTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                            target:self
                                                          selector:@selector(dismisAlertWithTimer:)
                                                          userInfo:nil
                                                           repeats:YES];
    }
    else
    {
        return;
    }
}

/**
 *定时器方法
 */
- (void)dismisAlertWithTimer:(NSTimer *)timer
{
    NSLog(@"Timer:%ld",dismisstime);
    if (dismisstime > self.dismissTimes)
    {
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
    self.didselectedAlertViewBlock();
}

/**
 *block监听，传递信息
 */
- (void)didSelectedAlertViewWithBlock:(SelectedAlertView)didselectedAlertViewBlock
{
    self.didselectedAlertViewBlock = didselectedAlertViewBlock;
}
@end
