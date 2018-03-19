//
//  RegisterVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
#import "URLManager.h"
#import "AsyncImageView.h"
#import "JVFloatLabeledTextField.h"
#import "NSString+TextDirectionality.h"
#import "NSMutableAttributedString+Color.h"



@interface RegisterVC : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,URLManagerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
    UIScrollView * scrlContent;
     //=====image view====//
    AsyncImageView * imgProfile;
    UIImageView * imgForSelectbuyer;
    UIImageView * imgForSelectDealer;
     //=====image view====//
    
     //=====text fields====//
    JVFloatLabeledTextField * txtFirstname;
    JVFloatLabeledTextField * txtLastname;
    JVFloatLabeledTextField * txtEmail;
    JVFloatLabeledTextField * txtPassword;
    JVFloatLabeledTextField * txtConfirmPassword;
    JVFloatLabeledTextField * txtMobileNumber;
    //=====text fields====//
    NSString *stringPop;
    //=====views for frames====//
    UIView * viewForFirstName;
    UIView * viewForLastName;
    UIView * viewForEmail;
    UIView * viewForPassword;
    UIView * viewForConfirmPassword;
    UIView * viewForMobileNumber;
    UIView *ViewPopupBackView,*viewLoginBorder;
    UIView *viewNew;
    UIView *viewBack;
    UIView *navView;
    //=====views for frames====//
    
    //=====Buttons====//
    UIButton * btnSelectBuyer;
    UIButton * btnRegister;
    UIButton * btnSelectDealer ;
    UIButton *btnTakePhoto;
     //=====Buttons====//
    
    //=====labels=====//
    UILabel * lblForSelectBuyer;
    UILabel * lblForSelectDealer;
    UILabel *orLBL;
    UILabel *lblinfo;
    UILabel *lblLogin;
    //=====labels=====//
    
    //====strings=====//
    NSString * strForIdentification;
    
    JVFloatLabeledTextField * txtEmailpop;
    JVFloatLabeledTextField * txtPasswordpop;
    
    UIButton * btnSignIn;
    UIButton* btnShowPassword;
    
    NSMutableArray * arrForLogin;
    NSString* strIdentifyPassword;
    
    UILabel * lblFirstLine;
    UILabel * lblSecondLine;
    CALayer * caNumber;
    CALayer * caPassword;
    CALayer * caCnPassword;
    CALayer * caEmail ,*caLastName,*caFirstName;
    UIButton *btnLogin;
    //UIImagePickerController *imagePicker;
    UIPopoverController *imgePickerIPAD;
    UIActionSheet *imagePickerType;
 }
@property (nonatomic, strong) UIPopoverController *pop;

@end
