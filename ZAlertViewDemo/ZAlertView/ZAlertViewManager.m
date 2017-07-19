//
//  ZAlertViewManager.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ZAlertViewManager.h"

@interface ZAlertViewManager ()
{
    NSInteger _dismisstime;
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

    });
    return shareManager;
}

#pragma mark 显示弹窗
- (void)showWithType:(AlertViewType)type title:(NSString *)title
{
    _dismisstime = 0;//将时间重置为0
    [self.dismisTimer invalidate];//销毁定时器
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
        [self.alertView topAlertViewTypewWithType:type title:title];
        [self.alertView show];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAlertView)];
        tap.cancelsTouchesInView = NO;
        [self.alertView addGestureRecognizer:tap];

    });
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
    NSLog(@"=01==%ld===",_dismisstime);
    _dismisstime += 1;
    if (_dismisstime > 5)
    {
        [self.dismisTimer invalidate];
        [self.alertView dismiss];
        NSLog(@"=02==%ld===",_dismisstime);
    }
}

#pragma mark block
- (void)tapAlertView
{
    [self.alertView dismiss];
    _dismisstime = 0;//将时间重置为0
    [self.dismisTimer invalidate];//销毁定时器
    self.didselectedAlertViewBlock();
}
- (void)didSelectedAlertViewWithBlock:(SelectedAlertView)didselectedAlertViewBlock
{
    self.didselectedAlertViewBlock = didselectedAlertViewBlock;
}
@end
