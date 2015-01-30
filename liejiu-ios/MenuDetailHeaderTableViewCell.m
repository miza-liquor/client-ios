//
//  MenuDetailHeaderTableViewCell.m
//  liquor-ios
//
//  Created by Minzhang Wei on 1/29/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "MenuDetailHeaderTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MenuDetailHeaderTableViewCell
{
    CGFloat rowHeight;
    NSDictionary *menuInfo;
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MenuDetailHeaderTableViewCell" bundle:nil];
}

- (void)awakeFromNib
{
    // Initialization code
    
    struct CGColor *borderColor = [UIColor colorWithRed:148.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.contentView.layer.borderColor = borderColor;
    self.contentView.layer.borderWidth = 1;
    self.metaViewWrap.layer.borderColor = borderColor;
    self.metaViewWrap.layer.borderWidth = 1;
//    self.contentView.layer.cornerRadius = 2;
    
    self.ownerImage.layer.cornerRadius = self.ownerImage.layer.frame.size.height/2;
    self.ownerImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.x += 5;
    frame.origin.y += 3;
    
    frame.size.width -= 10;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (IBAction)clickOnLiked:(id)sender
{
}

-(CGFloat) getRowHeight
{
    return [[MenuDetailHeaderTableViewCell prototypeCell] heightForObject:menuInfo];
    
}

- (void) populateWithObject:(id)object
{
    NSDictionary *data = (NSDictionary *) object;
    [self setHeaderData:data];
}

- (void) setHeaderData: (NSDictionary *) data
{
    self.ownerName.text = (NSString *) [data objectForKey:@"creator_name"];
    [self.ownerImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)[data objectForKey:@"creator_image"]] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    self.menuName.text = (NSString *) [data objectForKey:@"menu_name"];
    self.wineNum.text = [NSString stringWithFormat:@"%d", [[data objectForKey:@"wine_num"] intValue]];
    self.followNum.text = [NSString stringWithFormat:@"%d", [[data objectForKey:@"like_num"] intValue]];
    self.desc.text = (NSString *)[data objectForKey:@"menu_desc"];
    menuInfo = data;
//    rowHeight = [[MenuDetailHeaderTableViewCell prototypeCell] heightForObject:data];
}

@end
