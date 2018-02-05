//
//  Constant.h
//  ZAlertViewDemo
//
//  Created by YYKit on 2018/2/5.
//  Copyright © 2018年 kzkj. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define Start_Height - (Screen_Height == 812 ? 88:64)
#define Height (Screen_Height == 812 ? 88:64)
#define Self_Center_Y (Screen_Height == 812 ? 44:32)
#define Bounce_X_Label (Screen_Height == 812 ? 44:20)

#define Left_Offset 45
#define Right_Offset 5
#define Font_Size 14.0f
#define Image_Width 30
#define TipLabelHeight 40
#define Image_Center_X 25
#define Image_Center_Y (Height - 5 - TipLabelHeight/2)

#define ShowAnimationTime 1.0f
#define DissmissAnimationTime 0.25f

#endif /* Constant_h */
