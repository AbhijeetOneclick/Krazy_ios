//
//  AppInfoScreenVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "Constant.h"
#import "URLManager.h"
#import "URBAlertView.h"

@interface AppInfoScreenVC : UIViewController<UIScrollViewDelegate,GIDSignInDelegate,GIDSignInUIDelegate,URLManagerDelegate,UITextFieldDelegate>
{
    /*---Header----*/
    UIView * viewHeader;
    UILabel * lblTitle;
    
    /*------Button options------*/
    UIButton * btnFBLogin;
    UIButton * btnGPLogin;
    UIButton * btnLogin;
    UIButton * btnSkip;
    UIButton * btnRegister;
    
    UILabel * lblOR;

    
    AppDelegate * appDelegate;
    UIScrollView *scrlContent;
    UIPageControl *pageControl;
    UIButton *BtnNext;
    NSMutableDictionary  *userDict;
    
    //======strings======//
    NSString * strUserNumber;
    NSString *userIdForGoogle;
    NSString *idTokenForGoogle;
    NSString *givenNameForGoogle;
    NSString *familyNameForGoogle;
    NSString *emailForGoogle;
    NSString * strForIdentificationLoginType;
    
    UIView * viewLogin;
    UIView * viewTransparent;
    UIView * viewPlain;
    UIView * viewLoginBorder;
    UIView * viewBorder;
    
    UITextField * txtEmail;
    UITextField * txtPassword;
    
    UIButton * btnSignIn;
    
    //====arrays=====//
    NSMutableArray * arrForLogin;
    
    NSMutableDictionary * dictForGoogle;
    

}

@end
