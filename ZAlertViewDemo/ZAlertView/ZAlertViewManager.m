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

#pragma mark 创建伪单例，确保弹窗的唯一性
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
- (void)showWithType:(AlertViewType)type title:(NSString *)title
{
    dismisstime = 0;//将时间重置为0
    [self.dismisTimer invalidate];//销毁定时器
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
        [self.alertView topAlertViewTypewWithType:type title:title];
        [self.alertView show];
        [self showVoice];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAlertView)];
        tap.cancelsTouchesInView = NO;
        [self.alertView addGestureRecognizer:tap];
    });
}

#pragma mark 提示音
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

#pragma mark 移除弹窗
- (void)dismissAlert
{
    self.dismisTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                   target:self
                                                 selector:@selector(dismisAlertWithTimer:)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)dismisAlertWithTimer:(NSTimer *)timer
{
    NSLog(@"=01==%ld===",dismisstime);
    if (dismisstime > 4)
    {
        [self.dismisTimer invalidate];
        [self.alertView dismiss];
        NSLog(@"=02==%ld===",dismisstime);
    }
    dismisstime += 1;
}

#pragma mark block
- (void)tapAlertView
{
    [self.alertView dismiss];
    dismisstime = 0;//将时间重置为0
    [self.dismisTimer invalidate];//销毁定时器
    self.didselectedAlertViewBlock();
}
- (void)didSelectedAlertViewWithBlock:(SelectedAlertView)didselectedAlertViewBlock
{
    self.didselectedAlertViewBlock = didselectedAlertViewBlock;
}
@end
