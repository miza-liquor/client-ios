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
#import "TopStoryDetailViewController.h"

@interface TopStoryListViewController ()

@end

@implementation TopStoryListViewController
{
    NSArray *stories;
    NSDictionary *selectStory;
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
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    v.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:v];
    
    // record btn setting
    UIButton *addRecordView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 68)];
    [addRecordView setBackgroundImage:[UIImage imageNamed:@"btn_new_record"] forState:UIControlStateNormal];
    [self.btnNewRecord setCustomView: addRecordView];

    if ([self.mm_drawerController.centerViewController.restorationIdentifier isEqualToString:@"storyList"])
    {
        UIBarButtonItem *drawerBtn = [[UIBarButtonItem alloc] initWithTitle:@"抽屉" style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
        self.navigationItem.leftBarButtonItem = drawerBtn;

    }
    
    NSArray *cache = (NSArray *)[AppSetting getCache:@"topStory"];
    if (cache == Nil)
    {
        [AppSetting httpGet:@"topstory" parameters:Nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
            if (success == YES)
            {
                stories = (NSArray *)[response objectForKey:@"data"];
                [AppSetting setCache:@"topStory" value:stories];
                [self.tableView reloadData];
            }
        }];
    } else {
        stories = cache;
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
    return [stories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        detailView.title = (NSString *)[selectStory objectForKey:@"title"];
    }
    else if ([segue.identifier isEqualToString:@"menuDetail"])
    {
    }
}

@end
