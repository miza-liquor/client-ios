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
#import "TopWineCategoryViewController.h"
#import "AppSetting.h"

@interface NewWineViewController () <TGCameraDelegate>

@end

@implementation NewWineViewController
{
    NSMutableArray *wineImages;
    UIButton *newWineBtn;
    NSDictionary *currCategory;
    BOOL isLoading;
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
    
    isLoading = NO;
    wineImages = [[NSMutableArray alloc] initWithCapacity:9];
    
    [self.scrollView contentSizeToFit];
    
    struct CGColor *borderColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1].CGColor;
    self.wineDesc.layer.borderColor = borderColor;
    self.wineDesc.layer.borderWidth = 1;
    self.wineDesc.layer.masksToBounds = YES;
    
    newWineBtn = [self createButtonWithPX:20 PY:324];
}

-(UIButton *) createButtonWithPX:(CGFloat)pX PY:(CGFloat)pY
{
    UIImage *listImage = [UIImage imageNamed:@"btn_new_wineimage"];
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // get the image size and apply it to the button frame
    CGRect listButtonFrame = listButton.frame;
    listButtonFrame.size = listImage.size;
    listButtonFrame.origin.x = pX;
    listButtonFrame.origin.y = pY;
    listButton.frame = listButtonFrame;
    
    [listButton setImage:listImage forState:UIControlStateNormal];
    [listButton addTarget:self action:@selector(addNewImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:listButton];

    return listButton;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}
-(void) viewDidAppear:(BOOL)animated
{
    [AppSetting setCurrViewController:self];
    [self.scrollView contentSizeToFit];
}
-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (IBAction)selectWineCategory:(id)sender {
    TopWineCategoryViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"wineCategory"];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addNewImage:(id)sender
{
    [self openCamera];
}

- (IBAction)submit:(id)sender
{
    if (isLoading) return;

    [self.msgLabel setHidden:NO];
    NSString *name = self.wineName.text;
    NSString *desc = self.wineDesc.text;
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    desc = [desc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([name length] == 0)
    {
        self.msgLabel.text = @"名称不能为空";
        return;
    }
    
    if ([desc length] == 0)
    {
        self.msgLabel.text = @"描述不能为空";
        return;
    }
    
    if(!currCategory)
    {
        self.msgLabel.text = @"请选择酒分类";
        return;
    }
    
    NSArray *allViews = [self.view subviews];
    NSMutableArray *wineUploadImages = [[NSMutableArray alloc] init];
    
    for (NSInteger i =0, l = [allViews count]; i < l; i++)
    {
        UIView *view = (UIView *)[allViews objectAtIndex:i];
        if ([view tag] == 9999)
        {
            UIImageView *image = (UIImageView *)view;
            [wineUploadImages addObject:@{@"name": @"wine_image", @"image": image.image}];
        }
    }
    
    if ([wineUploadImages count] == 0) {
        self.msgLabel.text = @"至少上传一张图片";
        return;
    }
    
    isLoading = YES;
    NSDictionary *params = @{
                                @"name": name,
                                @"desc": desc,
                                @"category": (NSString *)[currCategory objectForKey:@"id"],
                                @"uploadImages": wineUploadImages
                            };
    [AppSetting httpPost:@"post/wine" parameters:params callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        isLoading = NO;
        if (success) {
            
        } else {
            self.msgLabel.text = msg;
        }
    }];
}

- (void) setPhoto:(UIImage *)image
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CGFloat screenWith = 280;
    CGFloat gap = (screenWith - newWineBtn.frame.size.width * 3) / 2;
    CGRect frame = newWineBtn.frame;

    CGFloat x = frame.origin.x;
    
    UIView *wrapView = [[UIView alloc] initWithFrame:frame];
    UIImageView *deleteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"icon_remove"]];
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [deleteIcon setFrame:CGRectMake(frame.size.width - deleteIcon.frame.size.width/2, -deleteIcon.frame.size.height/2, deleteIcon.frame.size.width, deleteIcon.frame.size.height)];
    [wrapView addSubview:newImageView];
    [wrapView addSubview:deleteIcon];
    wrapView.tag = 9999;

    newImageView.tag = 9999;
    newImageView.image = image;
    [newImageView setContentMode:UIViewContentModeScaleAspectFill];
    newImageView.layer.masksToBounds = YES;
    
    CGRect newFrame;
    if (x + gap + frame.size.width > screenWith) {
        newFrame = CGRectMake(20, frame.origin.y + gap + frame.size.height, frame.size.width, frame.size.height);
        [self.submitBtn setFrame:CGRectMake(self.submitBtn.frame.origin.x, self.submitBtn.frame.origin.y + frame.size.height + gap, self.submitBtn.frame.size.width, self.submitBtn.frame.size.height )];
        [self.msgLabel setFrame:CGRectMake(self.msgLabel.frame.origin.x, self.msgLabel.frame.origin.y + frame.size.height + gap, self.submitBtn.frame.size.width, self.submitBtn.frame.size.height )];
    } else {
        newFrame = CGRectMake(frame.origin.x + gap + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    }

    
    [newWineBtn removeFromSuperview];
    newWineBtn = [self createButtonWithPX:newFrame.origin.x PY:newFrame.origin.y];
    [self.scrollView addSubview:wrapView];
}

#pragma mark - top wine category delegate
- (void) topWineCategoryChanged:(NSDictionary *)info
{
    currCategory = info;
    [self.wineCategoryBtn setTitle:(NSString *)[currCategory objectForKey:@"name"] forState:UIControlStateNormal];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"allCategory"])
//    {
//    }
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
