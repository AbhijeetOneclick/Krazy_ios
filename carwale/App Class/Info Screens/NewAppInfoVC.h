//
//  NewAppInfoVC.h
//  carwale
//
//  Created by Oneclick IT Solution on 11/9/17.
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
#import "JVFloatLabeledTextField.h"
#import "NSString+TextDirectionality.h"
#import "NSMutableAttributedString+Color.h"

@interface NewAppInfoVC : UIViewController<GIDSignInDelegate,GIDSignInUIDelegate,URLManagerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    /*---Header----*/
    UIView * viewHeader;
    UILabel * lblTitle;
    UILabel *welcomeLbl;
    UILabel *infoLoginLbl;
    
    /*------Button options------*/
    UIButton * btnFBLogin;
    UIButton * btnGPLogin;
    UIButton * btnLogin;
    UIButton * btnSkip;
    UIButton * btnRegister;
    
    UILabel * lblOR;
    
    
    AppDelegate * appDelegate;
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
    UIView* ViewPopupBackView;
    
    JVFloatLabeledTextField * txtEmail;
    JVFloatLabeledTextField * txtPassword;
    
    UIButton * btnSignIn;
    UIButton* btnShowPassword;
    
    //====arrays=====//
    NSMutableArray * arrForLogin;
    NSString* strIdentifyPassword;
    NSString *getEmail;
    NSMutableDictionary * dictForGoogle;
    NSMutableDictionary *dicForFacebook;
    
    UILabel * lblFirstLine;
    UILabel * lblSecondLine;
    
}
@end
