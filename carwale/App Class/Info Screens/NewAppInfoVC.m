//
//  NewAppInfoVC.m
//  carwale
//
//  Created by Oneclick IT Solution on 11/9/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "NewAppInfoVC.h"
#import "SocialLoginVC.h"
#import "RegisterVC.h"
#import "TSLanguageManager.h"
#import "JVFloatLabeledTextField.h"


const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize =11.0f;

@interface NewAppInfoVC ()

@end

@implementation NewAppInfoVC
static NSString * const kClientID =
@"633631499846-n6ksnpijnovdtb89138sa0hutdeidm2n.apps.googleusercontent.com";

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden=YES;
    
    [GIDSignInButton class];
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.clientID= kClientID;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    
    arrForLogin = [[NSMutableArray alloc]init];
    dictForGoogle = [[NSMutableDictionary alloc]init];
    dicForFacebook = [[NSMutableDictionary alloc]init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    strUserNumber =[NSString stringWithFormat:@""];
    strForIdentificationLoginType = @"";//1 for facebook identify and 2 for google
    self.view.backgroundColor = [UIColor whiteColor];
    strIdentifyPassword = @"1";
//    ViewPopupBackView = [[UIView alloc]init];
//    viewLoginBorder = [[UIView alloc] init];
    [self FrameContent];
   // [self registerNotification];

}


#pragma mark - Lifecycle
-(void)FrameContent
{
    int height =DEVICE_HEIGHT/2;
    btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnSkip.frame =CGRectMake(DEVICE_WIDTH-80, 24, 70, 50);
    }
    else{
        btnSkip.frame =CGRectMake(0, 24, 100, 50);
    }
    [btnSkip setTitle:[TSLanguageManager localizedString:@"Later"] forState:UIControlStateNormal];
    btnSkip.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:20.0];
    [btnSkip setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnSkip addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnSkip.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [self.view addSubview:btnSkip];
    
    if(IS_IPAD){
    welcomeLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,height-150-20 ,DEVICE_WIDTH-60 ,24)];
    }else{
       welcomeLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,height-150-20 ,DEVICE_WIDTH-60 ,40)];
    }
    welcomeLbl.text = [TSLanguageManager localizedString:@"Welcome"];
    welcomeLbl.textAlignment=NSTextAlignmentCenter;
    welcomeLbl.numberOfLines=0;
    welcomeLbl.textColor =[UIColor grayColor];
    if(IS_IPAD){
        welcomeLbl.font = [UIFont systemFontOfSize:32.0 weight:UIFontWeightMedium];
    }else{
        welcomeLbl.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightMedium];
    }
    [self.view addSubview:welcomeLbl];
    
    infoLoginLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,height-47-40-25 ,DEVICE_WIDTH-60 ,40)];
    infoLoginLbl.text = [TSLanguageManager localizedString:@"Login for a personalized \n experience"];
    infoLoginLbl.textAlignment=NSTextAlignmentCenter;
    infoLoginLbl.font =[UIFont boldSystemFontOfSize:16.0];
    infoLoginLbl.numberOfLines=0;
    infoLoginLbl.textColor =[UIColor grayColor];
    infoLoginLbl.font =[UIFont boldSystemFontOfSize:16.0];
    [self.view addSubview:infoLoginLbl];

    btnFBLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPAD)
    {
    btnFBLogin.frame = CGRectMake((DEVICE_WIDTH/2)-(370/2), height-47, 370, 47);
    }
    else if(IS_IPHONE_6plus)
    {
    btnFBLogin.frame = CGRectMake((DEVICE_WIDTH/2)-(270/2), height-47, 270, 47);
    }
    else
    {
    btnFBLogin.frame = CGRectMake(DEVICE_WIDTH/2-(220/2), height-47, 220, 47);
    }
    [btnFBLogin addTarget:self action:@selector(btnFBClicked:) forControlEvents:UIControlEventTouchUpInside];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        [btnFBLogin setImage:[UIImage imageNamed:@"fb_btn"] forState:UIControlStateNormal];
    }
    else{
        [btnFBLogin setImage:[UIImage imageNamed:@"fb_btn"] forState:UIControlStateNormal];
    }
    [self.view addSubview:btnFBLogin];
 
    if(IS_IPAD){
        btnGPLogin = [[UIButton alloc] initWithFrame:CGRectMake(199, height+10, DEVICE_WIDTH-398, 47)];
    }else if(IS_IPHONE_6plus){
        btnGPLogin = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-(270/2), height+10, 270, 47)];
    }else{
        btnGPLogin = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-(220/2), height+10, 220, 47)];
    }
    [btnGPLogin addTarget:self action:@selector(btnGPClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnGPLogin setImage:[UIImage imageNamed:@"g+_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnGPLogin];
    

    UIView *view  = [[UIView alloc] init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        view.frame =CGRectMake(DEVICE_WIDTH/2-139, height+70,  278, 50);
    }else{
        view.frame =CGRectMake(DEVICE_WIDTH/2-139, height+70,  278, 50);
    }
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    UILabel *lblLogin=[[UILabel alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblLogin.frame = CGRectMake(44,0,70,40);
    }
    else{
        lblLogin.frame = CGRectMake(view.frame.size.width-120,0,90,40);
    }
    lblLogin.userInteractionEnabled = YES;
    lblLogin.text =[TSLanguageManager localizedString:@"Login with"];
    lblLogin.textColor = [UIColor grayColor];
    lblLogin.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [view addSubview:lblLogin];
       
    UIButton *btnLogin1=[[UIButton alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnLogin1.frame = CGRectMake(114,0, 40,44);
    }
    else{
        btnLogin1.frame = CGRectMake(view.frame.size.width-215,0, 100,44);
    }
    [btnLogin1 addTarget:self action:@selector(btnLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
       [btnLogin1 setTitle:[TSLanguageManager localizedString:@"Email"] forState:UIControlStateNormal];
       [btnLogin1 setTitleColor:[UIColor colorWithRed:0.0/255.0 green:114.0/255.0 blue:180.0/255.0 alpha:1] forState:UIControlStateNormal];
    btnLogin1.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
       [view addSubview:btnLogin1];
       
    UILabel *lblLogin2=[[UILabel alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblLogin2.frame = CGRectMake(159,0,25,40);
    }
    else{
        lblLogin2.frame = CGRectMake(view.frame.size.width-220,0,20,40);
    }
    lblLogin2.userInteractionEnabled = YES;
    lblLogin2.text =[TSLanguageManager localizedString:@"or"];
    lblLogin2.textColor = [UIColor grayColor];
    lblLogin2.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [view addSubview:lblLogin2];
       
       
    UIButton *btnLogin4=[[UIButton alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnLogin4.frame = CGRectMake(174,0, 60,44);
    }
    else{
        btnLogin4.frame = CGRectMake(view.frame.size.width-255,0, 30,44);
    }
    [btnLogin4 addTarget:self action:@selector(btnRegisterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnLogin4 setTitle:[TSLanguageManager localizedString:@"Sign up"] forState:UIControlStateNormal];
    [btnLogin4 setTitleColor:[UIColor colorWithRed:0.0/255.0 green:114.0/255.0 blue:180.0/255.0 alpha:1] forState:UIControlStateNormal];
       btnLogin4.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [view addSubview:btnLogin4];
    
    
    UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/2-100,34,200,1)];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblline.frame =CGRectMake(view.frame.size.width/2-95,34,190,1);
    }
    else{
        lblline.frame =CGRectMake(view.frame.size.width/2-100,34,200,1);
    }
    lblline.backgroundColor =[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1];
    [view addSubview:lblline];
    
   
    if (IS_IPHONE) {
        
        UIImageView *imageBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0,DEVICE_HEIGHT-175 , DEVICE_WIDTH, 165)];
        imageBackGround.image = [UIImage imageNamed:@"kuwait"];
        imageBackGround.contentMode = UIViewContentModeScaleAspectFit;
        imageBackGround.layer.masksToBounds = YES;
        [self.view addSubview:imageBackGround];
    }
    if (IS_IPAD) {
        UIImageView *imageBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0,height+160 , DEVICE_WIDTH,399 )];
        imageBackGround.image = [UIImage imageNamed:@"kuwait"];
        imageBackGround.contentMode = UIViewContentModeScaleAspectFit;
        imageBackGround.layer.masksToBounds = YES;
        [self.view addSubview:imageBackGround];
    }
   
}

#pragma mark - Button Actions
-(void)btnFBClicked:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    
    [login logInWithReadPermissions: @[@"email"] fromViewController:self  handler:^(FBSDKLoginManagerLoginResult *result, NSError *error){
        
        if (error){
            // Process error
            NSLog(@"error %@",error);
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"Cancelled");
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                [self fetchUserInfoFromFacebook];
            }
        }
        
    }];
}
-(void)btnGPClicked:(id)sender
{
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil)
    {
        [[GIDSignIn sharedInstance] signIn];
    }else
    {
        NSLog( @"name == %@", [GIDSignIn sharedInstance].currentUser.profile.name);
        
        userIdForGoogle = [GIDSignIn sharedInstance].currentUser.userID;                  // For client-side use only!
        NSString *idToken = [GIDSignIn sharedInstance].currentUser.authentication.idToken; // Safe to send to the server
        NSString *fullName = [GIDSignIn sharedInstance].currentUser.profile.name;
        givenNameForGoogle = [GIDSignIn sharedInstance].currentUser.profile.givenName;
        familyNameForGoogle = [GIDSignIn sharedInstance].currentUser.profile.familyName;
        emailForGoogle = [GIDSignIn sharedInstance].currentUser.profile.email;
        [dictForGoogle removeAllObjects];
        [dictForGoogle setValue:userIdForGoogle forKey:@"id"];
        [dictForGoogle setValue:givenNameForGoogle forKey:@"first_name"];
        [dictForGoogle setValue:familyNameForGoogle forKey:@"last_name"];
        [dictForGoogle setValue:emailForGoogle forKey:@"email"];
        strForIdentificationLoginType = @"2";
        
        if(userIdForGoogle.length>0)
        {
        [self loginWebServices:dictForGoogle];
        }
        
        NSLog(@"userId ==> %@ idToken ==%@, fullName==%@ givenName ==>%@ familyName==%@ email ==>%@",userIdForGoogle,idToken,fullName,givenNameForGoogle,familyNameForGoogle,emailForGoogle);
    }
}

-(void)skipButtonClicked:(id)sender
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setValue:@"yes" forKey:@"CURRENT_USER_SKIPBUTTON_CLICKED"];
    [APP_DELEGATE rootViewController];
}
-(void)btnLoginClicked:(id)sender
{
    [self openCoreDeviceView];
}
-(void)btnRegisterClicked:(id)sender
{
    RegisterVC * destinationForRegister = [[RegisterVC alloc ]init];
    [self.navigationController pushViewController:destinationForRegister animated:YES];
}
-(void)btnSignInClicked:(id)sender
{
  //  [self hideKeyboard];
    
    if([txtEmail.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[TSLanguageManager localizedString:@"Please enter email address"] cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            NSLog(@"button tapped: index=%ld", (long)buttonIndex);
            [alertView hideWithCompletionBlock:^{
                [alertView removeFromSuperview];
                
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if(![APP_DELEGATE validateEmail:txtEmail.text])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[TSLanguageManager localizedString:@"Please enter valid email address."] cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            NSLog(@"button tapped: index=%ld", (long)buttonIndex);
            [alertView hideWithCompletionBlock:^{
                [alertView removeFromSuperview];
                
                
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if([txtPassword.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[TSLanguageManager localizedString:@"Please enter password."] cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            NSLog(@"button tapped: index=%ld", (long)buttonIndex);
            [alertView hideWithCompletionBlock:^{
                [alertView removeFromSuperview];
                
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else
    {
        [self loginWebService];
    }
}
-(void)btnShowPassworHide:(id)sender
{

}

#pragma mark - webservice list
-(void)loginWebService
{
    [self hideView];
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        [APP_DELEGATE showProcessHud];
     
        NSString * webServiceName = @"userLogin";
        NSLog(@"There IS internet connection");
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
        [parameter_dict setObject:txtEmail.text forKey:@"email_id"];
        [parameter_dict setObject:txtPassword.text forKey:@"password"];
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"userLogin";
        NSLog(@"printDictionary:%@",parameter_dict);
        [manager urlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL,webServiceName] withParameters:parameter_dict];
    }
}

-(void)loginWebServices:(NSDictionary*)dicLogin
{
    NSLog(@"%@", dicLogin);
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
         [APP_DELEGATE showProcessHud];
        NSString * webServiceName = @"socialMediaLogin";
        NSLog(@"There IS internet connection");
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
        [parameter_dict setObject:[dicLogin valueForKey:@"first_name"] forKey:@"user_firstname"];
        [parameter_dict setObject:[dicLogin valueForKey:@"last_name"] forKey:@"user_lastname"];
        if ([dicLogin valueForKey:@"email"]) {
            if ([dicLogin valueForKey:@"email"]!=nil && [dicLogin valueForKey:@"email"]!=[NSNull null]) {
                [parameter_dict setObject:[dicLogin valueForKey:@"email"] forKey:@"email_id"];
                
            }else{
                [parameter_dict setObject:getEmail forKey:@"email_id"];
            }
        }
        [parameter_dict setObject:[dicLogin valueForKey:@"id"] forKey:@"auth_id"];
        if(![strForIdentificationLoginType isEqualToString:@""])
        {
            if([strForIdentificationLoginType isEqualToString:@"1"])//strtype 1 for facebook login and 2 for google login
            {
                [parameter_dict setObject:@"2" forKey:@"register_via"];// register vie 2 means from facebook and 3 for google
            }else if([strForIdentificationLoginType isEqualToString:@"2"]){
                [parameter_dict setObject:@"3" forKey:@"register_via"];
            }
        }
        else{
            [parameter_dict setObject:@"" forKey:@"register_via"];
        }
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"socialMediaLogin";
        NSLog(@"printDictionary:%@",parameter_dict);
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL,webServiceName] withParameters:parameter_dict andValidation:NO];
        //  [manager urlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL,webServiceName] withParameters:parameter_dict];
    }
}
-(void)forgetPadsswrod:(NSString*)email
{
    [APP_DELEGATE showProcessHud];
}
#pragma mark Response
- (void)onResult:(NSDictionary *)result
{
     [APP_DELEGATE hideProcessHud];
    if([[result valueForKey:@"commandName"] isEqualToString:@"socialMediaLogin"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"] isEqualToString:@"1"])
        {
            NSMutableDictionary * tempDict = [[result valueForKey:@"result"] valueForKey:@"data"];
            [self setUserDefaultWhenLogIn:tempDict];
        }
        else{
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[[result valueForKey:@"result"] valueForKey:@"message"] cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
            [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                NSLog(@"button tapped: index=%ld", (long)buttonIndex);
                [alertView hideWithCompletionBlock:^{
                 //   [alertView removeFromSuperview];
                }];
            }];
            [alertView showWithAnimation:URBAlertAnimationTopToBottom];
        }
    }
    
    else if([[result valueForKey:@"commandName"] isEqualToString:@"userLogin"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"] isEqualToString:@"1"])
        {
            NSMutableDictionary * tempDict = [[result valueForKey:@"result"] valueForKey:@"data"];
            [self CloseLoginView];
            [self setUserDefaultWhenLogIn:tempDict];
        }
        else{
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[[result valueForKey:@"result"] valueForKey:@"message"]cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
            [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                NSLog(@"button tapped: index=%ld", (long)buttonIndex);
                [alertView hideWithCompletionBlock:^{
                   // [alertView removeFromSuperview];
                }];
            }];
            [alertView showWithAnimation:URBAlertAnimationTopToBottom];
        }
    }
    
}

- (void)onError:(NSError *)error
{
    //HUD.labelText=@"";
    [APP_DELEGATE hideProcessHud];
    NSLog(@"The error is...%@", error);
}

#pragma mark - FB Delegate Methods

#pragma mark - FaceBook
-(void)fetchUserInfoFromFacebook
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available");
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, about ,location , friends ,hometown , friendlists, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 
                 NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
                 
                 if([result objectForKey:@"email"]==NULL)
                 {
                     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please enter email id" delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:@"Cancel", nil];
                     alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
                    
                     [alertView show];
                     
                      [dicForFacebook setDictionary:result];
                     
                 }
                 else
                 {
                     strForIdentificationLoginType = @"1";
                     [self loginWebServices:result];
                 
                 }
                 
                 NSLog(@"Fetched User Information:%@", result);
              
              
                 
//                 strUserID = [NSString stringWithFormat:@"%@",result[@"id"]];
//                 strName = [NSString stringWithFormat:@"%@",result[@"name"]];
//                 strLastName = [NSString stringWithFormat:@"%@",result[@"last_name"]];
//                 strEmail = [NSString stringWithFormat:@"%@",result[@"email"]];
//
//                 if (![strUserID isEqual:[NSNull null]] && strUserID!=nil)
//                 {
//                     strUserID = [NSString stringWithFormat:@"%@",result[@"id"]];
//
//                 }else{
//                     strUserID = @"";
//                 }
//
//                 if (![strName isEqual:[NSNull null]] && strName!=nil)
//                 {
//                     strName = [NSString stringWithFormat:@"%@",result[@"name"]];
//
//                 }else{
//                     strName = @"";
//                 }
//                 if (![strLastName isEqual:[NSNull null]] && strLastName!=nil)
//                 {
//                    strLastName = [NSString stringWithFormat:@"%@",result[@"last_name"]];
//
//                 }else{
//                     strLastName = @"";
//                 }
//                 if (![strEmail isEqual:[NSNull null]] && strEmail!=nil)
//                 {
//                     strEmail = [NSString stringWithFormat:@"%@",result[@"email"]];
//                 }else{
//                     strEmail =@"";
//                 }
              
                
                 
                 
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    else
    {
        //   // HUD.labelText=@"";
        
        //[HUD hide:YES];
        NSLog(@"User is not Logged in");
    }
    
}


#pragma mark - Google Plus Delegate Methods

#pragma mark - We will fetch all details from Google
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    userIdForGoogle = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    givenNameForGoogle = user.profile.givenName;
    familyNameForGoogle = user.profile.familyName;
    emailForGoogle = user.profile.email;
    NSLog(@"userId ==> %@ idToken ==%@, fullName==%@ givenName ==>%@ familyName==%@ email ==>%@",userIdForGoogle,idToken,fullName,givenNameForGoogle,familyNameForGoogle,emailForGoogle);
    [dictForGoogle removeAllObjects];
    
    NSString * strUserID = @"";
    NSString * strName = @"";
    NSString *strLastName = @"";
    NSString *strEmail = @"";
    
    strUserID = [NSString stringWithFormat:@"%@",userIdForGoogle];
    strName = [NSString stringWithFormat:@"%@",givenNameForGoogle];
    strLastName = [NSString stringWithFormat:@"%@",familyNameForGoogle];
    strEmail = [NSString stringWithFormat:@"%@",emailForGoogle];
    
    if (![strUserID isEqual:[NSNull null]] && strUserID!=nil)
    {
        [dictForGoogle setValue:strUserID forKey:@"id"];
  
    }else{
        [dictForGoogle setValue:@"" forKey:@"id"];
     }
    
    if (![strName isEqual:[NSNull null]] && strName!=nil)
    {
        [dictForGoogle setValue:strName forKey:@"first_name"];
        
    }else{
        [dictForGoogle setValue:@"" forKey:@"first_name"];
    }
    if (![strLastName isEqual:[NSNull null]] && strLastName!=nil)
    {
         [dictForGoogle setValue:strLastName forKey:@"last_name"];
        
    }else{
        [dictForGoogle setValue:@"" forKey:@"last_name"];
    }
    if (![strEmail isEqual:[NSNull null]] && strEmail!=nil)
    {
       [dictForGoogle setValue:strEmail forKey:@"email"];
        
    }else{
     [dictForGoogle setValue:@""forKey:@"email"];
    }
//    [dictForGoogle setValue:givenNameForGoogle forKey:@"first_name"];
   // [dictForGoogle setValue:familyNameForGoogle forKey:@"last_name"];
   // [dictForGoogle setValue:emailForGoogle forKey:@"email"];
    strForIdentificationLoginType = @"2";
    if(userIdForGoogle.length>0)
    {
    [self loginWebServices:dictForGoogle];
    }
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        if(![self validateEmailWithString:[alertView textFieldAtIndex:0].text]){
           
        }else{
            getEmail = [alertView textFieldAtIndex:0] .text;
            strForIdentificationLoginType = @"1";
            [dicForFacebook setObject:getEmail forKey:@"email"];
            [self loginWebServices:dicForFacebook];
        }
    }
}
- (BOOL)validateEmailWithString:(NSString*)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
#pragma mark - Webservice methods
-(void)loginwithSocialMedia:(NSMutableDictionary *) dictValues
{
}

#pragma mark - Login methods
-(void)openCoreDeviceView
{
    ViewPopupBackView = [[UIView alloc]init];
    [ViewPopupBackView setFrame:CGRectMake(0,0,DEVICE_WIDTH, DEVICE_HEIGHT)];
    ViewPopupBackView.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0.7];
    ViewPopupBackView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:ViewPopupBackView];

    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [ViewPopupBackView addGestureRecognizer:tap];
   
    viewLoginBorder = [[UIView alloc] init];
    if(IS_IPAD){
       [viewLoginBorder setFrame:CGRectMake(134, DEVICE_HEIGHT/2-135, DEVICE_WIDTH-268, 270)];
    }else{
        [viewLoginBorder setFrame:CGRectMake(14, DEVICE_HEIGHT/2-135, DEVICE_WIDTH-28, 270)];
    }
    viewLoginBorder.backgroundColor = [UIColor whiteColor];
    [ViewPopupBackView addSubview:viewLoginBorder];
    
    txtEmail = [[JVFloatLabeledTextField alloc] init];
    if(IS_IPAD)
    {
        [txtEmail setFrame:CGRectMake(65,40,viewLoginBorder.frame.size.width-130,46)];
    }else{
        [txtEmail setFrame:CGRectMake(24,40,viewLoginBorder.frame.size.width-48,46)];
    }
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtEmail.textAlignment = NSTextAlignmentLeft;
    }else{
        txtEmail.textAlignment = NSTextAlignmentRight;
    }
    txtEmail.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    [txtEmail setPlaceholder:[TSLanguageManager localizedString:@"Email"]];
    txtEmail.placeholderColor = [UIColor lightGrayColor];
    txtEmail.floatingLabelActiveTextColor = APP_BUTTON_COLOR;
    txtEmail.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    txtEmail.floatingLabelTextColor = [UIColor lightGrayColor];
    txtEmail.backgroundColor=[UIColor clearColor];
    txtEmail.delegate = self;
    [viewLoginBorder addSubview:txtEmail];
    
    lblFirstLine = [[UILabel alloc] initWithFrame:CGRectMake(0,txtEmail.frame.size.height-1,txtEmail.frame.size.width, 1)];
    [lblFirstLine setBackgroundColor:[UIColor lightGrayColor]];
    [txtEmail addSubview:lblFirstLine];
    
    if(IS_IPAD){
        txtPassword = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(65,90,viewLoginBorder.frame.size.width-130,46)];
    }else{
        txtPassword = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(24,90,viewLoginBorder.frame.size.width-48,46)];
    }
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtPassword.textAlignment = NSTextAlignmentLeft;
    }else{
        txtPassword.textAlignment = NSTextAlignmentRight;
    }
    txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    txtPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtPassword.keyboardType = UIKeyboardTypeEmailAddress;
    txtPassword.placeholderColor = [UIColor lightGrayColor];
    txtPassword.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtPassword.floatingLabelActiveTextColor = APP_BUTTON_COLOR;
    [txtPassword setPlaceholder:[TSLanguageManager localizedString:@"Password"]];
    txtPassword.returnKeyType=UIReturnKeyDone;
    txtPassword.secureTextEntry=YES;
    txtPassword.floatingLabelTextColor = [UIColor lightGrayColor];
    txtPassword.backgroundColor=[UIColor clearColor];
    txtPassword.delegate = self;
    [viewLoginBorder addSubview:txtPassword];

    lblSecondLine = [[UILabel alloc] initWithFrame:CGRectMake(0,txtPassword.frame.size.height-1,txtPassword.frame.size.width, 1)];
    [lblSecondLine setBackgroundColor:[UIColor lightGrayColor]];
    lblSecondLine.alpha = 0.5;
    [txtPassword addSubview:lblSecondLine];
    
    
    btnShowPassword =[UIButton buttonWithType:UIButtonTypeCustom];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
        if(IS_IPAD){btnShowPassword.frame=CGRectMake(viewLoginBorder.frame.size.width-65-46,90,46 ,46);}
        else{btnShowPassword.frame=CGRectMake(viewLoginBorder.frame.size.width-65,90,46 ,46);}
    }else{
        if(IS_IPAD){btnShowPassword.frame=CGRectMake(65,90,46 ,46);}
        else{btnShowPassword.frame=CGRectMake(24,90,46 ,46);}
    }
    btnShowPassword.backgroundColor = [UIColor clearColor];
    //[btnShowPassword setTitle:@"Show" forState:UIControlStateNormal];
    [btnShowPassword setImage:[UIImage imageNamed:@"visibility_hide"] forState:UIControlStateNormal];
    [btnShowPassword addTarget:self action:@selector(btnShowPasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnShowPassword.hidden = NO;
    [viewLoginBorder addSubview:btnShowPassword];
    
    
    btnSignIn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSignIn setFrame:CGRectMake(viewLoginBorder.frame.size.width/2-61,180,122,36)];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
         [btnSignIn setImage:[UIImage imageNamed:@"signin-button"] forState:UIControlStateNormal];
    }else{
        btnSignIn.backgroundColor = APP_BUTTON_COLOR;
        [btnSignIn setTitle:[TSLanguageManager localizedString:@"Sign In"] forState:UIControlStateNormal];
    }
    [btnSignIn addTarget:self action:@selector(btnSignInClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewLoginBorder addSubview:btnSignIn];
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        ViewPopupBackView.alpha = 1;
    } completion:^(BOOL finished) {
        //        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //            ViewPopupBackView.alpha = 1;
        //        } completion:nil];
    }];
}


-(void)CloseLoginView
{
    [ViewPopupBackView endEditing:YES];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        ViewPopupBackView.alpha = 0;
//        viewLoginBorder.transform = CGAffineTransformMakeTranslation(0,0);
    } completion:^(BOOL finished) {
        [ViewPopupBackView removeFromSuperview];
        [viewLoginBorder removeFromSuperview];
//        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            viewLoginBorder.transform = CGAffineTransformMakeTranslation(0,DEVICE_HEIGHT-100);
//        } completion:^(BOOL finished)
//         {
//             viewLoginBorder.hidden = YES;
//             ViewPopupBackView.hidden = YES;
//         }];
    }];
}

-(void)btnShowPasswordClicked:(id)sender
{
    if([strIdentifyPassword isEqualToString:@"1"])//1 == password will be secure text 2== password without secure text;
    {
         [btnShowPassword setImage:[UIImage imageNamed:@"visibility.png"] forState:UIControlStateNormal];
        txtPassword.secureTextEntry = NO;
        NSString *currentText = txtPassword.text;
        txtPassword.text = @"";
        txtPassword.text = currentText;
        strIdentifyPassword = @"2";
        //[btnShowPassword setTitle:@"Hide" forState:UIControlStateNormal];
        txtPassword.font = [UIFont systemFontOfSize:16];
    }
    else if([strIdentifyPassword isEqualToString:@"2"])//1 == password will be secure text 2== password without secure text;
    {
          [btnShowPassword setImage:[UIImage imageNamed:@"visibility_hide.png"] forState:UIControlStateNormal];
        txtPassword.secureTextEntry = YES;
        txtPassword.font =[UIFont systemFontOfSize:16];
        strIdentifyPassword = @"1";
        // [btnShowPassword setTitle:@"Show" forState:UIControlStateNormal];
   
    }
}

#pragma mark - Notification
-(void)registerNotification
{
    [self removeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - KeyBoard Notification
-(void) keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    viewLogin.frame = CGRectMake(0,-50, DEVICE_WIDTH, DEVICE_HEIGHT);
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note
{
    CGRect keyboardBounds;
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    viewLogin.frame=CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    
    // commit animations
    [UIView commitAnimations];
}

#pragma mark - UITextField Delegate Methods
#pragma mark TextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == txtEmail)
    {
        lblFirstLine.frame=CGRectMake(0,txtEmail.frame.size.height-3,txtEmail.frame.size.width ,2);
        lblFirstLine.backgroundColor = APP_BUTTON_COLOR;
        lblSecondLine.frame=CGRectMake(0,txtPassword.frame.size.height-3,txtPassword.frame.size.width ,1);
        lblSecondLine.backgroundColor =[UIColor grayColor] ;
    }else{
    lblSecondLine.frame=CGRectMake(0,txtPassword.frame.size.height-3,txtPassword.frame.size.width ,2);
        lblSecondLine.backgroundColor = APP_BUTTON_COLOR;
        lblFirstLine.frame=CGRectMake(0,txtEmail.frame.size.height-3,txtEmail.frame.size.width ,1);
        lblFirstLine.backgroundColor = [UIColor grayColor];
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtEmail)
    {
        [txtPassword becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)hideView
{
    //[self hideKeyboard];
    [self CloseLoginView];
}

#pragma mark - Hide keyboard
-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

-(void)setUserDefaultWhenLogIn:(NSDictionary*)result
{
    NSLog(@"LoginUser dict ====%@",result);
    NSUserDefaults *LoginUser=[NSUserDefaults standardUserDefaults];
    
    NSString* strUserId = [NSString stringWithFormat:@"%@",[result valueForKey:@"user_id"] ];
    if (strUserId!=nil && ![strUserId isEqualToString:@""])
    {
        [LoginUser setValue:strUserId forKey:@"CURRENT_USER_ID"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_ID"];
    }
    
    if ([result valueForKey:@"email"]!=[NSNull null] && ![[result valueForKey:@"email"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"email"] forKey:@"CURRENT_USER_EMAIL"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_EMAIL"];
    }
    
    if ([result valueForKey:@"first_name"]!=[NSNull null] && ![[result valueForKey:@"first_name"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"first_name"] forKey:@"CURRENT_USER_FIRST_NAME"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_FIRST_NAME"];
    }
    
    if ([result valueForKey:@"user_image"]!=[NSNull null] && ![[result valueForKey:@"user_image"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"user_image"] forKey:@"CURRENT_USER_IMAGE"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_IMAGE"];
    }
    
    if ([result valueForKey:@"last_name"]!=[NSNull null] && ![[result valueForKey:@"last_name"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"last_name"] forKey:@"CURRENT_USER_LAST_NAME"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_LAST_NAME"];
    }
    if([result valueForKey:@"phone_no"])
    {
        if ([result valueForKey:@"phone_no"]!=[NSNull null] && ![[result valueForKey:@"phone_no"] isEqualToString:@""])
        {
            [LoginUser setValue:[result valueForKey:@"phone_no"] forKey:@"CURRENT_USER_PHONE_NUMBER"];
        }else{
            [LoginUser setValue:@"" forKey:@"CURRENT_USER_PHONE_NUMBER"];
        }
    }
    if ([result valueForKey:@"access_token"]!=[NSNull null] && ![[result valueForKey:@"access_token"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"access_token"] forKey:@"CURRENT_USER_ACCESS_TOKEN"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_ACCESS_TOKEN"];
    }
       [LoginUser removeObjectForKey:@"CURRENT_USER_SKIPBUTTON_CLICKED"];
    
    NSLog(@"CURRENT_USER_ID==========%@",CURRENT_USER_ID);
    NSLog(@"CURRENT_USER_FIRST_NAME==========%@",CURRENT_USER_FIRST_NAME);
    NSLog(@"CURRENT_USER_LAST_NAME==========%@",CURRENT_USER_LAST_NAME);
    NSLog(@"CURRENT_USER_EMAIL==========%@",CURRENT_USER_EMAIL);
    NSLog(@"CURRENT_USER_IMAGE==========%@",CURRENT_USER_IMAGE);
    NSLog(@"CURRENT_USER_ACCESS_TOKEN==========%@",CURRENT_USER_ACCESS_TOKEN);
    [APP_DELEGATE rootViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*Flogin
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
