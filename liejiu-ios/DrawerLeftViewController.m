//
//  DrawerLeftViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/13/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "DrawerLeftViewController.h"
#import "AppSetting.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DrawerLeftViewController ()

@end

@implementation DrawerLeftViewController
{
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
    
    NSDictionary *userInfo = (NSDictionary *)[AppSetting getCache:@"userInfo"];
    NSString *imageUrl = [userInfo objectForKey:@"cover"];

    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.layer.masksToBounds = YES;

    [self.userImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    self.userNickName.text = [userInfo objectForKey:@"nickname"];
}

- (void) viewWillAppear:(BOOL)animated
{
    // disable the navbar
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    // disable the navbar
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sss::%d", indexPath.row);
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = @"userProfile";
            break;
        case 1:
            identifier = @"homepage";
            break;
        case 2:
            identifier = @"storyList";
            break;
        case 3:
            identifier = @"myMessage";
            break;
        case 4:
            identifier = @"addFriend";
            break;
        case 5:
            [self performSegueWithIdentifier:@"setting" sender:self];
            return;
            break;
        case 6:
            identifier = @"help";
            break;
        default:
            return;
            break;
    }

    UIViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        if ([self.mm_drawerController.centerViewController.restorationIdentifier isEqualToString:vc.restorationIdentifier])
        {
            return;
        }

        self.mm_drawerController.centerViewController = vc;
    }];
}

@end
