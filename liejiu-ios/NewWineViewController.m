//
//  NewWineViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/24/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "NewWineViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TGCameraViewController.h"

@interface NewWineViewController () <TGCameraDelegate>

@end

@implementation NewWineViewController
{
    NSMutableArray *wineImages;
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
    
    
    wineImages = [[NSMutableArray alloc] initWithCapacity:9];
    
    [self.scrollView contentSizeToFit];
    
    struct CGColor *borderColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1].CGColor;
    self.wineDesc.layer.borderColor = borderColor;
    self.wineDesc.layer.borderWidth = 1;
    self.wineDesc.layer.masksToBounds = YES;
    
//    CGRect buttonFrame = self.wineImageBtn.frame;
//    [self.wineImageBtn removeFromSuperview];
//    [self.wineImageBtn setFrame:buttonFrame];
//    [self.scrollView addSubview:self.wineImageBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
}
-(void) viewDidAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
    [self.scrollView contentSizeToFit];
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

- (IBAction)selectWineCatetory:(id)sender {
}

- (IBAction)addWineCategory:(id)sender {
}

- (IBAction)submitNewWine:(id)sender {
}
- (IBAction)selectWineCategory:(id)sender {
}

- (IBAction)addNewImage:(id)sender
{
    [self openCamera];
}

- (IBAction)submit:(id)sender {
}

- (void) setPhoto:(UIImage *)image
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CGFloat screenWith = 280;
    CGFloat gap = (screenWith - self.wineImageBtn.frame.size.width * 3) / 2;
    CGRect frame = self.wineImageBtn.frame;

    CGFloat x = frame.origin.x;
    
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:frame];
    newImageView.image = image;
    [newImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    CGRect newFrame;
    if (x + gap + frame.size.width > screenWith) {
        newFrame = CGRectMake(20, frame.origin.y + gap + frame.size.height, frame.size.width, frame.size.height);
        [self.submitBtn setFrame:CGRectMake(self.submitBtn.frame.origin.x, self.submitBtn.frame.origin.y + frame.size.height + gap, self.submitBtn.frame.size.width, self.submitBtn.frame.size.height )];
        [self.msgLabel setFrame:CGRectMake(self.msgLabel.frame.origin.x, self.msgLabel.frame.origin.y + frame.size.height + gap, self.submitBtn.frame.size.width, self.submitBtn.frame.size.height )];
    } else {
        newFrame = CGRectMake(frame.origin.x + gap + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    }

    [self.wineImageBtn.layer setFrame: newFrame];
    [self.scrollView addSubview:newImageView];
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

- (void) openCamera
{
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
}
@end
