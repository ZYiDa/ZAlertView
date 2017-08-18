//
//  ZAlertView.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS (NSInteger ,AlertViewType){
    AlertViewTypeSuccess = 0,
    AlertViewTypeError   ,
    AlertViewTypeMessage ,
    AlertViewTypeNetStatus
};

@interface ZAlertView : UIView

@property (nonatomic,assign) AlertViewType alertViewType;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel     *tipsLabel;

- (instancetype)init;
- (void)topAlertViewTypewWithType:(AlertViewType)type title:(NSString *)title;
- (void)show;
- (void)dismiss;
@end
