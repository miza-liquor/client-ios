//
//  NewRecordDetailViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/24/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "NewRecordDetailViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MenuListViewController.h"
#import "WineSelectViewController.h"
#import "RecordDetailViewController.h"
#import "AppSetting.h"

@interface NewRecordDetailViewController ()

@end

@implementation NewRecordDetailViewController
{
    BOOL isUploading;
    NSString *selectedWineID;
    NSString *selectedMenuID;
}
@synthesize previewImage;

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
    [self.scrollView contentSizeToFit];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情信息";
    
    struct CGColor *borderColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1].CGColor;
    self.recordDesc.layer.borderColor = borderColor;
    self.recordDesc.layer.borderWidth = 1;
    self.recordDesc.layer.masksToBounds = YES;
    
    self.recordImage.image = previewImage;
    
    isUploading = NO;
    [self.msgLabel setHidden:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - delegate menulist
-(void) selectedMenu:(NSDictionary *)menuInfo
{
    selectedMenuID = (NSString *)[menuInfo objectForKey:@"id"];
    self.recordMenu.titleLabel.text = (NSString *)[menuInfo objectForKey:@"menu_name"];
}
-(void) selectedWine:(NSDictionary *)wineInfo
{
    selectedWineID = (NSString *)[wineInfo objectForKey:@"id"];
    self.wineName.titleLabel.text = (NSString *)[wineInfo objectForKey:@"c_name"];
}

- (IBAction)addAddress:(id)sender
{
}

- (IBAction)addMenu:(id)sender
{
    MenuListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"myMenuList"];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)addWineName:(id)sender {
    WineSelectViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"wineSelector"];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)submitRecord:(id)sender
{
    if (isUploading)
    {
        return;
    }

    [self.msgLabel setHidden:NO];
    
    NSString *name = @"";
    NSString *desc = self.recordDesc.text;
    NSString *address = self.recordAddress.titleLabel.text;
    
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    name = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    desc = [desc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    desc = [desc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (!selectedWineID)
    {
        self.msgLabel.text = @"酒名称不能为空";
        return;
    }

    self.msgLabel.text = @"正在提交";
    isUploading = YES;

    NSString *url = @"post/record";
    NSDictionary *params = @{
                                @"wine_id": selectedWineID,
                                @"name": name,
                                @"desc": desc,
                                @"address": address,
                                @"menu_id": selectedMenuID,
                                @"uploadImages": @[@{
                                                       @"name": @"record_image",
                                                       @"image": self.recordImage.image
                                                    }]
                            };
    [AppSetting httpPost:url parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (!success)
        {
            self.msgLabel.text = msg;
        } else {
            self.msgLabel.text = @"上传成功";
            RecordDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"recordDetail"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        isUploading = NO;
    }];
}
@end
