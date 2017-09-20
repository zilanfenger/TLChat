//
//  TLMineViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

/*
 *  注意：该类TableView重载并增加section（0， 0）
 */

#import "TLMineViewController.h"
#import "TLMineHeaderCell.h"
#import "TLUserHelper.h"

#import "TLMineInfoViewController.h"
#import "TLWalletViewController.h"
#import "TLExpressionViewController.h"
#import "TLMineSettingViewController.h"


@implementation TLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我"];
    
    [self p_initData];
    
    [self.tableView registerClass:[TLMineHeaderCell class] forCellReuseIdentifier:@"TLMineHeaderCell"];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLMineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMineHeaderCell"];
        [cell setUser:[TLUserHelper sharedHelper].user];
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
}

//MARK: UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    return [super tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLMineInfoViewController *mineInfoVC = [[TLMineInfoViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:mineInfoVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    TLMenuItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"钱包"]) {
        TLWalletViewController *walletVC = [[TLWalletViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:walletVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else if ([item.title isEqualToString:@"表情"]) {
        TLExpressionViewController *expressionVC = [[TLExpressionViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:expressionVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else if ([item.title isEqualToString:@"设置"]) {
        TLMineSettingViewController *settingVC = [[TLMineSettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:settingVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - # Private Methods
- (void)p_initData
{
    TLMenuItem *item0 = TLCreateMenuItem(nil, nil);
    TLMenuItem *item1 = TLCreateMenuItem(@"mine_album", @"相册");
    TLMenuItem *item2 = TLCreateMenuItem(@"mine_favorites", @"收藏");
    TLMenuItem *item3 = TLCreateMenuItem(@"mine_wallet", @"钱包");
    TLMenuItem *item4 = TLCreateMenuItem(@"mine_card", @"优惠券");
    TLMenuItem *item5 = TLCreateMenuItem(@"mine_expression", @"表情");
    TLMenuItem *item6 = TLCreateMenuItem(@"mine_setting", @"设置");
    self.data = @[@[item0], @[item1, item2, item3, item4], @[item5], @[item6]].mutableCopy;
}

@end
