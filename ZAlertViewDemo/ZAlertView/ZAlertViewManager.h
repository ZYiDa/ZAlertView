//
//  ZAlertViewManager.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



/*
 block类型
 */
typedef void(^SelectedAlertView)();

/*
 弹窗类型
 */
typedef NS_OPTIONS (NSInteger ,AlertViewType){
    AlertViewTypeSuccess = 0,//成功
    AlertViewTypeError   ,//失败
    AlertViewTypeMessage ,//消息
    AlertViewTypeNetStatus//网络状态
};


#pragma mark === ZAlertView ===
@interface ZAlertView : UIView

@end

#pragma mark === ZAlertViewManager ===
@interface ZAlertViewManager : NSObject

@property (nonatomic,strong)ZAlertView *alertView;
+ (ZAlertViewManager *)shareManager;

- (void)showWithType:(AlertViewType)type title:(NSString *)title;
- (void)dismissAlertWithTime:(NSInteger)time;
- (void)dismissAlertImmediately;

@property (nonatomic,copy) SelectedAlertView didselectedAlertViewBlock;

- (void)didSelectedAlertViewWithBlock:(SelectedAlertView) didselectedAlertViewBlock;

@end









