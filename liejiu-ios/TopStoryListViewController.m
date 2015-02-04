//
//  TopStoryListViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopStoryListViewController.h"
#import "TopStoryTableViewCell.h"
#import "AppSetting.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LoadingTableViewCell.h"
#import "TopStoryDetailViewController.h"

@interface TopStoryListViewController ()

@end

@implementation TopStoryListViewController
{
    NSArray *stories;
    NSDictionary *selectStory;
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
    [AppSetting drawToolBar:self];
    [AppSetting topBarStyleSetting: self];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    v.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:v];

    if ([self.mm_drawerController.centerViewController.restorationIdentifier isEqualToString:@"storyList"])
    {
        UIBarButtonItem *drawerBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_drawer"] style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
        self.navigationItem.leftBarButtonItem = drawerBtn;
    }
    
    [self getData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getData
{
    NSArray *cache = (NSArray *)[AppSetting getCache:@"topStory"];
    isLoading = YES;
    if (cache == Nil)
    {
        [AppSetting httpGet:@"topstory" parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            isLoading = NO;
            if (success == YES)
            {
                stories = (NSArray *)[response objectForKey:@"data"];
                [AppSetting setCache:@"topStory" value:stories];
                [self.tableView reloadData];
            }
        }];
    } else {
        isLoading = NO;
        stories = cache;
        [self.tableView reloadData];
    }
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return isLoading ? 1 : [stories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil];
        LoadingTableViewCell *cell = [nib objectAtIndex:0];
        return cell;
    }
    static NSString *simpleTableIdentifier = @"TopStoryTableViewCell";
    TopStoryTableViewCell *cell = (TopStoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    NSDictionary *info = (NSDictionary *)[stories objectAtIndex:indexPath.row];
    cell.title.text = (NSString *)[info objectForKey:@"title"];
    cell.date.text = (NSString *)[info objectForKey:@"date"];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:(NSString *)[info objectForKey:@"photo"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectStory = (NSDictionary *)[stories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"storyDetail" sender:self];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"storyDetail"])
    {
        TopStoryDetailViewController *detailView = segue.destinationViewController;
        detailView.url = (NSString *)[selectStory objectForKey:@"link"];
        detailView.webTitle = (NSString *)[selectStory objectForKey:@"title"];
    }
    else if ([segue.identifier isEqualToString:@"menuDetail"])
    {
    }
}

@end
