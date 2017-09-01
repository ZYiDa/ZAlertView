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
#define Font_Size 14.0f
#define Image_Center_X 25
#define Image_Center_Y 40
#define Image_Width 30


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
        _tipsLabel.frame = CGRectMake(Left_Offset, 20, Screen_Width - Left_Offset, 40);
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
    if (self)
    {
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
    [UIView animateWithDuration:0.918f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.center = CGPointMake(self.center.x, 32);
                         [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
                     }
                     completion:^(BOOL finished) {
                     }];

}

/**
 *移除提示窗的动画
 */
- (void)dismiss
{
    [UIView animateWithDuration:0.218f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:20.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.center = CGPointMake(self.center.x, -32);
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];

}


@end
