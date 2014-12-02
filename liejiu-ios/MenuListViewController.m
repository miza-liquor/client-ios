//
//  MenuListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "MenuListViewController.h"
#import "NewMenuViewController.h"

@interface MenuListViewController ()

@end

@implementation MenuListViewController
{
    NSArray *menuList;
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
    
    menuList = @[
                 @{@"name": @"酒单1"},
                 @{@"name": @"酒单2"},
                 @{@"name": @"酒单3"},
                 @{@"name": @"酒单4"},
                 @{@"name": @"酒单5"},
                 @{@"name": @"酒单6"},
                 @{@"name": @"酒单7"},
                 @{@"name": @"酒单8"},
                 @{@"name": @"酒单9"},
                 @{@"name": @"酒单10"},
                 @{@"name": @"酒单11"},
                 @{@"name": @"酒单12"},
                 @{@"name": @"酒单13"},
                 @{@"name": @"酒单14"},
                 @{@"name": @"酒单15"},
                 @{@"name": @"酒单16"},
                 @{@"name": @"酒单17"},
                 @{@"name": @"酒单18"},
                 @{@"name": @"酒单19"},
                 @{@"name": @"酒单20"}
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
    // Return the number of sections.
    return [menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSDictionary *info = (NSDictionary *) [menuList objectAtIndex:indexPath.row];
    cell.textLabel.text = [info objectForKey:@"name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - new menu delegate
- (void) addNewMenu:(NSString *)menuID
{
    [self.tableView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newMenu"])
    {
        NewMenuViewController *categoryView = segue.destinationViewController;
        categoryView.delegate = self;
    }
}
@end
