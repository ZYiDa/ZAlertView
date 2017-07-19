//
//  ViewController.m
//  ZAlertViewDemo
//
//  Created by YYKit on 2017/7/19.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "ViewController.h"
#import "ZAlertViewManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showAlert:(id)sender
{
    [[ZAlertViewManager shareManager] showWithType:AlertViewTypeMessage title:@"这是一个测试信息!!!"];
    [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
        NSLog(@"DidSelectedAlertView");
    }];
    [[ZAlertViewManager shareManager] dismissAlert];
}
- (IBAction)dismissAlert:(id)sender
{
    [[ZAlertViewManager shareManager] dismissAlert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
