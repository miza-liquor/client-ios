//
//  NewRecordDetailViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/24/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "NewRecordDetailViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface NewRecordDetailViewController ()

@end

@implementation NewRecordDetailViewController
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
    
    struct CGColor *borderColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1].CGColor;
    self.recordDesc.layer.borderColor = borderColor;
    self.recordDesc.layer.borderWidth = 1;
    self.recordDesc.layer.masksToBounds = YES;
    self.recordName.layer.borderColor = borderColor;
    self.recordName.layer.borderWidth = 1;
    self.recordName.layer.masksToBounds = YES;
    
    self.recordImage.image = previewImage;
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

- (IBAction)addAddress:(id)sender {
}

- (IBAction)addMenu:(id)sender {
}

- (IBAction)submitRecord:(id)sender {
}
@end
