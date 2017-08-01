//
//  ZAlertView.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ZAlertView.h"
#import "UIColor+Hexadecimal.h"

#define Start_Height -64
#define Height 64
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Left_Offset 45
#define Font_Size 16.0f
#define Image_Center_X 25
#define Image_Center_Y 40
#define Image_Width 30
@implementation ZAlertView

#pragma mark 左侧的icon
- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, Image_Width, Image_Width);
        _imageView.center = CGPointMake(Image_Center_X, Image_Center_Y);
        [self addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark 右侧的文字提示
- (UILabel *)tipsLabel
{
    if (_tipsLabel == nil)
    {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.frame = CGRectMake(Left_Offset, 20, Screen_Width - Left_Offset, 40);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.font = [UIFont boldSystemFontOfSize:Font_Size];
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

#pragma mark 初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAlert)];
        [tap setCancelsTouchesInView:NO];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)removeAlert
{
    [self dismiss];
}

#pragma mark 设置type
- (void)topAlertViewTypewWithType:(AlertViewType)type title:(NSString *)title
{
    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#B0C4DE"];
            self.imageView.image = [UIImage imageNamed:@"success"];
            self.tipsLabel.text = title;
            self.tipsLabel.textColor = [UIColor colorWithHexString:@"#1296db"];
        }
            break;
        case AlertViewTypeError:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#EE7942"];
            self.imageView.image = [UIImage imageNamed:@"error"];
            self.tipsLabel.text = title;
            self.tipsLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        }
            break;
        case AlertViewTypeMessage:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#B0C4DE"];
            self.imageView.image = [UIImage imageNamed:@"Alert"];
            self.tipsLabel.text = title;
            self.tipsLabel.textColor = [UIColor colorWithHexString:@"#d4237a"];
        }
            break;
        case AlertViewTypeNetStatus:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#B0C4DE"];
            self.imageView.image = [UIImage imageNamed:@"net"];
            self.tipsLabel.text = title;
            self.tipsLabel.textColor = [UIColor colorWithHexString:@"#d4237a"];
        }
            break;
        default:
            break;
    }

}

#pragma mark 显示
- (void)show
{
    [UIView animateWithDuration:0.618f
                          delay:0
         usingSpringWithDamping:0.9f
          initialSpringVelocity:10.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(self.center.x, 32);
                         [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
                     }
                     completion:^(BOOL finished) {
                     }];

}

#pragma mark 移除
- (void)dismiss
{
    [UIView animateWithDuration:0.618f
                          delay:0
         usingSpringWithDamping:0.99f
          initialSpringVelocity:15.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(self.center.x, -32);
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];

}


@end
