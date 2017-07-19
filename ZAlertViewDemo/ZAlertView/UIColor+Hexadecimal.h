//
//  UIColor+Hexadecimal.h
//  Miaomai
//
//  Created by 你好，色彩 on 16/9/8.
//  Copyright © 2016年 yjfzcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hexadecimal)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*)color;
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
