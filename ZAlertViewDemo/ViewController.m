//
//  ViewController.m
//  ZAlertViewDemo
//
//  Created by YYKit on 2017/7/19.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "ViewController.h"
#import "ZAlertViewManager.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *styleList;
@property (copy, nonatomic) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSArray arrayWithObjects:@"成功",@"失败",@"预警信息",@"网络状况", nil];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"点击提示窗，使之消失。";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess title:@"请求成功!"];
            [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
                NSLog(@"请求成功!");
            }];
        }
            break;
        case 1:
        {
            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeError title:@"请求失败!"];
            [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
                NSLog(@"请求失败!");
            }];
        }
            break;
        case 2:
        {
            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeMessage title:@"19楼发生入侵事件!"];
            [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
                NSLog(@"19楼发生入侵事件!");
            }];
        }
            break;
        case 3:
        {
            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeNetStatus title:@"网络状态已发生改变!"];
            [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
                NSLog(@"网络状态已发生改变!");
            }];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
