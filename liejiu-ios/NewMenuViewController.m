//
//  NewMenuViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "NewMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NewMenuViewController ()

@end

@implementation NewMenuViewController

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
    
    self.menuDesc.layer.borderColor = UIColor.grayColor.CGColor;
    self.menuDesc.layer.borderWidth = 1;
    self.menuDesc.layer.cornerRadius = 4;
    self.menuDesc.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) clickOnNewMenuBtn:(id)sender
{
    [self.delegate addNewMenu:@"1"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
