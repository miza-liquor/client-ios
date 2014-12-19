//
//  BarDetailViewController.m
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import "BarDetailViewController.h"
#import "BarMapTableViewCell.h"
#import "BarDetailBaseTableViewCell.h"
#import "CommentTableViewCell.h"
#import "AppSetting.h"

@interface BarDetailViewController ()

@end

@implementation BarDetailViewController
{
    UITextView *inputView;
    NSArray *dataList;
}

@synthesize barBasicInfo;

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
    
    UIBarButtonItem *flexibleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 240, 32)];
    inputView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    inputView.layer.borderWidth = 1;
    inputView.layer.cornerRadius = 2;
    inputView.layer.masksToBounds = YES;
    
//    UIBarButtonItem *barSendBtnBtn = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    UIBarButtonItem *barSendBtnBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_send"] style:UIBarButtonItemStylePlain target:self action:@selector(sendComment:)];
    UIBarButtonItem *barInput = [[UIBarButtonItem alloc] initWithCustomView:inputView];
    
    [self setToolbarItems:[NSArray arrayWithObjects:barInput, flexibleBtn, barSendBtnBtn, nil]];

    dataList = @[];
    [self loadComment];

    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnTableView)]];
}

- (void) tapOnTableView
{
    [inputView resignFirstResponder];
}

- (void)sendComment:(UIBarButtonItem*)btn
{
    NSString *commentContent = inputView.text;
    commentContent = [commentContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if ([commentContent length] == 0)
    {
        NSLog(@"not allow empty comment");
        return;
    }

    [inputView resignFirstResponder];
    NSDictionary *userInfo = (NSDictionary *)[AppSetting getCache:@"userInfo"];
    NSDictionary *parameters = @{
                                 @"user_id": (NSString *)[userInfo objectForKey:@"id"],
                                 @"content_id": (NSString *)[self.barBasicInfo objectForKey:@"id"],
                                 @"category": @"bar",
                                 @"content": commentContent
                                };

    [AppSetting httpPost:@"post/comment" parameters:parameters callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            NSString *barID = (NSString *)[self.barBasicInfo objectForKey:@"id"];
            NSString *cacheName = [NSString stringWithFormat:@"bar-comment-%@", barID];
            NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
            dataList = (NSArray *)[data objectForKey:@"comments"];
            [AppSetting setCache:cacheName value:data];
            [self.tableView reloadData];
        } else {
            NSLog(@"error");
        }
    }];
}

//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [inputView resignFirstResponder];
//}

#pragma mark -
#pragma mark Notifications

- (void)keyboardWillChange:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat newHeight = self.view.frame.size.height - [self.view convertRect:keyboardRect fromView:nil].origin.y;
    CGRect frame = self.navigationController.toolbar.frame;
    frame.origin.y = self.view.bounds.size.height - newHeight - frame.size.height;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.navigationController.toolbar.frame = frame;
    [UIView commitAnimations];
}

- (void) UITextViewTextDidChange:(NSNotification *) notif
{
    return;
//    NSString *str = inputView.text;
//    //首先规定一个最大宽高(结构体)
//    CGSize maxSize=CGSizeMake(230, 1000);
//    //计算内容大小
//    CGSize contentSize=CGSizeMake(230, 50);
//    //动态改变textview和其他相关控件的大小和位置
//    if (contentSize.height + 20 > inputView.frame.size.height ) {
//        inputView.frame=CGRectMake(18, 60, 284, contentSize.height + 20);
//        
//    }
//    else if (contentSize.height - 20 < inputView.frame.size.height) {
//        inputView.frame=CGRectMake(18, 60, 284, contentSize.height + 20);
//    }
//    inputView.frame=CGRectMake(18, 60, 284, contentSize.height + 20);
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(UITextViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	/* No longer listen for keyboard */
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count] + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *barMapCell = @"BarMapTableViewCell";
        BarMapTableViewCell *mapCell = (BarMapTableViewCell *)[tableView dequeueReusableCellWithIdentifier:barMapCell];
        if (mapCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:barMapCell owner:self options:nil];
            mapCell = [nib objectAtIndex:0];
            
            [mapCell setBarBasicInfo:self.barBasicInfo];
        }

        return mapCell;
    } else if (indexPath.row == 1){
        static NSString *barInfoCell = @"BarDetailBaseTableViewCell";
        BarDetailBaseTableViewCell *infoCell = (BarDetailBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:barInfoCell];
        if (infoCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:barInfoCell owner:self options:nil];
            infoCell = [nib objectAtIndex:0];
            
            [infoCell setBarBasicInfo:self.barBasicInfo];
        }
        
        return infoCell;
    } else {
        static NSString *commentCell = @"CommentTableViewCell";
        CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:commentCell];
        if (cell == nil)
        {
            NSArray *collectionNib = [[NSBundle mainBundle] loadNibNamed:commentCell owner:self options:nil];
            cell = [collectionNib objectAtIndex:0];
        }
        
        [cell setCommentData:[dataList objectAtIndex:indexPath.row - 2]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 180;
    } else if (indexPath.row == 1)
    {
        return  130;
    } else {
        return 44;
    }
}

- (void) loadComment
{
    NSString *barID = (NSString *)[self.barBasicInfo objectForKey:@"id"];
    NSString *cacheName = [NSString stringWithFormat:@"bar-comment-%@", barID];
    NSDictionary *cacheData = (NSDictionary *)[AppSetting getCache:cacheName];
    
    if (cacheData != nil)
    {
        dataList = (NSArray *)[cacheData objectForKey:@"comments"];
        [self.tableView reloadData];
        return;
    }
    
    NSString *route = [NSString stringWithFormat:@"comments/bar/%@", barID];
    
    [AppSetting httpGet:route parameters:nil callback:^(BOOL success, NSDictionary *response, NSString *msg) {
        if (success == YES)
        {
            NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
            dataList = (NSArray *)[data objectForKey:@"comments"];
            [AppSetting setCache:cacheName value:data];
            [self.tableView reloadData];
        } else {
            NSLog(@"error with fetching data");
        }
    }];
    
}

@end
