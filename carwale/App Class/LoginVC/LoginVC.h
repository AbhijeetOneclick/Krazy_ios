//
//  LoginVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLManager.h"
#import "URBAlertView.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface LoginVC : UIViewController<URLManagerDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UIScrollView * scrlContent;
    
    UITextField * txtEmail;
    UITextField * txtPassword;
    
    UIButton * btnLogin;
    UIButton * btnForgotPassword;

}

@end
