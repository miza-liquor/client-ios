//
//  TopImageTableViewCell.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/17/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "TopImageTableViewCell.h"
#import "KDCycleBannerView.h"
#import "AppSetting.h"

@interface TopImageTableViewCell () <KDCycleBannerViewDataource, KDCycleBannerViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) KDCycleBannerView *cycleBannerView;
@end

@implementation TopImageTableViewCell
{
    NSArray *imageList;
}

- (void)awakeFromNib
{
    // Initialization code
    
    _cycleBannerView = [KDCycleBannerView new];
    _cycleBannerView.frame = CGRectMake(0, 0, 320, 190);
    _cycleBannerView.datasource = self;
    _cycleBannerView.delegate = self;
    _cycleBannerView.continuous = YES;
    _cycleBannerView.autoPlayTimeInterval = 5;
    [self addSubview:_cycleBannerView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - KDCycleBannerViewDataource

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView {
    int num = [imageList count];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:num];
    
    for (int i=0; i < num; i++) {
        NSDictionary *info = [imageList objectAtIndex:i];
        [array addObject:(NSString *)[info objectForKey:@"photo"]];
    }
    
    return array;
}

- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index {
    return UIViewContentModeScaleAspectFill;
}

- (UIImage *)placeHolderImageOfZeroBannerView {
    return [UIImage imageNamed:@"icon.png"];
}

#pragma mark - KDCycleBannerViewDelegate

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index {
//    NSLog(@"didScrollToIndex:%ld", (long)index);
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index {
    NSDictionary *info = [imageList objectAtIndex:index];
    [self.delegate gotoTopBannerDetail:(NSString *) [info objectForKey:@"link"]];
}

- (IBAction)clickOnTopSectionBtn:(id)sender
{
    NSInteger tag = [sender tag];
    NSString *segue;
    
    switch (tag) {
        case 1:
            segue = @"topStory";
            break;
        case 2:
            segue = @"topUser";
            break;
        case 3:
            segue = @"topWine";
            break;
        case 4:
        default:
            segue = @"topBar";
            break;
    }
    
    [self.delegate gotoTopSectionList:segue];
}

- (void) setSildeViewImages:(NSArray *)images
{
    imageList = images;
    NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaa");
}

@end
