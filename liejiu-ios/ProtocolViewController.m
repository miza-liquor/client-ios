//
//  ProtocolViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "ProtocolViewController.h"
#import "AppSetting.h"

@interface ProtocolViewController ()

@end

@implementation ProtocolViewController

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
    
    NSURL *nsurl = [NSURL URLWithString: @"http://www.baidu.com"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:requestObj];
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

@end
