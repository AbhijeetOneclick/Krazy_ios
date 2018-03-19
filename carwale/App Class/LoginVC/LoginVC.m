//
//  LoginVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self setcontentViews];
    [self registerNotification];

    // Do any additional setup after loading the view.
}
#pragma mark - Scroll Content Frame
-(void)setcontentViews
{
    scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    scrlContent.delegate=self;
    [self.view addSubview:scrlContent];
    
    UIImageView *imgBack=[[UIImageView alloc]initWithFrame:CGRectMake(15, 31.5, 12.5, 21)];
    imgBack.image=[UIImage imageNamed:@"backblack"];
    [scrlContent addSubview:imgBack];
    
    UIButton *btnback=[UIButton buttonWithType:UIButtonTypeCustom];
    btnback.frame=CGRectMake(0,20, 50,50);
    [btnback addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnback.backgroundColor=[UIColor clearColor];
    [scrlContent addSubview:btnback];
    
    NSString *labelText = @"Email";
    int yy =0;
    yy=yy+100;
    
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(19,yy,DEVICE_WIDTH-38,48)];
    txtEmail.textAlignment = NSTextAlignmentLeft;
    txtEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    [txtEmail setDelegate:self];
    [txtEmail setPlaceholder:labelText];
    txtEmail.backgroundColor = [UIColor clearColor];
    txtEmail.returnKeyType=UIReturnKeyNext;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, txtEmail.frame.size.height - 1, txtEmail.frame.size.width, 0.50f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtEmail.layer addSublayer:bottomBorder];
    [scrlContent addSubview:txtEmail];
    
    labelText = @"Password";
    
    yy=yy+60;

    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(19,yy,DEVICE_WIDTH-38,48)];
    txtPassword.textAlignment = NSTextAlignmentLeft;
    txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    txtPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtPassword.keyboardType = UIKeyboardTypeEmailAddress;
    [txtPassword setDelegate:self];
    [txtPassword setPlaceholder:labelText];
    txtPassword.backgroundColor = [UIColor clearColor];
    txtPassword.returnKeyType=UIReturnKeyDone;
    txtPassword.secureTextEntry=YES;
    CALayer *PasswordBorder = [CALayer layer];
    PasswordBorder.frame = CGRectMake(0.0f, txtPassword.frame.size.height - 1, txtPassword.frame.size.width, 0.50f);
    PasswordBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [txtPassword.layer addSublayer:PasswordBorder];
    [scrlContent addSubview:txtPassword];
    
    yy=yy+60;
    labelText = @"Forgot password?";

    UILabel *lblForgetPassword=[[UILabel alloc]initWithFrame:CGRectMake(99, yy, DEVICE_WIDTH-99, 16)];
    lblForgetPassword.textAlignment=NSTextAlignmentCenter;
    [lblForgetPassword setText:labelText];
    [scrlContent addSubview:lblForgetPassword];
    
    btnForgotPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    btnForgotPassword.frame=CGRectMake(lblForgetPassword.frame.origin.x, lblForgetPassword.frame.origin.y-12, lblForgetPassword.frame.size.width, lblForgetPassword.frame.size.height+12);
    [btnForgotPassword addTarget:self action:@selector(btnForgotPasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnForgotPassword.layer.cornerRadius = 5.0f;
    [scrlContent addSubview:btnForgotPassword];
    
    yy=yy+40;
    labelText = @"Login";
  
    btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin setFrame:CGRectMake(30,yy,DEVICE_WIDTH-60,49)];
    btnLogin.backgroundColor=[UIColor colorWithRed:1.0/225.0 green:175.0/225.0 blue:174.0/225.0 alpha:1.0];
    btnLogin.layer.cornerRadius=4.0;
    [btnLogin setTitle:labelText forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(btnLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:btnLogin];
    [scrlContent setContentSize:CGSizeMake(DEVICE_WIDTH, yy+79)];
    if (IS_IPHONE_4)
    {
        [scrlContent setContentSize:CGSizeMake(DEVICE_WIDTH, yy+79)];
        
    }
    scrlContent.showsHorizontalScrollIndicator=NO;
    scrlContent.showsVerticalScrollIndicator=NO;
    scrlContent.scrollEnabled=YES;

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

#pragma mark - Button actions
-(void)backButtonClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
   // [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnForgotPasswordClicked:(id)sender
{
    [self hideKeyboard];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Forgot Password ?"
                                                                              message: @"lease enter your email"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Email";
        textField.textColor = [UIColor grayColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
   
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        NSLog(@"%@",namefield.text);
//        [self forgetPadsswrod:namefield.text];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)btnLoginClicked:(id)sender
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
        [self loginWebServices];
    }
}

#pragma mark - Hide keyboard
-(void)hideKeyboard
{
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
}

#pragma mark - webservice list

-(void)forgetPadsswrod:(NSString*)email
{
    [APP_DELEGATE showProcessHud];
}


-(void)loginWebServices
{
    [APP_DELEGATE showProcessHud];
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
        //[parameter_dict setObject:CURRENT_USER_ACCESS_TOKEN forKey:@"access_token"];
        // NSLog(@"printDictionary:%@",parameter_dict);
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"normalSignup";
        NSLog(@"printDictionary:%@",parameter_dict);

        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL,webServiceName] withParameters:parameter_dict andValidation:NO];
        
        // [manager postUrlCallForMultipleImage:[NSString stringWithFormat:@"%@",@"http://oneclickitmarketing.co.in/subdomain/carwale/index.php/users/normalSignup"] withParameters:parameter_dict andMediaData:ArrMediaData andDataParameterName:ArrDataParameterName andFileName:ArrFileName];
    }
}

#pragma mark Response
- (void)onResult:(NSDictionary *)result
{
    NSLog(@"Result :%@",result);
    if([[result valueForKey:@"commandName"] isEqualToString:@"userLogin"])
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
}

- (void)onError:(NSError *)error
{
    //HUD.labelText=@"";
    [APP_DELEGATE hideProcessHud];
    NSLog(@"The error is...%@", error);
}


#pragma mark - NSUserDefults 
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
        [LoginUser setValue:[result valueForKey:@"profile_photo"] forKey:@"CURRENT_USER_IMAGE"];
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
    
    [APP_DELEGATE rootViewController];
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
    
    if(IS_IPHONE_4)
    {
        scrlContent.frame = CGRectMake(0,-110, DEVICE_WIDTH, DEVICE_HEIGHT);
    }
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
    
    if (IS_IPHONE_4) {
       scrlContent.frame=CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    }
    
    [scrlContent setContentSize:CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT)];
    
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


#pragma mark - Memory Warning
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
