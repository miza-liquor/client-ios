//
//  WineSelectViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 3/13/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "WineSelectViewController.h"
#import "LoadingTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppSetting.h"

@interface WineSelectViewController ()

@end

@implementation WineSelectViewController
{
    NSArray *wines;
    NSString *keyword;
    BOOL isLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"选择酒品";
    wines = @[];
    isLoading = YES;
    keyword = @"";
    
    [self getWineData];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void) getWineData
{
    isLoading = YES;
    wines = @[];
    [self.tableview reloadData];
    NSString *url = [NSString stringWithFormat:@"search/wine/%@", keyword];
    
    [AppSetting httpGet:url parameters:@{@"simple": @"1"} callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        isLoading = NO;
        if (success) {
            wines = (NSArray *)[response objectForKey:@"data"];
        } else {
            NSLog(@"error in fetching data from server");
        }
        
        [self.tableview reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    return isLoading ? 1 : [wines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) {
        static NSString *loadingTableIdentifier = @"LoadingTableViewCell";
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:loadingTableIdentifier owner:self options:nil];
        LoadingTableViewCell *loadingCell = [nib objectAtIndex:0];
        return loadingCell;
    }
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSDictionary *data = (NSDictionary *)[wines objectAtIndex:indexPath.row];
    cell.textLabel.text = (NSString *)[data objectForKey:@"c_name"];
    cell.detailTextLabel.text = (NSString *)[data objectForKey:@"desc"];
    
    NSString *imageUrl = (NSString *)[data objectForKey:@"image"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"Icon-40"]];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *selectedMenuInfo = (NSDictionary *)[wines objectAtIndex:indexPath.row];
    [self.delegate selectedWine:selectedMenuInfo];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
