//
//  AddressListViewController.m
//  liquor-ios
//
//  Created by Minzhang Wei on 3/13/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import "AddressListViewController.h"
#import "LoadingTableViewCell.h"
#import "BMapKit.h"

@interface AddressListViewController ()

@end

@implementation AddressListViewController
{
    NSArray *locations;
    BOOL isLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"选择位置";
    locations = @[];
    isLoading = YES;
    
    [self drawMap];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void) drawMap
{
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    mapView.showsUserLocation = YES;
    mapView.zoomEnabled = YES;
    mapView.mapType = BMKMapTypeStandard;
    self.view = mapView;
//    [self.mapView addSubview:mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    return isLoading ? 1 : [locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) {
        static NSString *loadingTableIdentifier = @"LoadingTableViewCell";
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:loadingTableIdentifier owner:self options:nil];
        LoadingTableViewCell *loadingCell = [nib objectAtIndex:0];
        return loadingCell;
    }

    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}



@end
