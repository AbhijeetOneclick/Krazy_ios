//
//  LeftMenuVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/4/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "LeftMenuVC.h"
#import "HomeVC.h"
#import "MyFavVC.h"
#import "Tips&AdviceVC.h"
#import "NewsVC.h"
#import "FindCarVC.h"
#import "CompareCarVC.h"
#import "CheckOnRoadPriceVC.h"
#import "NewCarOfferVC.h"
#import "BuyAssistanceVC.h"
#import "LoacalDealarVC.h"
#import "UpcomingCarVC.h"
#import "AllUsedCarVC.h"
#import "SellCarVC.h"
#import "CheckValuationVC.h"
#import "LanguageSelectionVC.h"


@interface LeftMenuVC ()

@end

@implementation LeftMenuVC
@synthesize window;
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationController.navigationBarHidden=YES;
    arrayNewCars = [[NSMutableArray alloc]initWithObjects:@"Upcoming cars",@"Tips & Advice", nil];
    arryNewCarArbic = [[NSMutableArray alloc]initWithObjects:@"السيارات القادمة",@"نصائح والمشورة", nil];
    
    arraySelected = [[NSMutableArray alloc]initWithObjects:@"Locate Dealer",@"Sell Car",@"Used Car Market Price", nil];
    
    arraySelectedArbic = [[NSMutableArray alloc]initWithObjects:@"تحديد موقع تاجر",@"بيع السيارة",@"سعر سوق السيارات المستعملة", nil];
    
    if([CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"yes"])
    {
    arrayUsedCars = [[NSMutableArray alloc]initWithObjects:@"Favourites",@"Language",@"Feedback", nil];
        
    arrayUsedCarsArbic = [[NSMutableArray alloc]initWithObjects:@"المفضلة",@"لغة",@"ردود الفعل", nil];
        
       
    }else{
        arrayUsedCars = [[NSMutableArray alloc]initWithObjects:@"Favourites",@"Language",@"Feedback",@"Logout", nil];
     arrayUsedCarsArbic = [[NSMutableArray alloc]initWithObjects:@"المفضلة",@"لغة",@"ردود الفعل",@"تسجيل الدخول", nil];

    }
    [self SetContentFrame];
}

#pragma mark - Set Content View Frame
-(void)SetContentFrame
{
    if([CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"yes"])
    {
        if(IS_IPAD)
        {
            viewTableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 370, 160)];
        }else{
            viewTableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 160)];
        }
    }else{
        if(IS_IPAD)
        {
            viewTableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 370, 160)];
        }else{
            viewTableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 160)];
        }
    }
    viewTableHeader.backgroundColor =[UIColor clearColor];

    UILabel* lblNotification = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewTableHeader.frame.size.width-100, 18)];
    lblNotification.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblNotification.text =[TSLanguageManager localizedString:@"Notifications"];
    lblNotification.textAlignment=NSTextAlignmentRight;
    lblNotification.textColor = [UIColor lightGrayColor];
    [viewTableHeader addSubview:lblNotification];
    
    UIImageView* imgNotification = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewTableHeader.frame.size.width-90, 20, 20, 20)];
    imgNotification.contentMode=UIViewContentModeScaleAspectFill;
    imgNotification.image = [UIImage imageNamed:@"notification"];
    [viewTableHeader addSubview:imgNotification];

   if([CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"yes"])
    {
        UILabel* lblSecondLine = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, viewTableHeader.frame.size.width-100, 18)];
        lblSecondLine.font =[UIFont boldSystemFontOfSize:16];
        lblSecondLine.text =[TSLanguageManager localizedString:@"Sign in for better experience"];
         lblSecondLine.textColor = [UIColor blackColor];
         lblSecondLine.textAlignment=NSTextAlignmentLeft;
        [viewTableHeader addSubview:lblSecondLine];
    }else{
        imgProfile  = [[AsyncImageView alloc] init];
        if (IS_IPHONE_6 || IS_IPHONE_5)
        {
            imgProfile.frame=CGRectMake(20,20, 64*iPhone6,64*iPhone6);
        }else
        {
            imgProfile.frame=CGRectMake(20,20, 64*iPhone6Plus,64*iPhone6Plus);
        }
        imgProfile.backgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2;
        NSURL *url = [NSURL URLWithString:CURRENT_USER_IMAGE];
        NSLog(@"Profile Image=====>%@",CURRENT_USER_IMAGE);
        imgProfile.imageURL = url;
        imgProfile.layer.masksToBounds = YES;
        imgProfile.userInteractionEnabled = YES;
        [imgProfile setContentMode:UIViewContentModeScaleAspectFill];
        [viewTableHeader addSubview:imgProfile];
        
        UILabel* lblSecondLine = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, viewTableHeader.frame.size.width-100, 18)];
        lblSecondLine.text =[NSString stringWithFormat:@"%@ %@",CURRENT_USER_FIRST_NAME,CURRENT_USER_LAST_NAME];
            lblSecondLine.textColor = [UIColor grayColor];
         lblSecondLine.textAlignment=NSTextAlignmentLeft;
        [viewTableHeader addSubview:lblSecondLine];
    }
    
    UILabel* lblThirdLine = [[UILabel alloc] initWithFrame:CGRectMake(20, 133, viewTableHeader.frame.size.width, 18)];
    lblThirdLine.font =[UIFont boldSystemFontOfSize:16];
    
   
    lblThirdLine.textColor = [UIColor grayColor];
    if([CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"yes"])
    {
    }else{
        lblThirdLine.text =CURRENT_USER_EMAIL;
            lblThirdLine.textAlignment=NSTextAlignmentLeft;
    
    [viewTableHeader addSubview:lblThirdLine];
    }
    
    btnSignIn = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        [btnSignIn setFrame:CGRectMake(40,100,90,45)];
    }
    else{
        [btnSignIn setFrame:CGRectMake(viewTableHeader.frame
                                       .size.width-160,100,100,45)];
    }
    btnSignIn.backgroundColor=[UIColor clearColor];
    btnSignIn.layer.cornerRadius=45/2;
    btnSignIn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    btnSignIn.layer.borderWidth = 1.0;
    if([CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"yes"])
    {
    [btnSignIn setTitle:[TSLanguageManager localizedString:@"Login"] forState:UIControlStateNormal];
    }else{
   // [btnSignIn setTitle:@"Logout" forState:UIControlStateNormal];
    }
    [btnSignIn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSignIn addTarget:self action:@selector(btnSignInClicked:) forControlEvents:UIControlEventTouchUpInside];
    if([CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"yes"])
    {
    [viewTableHeader addSubview:btnSignIn];
    }else{
    
    }
    if(IS_IPAD)
    {
        imageBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(5,DEVICE_HEIGHT-150 , 370-5, 165)];
    }else{
        imageBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0,DEVICE_HEIGHT-150 , DEVICE_WIDTH-60, 165)];
    }
    imageBackGround.image = [UIImage imageNamed:@"kuwait"];
    imageBackGround.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageBackGround];
    
    
    tblLeftMenu = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    [tblLeftMenu setBackgroundColor:[UIColor clearColor]];
    tblLeftMenu.delegate = self;
    tblLeftMenu.dataSource = self;
    tblLeftMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tblLeftMenu setShowsVerticalScrollIndicator:NO];
    tblLeftMenu.tableHeaderView =viewTableHeader;
    [self.view addSubview:tblLeftMenu];
    

    
}
#pragma mark - Button Actions
/*-(void)btnHeaderClicked:(id)sender
{
        if ([[[arraySelected objectAtIndex:[sender tag]]valueForKey:@"isSelect"]isEqualToString:@"no"])
    {
        [arraySelected setValue:@"no" forKey:@"isSelect"];
        [[arraySelected objectAtIndex:[sender tag]]setValue:@"yes" forKey:@"isSelect"];
    }else
    {
        [[arraySelected objectAtIndex:[sender tag]]setValue:@"no" forKey:@"isSelect"];
    }
    if ([sender tag]==0)
    {
        HomeVC *demoController = [[HomeVC alloc] init];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }else if ([sender tag]==1)
    {
       
    }else if ([sender tag]==2)
    {
       
    }else if ([sender tag]==3)
    {
        NewsVC *demoController = [[NewsVC alloc] init];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([sender tag]==4)
    {
    }
    else if([sender tag]==5)
    {
        MyFavVC *demoController = [[MyFavVC alloc] init];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }else if ([sender tag]==6)
    {
        Tips_AdviceVC *demoController = [[Tips_AdviceVC alloc] init];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    }else if ([sender tag]==7)
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:@"This is an optional mail subject!"];
            [mc setMessageBody:@"This is an optional message body plain text!" isHTML:NO];
            [mc setToRecipients:[NSArray arrayWithObjects:@"first.address@test.com", @"second.address@test.com", nil]];
            [self presentViewController:mc animated:YES completion:nil];

        }else
        {
            URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Mail feature is not available, Please try in mobile device" cancelButtonTitle:OK_BTN otherButtonTitles:nil, nil];
            [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                NSLog(@"button tapped: index=%ld", (long)buttonIndex);
                [alertView hideWithCompletionBlock:^{
                    [alertView removeFromSuperview];
                }];
            }];
            [alertView showWithAnimation:URBAlertAnimationTopToBottom];

        }
    }else if ([sender tag]==8)
    {
        NSString *strUserID = [[NSString stringWithFormat:@"%@",CURRENT_USER_ID]copy];
        NSLog(@"%@",strUserID);
        
        if(![CURRENT_USER_ID isEqualToString:@"(null)"] && ![CURRENT_USER_ID isEqual:[NSNull null]] && [CURRENT_USER_ID  length]>0)
        {
            URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Are you sure you want to logout?" cancelButtonTitle:OK_BTN otherButtonTitles:@"cancle", nil];
           
            [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{
                    if(buttonIndex==0)
                    {
                     [APP_DELEGATE logoutMethod];
                    [alertView removeFromSuperview];
                    }
                }];
            }];
            
            [alertView showWithAnimation:URBAlertAnimationTopToBottom];

        }else
        {
            NSUserDefaults *pre = [NSUserDefaults standardUserDefaults];
            [pre removeObjectForKey:@"CURRENT_USER_SKIPBUTTON_CLICKED"];
        [APP_DELEGATE loginMethod];
        }
    }
     [tblLeftMenu reloadData];
}*/

-(void)btnSignInClicked:(id)sender
{
    NSUserDefaults *pre = [NSUserDefaults standardUserDefaults];
    [pre removeObjectForKey:@"CURRENT_USER_SKIPBUTTON_CLICKED"];
    [APP_DELEGATE loginMethod];
}

#pragma mark - Switch Action
-(void)switchChange:(id)sender
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [tblLeftMenu reloadData];
}


#pragma mark- UITableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat x = 0;
    if (section==0)
    {
   x= 50;
    }
    else   if (section==1)
    {
       x= 50;
    }
    else{
        x= 15;
    }
    return x;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]init];
    if(IS_IPAD)
    {
        headerView.frame = CGRectMake(0, 0, 370, 50);
    }
    else
    {
      headerView.frame =CGRectMake(0, 0, DEVICE_WIDTH, 50);
    }
   
    
    UIImageView * imgIcon = [[UIImageView alloc] init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        imgIcon.frame= CGRectMake(40, 20, 20, 20);
    }
    else
    {
        imgIcon.frame= CGRectMake(headerView.frame.size.width-80, 20, 20, 20);
    }
    imgIcon.contentMode=UIViewContentModeScaleAspectFit;
    [headerView addSubview:imgIcon];
    
    
    UILabel *lblSeprator1 =[[UILabel alloc]initWithFrame:CGRectMake(21, 10, DEVICE_WIDTH-42,1 )];
    

    lblSeprator1.backgroundColor=[[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    [headerView addSubview:lblSeprator1];
    
    UILabel *lblname =[[UILabel alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblname.frame= CGRectMake(70, 20, DEVICE_WIDTH-120, 20);
        lblname.textAlignment=NSTextAlignmentLeft;
    }
    else
    {
        lblname.frame= CGRectMake(headerView.frame.size.width-250, 20, 150, 20);
        lblname.textAlignment=NSTextAlignmentRight;
    }
    lblname.textColor=[UIColor lightGrayColor];
    lblname.backgroundColor=[UIColor clearColor];
    
    lblname.font=[UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
    [headerView addSubview:lblname];
    
    if (section==0)
    {
        imgIcon.image = [UIImage imageNamed:@"Explore"];
        lblname.text = [TSLanguageManager localizedString:@"EXPLORE"];
        
    }
else if (section==1)
    {
        imgIcon.image = [UIImage imageNamed:@"tools"];
     lblname.text =[TSLanguageManager localizedString:@"TOOLS"];
        
    }
else{

}
    return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            return [arrayNewCars count];
        }
        else
        {
            return [arryNewCarArbic count];
        }
    }else if (section==1)
    {
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            return [arraySelected count];
        }
        else
        {
            return [arraySelectedArbic count];
        }
    }
    else
    {
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            return [arrayUsedCars count];
        }
        else
        {
            return [arrayUsedCarsArbic count];
        }
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = nil;
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.lblTitle.text = [arrayMenuItems objectAtIndex:indexPath.row];
    
    if (indexPath.section==0)
    {
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            cell.lblTitle.text = [NSString stringWithFormat:@"%@",[arrayNewCars objectAtIndex:indexPath.row]];
        }
        else
        {
            cell.lblTitle.text = [NSString stringWithFormat:@"%@",[arryNewCarArbic objectAtIndex:indexPath.row]];
        }
        
    }else if (indexPath.section==1)
    {
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
         cell.lblTitle.text = [NSString stringWithFormat:@"%@",[arraySelected objectAtIndex:indexPath.row]];
        }
        else
        {
        cell.lblTitle.text = [NSString stringWithFormat:@"%@",[arraySelectedArbic objectAtIndex:indexPath.row]];
        }
         
    }
    else if (indexPath.section==2)
    {
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            cell.lblTitle.text = [NSString stringWithFormat:@"%@",[arrayUsedCars objectAtIndex:indexPath.row]];
        }
        else
        {
            cell.lblTitle.text = [NSString stringWithFormat:@"%@",[arrayUsedCarsArbic objectAtIndex:indexPath.row]];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==2)
    {
        if(indexPath.row==1)
        {
            [APP_DELEGATE LanguageSelection];
        }
        if(indexPath.row ==3)
        {
            [self LogoutButtonClicked];
        }
    }
}



-(void)LogoutButtonClicked
{
    URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[TSLanguageManager localizedString: @"Are you sure you want to logout?"] cancelButtonTitle:ALERT_CANCEL otherButtonTitles:OK_BTN, nil];
    
    [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
    [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        [alertView hideWithCompletionBlock:^{
            if(buttonIndex==1)
            {
                [APP_DELEGATE logoutMethod];
                [alertView removeFromSuperview];
            }
        }];
    }];
    
    [alertView showWithAnimation:URBAlertAnimationTopToBottom];

}

#pragma mark - MFMailComposeViewControllerDelegate Methode.
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@",error.description);
            
            break;
    }
    
    // Dismiss the mail compose view controller.
    [controller dismissViewControllerAnimated:true completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
