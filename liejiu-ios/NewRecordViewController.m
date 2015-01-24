//
//  NewRecordViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 12/24/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TGCamera.h"
#import "TGCameraViewController.h"
#import "NewRecordViewController.h"
#import "NewRecordDetailViewController.h"

@interface NewRecordViewController () <TGCameraDelegate>

@end

@implementation NewRecordViewController
{
    UIBarButtonItem *barItemSelectPhoto;
    UIBarButtonItem *barItemConfirm;
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
    
    self.navigationItem.title = @"新增记录";
    
    barItemSelectPhoto = [[UIBarButtonItem alloc] initWithTitle:@"获取照片" style:UIBarButtonItemStylePlain target:self action:@selector(selectPhoto:)];
    barItemConfirm = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(confirmSelect:)];
    UIBarButtonItem *flexibleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setToolbarItems:[NSArray arrayWithObjects:barItemSelectPhoto, flexibleBtn, barItemConfirm, nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - TGCameraDelegate required

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    [self setPhoto:image];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    [self setPhoto:image];
}

#pragma mark -
#pragma mark - TGCameraDelegate optional

- (void)cameraWillTakePhoto
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)cameraDidSavePhotoAtPath:(NSURL *)assetURL
{
    NSLog(@"%s album path: %@", __PRETTY_FUNCTION__, assetURL);
}

- (void)cameraDidSavePhotoWithError:(NSError *)error
{
    NSLog(@"%s error: %@", __PRETTY_FUNCTION__, error);
}

#pragma mark -
#pragma mark - Actions
- (IBAction)clickOnPreviewBtn:(id)sender
{
    [self openCamera];
}

- (void) selectPhoto:(id) sender
{
    [self openCamera];
}

- (void) confirmSelect:(id) sender
{
    [self performSegueWithIdentifier:@"recordDesc" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"recordDesc"])
    {
        NewRecordDetailViewController *vc = segue.destinationViewController;
        vc.previewImage = self.previewImageView.image;
    }
}

- (void) setPhoto:(UIImage *)image
{
    self.previewImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    barItemSelectPhoto.title = @"重新选择照片";
    barItemConfirm.title = @"确认，下一步";
}

- (void) openCamera
{
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
}
@end
