//
//  LeftMenuVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/4/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLManager.h"
#import "LeftMenuCell.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import <MessageUI/MessageUI.h>
#import "MyFavVC.h"

@interface LeftMenuVC : UIViewController<UITableViewDelegate, UITableViewDataSource,URLManagerDelegate,MFMailComposeViewControllerDelegate>
{
    UITableView * tblLeftMenu;
    
    UIView * navView;
    UILabel * lblHeader;
    NSMutableArray * arrayMenuItems, * arrayNewCars, * arrayUsedCars, * tempSelectedSection,* arraySelected,*arryNewCarArbic,*arraySelectedArbic,*arrayUsedCarsArbic;
    
    UIView * viewTableHeader;
    
    AsyncImageView * imgUser;
    AsyncImageView *imgProfile;
    UISwitch * switchNoti;
    UILabel * lblUserName;
    UIImageView *imageBackGround;
    
    
    UIButton*btnSignIn;
}
@property (strong, nonatomic) UIWindow *window;

@end
