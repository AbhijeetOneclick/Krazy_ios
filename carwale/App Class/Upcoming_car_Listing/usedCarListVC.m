//
//  usedCarListVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 14/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "usedCarListVC.h"
#import "DetailCarTblViewCell.h"
#import "ListViewCell.h"
#import "UsedCarFilterVC.h"

@interface usedCarListVC ()

@end

@implementation usedCarListVC
@synthesize isSelectChangeTblView,isShowFilter;
#pragma mark -Life Cycle 
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
    self.view.backgroundColor = [UIColor whiteColor];
    usedCarArr = [[NSMutableArray alloc] init];
    
    isSelectChangeTblView=NO;
    isShowFilter = NO;
    
    [self headerFrame];
    [self setFrame];
    [self GetCarUsedCar];

    
    // Do any additional setup after loading the view.
}

#pragma mark -Header Frmae
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
    lblHeader.text = @"Used Cars in Ahmedabad";
    lblHeader.font = [UIFont boldSystemFontOfSize:15];
    [navView addSubview:lblHeader];
    
    btnChangeView=[UIButton buttonWithType:UIButtonTypeCustom];
    btnChangeView.frame=CGRectMake(DEVICE_WIDTH-60,20, 50,44);
    [btnChangeView setImage:[UIImage imageNamed:@"list_Grid_type1"] forState:UIControlStateNormal];
    [btnChangeView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnChangeView addTarget:self action:@selector(ResetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnChangeView.backgroundColor=[UIColor clearColor];
    [navView addSubview:btnChangeView];
    
    
}

#pragma mark -Set Frmae 
-(void)setFrame
{
    listCarviewTbl = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    listCarviewTbl.delegate = self;
    listCarviewTbl.dataSource = self;
    listCarviewTbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:listCarviewTbl];
     listCarviewTbl.hidden = YES;
    //List Tblview
    
    detailcarViewTbl = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    detailcarViewTbl.delegate = self;
    detailcarViewTbl.dataSource = self;
    detailcarViewTbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:detailcarViewTbl];
    detailcarViewTbl.hidden = NO;
    //Detail Tblview
    
    floatFrame = CGRectMake(DEVICE_WIDTH-65,DEVICE_HEIGHT-65 , 55, 55);
    FilterBtn = [[UIButton alloc]initWithFrame:floatFrame];
    [FilterBtn setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
    [FilterBtn addTarget:self action:@selector(addbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FilterBtn];
}
#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return usedCarArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listCarviewTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    detailcarViewTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    
     if (isSelectChangeTblView == NO)
     {
         static NSString *cellIdentifier=nil;
         DetailCarTblViewCell *cell = [detailcarViewTbl dequeueReusableCellWithIdentifier:cellIdentifier];
         if(cell==nil)
         {
             cell = [[DetailCarTblViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
         }
         cell.backgroundColor=[UIColor clearColor];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         NSURL *image = [NSURL URLWithString: [[usedCarArr objectAtIndex:indexPath.row] valueForKey:@"media_name"]];
         cell.carImg.imageURL = image;
         cell.carNameLbl.text=[[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"car_name"];
         cell.carPricelbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"price"];
         cell.totalDrivenLbl.text = [NSString stringWithFormat:@"%@ Kms",[[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"total_driven"]];
         cell.fuelTypeLbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"fuel_type"];
         cell.yearlbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"purchase_date"];
         cell.citylbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"car_location"];
         return cell;
     }
     else
     {
         static NSString *cellIdentifier=nil;
         ListViewCell *cell = [listCarviewTbl dequeueReusableCellWithIdentifier:cellIdentifier];
         if(cell==nil)
         {
             cell = [[ListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
         }
         cell.backgroundColor=[UIColor clearColor];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         NSURL *image = [NSURL URLWithString: [[usedCarArr objectAtIndex:indexPath.row] valueForKey:@"media_name"]];
         cell.carImg.imageURL = image;
         cell.carNameLbl.text=[[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"car_name"];
         cell.carPricelbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"price"];
         cell.totalDrivenLbl.text = [NSString stringWithFormat:@"%@ Kms",[[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"total_driven"]];
         cell.fuelTypeLbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"fuel_type"];
         cell.yearlbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"purchase_date"];
         cell.citylbl.text = [[usedCarArr objectAtIndex:indexPath.row]objectForKey:@"car_location"];
         return cell;
     }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (isSelectChangeTblView == NO)
    {
        return 290;
    }
    else
    {
        return 160;
    }
   
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark -  webservices
-(void)GetCarUsedCar
{
    
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        NSString * webServiceName = @"getUsedCar";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getUsedCar";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_USEDCAR,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}

#pragma mark - URLManger delegate

-(void)onResult:(NSDictionary *)result
{
   
    NSLog(@"Result :%@",result);
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getUsedCar"])
    {
//        if ([[result valueForKey:@"success"] isEqualToString:@"1"]) {
         usedCarArr = [[result valueForKey:@"result"] valueForKey:@"used_car_list"];
            [detailcarViewTbl reloadData];
            [listCarviewTbl reloadData];
        
      //  }
        
    }
}
-(void)onError:(NSError *)error
{
    NSLog(@"Error========>%@",error);
}



#pragma mark -Button Action
-(void)backbtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ResetButtonClicked:(id)sender
{
    if(isSelectChangeTblView == YES)
    {
    
        [btnChangeView setImage:[UIImage imageNamed:@"list_Grid_type1"] forState:UIControlStateNormal];
        detailcarViewTbl.hidden = YES;
        listCarviewTbl.hidden = NO;
        [listCarviewTbl reloadData];
        isSelectChangeTblView = NO;
    }
    else
    {
        [btnChangeView setImage:[UIImage imageNamed:@"list_Grid_type2"] forState:UIControlStateNormal];
        listCarviewTbl.hidden = YES;
        detailcarViewTbl.hidden = NO;
        [detailcarViewTbl reloadData];
        isSelectChangeTblView = YES;
    }
}

-(void)addbuttonClicked:(id)sender
{
//    if(isShowFilter == NO)
//    {
//        [UIView animateWithDuration:1.0 animations:^{
//        FilterBtn.frame = CGRectMake(10, DEVICE_HEIGHT-65, 55, 55);
//         }];
//        isShowFilter = YES;
//    }
//    else
//    {
//        [UIView animateWithDuration:1.0 animations:^{
//            FilterBtn.frame = CGRectMake(DEVICE_WIDTH-65,DEVICE_HEIGHT-65 , 55, 55);
//        }];
//        isShowFilter = NO;
//    
//    }
    UsedCarFilterVC *vc = [[UsedCarFilterVC alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
