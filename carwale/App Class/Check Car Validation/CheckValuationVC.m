//
//  CheckValuationVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CheckValuationVC.h"

@interface CheckValuationVC ()

@end

@implementation CheckValuationVC

#pragma mark - Lifecycle class
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrame];
    [self headerFrame];
    self.view.backgroundColor=[UIColor whiteColor];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Header frame
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
    lblHeader.text=@"Check Car Valuation";
    lblHeader.textColor = [UIColor whiteColor];
    lblHeader.textAlignment=NSTextAlignmentCenter;
    [lblHeader setFont:[UIFont systemFontOfSize:16.0]];
    lblHeader.userInteractionEnabled=YES;
    [navView addSubview:lblHeader];
    
    btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
    [btnSideMenu addTarget:self action:@selector(btnSideMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnSideMenu.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [navView addSubview:btnSideMenu];
    
    
}

#pragma - Content Frame
-(void)setFrame
{
    [scrlContent removeFromSuperview];
    scrlContent=nil;
    scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    scrlContent.userInteractionEnabled = YES;
    scrlContent.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrlContent];
    int y=20;
    
    txtSelectcity = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    txtSelectcity.backgroundColor = [UIColor clearColor];
    txtSelectcity.placeholder=@"Select City";
    txtSelectcity.delegate=self;
    txtSelectcity.userInteractionEnabled=NO;
    [scrlContent addSubview:txtSelectcity];
    
    UIButton *showCity = [[UIButton alloc] initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    [showCity addTarget:self action:@selector(btnCityClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:showCity];
    
    
    y=y+50;
    LineSelectcityLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, y, DEVICE_WIDTH-20, 1)];
    LineSelectcityLbl.backgroundColor = [UIColor grayColor];

    [scrlContent addSubview:LineSelectcityLbl];
    y=y+20;
    txtManufacturingYear = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    txtManufacturingYear.backgroundColor = [UIColor clearColor];
    txtManufacturingYear.placeholder=@"Manufacturing Year";
    txtManufacturingYear.delegate=self;
    [scrlContent addSubview:txtManufacturingYear];
    
    UIButton *showManuFacturingYear = [[UIButton alloc] initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    [showManuFacturingYear addTarget:self action:@selector(btnCityClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:showManuFacturingYear];

    
    y=y+50;
    LineManufacturingLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, y, DEVICE_WIDTH-20, 1)];
    LineManufacturingLbl.backgroundColor = [UIColor grayColor];
    [scrlContent addSubview:LineManufacturingLbl];
    
    y=y+20;
    txtSelectMake = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    txtSelectMake.backgroundColor = [UIColor clearColor];
    txtSelectMake.placeholder=@"Select Make";
    txtSelectMake.delegate=self;
    [scrlContent addSubview:txtSelectMake];
    
    UIButton *showMaker = [[UIButton alloc] initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    [showMaker addTarget:self action:@selector(btnCityClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:showMaker];
    
    y=y+50;
    LineSelectMakeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, y, DEVICE_WIDTH-20, 1)];
    LineSelectMakeLbl.backgroundColor = [UIColor grayColor];
    [scrlContent addSubview:LineSelectMakeLbl];
    
    y=y+20;
    txtSelectModel= [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    txtSelectModel.backgroundColor = [UIColor clearColor];
    txtSelectModel.placeholder=@"Select Model";
    txtSelectModel.delegate=self;
    [scrlContent addSubview:txtSelectModel];
    
    UIButton *showModel = [[UIButton alloc] initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    [showModel addTarget:self action:@selector(btnCityClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:showModel];

    
    y=y+50;
    LineManufacturingLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, y, DEVICE_WIDTH-20, 1)];
    LineManufacturingLbl.backgroundColor = [UIColor grayColor];
    [scrlContent addSubview:LineManufacturingLbl];
    
    y=y+20;
    txtSelectVersion= [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    txtSelectVersion.backgroundColor = [UIColor clearColor];
    txtSelectVersion.placeholder=@"Select Version";
    txtSelectVersion.delegate=self;
    [scrlContent addSubview:txtSelectVersion];
    
    UIButton *showVersion = [[UIButton alloc] initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    [showVersion addTarget:self action:@selector(btnCityClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:showVersion];

    
    y=y+50;
    LineSelectVersionLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, y, DEVICE_WIDTH-20, 1)];
    LineSelectVersionLbl.backgroundColor = [UIColor grayColor];
    [scrlContent addSubview:LineSelectVersionLbl];

    y=y+20;
    txtNumberOfOwners= [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(10,y ,DEVICE_WIDTH-20 ,50)];
    txtNumberOfOwners.backgroundColor = [UIColor clearColor];
    txtNumberOfOwners.placeholder=@"Number of Owners";
    txtNumberOfOwners.delegate=self;
    [scrlContent addSubview:txtNumberOfOwners];
    
    y=y+50;
    LineNumberOfOwnersLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, y, DEVICE_WIDTH-20, 1)];
    LineNumberOfOwnersLbl.backgroundColor = [UIColor grayColor];
    [scrlContent addSubview:LineNumberOfOwnersLbl];
    
    y=y+20;
    btncheckValuation = [[UIButton alloc]initWithFrame:CGRectMake(10, y, DEVICE_WIDTH-20, 50)];
    btncheckValuation.backgroundColor = [UIColor orangeColor];
    [btncheckValuation setTitle:@"CONFIRM CITY" forState:UIControlStateNormal];
  //  [btncheckValuation addTarget:self action:@selector(btnConfirmCityClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:btncheckValuation];
    

}
#pragma mark - Button Action
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}
-(void)btnCityClicked:(id)sender
{
    SelectCityVC * destinationForRegister = [[SelectCityVC alloc ]init];
    [self.navigationController pushViewController:destinationForRegister animated:YES];
}
#pragma mark - Text-Field Delegate
-(void)hideKeyboard
{
   // *txtSelectcity,*txtManufacturingYear,*txtSelectMake,*txtSelectModel,*txtSelectVersion,*txtNumberOfOwners;
    [txtSelectcity resignFirstResponder];
    [txtManufacturingYear resignFirstResponder];
    [txtSelectMake resignFirstResponder];
    [txtSelectModel resignFirstResponder];
    [txtSelectVersion resignFirstResponder];
    [txtNumberOfOwners resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideKeyboard];
    
           // [txtNumberOfOwners becomeFirstResponder];
        if (IS_IPHONE_4)
        {
            // [scrlContent setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (txtSelectcity == textField)
    {
        [self hideKeyboard];
        

    }
    if (txtSelectModel == textField) {
        [scrlContent setContentOffset:CGPointMake(0, 20) animated:YES];
    }
    if (txtSelectVersion == textField) {
        [scrlContent setContentOffset:CGPointMake(0, 80) animated:YES];
    }
    if (txtNumberOfOwners == textField) {
        [scrlContent setContentOffset:CGPointMake(0, 120) animated:YES];
    }
    

    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (txtSelectModel == textField){
    [scrlContent setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    if (txtSelectVersion == textField){
        [scrlContent setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    if (txtNumberOfOwners == textField){
        [scrlContent setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}
@end
