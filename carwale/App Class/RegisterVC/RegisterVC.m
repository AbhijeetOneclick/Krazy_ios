//
//  RegisterVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//


#import "RegisterVC.h"
#import "JVFloatLabeledTextField.h"

const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;
@interface RegisterVC ()

@end

@implementation RegisterVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    strForIdentification = @"";
        self.navigationController.navigationBar.hidden=YES;
    strIdentifyPassword = @"1";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpFrames];
}

/*#pragma mark - set up frames
-(void)setUpNavigationFrame
{
    UIView* viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    viewHeader.backgroundColor = APP_HEADER_COLOR;
    [self.view addSubview:viewHeader];
    
    UILabel * lblHeaderLine = [[UILabel alloc] initWithFrame:CGRectMake(0,viewHeader.frame.size.height-0.5, DEVICE_WIDTH, 0.5)];
    [lblHeaderLine setBackgroundColor:[UIColor whiteColor]];
    [viewHeader addSubview:lblHeaderLine];
    
    UIButton *btnback=[UIButton buttonWithType:UIButtonTypeCustom];
    btnback.frame=CGRectMake(0,20, 50,44);
    [btnback setImage:[UIImage imageNamed:@"back-blue.png"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    btnback.backgroundColor=[UIColor clearColor];
    [viewHeader addSubview:btnback];
}*/
#pragma mark - set up frames
-(void)setUpFrames
{
    stringPop = @"1";
    scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    [scrlContent setBackgroundColor:[UIColor whiteColor]];
    scrlContent.delegate = self;
    [scrlContent setShowsVerticalScrollIndicator:NO];
    if(!IS_IPHONE_X){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    scrlContent.showsHorizontalScrollIndicator=NO;
    scrlContent.clipsToBounds = YES;
    scrlContent.bounces = NO;
    scrlContent.scrollEnabled=YES;
    [self.view addSubview:scrlContent];
    
    UIView* viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    viewHeader.userInteractionEnabled=YES;
    viewHeader.clipsToBounds=YES;
    viewHeader.backgroundColor = [UIColor colorWithRed:11.0/255.0 green:57.0/255.0 blue:88/255.0 alpha:1.0];
    [scrlContent addSubview:viewHeader];
    
    int y=0;
    
    [navView removeFromSuperview];
    if(IS_IPHONE_X)
    {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,y,DEVICE_WIDTH , 88)];
    }
    else
    {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,y,DEVICE_WIDTH , 64)];
    }
    navView.backgroundColor = [UIColor colorWithRed:11.0/255.0 green:57.0/255.0 blue:88/255.0 alpha:1.0];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    if(IS_IPHONE_X)
    {
        y=y+44;
    }
    else
    {
        y=y+20;
    }
    
    
    UIButton *btnback=[UIButton buttonWithType:UIButtonTypeCustom];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]) {
        btnback = [[UIButton alloc] initWithFrame:CGRectMake(0, y, 50, 44)];
    } else {
        btnback = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-50, y, 50, 44)];
    }
    [btnback setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    btnback.backgroundColor=[UIColor clearColor];
    [navView addSubview:btnback];
    
    UILabel *lblUploadText=[[UILabel alloc]initWithFrame:CGRectMake(0,y+12, DEVICE_WIDTH, 20)];
    lblUploadText.text =[TSLanguageManager localizedString:@"Sign Up"];
    lblUploadText.font = [UIFont boldSystemFontOfSize:20];
    lblUploadText.textColor = [UIColor whiteColor];
    lblUploadText.textAlignment=NSTextAlignmentCenter;
    [navView addSubview:lblUploadText];
    
    int yy = 100;

    imgProfile  = [[AsyncImageView alloc] init];
    imgProfile.frame = CGRectMake(DEVICE_WIDTH/2-32,yy, 64,64);
    if (IS_IPHONE_6 || IS_IPHONE_5)
    {
        imgProfile.frame=CGRectMake(16,yy, 64*iPhone6,64*iPhone6);
    }else 
    {
        imgProfile.frame=CGRectMake(16,yy, 64*iPhone6Plus,64*iPhone6Plus);
    }
    imgProfile.backgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
    imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2;
    imgProfile.image = [UIImage imageNamed:@"signup-user"];
    imgProfile.layer.masksToBounds = YES;
    imgProfile.userInteractionEnabled = YES;
    [imgProfile setContentMode:UIViewContentModeScaleAspectFill];
    [viewHeader addSubview:imgProfile];

    btnTakePhoto=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTakePhoto.frame=CGRectMake(0,0, imgProfile.frame.size.width, imgProfile.frame.size.height);
    /*if(IS_IPAD){
        [btnTakePhoto addTarget:self action:@selector(EditPhotoIPADClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{*/
    [btnTakePhoto addTarget:self action:@selector(EditPhotoClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imgProfile addSubview:btnTakePhoto];

    viewNew =[[UIView alloc] init];
    viewNew.backgroundColor = [UIColor whiteColor];
    [scrlContent addSubview:viewNew];

    lblinfo=[[UILabel alloc]init];
    lblinfo.textColor =[UIColor grayColor];
    lblinfo.text = [TSLanguageManager localizedString:@"Basic Information"];
    lblinfo.textAlignment = NSTextAlignmentCenter;
    lblinfo.font =[UIFont boldSystemFontOfSize:16.0];
    lblinfo.textColor = APP_BUTTON_COLOR;
    [viewNew addSubview:lblinfo];

    viewForFirstName =[[UIView alloc] init];
    viewForFirstName.userInteractionEnabled = YES;
    [viewForFirstName setBackgroundColor:[UIColor clearColor]];
    [scrlContent addSubview:viewForFirstName];
 
    
    txtFirstname = [[JVFloatLabeledTextField alloc] init];
    txtFirstname.frame = CGRectMake(10, 10,viewForFirstName.frame.size.width -20, viewForFirstName.frame.size.height-20);
    txtFirstname.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    [txtFirstname setPlaceholder:[TSLanguageManager localizedString:@"First Name"]];
     if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
     {
         txtFirstname.textAlignment = NSTextAlignmentLeft;
     }else {
         txtFirstname.textAlignment = NSTextAlignmentRight;
     }
    txtFirstname.placeholderColor = [UIColor lightGrayColor];
    txtFirstname.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtFirstname.keyboardType = UIKeyboardTypeDefault;
    txtFirstname.returnKeyType = UIReturnKeyNext;
    txtFirstname.autocorrectionType = UITextAutocorrectionTypeNo;
    txtFirstname.floatingLabelTextColor = APP_BUTTON_COLOR;
    txtFirstname.backgroundColor = [UIColor clearColor];
    txtFirstname.delegate = self;
    [viewForFirstName addSubview:txtFirstname];
    
 
    caFirstName = [CALayer layer];
    caFirstName.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtFirstname.layer addSublayer:caFirstName];

    viewForLastName = [[UIView alloc] init];
    viewForLastName.backgroundColor = [UIColor clearColor];
    [scrlContent addSubview:viewForLastName];
    
    txtLastname = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    [txtLastname setPlaceholder:[TSLanguageManager localizedString:@"Last Name"]];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtLastname.textAlignment = NSTextAlignmentLeft;
    }else {
        txtLastname.textAlignment = NSTextAlignmentRight;
    }
    txtFirstname.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtLastname.autocorrectionType = UITextAutocorrectionTypeNo;
    txtLastname.keyboardType = UIKeyboardTypeDefault;
    txtLastname.returnKeyType = UIReturnKeyNext;
    txtLastname.floatingLabelTextColor = APP_BUTTON_COLOR;
    [viewForLastName addSubview:txtLastname];
    txtLastname.backgroundColor = [UIColor clearColor];
    [txtLastname setDelegate:self];
    
    caLastName = [CALayer layer];
    caLastName.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtLastname.layer addSublayer:caLastName];

    viewForEmail = [[UIView alloc] init];
    viewForEmail.backgroundColor = [UIColor clearColor];
    [scrlContent addSubview:viewForEmail];

    txtEmail = [[JVFloatLabeledTextField alloc] init];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtEmail.textAlignment = NSTextAlignmentLeft;
    }else {
        txtEmail.textAlignment = NSTextAlignmentRight;
    }
    txtEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    [txtEmail setDelegate:self];
    txtEmail.backgroundColor = [UIColor clearColor];
    [txtEmail setPlaceholder:[TSLanguageManager localizedString:@"E-mail"]];
    txtEmail.returnKeyType = UIReturnKeyNext;
    [viewForEmail addSubview:txtEmail];
    
    caEmail = [CALayer layer];
    caEmail.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtEmail.layer addSublayer:caEmail];

    viewForMobileNumber = [[UIView alloc] init];
    viewForMobileNumber.backgroundColor = [UIColor clearColor];
    [scrlContent addSubview:viewForMobileNumber];

    txtMobileNumber = [[JVFloatLabeledTextField alloc] init];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtMobileNumber.textAlignment = NSTextAlignmentLeft;
    }else {
        txtMobileNumber.textAlignment = NSTextAlignmentRight;
    }
    txtMobileNumber.autocorrectionType = UITextAutocorrectionTypeNo;
    txtMobileNumber.keyboardType = UIKeyboardTypePhonePad;
    [txtMobileNumber setDelegate:self];
    txtMobileNumber.backgroundColor = [UIColor clearColor];
    [txtMobileNumber setPlaceholder:[TSLanguageManager localizedString:@"Mobile Number"]];
    txtMobileNumber.returnKeyType = UIReturnKeyNext;
    [viewForMobileNumber addSubview:txtMobileNumber];

    caNumber = [CALayer layer];
    caNumber.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtMobileNumber.layer addSublayer:caNumber];

    viewForPassword = [[UIView alloc] init];
    viewForPassword.backgroundColor = [UIColor clearColor];
    [scrlContent addSubview:viewForPassword];

    txtPassword = [[JVFloatLabeledTextField alloc] init];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtPassword.textAlignment = NSTextAlignmentLeft;
    }else {
        txtPassword.textAlignment = NSTextAlignmentRight;
    }
    txtPassword.secureTextEntry = YES;
    txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    txtPassword.keyboardType = UIKeyboardTypeDefault;
    [txtPassword setDelegate:self];
    txtPassword.backgroundColor = [UIColor clearColor];
    [txtPassword setPlaceholder:[TSLanguageManager localizedString:@"Password"]];
    txtPassword.returnKeyType = UIReturnKeyNext;
    [viewForPassword addSubview:txtPassword];

    caPassword = [CALayer layer];
    caPassword.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtPassword.layer addSublayer:caPassword];

    viewForConfirmPassword = [[UIView alloc] init];
    viewForConfirmPassword.backgroundColor = [UIColor clearColor];
    [scrlContent addSubview:viewForConfirmPassword];

    txtConfirmPassword = [[JVFloatLabeledTextField alloc] init];
    txtConfirmPassword.secureTextEntry = YES;
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtConfirmPassword.textAlignment = NSTextAlignmentLeft;
    }else {
        txtConfirmPassword.textAlignment = NSTextAlignmentRight;
    }
    txtConfirmPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    txtConfirmPassword.keyboardType = UIKeyboardTypeDefault;
    [txtConfirmPassword setDelegate:self];
    txtConfirmPassword.backgroundColor = [UIColor clearColor];
    [txtConfirmPassword setPlaceholder:[TSLanguageManager localizedString:@"Confirm Password"]];
    txtConfirmPassword.returnKeyType = UIReturnKeyNext;
    [viewForConfirmPassword addSubview:txtConfirmPassword];
    
    caCnPassword = [CALayer layer];
    caCnPassword.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtConfirmPassword.layer addSublayer:caCnPassword];
    
    btnRegister = [[UIButton alloc] init];
    btnRegister =[UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.backgroundColor = APP_BUTTON_COLOR;
        [btnRegister setTitle:[TSLanguageManager localizedString:@"Sign Up"] forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(btnRegisterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:btnRegister];

    orLBL = [[UILabel alloc] init];
    orLBL.text = [TSLanguageManager localizedString:@"or"];
    orLBL.font = [UIFont boldSystemFontOfSize:14];
    orLBL.textColor = APP_BUTTON_COLOR;
    orLBL.textAlignment=NSTextAlignmentCenter;
    [scrlContent addSubview:orLBL];

    viewBack = [[UIView alloc] init];
    viewBack.backgroundColor = [UIColor whiteColor];
    [scrlContent addSubview:viewBack];

    lblLogin = [[UILabel alloc] init];
    lblLogin.userInteractionEnabled = YES;
    lblLogin.font =[UIFont boldSystemFontOfSize:14.0];
    lblLogin.textAlignment=NSTextAlignmentCenter;
    [viewBack addSubview:lblLogin];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[TSLanguageManager localizedString:@"Already have account Login here"]];
    [string setColorForText:[TSLanguageManager localizedString:@"Already have account"] withColor:[UIColor grayColor]];
    [string setColorForText:[TSLanguageManager localizedString:@"Login"] withColor:[UIColor colorWithRed:0.0/255.0 green:114.0/255.0 blue:180.0/255.0 alpha:1]];
    [string setColorForText:[TSLanguageManager localizedString:@"here"] withColor:[UIColor grayColor]];
    lblLogin.attributedText = string;
    
    btnLogin = [[UIButton alloc] init];
    btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewBack addSubview:btnLogin];
    [self setFrame];
}
#pragma mark - set frame
-(void)setFrame
{
    int y = 200;
    
    if (IS_IPHONE_6)
    {
        y=200*iPhone6;
    }
    else if (IS_IPHONE_6plus)
    {
        y=200*iPhone6Plus;
    }else {
        y=200*1.29;
    }

    if(IS_IPAD)
    {
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
        [viewNew setFrame:CGRectMake(0, y, DEVICE_WIDTH, 22)];
        y=y+65;
        [viewForFirstName setFrame:CGRectMake(0, y, DEVICE_WIDTH/2, 52)];
        [viewForLastName setFrame:CGRectMake(DEVICE_WIDTH/2, y, DEVICE_WIDTH/2, 52)];
        y = y + 52 + 28;
        [viewForEmail setFrame:CGRectMake(0, y, DEVICE_WIDTH/2, 52)];
        [viewForMobileNumber setFrame:CGRectMake(DEVICE_WIDTH/2, y, DEVICE_WIDTH/2, 52)];
        y = y + 52 + 28;
        [viewForPassword setFrame:CGRectMake(0, y, DEVICE_WIDTH/2, 52)];
        [viewForConfirmPassword setFrame:CGRectMake(DEVICE_WIDTH/2, y, DEVICE_WIDTH/2, 52)];
        y = y + 52 + 28;
        [btnRegister setFrame:CGRectMake(63,y,DEVICE_WIDTH-129, 50)];
        y = y+20+50;
        [orLBL setFrame:CGRectMake(20, y,DEVICE_WIDTH-40 ,14)];
        y = y+20;
        [viewBack setFrame:CGRectMake(50, y, DEVICE_WIDTH-100, 50)];
        }else
        {
            [viewNew setFrame:CGRectMake(0, y, DEVICE_WIDTH, 22)];
            y=y+65;
            [viewForLastName setFrame:CGRectMake(0, y, DEVICE_WIDTH/2, 52)];
            [viewForFirstName setFrame:CGRectMake(DEVICE_WIDTH/2, y, DEVICE_WIDTH/2, 52)];
            y = y + 52 + 28;
            [viewForMobileNumber setFrame:CGRectMake(0, y, DEVICE_WIDTH/2, 52)];
            [viewForEmail setFrame:CGRectMake(DEVICE_WIDTH/2, y, DEVICE_WIDTH/2, 52)];
            y = y + 52 + 28;
            [viewForConfirmPassword setFrame:CGRectMake(0, y, DEVICE_WIDTH/2, 52)];
            [viewForPassword setFrame:CGRectMake(DEVICE_WIDTH/2, y, DEVICE_WIDTH/2, 52)];
            y = y + 52 + 28;
            [btnRegister setFrame:CGRectMake(63,y,DEVICE_WIDTH-129, 50)];
            y = y+20+50;
            [orLBL setFrame:CGRectMake(20, y,DEVICE_WIDTH-40 ,14)];
            y = y+20;
            [viewBack setFrame:CGRectMake(50, y, DEVICE_WIDTH-100, 50)];
        }
        
    }else{
        [viewNew setFrame:CGRectMake(0, y, DEVICE_WIDTH, 22)];
        y=y+47;
        [viewForFirstName setFrame:CGRectMake(0, y, DEVICE_WIDTH, 40)];
        y=y+65;
        [viewForLastName setFrame:CGRectMake(0, y, DEVICE_WIDTH, 40)];
        y=y+65;
        [viewForEmail setFrame:CGRectMake(0, y, DEVICE_WIDTH, 40)];
        y=y+65;
        [viewForMobileNumber setFrame:CGRectMake(0, y, DEVICE_WIDTH, 40)];
        y=y+65;
        [viewForPassword setFrame:CGRectMake(0, y, DEVICE_WIDTH, 40)];
        y=y+65;
        [viewForConfirmPassword setFrame:CGRectMake(0, y, DEVICE_WIDTH, 40)];
        y = y + 66;
        [btnRegister setFrame:CGRectMake((DEVICE_WIDTH/2)-74.5,y,149 , 50)];
        y = y+17+50;
        [orLBL setFrame:CGRectMake(20, y,DEVICE_WIDTH-40 ,14)];
        y = y+20;
        [viewBack setFrame:CGRectMake(50, y, DEVICE_WIDTH-100, 50)];
    }
        [lblinfo setFrame:CGRectMake(30,0,viewNew.frame.size.width-30,30)];
        [txtFirstname setFrame:CGRectMake(30,0,viewForFirstName.frame.size.width-60, viewForFirstName.frame.size.height)];
         [caFirstName setFrame:CGRectMake(0.0f, txtFirstname.frame.size.height - 1, txtFirstname.frame.size.width, 0.50f)];
        [txtLastname setFrame:CGRectMake(30,0,viewForLastName.frame.size.width-60, viewForLastName.frame.size.height)];
        [caLastName setFrame:CGRectMake(0.0f, txtLastname.frame.size.height - 1, txtLastname.frame.size.width, 0.50f)];
        [txtEmail setFrame:CGRectMake(30,0,viewForEmail.frame.size.width-60, viewForEmail.frame.size.height)];
          [caEmail setFrame:CGRectMake(0.0f, txtEmail.frame.size.height - 1, txtEmail.frame.size.width, 0.50f)];
        [txtMobileNumber setFrame:CGRectMake(30, 0,viewForMobileNumber.frame.size.width-60, viewForMobileNumber.frame.size.height)];
        [caNumber setFrame:CGRectMake(0.0f, txtMobileNumber.frame.size.height - 1, txtMobileNumber.frame.size.width, 0.50f)];
        [txtPassword setFrame:CGRectMake(30,0,viewForPassword.frame.size.width-60, viewForPassword.frame.size.height)];
        [caPassword setFrame:CGRectMake(0.0f, txtPassword.frame.size.height - 1, txtPassword.frame.size.width, 0.50f)];
        [txtConfirmPassword setFrame:CGRectMake(30,0,viewForConfirmPassword.frame.size.width-60, viewForConfirmPassword.frame.size.height)];
        [caCnPassword setFrame:CGRectMake(0.0f, txtConfirmPassword.frame.size.height - 1, txtConfirmPassword.frame.size.width, 0.50f)];
        [lblLogin setFrame:CGRectMake(0,0, viewBack.frame.size.width,30)];
        [btnLogin setFrame:CGRectMake(viewBack.frame.size.width/2-40,0,100,44)];
        [btnLogin addTarget:self action:@selector(btnLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
        //btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrlContent setContentSize:CGSizeMake(DEVICE_WIDTH, y+80)];
    
}

#pragma mark - Buttons Clicks

-(void)btnSelectBuyerClicked:(id)sender
{
    imgForSelectbuyer.backgroundColor = [APP_DELEGATE colorWithHexString:AppHeaderColor];
    lblForSelectBuyer.textColor = [APP_DELEGATE colorWithHexString:AppHeaderColor];
    imgForSelectDealer.backgroundColor = [UIColor whiteColor];
    lblForSelectDealer.textColor = [UIColor darkGrayColor];
    strForIdentification = @"2";  //1 for dealer and 2 for buyer for identification//
}

-(void)btnRegisterClicked:(id)sender
{
    [self hideKeyboard];
    if([txtFirstname.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter your first name" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if([txtLastname.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter your last name" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if([txtEmail.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter your email address" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if(![APP_DELEGATE validateEmail:txtEmail.text])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter valid email address" cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if([txtMobileNumber.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter your mobile number." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if(![self validatePhone:txtMobileNumber.text])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter valid mobile number." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    
    else if([txtPassword.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter your password." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if([txtConfirmPassword.text isEqualToString:@""])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please confirm password." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
    else if(![txtConfirmPassword.text isEqualToString:txtPassword.text])
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Password and confirm password should be same." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithCompletionBlock:^{
            }];
        }];
        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    }
//      else if([strForIdentification isEqualToString:@""])
//    {
//        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please select your user type." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
//        
//        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
//        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
//            [alertView hideWithCompletionBlock:^{
//            }];
//        }];
//        [alertView showWithAnimation:URBAlertAnimationTopToBottom];
//    }
      else{
          [self normalSignup];
      }
}

-(void)btnSelectDealerClicked:(id)sender
{
   /* imgForSelectDealer.backgroundColor = [APP_DELEGATE colorWithHexString:AppHeaderColor];
    lblForSelectDealer.textColor = [APP_DELEGATE colorWithHexString:AppHeaderColor];
    imgForSelectbuyer.backgroundColor = [UIColor whiteColor];
    lblForSelectBuyer.textColor = [UIColor darkGrayColor];
    strForIdentification = @"1";  //1 for dealer and 2 for buyer for identification//*/
}

-(void)EditPhotoClick:(id)sender
{
    [self hideKeyboard];
    imagePickerType= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:ALERT_CANCEL destructiveButtonTitle:nil otherButtonTitles: ACTION_TAKE_PHOTO ,ACTION_LIBRARY_PHOTO, nil];
    [imagePickerType  showInView:self.view];
}
-(void)EditPhotoIPADClick:(id)sender{
    UIImagePickerController *imagePicker;
    CGRect sourceRect = CGRectMake(self.view.frame.size.width/2-200, self.view.frame.size.height/2 - 300, 400, 400);
    
    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:imagePicker animated:YES completion:nil];
    imagePicker.popoverPresentationController.sourceRect = self.view.frame;
    imagePicker.popoverPresentationController.sourceView = self.view;
    
}

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}

-(void)btnDoneClicked:(id)sender
{
    [txtMobileNumber resignFirstResponder];
    [txtPassword becomeFirstResponder];
}

-(void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*#pragma mark - UIActionsheet Delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imagePicker;
    imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ALERT_CANCEL])
        return;
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ACTION_TAKE_PHOTO])
    {
     
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    
        else
        {
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;

            if(IS_IPAD)
            {
                self.pop=[[UIPopoverController alloc] initWithContentViewController:imagePicker];
                [self.pop presentPopoverFromRect:CGRectMake(300, 750, 100, 100)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }else{
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ACTION_LIBRARY_PHOTO])
    {
        if (self.pop)
        {
            [self.pop dismissPopoverAnimated:YES];
            
        }
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES; //if you want to edit the image
        
        self.pop=[[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [self.pop presentPopoverFromRect:CGRectMake(300, 750, 100, 100)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
}

-(void) actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
  
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    /*if(image != nil)
    {
        imgProfile.image= image;
        [imgProfile setContentMode:UIViewContentModeScaleAspectFill];
    }
    if(IS_IPAD)
    {
        [picker dismissViewControllerAnimated:YES completion:^{
              [imgePickerIPAD dismissPopoverAnimated:YES];
        }];
     
    }else
    {
        [picker dismissViewControllerAnimated:YES completion:^{
             [picker dismissViewControllerAnimated:YES completion:nil];
        }];
      
    }
    imgProfile.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     [picker dismissViewControllerAnimated:YES completion:nil];
}*/
#pragma mark - UIActionsheet Delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ALERT_CANCEL])
            return;
        
        UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
        imagePicker.delegate    =self;
        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ACTION_TAKE_PHOTO])
        {
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                [self presentModalViewController:imagePicker animated:YES];
            }
            else
            {
                imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                if (IS_IPAD) {
                    self.pop = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                    [self.pop  presentPopoverFromRect:CGRectMake(10, 100, 500, 500) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                }else{
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
                //                [self presentModalViewController:imagePicker animated:YES];
            }
        }else if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ACTION_LIBRARY_PHOTO]){
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            //        if (IS_IPAD) {
            //            popVC = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            //            [popVC presentPopoverFromRect:adsphotoImg.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            //        }else
            //            [self presentModalViewController:imagePicker animated:YES];
            
            if (IS_IPAD) {
                self.pop = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                [self.pop presentPopoverFromRect:CGRectMake(84, -400, 600, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            }else{
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
    
}

-(void) actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}

#pragma mark - Image Picker Controller Delegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    if(image == nil)
    {
        
    }
    else
    {
        //        isProfileImageChanged = YES;
        imgProfile.image= image;
        [imgProfile setContentMode:UIViewContentModeScaleAspectFill];
        imgProfile.clipsToBounds = YES;
        //        [profileImg     setImage:image];
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2;
        imgProfile.layer.masksToBounds = YES;
        
        //isEditImage=YES;
        //    if (IS_IPAD && popVC) {
        //        [popVC dismissPopoverAnimated:YES];
        //        popVC=nil;
        //    }else
        
        //v dataForImage =  UIImagePNGRepresentation(profileImg.image);
    }
    if (IS_IPAD) {
        [self.pop dismissPopoverAnimated:YES];
    }else{
        [picker dismissModalViewControllerAnimated:YES];
    }
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - hide keyboard
-(void)hideKeyboard
{
    [txtFirstname resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtConfirmPassword resignFirstResponder];
    [txtMobileNumber resignFirstResponder];
    [scrlContent setContentOffset:CGPointMake(0, 0)animated:YES];
}

#pragma mark TextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    if(IS_IPAD){
        
    }else{
        
            if(textField == txtLastname)
            {
                if(IS_IPHONE_4)
                {
                    [scrlContent setContentOffset:CGPointMake(0,60)animated:YES];
                }
            }
            else if (textField==txtMobileNumber)
            {
                UIView *tool=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
                tool.userInteractionEnabled=YES;
                tool.backgroundColor = APP_HEADER_COLOR;
                UIButton *btnDone=[UIButton buttonWithType:UIButtonTypeCustom];
                [btnDone setFrame:CGRectMake(DEVICE_WIDTH-60, 0, 50, 40)];
                [btnDone setTitle:@"Done" forState:UIControlStateNormal];
                [btnDone setBackgroundColor:APP_HEADER_COLOR];
                [btnDone addTarget:self action:@selector(btnDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
                [tool addSubview:btnDone];
                txtMobileNumber.inputAccessoryView=tool;
                if (IS_IPHONE_6 || IS_IPHONE_X)
                {
                    [scrlContent setContentOffset:CGPointMake(0,textField.frame.origin.y+120)animated:YES];
                }
                else if (IS_IPHONE_6plus)
                {
                    [scrlContent setContentOffset:CGPointMake(0,textField.frame.origin.y+80)animated:YES];
                }
                else if(IS_IPHONE_5)
                {
                    [scrlContent setContentOffset:CGPointMake(0,80)animated:YES];
                }
                else if(IS_IPHONE_4)
                {
                    [scrlContent setContentOffset:CGPointMake(0,150)animated:YES];
                }
                
            }
            else if(textField==txtPassword)
            {
                if (IS_IPHONE_6 || IS_IPHONE_X)
                {
                    [scrlContent setContentOffset:CGPointMake(0,textField.frame.origin.y+160)animated:YES];
                }
                else if (IS_IPHONE_6plus)
                {
                    [scrlContent setContentOffset:CGPointMake(0,textField.frame.origin.y+120)animated:YES];
                }
                else if(IS_IPHONE_5)
                {
                    [scrlContent setContentOffset:CGPointMake(0,150)animated:YES];
                }
                else if(IS_IPHONE_4)
                {
                    [scrlContent setContentOffset:CGPointMake(0,200)animated:YES];
                }
            }
            else if(textField==txtConfirmPassword)
            {
                if(IS_IPHONE_5)
                {
                    [scrlContent setContentOffset:CGPointMake(0,200)animated:YES];
                }
                else if (IS_IPHONE_6 || IS_IPHONE_X)
                {
                    [scrlContent setContentOffset:CGPointMake(0,textField.frame.origin.y+210)animated:YES];
                }
                else if (IS_IPHONE_6plus)
                {
                    [scrlContent setContentOffset:CGPointMake(0,textField.frame.origin.y+160)animated:YES];
                }
                else if(IS_IPHONE_4)
                {
                    [scrlContent setContentOffset:CGPointMake(0,260)animated:YES];
                }
                
                textField.inputAccessoryView = nil;
            }
        
    }
   
     if (textField == txtEmailpop)
    {
        lblFirstLine.frame=CGRectMake(0,txtEmailpop.frame.size.height-3,txtEmailpop.frame.size.width ,3);
        lblFirstLine.backgroundColor = APP_BUTTON_COLOR;
        lblSecondLine.frame=CGRectMake(0,txtPasswordpop.frame.size.height-3,txtPasswordpop.frame.size.width ,1);
        lblSecondLine.backgroundColor =[UIColor grayColor] ;
    }else{
        lblSecondLine.frame=CGRectMake(0,txtPasswordpop.frame.size.height-3,txtPasswordpop.frame.size.width ,3);
        lblSecondLine.backgroundColor = APP_BUTTON_COLOR;
        lblFirstLine.frame=CGRectMake(0,txtEmailpop.frame.size.height-3,txtEmailpop.frame.size.width ,1);
        lblFirstLine.backgroundColor = [UIColor grayColor];
    }
     [APP_DELEGATE drawLineDivider:textField];
      return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([stringPop isEqualToString:@"1"])
    {
        [APP_DELEGATE HideLineDivider:textField];
    }else{
      return YES;
    }
    return YES;
}
#pragma mark TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtMobileNumber)
    {
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int length = [currentString length];
        if (length > 13)
        {
            return NO;
        }
        return YES;
    }
    else
    {
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtFirstname)
    {
        [txtLastname becomeFirstResponder];
    }
    else if (textField==txtLastname)
    {
        [txtEmail becomeFirstResponder];
    }
    else if (textField == txtEmail)
    {
        [txtMobileNumber becomeFirstResponder];
    }
    else if (textField == txtPassword)
    {
        [txtConfirmPassword becomeFirstResponder];
    }
    else if (textField == txtConfirmPassword)
    {
        [txtConfirmPassword resignFirstResponder];
        [scrlContent setContentOffset:CGPointMake(0,0)animated:YES];
    }
    return YES;
}

#pragma mark - Login methods
-(void)openCoreDeviceView
{
    ViewPopupBackView = [[UIView alloc]initWithFrame:CGRectMake(0,0,DEVICE_WIDTH, DEVICE_HEIGHT)];
    ViewPopupBackView.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0.7];
    ViewPopupBackView.alpha = 0;
    
    [[UIApplication sharedApplication].keyWindow addSubview:ViewPopupBackView];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        ViewPopupBackView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            ViewPopupBackView.alpha = 1;
            
        } completion:nil];
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [ViewPopupBackView addGestureRecognizer:tap];
    
    if(IS_IPAD)
    {
        viewLoginBorder = [[UIView alloc] initWithFrame:CGRectMake(134, DEVICE_HEIGHT/2-135, DEVICE_WIDTH-268, 270)];
    }else
    {
        viewLoginBorder = [[UIView alloc] initWithFrame:CGRectMake(14, DEVICE_HEIGHT/2-135, DEVICE_WIDTH-28, 270)];
        
    }
    viewLoginBorder.backgroundColor = [UIColor whiteColor];
    viewLoginBorder.alpha = 0;
    [ViewPopupBackView addSubview:viewLoginBorder];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [viewLoginBorder addGestureRecognizer:tap1];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        viewLoginBorder.alpha = 0;
        // ViewPopup.transform = CGAffineTransformMakeTranslation(0,DEVICE_HEIGHT+20);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            viewLoginBorder.alpha = 1;
            //ViewPopup.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    }];
    
    if(IS_IPAD)
    {
        txtEmailpop = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(65,40,viewLoginBorder.frame.size.width-130,46)];
    }else{
        txtEmailpop = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(24,40,viewLoginBorder.frame.size.width-48,46)];
    }
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtEmailpop.textAlignment = NSTextAlignmentLeft;
    }else{
        txtEmailpop.textAlignment = NSTextAlignmentRight;
    }
    txtEmailpop.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    [txtEmailpop setPlaceholder:[TSLanguageManager localizedString:@"Email"]];
    txtEmailpop.placeholderColor = APP_BUTTON_COLOR;
    txtEmailpop.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtEmailpop.keyboardType = UIKeyboardTypeEmailAddress;
    txtEmailpop.floatingLabelTextColor = APP_BUTTON_COLOR;
    [viewLoginBorder addSubview:txtEmailpop];
    txtEmailpop.translatesAutoresizingMaskIntoConstraints = NO;
    txtEmailpop.backgroundColor=[UIColor clearColor];
    txtEmailpop.delegate = self;
    
    lblFirstLine = [[UILabel alloc] initWithFrame:CGRectMake(0,txtEmailpop.frame.size.height-1,txtEmailpop.frame.size.width, 1)];
    [lblFirstLine setBackgroundColor:[UIColor lightGrayColor]];
    [txtEmailpop addSubview:lblFirstLine];
    
    if(IS_IPAD)
    {
        txtPasswordpop = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(65,90,viewLoginBorder.frame.size.width-130,46)];
    }else{
        txtPasswordpop = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(24,90,viewLoginBorder.frame.size.width-48,46)];
    }
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        txtPasswordpop.textAlignment = NSTextAlignmentLeft;
    }else{
        txtPasswordpop.textAlignment = NSTextAlignmentRight;
    }
    txtPasswordpop.autocorrectionType = UITextAutocorrectionTypeNo;
    txtPasswordpop.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtPasswordpop.keyboardType = UIKeyboardTypeEmailAddress;
    txtPasswordpop.placeholderColor = APP_BUTTON_COLOR;
    txtPasswordpop.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    [txtPasswordpop setPlaceholder:[TSLanguageManager localizedString:@"Password"]];
    txtPasswordpop.returnKeyType=UIReturnKeyDone;
    txtPasswordpop.secureTextEntry=YES;
    txtPasswordpop.floatingLabelTextColor = APP_BUTTON_COLOR;
    [viewLoginBorder addSubview:txtPasswordpop];
    txtPasswordpop.translatesAutoresizingMaskIntoConstraints = NO;
    txtPasswordpop.backgroundColor=[UIColor clearColor];
    txtPasswordpop.delegate = self;
    
    lblSecondLine = [[UILabel alloc] initWithFrame:CGRectMake(0,txtPasswordpop.frame.size.height-1,txtPasswordpop.frame.size.width, 1)];
    [lblSecondLine setBackgroundColor:[UIColor lightGrayColor]];
    lblSecondLine.alpha = 0.5;
    [txtPasswordpop addSubview:lblSecondLine];
    
    btnShowPassword =[UIButton buttonWithType:UIButtonTypeCustom];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        if(IS_IPAD){btnShowPassword.frame=CGRectMake(viewLoginBorder.frame.size.width-65-46,90,46 ,46);}
        else{btnShowPassword.frame=CGRectMake(viewLoginBorder.frame.size.width-65,90,46 ,46);}
    }
    else{
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
    
}
-(void)CloseLoginView
{
    [ViewPopupBackView endEditing:YES];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        viewLoginBorder.alpha = 1;
        viewLoginBorder.transform = CGAffineTransformMakeTranslation(0,0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            viewLoginBorder.transform = CGAffineTransformMakeTranslation(0,DEVICE_HEIGHT-100);
        } completion:^(BOOL finished)
         {
             ViewPopupBackView.hidden = YES;
         }];
    }];
}

-(void)btnShowPasswordClicked:(id)sender
{
    if([strIdentifyPassword isEqualToString:@"1"])//1 == password will be secure text 2== password without secure text;
    {
        [btnShowPassword setImage:[UIImage imageNamed:@"visibility.png"] forState:UIControlStateNormal];
        txtPasswordpop.secureTextEntry = NO;
        NSString *currentText = txtPassword.text;
        txtPasswordpop.text = @"";
        txtPasswordpop.text = currentText;
        strIdentifyPassword = @"2";
        txtPasswordpop.font = [UIFont systemFontOfSize:16];
    }
    else if([strIdentifyPassword isEqualToString:@"2"])//1 == password will be secure text 2== password without secure text;
    {
        [btnShowPassword setImage:[UIImage imageNamed:@"visibility_hide"] forState:UIControlStateNormal];
        txtPasswordpop.secureTextEntry = YES;
        txtPasswordpop.font =[UIFont systemFontOfSize:16];
        strIdentifyPassword = @"1";
        txtPasswordpop.font = [UIFont systemFontOfSize:16];
    }
}

#pragma mark  - Button actions
-(void)btnLoginClicked:(id)sender
{
    stringPop = @"2";
    [self openCoreDeviceView];
}
-(void)btnSignInClicked:(id)sender
{
    
}
-(void)hideView
{
    stringPop = @"1";
    [self hideKeyboard];
    [self CloseLoginView];
}


#pragma mark - web services
-(void)normalSignup
{
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        [APP_DELEGATE showProcessHud];
        NSString * webServiceName = @"normalSignup";
        NSLog(@"There IS internet connection");
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
        [parameter_dict setObject:txtFirstname.text forKey:@"user_firstname"];
        [parameter_dict setObject:txtLastname.text forKey:@"user_lastname"];
        [parameter_dict setObject:txtEmail.text forKey:@"email_id"];
        [parameter_dict setObject:txtPassword.text forKey:@"password"];
        [parameter_dict setObject:txtConfirmPassword.text forKey:@"confirmPassword"];
        [parameter_dict setObject:@"1" forKey:@"register_via"];
      [parameter_dict setObject:txtMobileNumber.text forKey:@"phone_no"];
        //[parameter_dict setObject:@"0" forKey:@"device_type"];
        NSData* data ;
        if (imgProfile.image==nil)
        {
            data = UIImageJPEGRepresentation([UIImage imageNamed:@"icon_fav_filled"], 0.2f);
        }
        else
        {
            data = UIImageJPEGRepresentation(imgProfile.image, 0.2f);
        }
        
        //[parameter_dict setObject:CURRENT_USER_ACCESS_TOKEN forKey:@"access_token"];
       // NSLog(@"printDictionary:%@",parameter_dict);
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"normalSignup";
        NSMutableArray *ArrMediaData =[[NSMutableArray alloc]init];
        NSMutableArray *ArrDataParameterName =[[NSMutableArray alloc]init];
        NSMutableArray *ArrFileName =[[NSMutableArray alloc]init];
        [ArrDataParameterName addObject:@"user_image"];
        int rendID = arc4random()%9000+1000;
        NSString * imgID = [NSString stringWithFormat:@"images%d.jpg",rendID];
        [ArrFileName addObject:imgID];
        [ArrMediaData addObject:data];
        NSLog(@"printDictionary:%@",parameter_dict);
        
        [manager postUrlCallForMultipleImage:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL,webServiceName] withParameters:parameter_dict andMediaData:ArrMediaData andDataParameterName:ArrDataParameterName andFileName:ArrFileName];
    }
}


#pragma mark - UrlManager Delegate
- (void)onResult:(NSDictionary *)result
{
     [APP_DELEGATE hideProcessHud];
    NSLog(@"Result :%@",result);
    if([[result valueForKey:@"commandName"] isEqualToString:@"normalSignup"])
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
                    [alertView removeFromSuperview];
                }];
            }];
            [alertView showWithAnimation:URBAlertAnimationTopToBottom];
        }
    }
}

- (void)onError:(NSError *)error
{
     [APP_DELEGATE hideProcessHud];
    NSLog(@"The error is...%@", error);
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
    
      if ([result valueForKey:@"profile_photo"]!=[NSNull null] && ![[result valueForKey:@"profile_photo"] isEqualToString:@""])
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
    
    if ([result valueForKey:@"phone_no"]!=[NSNull null] && ![[result valueForKey:@"phone_no"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"phone_no"] forKey:@"CURRENT_USER_PHONE_NUMBER"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_PHONE_NUMBER"];
    }
    
    if ([result valueForKey:@"access_token"]!=[NSNull null] && ![[result valueForKey:@"access_token"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"access_token"] forKey:@"CURRENT_USER_ACCESS_TOKEN"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_USER_ACCESS_TOKEN"];
    }
    
    NSLog(@"CURRENT_USER_ID==========%@",CURRENT_USER_ID);
    NSLog(@"CURRENT_USER_FIRST_NAME==========%@",CURRENT_USER_FIRST_NAME);
    NSLog(@"CURRENT_USER_LAST_NAME==========%@",CURRENT_USER_LAST_NAME);
    NSLog(@"CURRENT_USER_EMAIL==========%@",CURRENT_USER_EMAIL);
    NSLog(@"CURRENT_USER_IMAGE==========%@",CURRENT_USER_IMAGE);
    NSLog(@"CURRENT_USER_ACCESS_TOKEN==========%@",CURRENT_USER_ACCESS_TOKEN);
[LoginUser removeObjectForKey:@"CURRENT_USER_SKIPBUTTON_CLICKED"];
    [APP_DELEGATE rootViewController];
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
