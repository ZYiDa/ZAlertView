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
@property (copy, nonatomic) NSArray *dataSource2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.dataSource = [NSArray arrayWithObjects:@"成功",@"失败",@"预警信息",@"网络状况", nil];
    self.dataSource2 = [NSArray arrayWithObjects:@"延迟消失",@"立即消失", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?self.dataSource.count:self.dataSource2.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = indexPath.section == 0?self.dataSource[indexPath.row]:self.dataSource2[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0? @"点击提示窗，使之消失。" : @"点击下面表格使提示窗消失";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSArray *tips = [NSArray arrayWithObjects:@"请求成功!",@"请求失败!",@"888楼发生入侵事件!",@"网络状态已发生改变!", nil];
        [[ZAlertViewManager shareManager] showWithType:indexPath.row title:tips[indexPath.row]];
        [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
            NSLog(@"%@",tips[indexPath.row]);
        }];
    }
    else
    {
        if (indexPath.row == 0)
        {
            [[ZAlertViewManager shareManager] dismissAlertWithTime:10];
        }
        else
        {
            [[ZAlertViewManager shareManager] dismissAlertImmediately];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
