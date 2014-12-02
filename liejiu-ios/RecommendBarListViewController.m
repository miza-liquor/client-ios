//
//  RecommendBarListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "RecommendBarListViewController.h"
#import "RecommendBarTableViewCell.h"

@interface RecommendBarListViewController ()

@end

@implementation RecommendBarListViewController
{
    NSArray *bars;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    bars = @[
             @{@"name": @"酒吧1", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧2", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧3", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧4", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧5", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧6", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧7", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧8", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧9", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧10", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧11", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧12", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧13", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧14", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧15", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧16", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧17", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧18", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧19", @"checkinNum": @"2123232"},
             @{@"name": @"酒吧10", @"checkinNum": @"2123232"},
            ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"RecommendBarTableViewCell";
    RecommendBarTableViewCell *cell = (RecommendBarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *info = (NSDictionary *)[bars objectAtIndex:indexPath.row];
    cell.barName.text = [info objectForKey:@"name"];
    cell.checkinNum.text = [NSString stringWithFormat:@"签到(%@)", [info objectForKey:@"checkinNum"]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"barDetail" sender:self];
}

@end
