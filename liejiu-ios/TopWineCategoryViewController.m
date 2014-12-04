//
//  TopWineCategoryViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopWineCategoryViewController.h"
#import "TopWineCategoryTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"

@interface TopWineCategoryViewController ()

@end

@implementation TopWineCategoryViewController
{
    NSArray *categories;
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
    
    NSArray *cache = (NSArray *)[AppSetting getCache:@"wineCategory"];
    if (cache == Nil)
    {
        [AppSetting httpGet:@"winecategory" parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            if (success == YES)
            {
                categories = (NSArray *)[response objectForKey:@"data"];
                [AppSetting setCache:@"wineCategory" value:categories];
                [self.tableView reloadData];
            }
        }];
    } else {
        categories = cache;
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
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"TopWineCategoryTableViewCell";
    TopWineCategoryTableViewCell *cell = (TopWineCategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *info = (NSDictionary *)[categories objectAtIndex:indexPath.row];
    
    cell.category.text = (NSString *)[info objectForKey:@"name"];
    [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[info objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* category = [NSString stringWithFormat:@"%d", indexPath.row];
    [self.delegate topWineCategoryChanged: category];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
