//
//  TopWineListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopWineListViewController.h"
#import "TopWineTableViewCell.h"
#import "TopWineHeaderTableViewCell.h"
#import "TopWineCategoryViewController.h"
#import "WineDetailViewController.h"
#import "LoadingTableViewCell.h"
#import "AppSetting.h"

@interface TopWineListViewController ()

@end

@implementation TopWineListViewController
{
    NSArray *wines;
    NSDictionary *category;
    NSDictionary *selectedWineInfo;
    TopWineHeaderTableViewCell *headerCell;
    BOOL isLoading;
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
    
    isLoading = YES;
    wines = @[];
    [self getData];
    [AppSetting drawToolBar:self];
    
    [self initStaticHeaderCell];
}

-(void) initStaticHeaderCell
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopWineHeaderTableViewCell" owner:self options:nil];
    headerCell = [nib objectAtIndex:0];
    headerCell.delegate = self;
    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setHeaderTitle];
}

-(void) setHeaderTitle
{
    headerCell.headerTitle.text = category ? [NSString stringWithFormat:@"%@ 排名TOP10", (NSString *)[category objectForKey:@"name"]] : @"全站排名TOP10";
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return isLoading ? 2 : [wines count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *headerTableIdentifier = @"TopWineHeaderTableViewCell";
        TopWineHeaderTableViewCell *cell = (TopWineHeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:headerTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:headerTableIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.headerTitle.text = category ? [NSString stringWithFormat:@"%@ 排名TOP10", (NSString *)[category objectForKey:@"name"]] : @"全站排名TOP10";

        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (isLoading)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
        LoadingTableViewCell *cell = [nib objectAtIndex:0];
        return cell;
    }

    static NSString *simpleTableIdentifier = @"TopWineTableViewCell";
    TopWineTableViewCell *cell = (TopWineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *info = (NSDictionary *)[wines objectAtIndex:indexPath.row - 1];
    [cell setWineData:info];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 54 : 88;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    selectedWineInfo = (NSDictionary *)[wines objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"wineDetail" sender:self];
}

#pragma mark - Top image cell delegate
- (void) clickOnShareBtn
{
    NSLog(@"click on share btn");
}

#pragma mark - top wine category delegate
- (void) topWineCategoryChanged:(NSDictionary *)info
{
    category = info;
    wines = @[];
    [self setHeaderTitle];
    [self.tableView reloadData];
    [self getData];
}

- (void) getData
{
    NSString *cacheName;
    NSString *url;
    if (category) {
        NSString *category_id = (NSString *)[category objectForKey:@"id"];
        url =[NSString stringWithFormat:@"topwine/%@", category_id];
        cacheName = [NSString stringWithFormat:@"topwine:%@", category_id];
    } else {
        url = @"topwine";
        cacheName = @"topwine:all";
    }
    NSArray *cache = (NSArray *)[AppSetting getCache:cacheName];
    isLoading = YES;
    if (cache == Nil)
    {
        [AppSetting httpGet:url parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            isLoading = NO;
            if (success == YES)
            {
                wines = (NSArray *)[response objectForKey:@"data"];
                [AppSetting setCache:cacheName value:wines];
                [self.tableView reloadData];
            }
        }];
    } else {
        isLoading = NO;
        wines = cache;
        [self.tableView reloadData];
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"allCategory"])
    {
        TopWineCategoryViewController *categoryView = segue.destinationViewController;
        categoryView.delegate = self;
    } else if ([segue.identifier isEqualToString:@"wineDetail"])
    {
        WineDetailViewController *wine = segue.destinationViewController;
        wine.basicInfo = selectedWineInfo;
    }
}

@end
