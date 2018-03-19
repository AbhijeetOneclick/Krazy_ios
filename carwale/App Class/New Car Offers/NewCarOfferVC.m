//
//  NewCarOfferVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "NewCarOfferVC.h"
#import "NewCarOfferCellVC.h"
#import "FilterCarVC.h"
#import "CarDetailVC.h"
@interface NewCarOfferVC ()

@end

@implementation NewCarOfferVC
@synthesize storyboard,strBrandGet,strBodyTypeGet,strFuelTypeGet,strTrasmissionTypeGet;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrCar = [[NSMutableArray alloc] init];
    [self CallServiceNewCar];
    [self setFrame];
    [self headerFrame];

    newCarOfferInfoTbl.separatorColor = [UIColor clearColor];
    self.view.backgroundColor=[UIColor whiteColor];

 
   
}

-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =APP_HEADER_COLOR;
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    UIButton *btnback=[UIButton buttonWithType:UIButtonTypeCustom];
    btnback.frame=CGRectMake(0,20, 50,44);
    [btnback setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(backbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnback.backgroundColor=[UIColor clearColor];
    [navView addSubview:btnback];
    
    lblHeader =[[UILabel alloc]initWithFrame:CGRectMake(60,20,180,44)];
    lblHeader.textColor= [UIColor whiteColor];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textAlignment=NSTextAlignmentLeft;
    lblHeader.text = @"New Cars";
    lblHeader.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblHeader];
    
}

-(void)setFrame
{
    newCarOfferInfoTbl = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    [newCarOfferInfoTbl setContentOffset:CGPointZero animated:YES];
    newCarOfferInfoTbl.delegate = self;
    newCarOfferInfoTbl.dataSource = self;
    newCarOfferInfoTbl.bounces = YES;
    newCarOfferInfoTbl.scrollEnabled = YES;
    newCarOfferInfoTbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:newCarOfferInfoTbl];
    
    CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 44 - 20, [UIScreen mainScreen].bounds.size.height - 50-50, 55, 55);
    UIButton * addButton = [[UIButton alloc]initWithFrame:floatFrame];
      [addButton setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return arrCar.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellIdentifier=nil;
    NewCarOfferCellVC *cell = [theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[NewCarOfferCellVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    NSURL *image = [NSURL URLWithString: [[arrCar objectAtIndex:indexPath.row] valueForKey:@"model_image"]];
    cell.carImg.imageURL = image;
    cell.carNameLbl.text=[[arrCar objectAtIndex:indexPath.row]objectForKey:@"car_model_name"];
    cell.carPriceLbl.text=[NSString stringWithFormat:@"%@%@",[[arrCar objectAtIndex:indexPath.row]objectForKey:@"currency_symbol"],[[arrCar objectAtIndex:indexPath.row]objectForKey:@"price"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([arrCar count]>0)
    {
        CarDetailVC * car = [[CarDetailVC alloc] init];
        car.hidesBottomBarWhenPushed = YES;
        car.dictCar = [arrCar objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:car animated:YES];
    }
}
-(void)backbtnClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)addbuttonClicked:(id)sender
{
    FilterCarVC *filterVC = [[FilterCarVC alloc] init];
    [self.navigationController pushViewController:filterVC animated:YES];
}
-(void)CallServiceNewCar
{    [APP_DELEGATE showProcessHud];
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else 
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        if(![strBrandGet isEqualToString:@""])
        {
            [parameter_dict setObject:strBrandGet forKey:@"brand_ids"];
        }
        else
        {
            [parameter_dict setObject:@"" forKey:@"brand_ids"];
        
        }
        [parameter_dict setObject:strFuelTypeGet forKey:@"fuel_types"];
        [parameter_dict setObject:strTrasmissionTypeGet forKey:@"transmission_types"];
        [parameter_dict setObject:strBodyTypeGet forKey:@"car_types"];
        
        NSString * webServiceName = @"getCarModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getCarModels";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}
-(void)onResult:(NSDictionary *)result
{
    [APP_DELEGATE hideProcessHud];
    if([[result valueForKey:@"commandName"] isEqualToString:@"getCarModels"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"] isEqualToString:@"1"])
        {
            
            arrCar = [[result valueForKey:@"result"] valueForKey:@"car_model"];
            if([arrCar count]>0)
            {
                [newCarOfferInfoTbl reloadData];
            }
            else
            {
                
                UILabel *showError = [[UILabel alloc] initWithFrame:CGRectMake(120, 70,DEVICE_WIDTH/2-40 , 20)];
                showError.text = @"Car's Not available";
                showError.textAlignment =  NSTextAlignmentCenter;
                showError.font = [UIFont fontWithName:FONT size:15];
                showError.textColor = [UIColor lightGrayColor];
                [self.view addSubview:showError];
            
            }
            
            
                NSLog(@"Result=====>%@",result);
            
        }
        else
        {
            UILabel *showError = [[UILabel alloc] initWithFrame:CGRectMake(120, 70,DEVICE_WIDTH/2-40 , 20)];
            showError.text = @"Car's Not available";
            showError.textAlignment =  NSTextAlignmentCenter;
            showError.font = [UIFont fontWithName:FONT size:15];
            showError.textColor = [UIColor lightGrayColor];
            [self.view addSubview:showError];
            
        }
    }
}
-(void)onError:(NSError *)error
{
    NSLog(@"Error=====>%@",error);
}
#pragma mark - Button Action
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
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
