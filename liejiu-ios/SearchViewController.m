//
//  SearchViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/27/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHeaderTableViewCell.h"
#import "UserFromRecommandTableViewCell.h"
#import "AppSetting.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    SearchHeaderTableViewCell *headerCell;
    NSArray *dataList;
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
    [self initStaticCell];
}

- (void) loadWineData
{
}

- (void) initStaticCell
{
    NSArray *nibTab = [[NSBundle mainBundle] loadNibNamed:@"SearchHeaderTableViewCell" owner:self options:nil];
    headerCell = [nibTab objectAtIndex:0];
    headerCell.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return headerCell;
    }
    static NSString *simpleTableIdentifier = @"UserFromRecommandTableViewCell";
    UserFromRecommandTableViewCell *cell = (UserFromRecommandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary* dataInfo = (NSDictionary *)[dataList objectAtIndex:indexPath.row - 1];
    [cell setUserData:dataInfo];
//    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 100;
    } else {
        return 60;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
//    selectedWine = (NSDictionary *)[wineList objectAtIndex:indexPath.row-1];
//    [self performSegueWithIdentifier:@"wineDetail" sender:self];
}

- (void) addWineToMenuList:(NSString *)wineID
{
    [self performSegueWithIdentifier:@"addToMenu" sender:self];
}

- (void) submitSearchBox:(NSString *)kw
{
//    keyword = kw;
    [self loadWineData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
