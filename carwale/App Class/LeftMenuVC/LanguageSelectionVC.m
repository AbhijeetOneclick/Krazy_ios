//
//  LanguageSelectionVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 25/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "LanguageSelectionVC.h"
#import "TSLanguageManager.h"
#import "NewHomeVC.h"
#import "NewAppInfoVC.h"

@interface LanguageSelectionVC ()

@end

@implementation LanguageSelectionVC
@synthesize strComeFromSettings;


-(instancetype)init
{
    if(self)
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    strForIdentifyArebicLanguageSelection = @"1";
    strForIdentifyEnglishLanguageSelection = @"2";
    strSelect =@"0";
  
    if(strComeFromSettings)
    {
        if([strComeFromSettings isEqualToString:@"1"])
        {
            
        }
    }else{
         selected_languaage =@"English";
    }
    [self headerFrame];

}
-(void)headerFrame
{
    [navView removeFromSuperview];
   
    if(IS_IPHONE_X){
        navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 88)];
    }else{
        navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    }
    int yy=0;
    if(IS_IPHONE_X)
    {
        yy=yy+44;
    }
    else
    {
        yy=yy+20;
    }
   
    navView.backgroundColor =APP_HEADER_COLOR;
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    UILabel *lblHeader =[[UILabel alloc]initWithFrame:CGRectMake(15,yy, DEVICE_WIDTH-25,20)];
    lblHeader.textColor= [UIColor whiteColor];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textAlignment=NSTextAlignmentCenter;
    lblHeader.text = @"Select Language (اختار اللغة)";
    lblHeader.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblHeader];
    
    [self SetupFrames];

}
-(void)SetupFrames
{
    int  yy = 130;
    
    btnEnglish = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnglish.frame=CGRectMake(40,DEVICE_HEIGHT/2-60,DEVICE_WIDTH-80, 50);
    btnEnglish.layer.cornerRadius = 2.0f;
    btnEnglish.tag = 1;
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnEnglish.backgroundColor =APP_BUTTON_COLOR;
        [btnEnglish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
     btnEnglish.backgroundColor =[UIColor whiteColor];
    [btnEnglish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     btnEnglish.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1].CGColor;
    btnEnglish.layer.borderWidth = 0.8;
    }
    [btnEnglish setTitle:@"English (الإنجليزية)" forState:UIControlStateNormal];
    [btnEnglish addTarget:self action:@selector(btnlanguageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnglish];
    
    yy = yy + 80;
    
    btnArebic = [UIButton buttonWithType:UIButtonTypeCustom];
    btnArebic.frame=CGRectMake(40,DEVICE_HEIGHT/2,DEVICE_WIDTH-80, 50);
    btnArebic.tag = 2;
    btnArebic.layer.cornerRadius = 2.0f;
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"ar"])
    {
        btnArebic.backgroundColor =APP_BUTTON_COLOR;
        [btnArebic setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        btnArebic.backgroundColor =[UIColor whiteColor];
        [btnArebic setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnArebic.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1].CGColor;
        btnArebic.layer.borderWidth = 0.8;
    }
    [btnArebic setTitle:@"Arabic (عربى)" forState:UIControlStateNormal];
    [btnArebic addTarget:self action:@selector(btnlanguageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnArebic];

    btnSelect =[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_X){
    btnSelect.frame=CGRectMake(0,DEVICE_HEIGHT-80,DEVICE_WIDTH , 50);
    }else{
    btnSelect.frame=CGRectMake(0,DEVICE_HEIGHT-50,DEVICE_WIDTH , 50);
    }
    
    btnSelect.backgroundColor =[UIColor colorWithRed:6.0/255.0 green:88.0/255.0 blue:120.0/255.0 alpha:1];
    [btnSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSelect setTitle:@"Next (التالى)" forState:UIControlStateNormal];
    btnSelect.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [btnSelect addTarget:self action:@selector(btnSelectLanguageClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelect];
    
}

-(void)btnSelectLanguageClicked
{
    [btnSelect setEnabled:NO];
    if([strSelect isEqualToString:@"0"]){
        
    }else{
        if([selected_languaage isEqualToString:@"English"])
        {
            [TSLanguageManager setSelectedLanguage:kLMEnglish];
            
        }else{
            
            [TSLanguageManager setSelectedLanguage:kLMArabic];
        }
    }
    if(strComeFromSettings)
    {
        if([strComeFromSettings isEqualToString:@"1"])
        {
            NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
            [user setValue:@"1" forKey:@"COME_FROM_SETTING_SCREEN_TO_LANGUAGE"];
            [APP_DELEGATE setUpTabBarController];
        }
      
    }
    else
    {
        if([selected_languaage isEqualToString:@"English"])
        {
            [TSLanguageManager setSelectedLanguage:kLMEnglish];
            
        }else{
            
            [TSLanguageManager setSelectedLanguage:kLMArabic];
        }
        
        NewAppInfoVC * vc = [[NewAppInfoVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)btnlanguageClicked:(id)sender
{
    strSelect = @"1";
    if([sender tag] == 1)
    {

        selected_languaage = @"English";
        btnEnglish.backgroundColor =APP_BUTTON_COLOR;
        btnEnglish.layer.borderColor =[[APP_DELEGATE colorWithHexString:App_green_color]CGColor];
        btnArebic.backgroundColor =[UIColor whiteColor];
        btnArebic.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1].CGColor;
        btnArebic.layer.borderWidth = 0.8;
        [btnArebic setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnEnglish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if([sender tag] == 2)
    {
        selected_languaage = @"Arabic";
        btnArebic.backgroundColor =APP_BUTTON_COLOR ;
        btnEnglish.layer.borderColor =[UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1].CGColor;
        btnEnglish.backgroundColor =[UIColor whiteColor];
        btnEnglish.layer.borderWidth = 0.8;
        [btnEnglish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnArebic setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
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
