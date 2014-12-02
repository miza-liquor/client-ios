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

@interface TopWineListViewController ()

@end

@implementation TopWineListViewController
{
    NSArray *wines;
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
    
    wines = @[
              @{@"name": @"酒名称 - 1", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 2", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 3", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 4", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 5", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 6", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 7", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 8", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 9", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 10", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 11", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 12", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 13", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 14", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 15", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 16", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 17", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 18", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 19", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"},
              @{@"name": @"酒名称 - 19", @"category": @"啤酒", @"score": @"5/5", @"drinked": @"66666"}
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
    return [wines count];
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

        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    static NSString *simpleTableIdentifier = @"TopWineTableViewCell";
    TopWineTableViewCell *cell = (TopWineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *info = (NSDictionary *)[wines objectAtIndex:indexPath.row];
    cell.name.text = [info objectForKey:@"name"];
    cell.category.text = [info objectForKey:@"category"];
    cell.score.text = [info objectForKey:@"score"];
    cell.drinked.text = [NSString stringWithFormat:@"喝过(%@)", [info objectForKey:@"drinked"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 60 : 80;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    [self performSegueWithIdentifier:@"wineDetail" sender:self];
}

#pragma mark - Top image cell delegate
- (void) clickOnShareBtn
{
    NSLog(@"click on share btn");
}

#pragma mark - top wine category delegate
- (void) topWineCategoryChanged:(NSString *)category
{
    NSLog([NSString stringWithFormat:@"topWineCategoryChanged::%@", category]);
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"allCategory"])
    {
        TopWineCategoryViewController *categoryView = segue.destinationViewController;
        categoryView.delegate = self;
    }
}

@end
