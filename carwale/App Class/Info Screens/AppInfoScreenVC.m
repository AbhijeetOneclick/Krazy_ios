//
//  AppInfoScreenVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "AppInfoScreenVC.h"
#import "SocialLoginVC.h"
#import "RegisterVC.h"

@interface AppInfoScreenVC ()

@end

@implementation AppInfoScreenVC

static NSString * const kClientID =
@"633631499846-n6ksnpijnovdtb89138sa0hutdeidm2n.apps.googleusercontent.com";

#pragma mark - App life cycle method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    
    [GIDSignInButton class];
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.clientID= kClientID;
    signIn.delegate = self;
    signIn.uiDelegate = self;

    arrForLogin = [[NSMutableArray alloc]init];
    dictForGoogle = [[NSMutableDictionary alloc]init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    strUserNumber =[NSString stringWithFormat:@""];
    strForIdentificationLoginType = @"";//1 for facebook identify and 2 for google
    UIImageView *imgBg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    imgBg.image=[UIImage imageNamed:Image_App_Background];
    
    [self.view addSubview:imgBg];
    [self frameHeader];
    [self registerNotification];
}

#pragma mark - Frame of Heacder view
-(void)frameHeader
{
    scrlContent =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,DEVICE_HEIGHT) ];
    scrlContent.delegate=self;
    scrlContent.bounces= NO;
    scrlContent.pagingEnabled =YES;
    scrlContent.showsVerticalScrollIndicator=NO;
    scrlContent.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrlContent];
    
    int xx=0;
    for(int i=0; i<3 ;i++)
    {
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(xx, 0, DEVICE_WIDTH, scrlContent.frame.size.height)];
        firstView.backgroundColor =[UIColor clearColor];
        [scrlContent addSubview:firstView];
        
        UIImageView * imgSplash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, firstView.frame.size.width, firstView.frame.size.height)];
        
        UILabel * lblCarType = [[UILabel alloc] initWithFrame:CGRectMake(20, DEVICE_HEIGHT/2-170, DEVICE_WIDTH-20, 20)];
        [lblCarType setFont:[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular]];
        lblCarType.textAlignment=NSTextAlignmentLeft;
        lblCarType.textColor =[UIColor whiteColor];
        
         UILabel * lblText = [[UILabel alloc] initWithFrame:CGRectMake(20,DEVICE_HEIGHT/2-140, DEVICE_WIDTH-40, 60)];
        if (i==0)
        {
            if (IS_IPHONE_4)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip4.png"]];
            }else if (IS_IPHONE_5)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip5.png"]];
            }else if (IS_IPHONE_6)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip6.png"]];
            }else if (IS_IPHONE_6plus)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip6+@1242x2208.png"]];
            }
            
            lblCarType.text=@"NEW CAR";
            lblText.text=@"Get feature, specifications, updated prices & offers of all new cars, and directly connect with authorized dealers.";
        }else if(i==1)
        {
            if (IS_IPHONE_4)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip4.png"]];
            }else if (IS_IPHONE_5)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip5.png"]];
            }else if (IS_IPHONE_6)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip6.png"]];
            }else if (IS_IPHONE_6plus)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip6+@1242x2208.png"]];
            }
            lblCarType.text=@"USED CAR";
            lblText.text=@"Buying a used car has been made and affordable with lens of thousand of options to choose from";
        }
        else
        {
            if (IS_IPHONE_4)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip4.png"]];
            }else if (IS_IPHONE_5)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip5.png"]];
            }else if (IS_IPHONE_6)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip6.png"]];
            }else if (IS_IPHONE_6plus)
            {
                [imgSplash setImage:[UIImage imageNamed:@"bg_ip6+@1242x2208.png"]];
            }
            lblCarType.text=@"CAR ENTHUSIAST";
            lblText.text=@"Stay up to date on new car launches, upcoming cars and latest happening in the automobile circuit";
        }
        [firstView addSubview:imgSplash];
        [firstView addSubview:lblCarType];
       
        lblText.numberOfLines=4;
        [lblText setFont:[UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular]];
        lblText.lineBreakMode=NSLineBreakByWordWrapping;
        lblText.textAlignment=NSTextAlignmentLeft;
        lblText.textColor =[UIColor whiteColor];
        [firstView addSubview:lblText];
        xx= xx+DEVICE_WIDTH;
    }
    [scrlContent setContentSize:CGSizeMake(xx, DEVICE_HEIGHT)];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(100, DEVICE_HEIGHT/2-70,DEVICE_WIDTH-200,20);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.enabled=NO;
    [self.view addSubview:pageControl];
    
    btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSkip.frame =CGRectMake(DEVICE_WIDTH-80, 24, 70, 50);
    [btnSkip setTitle:@"Skip" forState:UIControlStateNormal];
    [btnSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSkip addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnSkip.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
    [self.view addSubview:btnSkip];
    
    
    if (!btnFBLogin)
    {
        btnFBLogin = [[UIButton alloc] initWithFrame:CGRectMake(20, DEVICE_HEIGHT-180, DEVICE_WIDTH/2-30, 50)];
        [btnFBLogin addTarget:self action:@selector(btnFBClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnFBLogin setImage:[UIImage imageNamed:@"fb_btn.png"] forState:UIControlStateNormal];
        [self.view addSubview:btnFBLogin];
    }
    if (!btnGPLogin)
    {
        btnGPLogin = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+10, DEVICE_HEIGHT-180,DEVICE_WIDTH/2-30, 50)];
        [btnGPLogin addTarget:self action:@selector(btnGPClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnGPLogin setImage:[UIImage imageNamed:@"g+_btn.png"] forState:UIControlStateNormal];
        [self.view addSubview:btnGPLogin];
    }
    
    UILabel *lblLogin=[[UILabel alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-130, DEVICE_WIDTH, 60)];
    lblLogin.textAlignment=NSTextAlignmentCenter;
    lblLogin.numberOfLines=3;
    lblLogin.textColor =[UIColor whiteColor];
    lblLogin.lineBreakMode=NSLineBreakByWordWrapping;
    lblLogin.font =[UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
    NSMutableAttributedString *strText = [[NSMutableAttributedString alloc] initWithString:@"Sign in to get the best Experience with Carwale \n Already have an account? LOGIN"];
    [strText addAttribute:NSFontAttributeName
                    value:[UIFont boldSystemFontOfSize:13.0]
                    range:NSMakeRange(40, 7)];
    lblLogin.attributedText=strText;
    [self.view addSubview:lblLogin];
    
    btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame = CGRectMake(20, DEVICE_HEIGHT-120, DEVICE_WIDTH-40, 50);
    btnLogin.backgroundColor = [UIColor clearColor];
    [btnLogin addTarget:self action:@selector(btnLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    UILabel *lblSignup=[[UILabel alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-50, DEVICE_WIDTH, 15)];
    lblSignup.textAlignment=NSTextAlignmentCenter;
    lblSignup.textColor =[UIColor whiteColor];
    lblSignup.font =[UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
    lblSignup.text = @"Don't have an account? Register here";
    [self.view addSubview:lblSignup];
    
    btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.frame = CGRectMake(20, DEVICE_HEIGHT-60, DEVICE_WIDTH-40, 50);
    btnRegister.backgroundColor = [UIColor clearColor];
    [btnRegister addTarget:self action:@selector(btnRegisterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
}

#pragma mark - page Controller
#pragma mark - Scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2 ) / pageWidth) + 1; //this provide you the page number
    pageControl.currentPage = page;// this displays the white dot as current page

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
        [self loginWebServices:dictForGoogle];
        
        NSLog(@"userId ==> %@ idToken ==%@, fullName==%@ givenName ==>%@ familyName==%@ email ==>%@",userIdForGoogle,idToken,fullName,givenNameForGoogle,familyNameForGoogle,emailForGoogle);
    }
}
-(void)btnNextClickedClicked:(id)sender
{
    if(pageControl.currentPage==0)
    {
        [scrlContent setContentOffset:CGPointMake(DEVICE_WIDTH, 0) animated:YES];
        
    }
    else if(pageControl.currentPage==1)
    {
        SocialLoginVC * social = [[SocialLoginVC alloc] init];
        [self.navigationController pushViewController:social animated:YES];
    }
}
-(void)skipButtonClicked:(id)sender
{
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
    [self hideKeyboard];
    
    if([txtEmail.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter email address" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
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
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter valid email address" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
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
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter password" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        
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
-(void)btnShowPasswordHide:(id)sender
{

}

#pragma mark - webservice list
-(void)loginWebService
{
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
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
        NSString * webServiceName = @"socialMediaLogin";
        NSLog(@"There IS internet connection");
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
        [parameter_dict setObject:[dicLogin valueForKey:@"first_name"] forKey:@"user_firstname"];
        [parameter_dict setObject:[dicLogin valueForKey:@"last_name"] forKey:@"user_lastname"];
        [parameter_dict setObject:[dicLogin valueForKey:@"email"] forKey:@"email_id"];
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
    if([[result valueForKey:@"commandName"] isEqualToString:@"socialMediaLogin"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"] isEqualToString:@"1"])
        {
            NSMutableDictionary * tempDict = [[result valueForKey:@"result"] valueForKey:@"data"];
            [self setUserDefaultWhenLogIn:tempDict];
        }
        else{
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"unable to process your request please try again leter." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
            [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                NSLog(@"button tapped: index=%ld", (long)buttonIndex);
                [alertView hideWithCompletionBlock:^{
                    [alertView removeFromSuperview];
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
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"unable to process your request please try again leter" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
            [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                NSLog(@"button tapped: index=%ld", (long)buttonIndex);
                [alertView hideWithCompletionBlock:^{
                    [alertView removeFromSuperview];
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
                 NSLog(@"Fetched User Information:%@", result);
                 strForIdentificationLoginType = @"1";//1 for facebook and 2 for google
                 [self loginWebServices:result];
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
    [dictForGoogle setValue:userIdForGoogle forKey:@"id"];
    [dictForGoogle setValue:givenNameForGoogle forKey:@"first_name"];
    [dictForGoogle setValue:familyNameForGoogle forKey:@"last_name"];
    [dictForGoogle setValue:emailForGoogle forKey:@"email"];
    strForIdentificationLoginType = @"2";
    [self loginWebServices:dictForGoogle];
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
}

#pragma mark - Webservice methods
-(void)loginwithSocialMedia:(NSMutableDictionary *) dictValues
{
}

#pragma mark - Login methods
-(void)openCoreDeviceView
{
    [viewLogin removeFromSuperview];
    viewLogin=[[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, DEVICE_HEIGHT)];
    viewLogin.backgroundColor=[UIColor clearColor];
    [self.view addSubview:viewLogin];
    
    viewTransparent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    viewTransparent.backgroundColor = [UIColor blackColor];
    viewTransparent.alpha=0.3;
    [viewLogin addSubview:viewTransparent];
    
    viewPlain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    viewPlain.backgroundColor = [UIColor clearColor];
    [viewLogin addSubview:viewPlain];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    tap.cancelsTouchesInView = YES;
    [viewLogin addGestureRecognizer:tap];
    viewLoginBorder = [[UIView alloc] initWithFrame:CGRectMake(20, DEVICE_HEIGHT/2-100, DEVICE_WIDTH-40, 200)];
    viewLoginBorder.backgroundColor = [UIColor whiteColor];
    viewLoginBorder.userInteractionEnabled=NO;
    [viewLogin addSubview:viewLoginBorder];
    
    viewBorder = [[UIView alloc] initWithFrame:CGRectMake(30, DEVICE_HEIGHT/2-90, DEVICE_WIDTH-60, 180)];
    viewBorder.backgroundColor = [UIColor whiteColor];
    viewBorder.layer.cornerRadius=5;
//    viewBorder.clipsToBounds=YES;
    [viewLogin addSubview:viewBorder];
    viewBorder.layer.shadowColor = [UIColor blackColor].CGColor;
    viewBorder.layer.shadowOffset = CGSizeMake(0, 1);
    viewBorder.layer.shadowOpacity = 1;
    viewBorder.layer.shadowRadius = 1;
    
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(40,DEVICE_HEIGHT/2-90,DEVICE_WIDTH-80,44)];
    txtEmail.textAlignment = NSTextAlignmentLeft;
    txtEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    [txtEmail setDelegate:self];
    [txtEmail setPlaceholder:@"Email"];
    txtEmail.backgroundColor = [UIColor clearColor];
    txtEmail.returnKeyType=UIReturnKeyNext;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, txtEmail.frame.size.height - 1, txtEmail.frame.size.width, 0.50f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtEmail.layer addSublayer:bottomBorder];
    [viewLogin addSubview:txtEmail];

    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(40,DEVICE_HEIGHT/2-35,DEVICE_WIDTH-80,44)];
    txtPassword.textAlignment = NSTextAlignmentLeft;
    txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    txtPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtPassword.keyboardType = UIKeyboardTypeEmailAddress;
    [txtPassword setDelegate:self];
    [txtPassword setPlaceholder:@"Password"];
    txtPassword.backgroundColor = [UIColor clearColor];
    txtPassword.returnKeyType=UIReturnKeyDone;
    txtPassword.secureTextEntry=YES;
    CALayer *PasswordBorder = [CALayer layer];
    PasswordBorder.frame = CGRectMake(0.0f, txtPassword.frame.size.height - 1, txtPassword.frame.size.width, 0.50f);
    PasswordBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtPassword.layer addSublayer:PasswordBorder];
    [viewLogin addSubview:txtPassword];
    
    btnSignIn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSignIn setFrame:CGRectMake(50,DEVICE_HEIGHT/2+25,DEVICE_WIDTH-100,49)];
    btnSignIn.backgroundColor=[UIColor colorWithRed:1.0/225.0 green:175.0/225.0 blue:174.0/225.0 alpha:1.0];
    btnSignIn.layer.cornerRadius=4.0;
    [btnSignIn setTitle:@"Sign in" forState:UIControlStateNormal];
    [btnSignIn addTarget:self action:@selector(btnSignInClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewLogin addSubview:btnSignIn];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         
                         viewLogin.frame=CGRectMake(0,0,DEVICE_WIDTH, DEVICE_HEIGHT);
                         
                     }
                     completion:^(BOOL finished){
                     }];
}
-(void)CloseLoginView
{
    [UIView animateWithDuration:0.2
                     animations:^{
                         
                         viewLogin.frame=CGRectMake(0,DEVICE_HEIGHT, DEVICE_WIDTH, DEVICE_HEIGHT);
                     }
                     completion:^(BOOL finished){
                         [viewLogin removeFromSuperview];
                         
                     }];
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
    
    [APP_DELEGATE drawLineDivider:textField];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [APP_DELEGATE HideLineDivider:textField];
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
    [self hideKeyboard];
    [self CloseLoginView];
}
#pragma mark - Hide keyboard
-(void)hideKeyboard
{
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
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
    
    [LoginUser synchronize];
    
    NSLog(@"CURRENT_USER_ID==========%@",CURRENT_USER_ID);
    NSLog(@"CURRENT_USER_FIRST_NAME==========%@",CURRENT_USER_FIRST_NAME);
    NSLog(@"CURRENT_USER_LAST_NAME==========%@",CURRENT_USER_LAST_NAME);
    NSLog(@"CURRENT_USER_EMAIL==========%@",CURRENT_USER_EMAIL);
    NSLog(@"CURRENT_USER_IMAGE==========%@",CURRENT_USER_IMAGE);
    NSLog(@"CURRENT_USER_ACCESS_TOKEN==========%@",CURRENT_USER_ACCESS_TOKEN);
    [APP_DELEGATE rootViewController];
}

#pragma mark - cleanup
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
