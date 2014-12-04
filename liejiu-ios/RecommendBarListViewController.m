//
//  RecommendBarListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "RecommendBarListViewController.h"
#import "RecommendBarTableViewCell.h"
#import "AppSetting.h"

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
    [AppSetting drawToolBar:self];
    
    NSArray *cache = (NSArray *)[AppSetting getCache:@"topbar"];
    if (cache == Nil)
    {
        [AppSetting httpGet:@"topbar" parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            if (success == YES)
            {
                bars = (NSArray *)[response objectForKey:@"data"];
                [AppSetting setCache:@"topbBar" value:bars];
                [self.tableView reloadData];
            }
        }];
    } else {
        bars = cache;
    }
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
    [cell setTopBarData:info];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"barDetail" sender:self];
}

@end
