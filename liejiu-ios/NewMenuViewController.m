//
//  NewMenuViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "NewMenuViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppSetting.h"

@interface NewMenuViewController ()

@end

@implementation NewMenuViewController
@synthesize scrollView;

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
    
    self.menuName.layer.borderColor = UIColor.grayColor.CGColor;
    self.menuName.layer.borderWidth = 1;
    self.menuName.layer.cornerRadius = 1;
    
    self.menuDesc.layer.borderColor = UIColor.grayColor.CGColor;
    self.menuDesc.layer.borderWidth = 1;
    self.menuDesc.layer.cornerRadius = 1;
    self.menuDesc.layer.masksToBounds = YES;
    
    [self.msg setHidden:YES];
    [self.scrollView contentSizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) clickOnNewMenuBtn:(id)sender
{
    NSString* name = [self.menuName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* desc = [self.menuDesc.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [self.msg setHidden:NO];

    if ([name length] == 0)
    {
        self.msg.text = @"酒单名称不能为空";
        return;
    }
    
    self.msg.text = @"正在添加新酒单";
    
    NSDictionary *paramers = @{@"name": name, @"desc": desc};
    
    [AppSetting httpPost:@"post/menu" parameters:paramers callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            // remove cache
            NSDictionary *userInfo = (NSDictionary *)[AppSetting getCache:@"userInfo"];
            NSString *userID = (NSString *)[userInfo objectForKey:@"id"];
            NSString *cacheName = [NSString stringWithFormat:@"user-%@-mymenu", userID];
            [AppSetting removeCache:cacheName];
            
//            [self.delegate addNewMenu:@"1"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            self.msg.text = msg;
        }
    }];
}

@end
