//
//  FilterCarVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 05/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "FilterCarVC.h"
#import "BodyTypeTableCell.h"
#import "TransmisoonTypeTblViewCell.h"
#import "FuleTypeTableViewCell.h"
#import "BrandtblViewCell.h"
#define GalleryImagePerRow  (IS_IPAD ? 2 :3)

@interface FilterCarVC ()

@end
#pragma mark - Life Cycle
@implementation FilterCarVC

@synthesize rangeSlider,isSected,isSectedPrice;

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
    [self GetCarTypeAndModel];
    CarTypeArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden=YES;
    sectionArray = [[NSMutableArray alloc]init];
    brandNameArr = [[NSMutableArray alloc]init];
    transCarTypeArr = [[NSMutableArray alloc]init];
    fuelTypeArr = [[NSMutableArray alloc]init];
    arrCar = [[NSMutableArray alloc]init];
    lineBottom.hidden=NO;
    priceLevelArray = [[NSMutableArray alloc] initWithObjects:@"Price Low to High",@"Price High to Low",@"None", nil];
    
    for (int i=0; i<5; i++) {
         dicCategory =[[NSMutableDictionary alloc] init] ;

        if (i==0)
        {
            [dicCategory setValue:[TSLanguageManager localizedString: @"Budget/EMI"] forKey:@"type"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==1)
        {
            [dicCategory setValue:[TSLanguageManager localizedString:@"Brand"] forKey:@"type"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==2)
        {
            [dicCategory setValue:[TSLanguageManager localizedString:@"Fuel Type"] forKey:@"type"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==3)
        {
            [dicCategory setValue:[TSLanguageManager localizedString:@"Transmission Type"] forKey:@"type"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==4)
        {
            [dicCategory setValue:[TSLanguageManager localizedString:@"Body Type"] forKey:@"type"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
         [sectionArray addObject:dicCategory];
    }
    
    
    for (int i=0; i<2; i++) {
        
        //Disha Dic Name changes
        
        NSMutableDictionary *dicTransmissionType =[[NSMutableDictionary alloc] init] ;
        
        if (i==0)
        {
            [dicTransmissionType setObject:@"auto_icon" forKey:@"Trans_img"];
            [dicTransmissionType setObject:@"auto_selected" forKey:@"select_Trans_img"];
            [dicTransmissionType setValue:[TSLanguageManager localizedString:@"Automatic"] forKey:@"Trans_name"];
            
        }
        if (i==1)
        {
            [dicTransmissionType setObject:@"manual_icon" forKey:@"Trans_img"];
            [dicTransmissionType setObject:@"manual_selected" forKey:@"select_Trans_img"];
            [dicTransmissionType setValue:[TSLanguageManager localizedString: @"Manual"] forKey:@"Trans_name"];
            
        }
        [transCarTypeArr addObject:dicTransmissionType];
        [transCarTypeArr setValue:@"No" forKey:@"isSelect"];
    }
    
    
    for (int i=0; i<5; i++) {
        
        //Disha Dic Name changes

        NSMutableDictionary *dicFuelType =[[NSMutableDictionary alloc] init] ;
        
        if (i==0)
        {
            [dicFuelType setObject:@"petrol-diesel_icon" forKey:@"Fule_type_image"];
            [dicFuelType setObject:@"petrol-diesel_selected" forKey:@"Selected_Fule_type_image"];

            [dicFuelType setValue:[TSLanguageManager localizedString:@"Petrol"] forKey:@"Fule_name"];
            
        }else if (i==1)
        {
            [dicFuelType setObject:@"petrol-diesel_icon" forKey:@"Fule_type_image"];
             [dicFuelType setObject:@"petrol-diesel_selected" forKey:@"Selected_Fule_type_image"];
            [dicFuelType setValue:[TSLanguageManager localizedString:@"Diesel"] forKey:@"Fule_name"];
            
        }else if (i==2)
        {
            [dicFuelType setObject:@"cng_icon" forKey:@"Fule_type_image"];
             [dicFuelType setObject:@"cng_selected" forKey:@"Selected_Fule_type_image"];
            [dicFuelType setValue:@"CNG" forKey:@"Fule_name"];
            
        }else if (i==3)
        {
            [dicFuelType setObject:@"electric_icon" forKey:@"Fule_type_image"];
             [dicFuelType setObject:@"electric_selected" forKey:@"Selected_Fule_type_image"];
            [dicFuelType setValue:[TSLanguageManager localizedString:@"Electric"] forKey:@"Fule_name"];
            
        }else if (i==4)
        {
            [dicFuelType setObject:@"coal_icon" forKey:@"Fule_type_image"];
             [dicFuelType setObject:@"coal_selected" forKey:@"Selected_Fule_type_image"];
            [dicFuelType setValue:[TSLanguageManager localizedString:@"Hybrid"] forKey:@"Fule_name"];
            
        }
        [fuelTypeArr addObject:dicFuelType];
        [fuelTypeArr setValue:@"No" forKey:@"isSelect"];
    }
    
    for (int i=0; i<6; i++) {
        
        NSMutableDictionary *dicCategory1 =[[NSMutableDictionary alloc] init] ;
        if(i==0)
        {
            [dicCategory1 setObject:@"sedan_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory1 setObject:@"sedan_selected" forKey:@"Body_type_image_selected"];
            [dicCategory1 setValue:@"Sendan" forKey:@"body_type_name"];
        }
        if(i==1)
        {
            [dicCategory1 setObject:@"Minivan_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory1 setObject:@"Minivan_selected" forKey:@"Body_type_image_selected"];
            [dicCategory1 setValue:@"Minivan" forKey:@"body_type_name"];
        }
        if(i==2)
        {
            [dicCategory1 setObject:@"hatchback_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory1 setObject:@"hatchback_selected" forKey:@"Body_type_image_selected"];
            [dicCategory1 setValue:@"Hatchback" forKey:@"body_type_name"];
        }
        if(i==3)
        {
            [dicCategory1 setObject:@"suv_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory1 setObject:@"suv_selected" forKey:@"Body_type_image_selected"];
            [dicCategory1 setValue:@"SUV" forKey:@"body_type_name"];
        }
        if(i==4)
        {
            [dicCategory1 setObject:@"truck_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory1 setObject:@"truck_selected" forKey:@"Body_type_image_selected"];
            [dicCategory1 setValue:@"Truck" forKey:@"body_type_name"];
        }
        if(i==5)
        {
            [dicCategory1 setObject:@"couple_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory1 setObject:@"couple_selected" forKey:@"Body_type_image_selected"];
            [dicCategory1 setValue:@"Couple" forKey:@"body_type_name"];
        }
        [CarTypeArr addObject:dicCategory1];
        [CarTypeArr setValue:@"No" forKey:@"isSelect"];
    }
    strBrand = [NSString stringWithFormat:@""];
    strFuel = [NSString stringWithFormat:@""];
    strBodyType = [NSString stringWithFormat:@""];
    strTransmisooinType = [NSString stringWithFormat:@""];
    
    [self headerFrame];
    [self setFrame];
    
  
}
-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
    
    NSInteger intValue = [_strSelectedTypeName integerValue];
    if([[[sectionArray objectAtIndex:intValue]valueForKey:@"isSelect"]isEqualToString:@"yes"])
    {
        [[sectionArray objectAtIndex:intValue]setValue:@"No" forKey:@"isSelect"];
    }
    else
    {
        [[sectionArray objectAtIndex:intValue]setValue:@"yes" forKey:@"isSelect"];
    }
        self.tabBarController.tabBar.hidden=NO;
    
     [tblFilter reloadData];
    
}

#pragma mark - Header Frame
-(void)headerFrame
{
    [navView removeFromSuperview];
    int yy = 0;
    if(IS_IPHONE_X)
    {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,yy,DEVICE_WIDTH , 88)];
    }
    else
    {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,yy,DEVICE_WIDTH , 64)];
    }
    navView.backgroundColor =APP_HEADER_COLOR;
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    if(IS_IPHONE_X)
    {
        yy=yy+44;
    }
    else
    {
        yy=yy+20;
    }
    
    UIButton *btnback=[UIButton buttonWithType:UIButtonTypeCustom];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnback.frame=CGRectMake(0,yy, 50,44);
        [btnback setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    }else{
        btnback.frame=CGRectMake(DEVICE_WIDTH-50,yy, 50,44);
        [btnback setImage:[UIImage imageNamed:@"Back_btn_Arabic"] forState:UIControlStateNormal];
    }
    [btnback addTarget:self action:@selector(backbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnback.backgroundColor=[UIColor clearColor];
    [navView addSubview:btnback];
    
    lblHeader =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-90,yy,180,44)];
    lblHeader.textColor= [UIColor whiteColor];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textAlignment=NSTextAlignmentCenter;
    lblHeader.text = [TSLanguageManager localizedString:@"Sort and Filter By"];
    lblHeader.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblHeader];
    
    UIButton *btnRest=[UIButton buttonWithType:UIButtonTypeCustom];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnRest.frame=CGRectMake(DEVICE_WIDTH-60,yy, 50,44);
    }else{
        btnRest.frame=CGRectMake(10,yy, 50,44);
    }
    [btnRest setTitle:[TSLanguageManager localizedString:@"Reset"] forState:UIControlStateNormal];
    [btnRest setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRest addTarget:self action:@selector(ResetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnRest.backgroundColor=[UIColor clearColor];
    [navView addSubview:btnRest];
    
}

-(void)setFrame
{
    [viewTableHeader removeFromSuperview];
    int yy;
    if(IS_IPHONE_X)
    {
        yy=88;
    }
    else
    {
        yy=64;
    }
    viewTableHeader = [[UIView alloc]initWithFrame:CGRectMake(0,yy , DEVICE_WIDTH, 55)];
    viewTableHeader.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewTableHeader];
    
    UIView *viewTblHeader = [[UIView alloc]initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,44)];
    viewTblHeader.backgroundColor = [UIColor whiteColor];
    viewTblHeader.layer.shadowColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.16].CGColor;
    viewTblHeader.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);;
    viewTblHeader.layer.shadowOpacity = 1.0f;
    [viewTableHeader addSubview:viewTblHeader];
  
    lblSortBy = [[UILabel alloc] initWithFrame:CGRectMake(10, (viewTblHeader.frame.size.height/2)-9, DEVICE_WIDTH-20, 18)];
    lblSortBy.text = [TSLanguageManager localizedString:@"SORT BY"];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
    lblSortBy.textAlignment =NSTextAlignmentLeft;
    }else{
    lblSortBy.textAlignment =NSTextAlignmentRight;
    }
    lblSortBy.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblSortBy.textColor = [UIColor blackColor];
    [viewTblHeader addSubview:lblSortBy];
    
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
    lblPricelevel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-180, viewTblHeader.frame.size.height/2-7.5,120, 15)];
    }else{
     lblPricelevel = [[UILabel alloc] initWithFrame:CGRectMake(45, viewTblHeader.frame.size.height/2-6.5,100, 11)];
    }
    lblPricelevel.text = [TSLanguageManager localizedString:@"Price Low to High"];
    lblPricelevel.textAlignment = NSTextAlignmentLeft;
    lblPricelevel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
    lblPricelevel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    [viewTblHeader addSubview:lblPricelevel];
    
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        upselectedDown = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-20-14,10 , 15, 10)];
    }else{
         upselectedDown = [[UIImageView alloc] initWithFrame:CGRectMake(10,10 , 15, 10)];
    }
        
    upselectedDown.image = [UIImage imageNamed:@"up_icon"];
    [viewTblHeader addSubview:upselectedDown];
    
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
    DownselectedUp = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-20-14,25 , 15, 10)];
    }else{
     DownselectedUp = [[UIImageView alloc] initWithFrame:CGRectMake(10,25 , 15, 10)];
    }
    DownselectedUp.image = [UIImage imageNamed:@"down_grey"];
    [viewTblHeader addSubview:DownselectedUp];
    
    UIButton *selectPriceLevel = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , DEVICE_WIDTH, 40)];
    selectPriceLevel.backgroundColor = [UIColor clearColor];
    [selectPriceLevel addTarget:self action:@selector(btnClickPriceLevel:) forControlEvents:UIControlEventTouchUpInside];
    [viewTblHeader addSubview:selectPriceLevel];

    //----Tableview----//
    [tblFilter removeFromSuperview];
    tblFilter =[[UITableView alloc]initWithFrame:CGRectMake(0,yy,DEVICE_WIDTH, DEVICE_HEIGHT-49-64) style:UITableViewStyleGrouped];
    [tblFilter setBackgroundColor:[UIColor clearColor]];
    tblFilter.showsVerticalScrollIndicator = NO;
    tblFilter.showsHorizontalScrollIndicator=NO;
    [tblFilter setDelegate:self];
    [tblFilter setDataSource:self];
    tblFilter.tableHeaderView = viewTableHeader;
    tblFilter.bounces = NO;
    tblFilter.layer.masksToBounds = YES;
    [tblFilter setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblFilter];
    
    UIView *resultView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT-49, DEVICE_WIDTH, 49)];
    if(IS_IPHONE_X){
        [resultView setFrame:CGRectMake(0, DEVICE_HEIGHT-49-20, DEVICE_WIDTH, 49)];
    }
    resultView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:resultView];
    
    UIView *showResultView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, DEVICE_WIDTH/2-30, resultView.frame.size.height)];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        showResultView.frame =CGRectMake(0, 1, DEVICE_WIDTH/2-30, resultView.frame.size.height);
    }else{
        showResultView.frame =CGRectMake(DEVICE_WIDTH/2+30, 1, DEVICE_WIDTH/2-30, resultView.frame.size.height);
    }
    
    showResultView.backgroundColor  = [UIColor whiteColor];
    [resultView addSubview:showResultView];
    
    UILabel *lblSearchResult = [[UILabel alloc]init];
    if(IS_IPAD)
    {
        lblSearchResult.frame = CGRectMake(0,16,showResultView.frame.size.width, 14);
    }else{
       lblSearchResult.frame = CGRectMake(0,9,showResultView.frame.size.width, 30);
    }
    if(IS_IPAD)
    {
    lblSearchResult.text = @"231 matching cars found";
    }else{
    lblSearchResult.text = @"231 matching cars \n found";
    }
    
    if(IS_IPAD)
    {
    lblSearchResult.numberOfLines = 1;
    }else{
    lblSearchResult.numberOfLines = 2;
    }
    lblSearchResult.textAlignment = NSTextAlignmentCenter;
    lblSearchResult.font = [UIFont boldSystemFontOfSize:12.0f];
    lblSearchResult.textColor = [UIColor lightGrayColor];
    [showResultView addSubview:lblSearchResult];
    
    UIButton *btnApply = [[UIButton alloc] init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnApply.frame =CGRectMake(showResultView.frame.size.width,1 , DEVICE_WIDTH/2+30,resultView.frame.size.height);
    }else{
        btnApply.frame =CGRectMake(0, 1, DEVICE_WIDTH/2+30, resultView.frame.size.height);
    }
    
    btnApply.backgroundColor = APP_BUTTON_COLOR;
    [btnApply setTitle:[TSLanguageManager localizedString:@"Apply"] forState:UIControlStateNormal];
    [btnApply setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnApply addTarget:self action:@selector(btnApplyClicked:) forControlEvents:UIControlEventTouchUpInside];
    [resultView addSubview:btnApply];

}
#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[sectionArray objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
    {
       if ([[[sectionArray objectAtIndex:section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Budget/EMI"]])
       {
        return 1;
       }
        else if ([[[sectionArray objectAtIndex:section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Brand"]])
        {
            int no;
            if(IS_IPAD)
            {
                no =[brandNameArr count] /3;
                return ([brandNameArr count] %3 > 0 ? no+1 : no);
               
            }else{
                no =[brandNameArr count] /2;
                return ([brandNameArr count] %2 > 0 ? no+1 : no);
            }
           
        }
        else if ([[[sectionArray objectAtIndex:section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Fuel Type"]])
        {
            int no;
            if(IS_IPAD)
            {
                no =[fuelTypeArr count] /5;
                return ([fuelTypeArr count] %5 > 0 ? no+1 : no);
            
            }else{
                no =[fuelTypeArr count] /3;
                return ([fuelTypeArr count] %3 > 0 ? no+1 : no);
            }

        }
        else if ([[[sectionArray objectAtIndex:section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString: @"Transmission Type"]])
        {
            int no;
            if(IS_IPAD)
            {
                  no = [transCarTypeArr count] /5;
                return ([transCarTypeArr count] %5 > 0 ? no+1 : no);
            }else{
                no = [transCarTypeArr count] /3;
                return ([transCarTypeArr count] %3 > 0 ? no+1 : no);
            }
        }
        else if ([[[sectionArray objectAtIndex:section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Body Type"]])
        {
//            NSInteger no =[CarTypeArr count] /GalleryImagePerRow;
//            return ([CarTypeArr count] %GalleryImagePerRow > 0 ? no+1 : no);
            int no;
            if(IS_IPAD)
            {
                no = [CarTypeArr count] /5;
                return ([CarTypeArr count] %5 > 0 ? no+1 : no);
            }else{
                no =[CarTypeArr count] /3;
                return ([CarTypeArr count] %3 > 0 ? no+1 : no);
            }
            
        }
        return 0;
    }else
    {
        return 0;
    }
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView * sectionHeader = [[UIView alloc] init];
    sectionHeader.frame = CGRectMake(0,0 , DEVICE_WIDTH,45);
    sectionHeader.backgroundColor = [UIColor clearColor];
    
    if(section==4)
    {
        [lineBottom removeFromSuperview];
        lineBottom = [[UIView alloc]initWithFrame:CGRectMake(0.0f, sectionHeader.frame.size.height-1,DEVICE_WIDTH, 1.0f)];
        lineBottom.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [sectionHeader addSubview:lineBottom];
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0,DEVICE_WIDTH, 1.0f)];
    lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [sectionHeader addSubview:lineView];

    //}
    UILabel *lblType = [[UILabel alloc] init];
    lblType.frame =CGRectMake(10, sectionHeader.frame.size.height/2-10, DEVICE_WIDTH-20, 20);
    lblType.text = [[sectionArray objectAtIndex:section] valueForKey:@"type"];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
    lblType.textAlignment =NSTextAlignmentLeft;
    }else{
    lblType.textAlignment =NSTextAlignmentRight;
    }
    lblType.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    lblType.textColor = [APP_DELEGATE colorWithHexString:@"333333"];
    [sectionHeader addSubview:lblType];
    
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-20-14, sectionHeader.frame.size.height/2-5, 14, 10)];
    }else{
     imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(20, sectionHeader.frame.size.height/2-5, 14, 10)];
    }
    [sectionHeader addSubview:imageArrow];
    if ([[[sectionArray objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
    {
        imageArrow.image = [UIImage imageNamed:@"up_icon"];
    }else
    {
         imageArrow.image = [UIImage imageNamed:@"down_icon"];
    }
    
    UIButton * btnHeader = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 50)];
    btnHeader.backgroundColor = [UIColor clearColor];
    btnHeader.tag=section;
    [btnHeader addTarget:self action:@selector(btnHeaderClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sectionHeader addSubview:btnHeader];
    return sectionHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",sectionArray);
    if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
    {
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Budget/EMI"]])
        {
            return 195.0;
        }
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Brand"]])
        {
            return 60.0;
        }
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Fuel Type"]])
        {
            if(IS_IPAD)
            {
                return 90.0;
            }else{
                return 80.0;
            }
        }
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Transmission Type"]])
        {
            if(IS_IPAD)
            {
                return 90.0;
            }else{
                return 80.0;
            }
        }
        
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Body Type"]])
        {
            if(IS_IPAD)
            {
                return 90.0;
            }else{
                return 80.0;
            }
        }
        return 0;
    }else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
    {
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Budget/EMI"]])
        {
            NSString *cellID = nil;
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell != nil)
                return cell;
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            UIView *viewFilterBudget = [[UIView alloc] initWithFrame:CGRectMake(0,0 , DEVICE_WIDTH, 40)];
            int xx;
            if(IS_IPAD)
            {
                xx = 264;
            }if(IS_IPHONE_6plus){
                xx = 87;
            }if(IS_IPHONE_5){
                xx=40;
            }else{
                xx=67;
            }
            NSLog(@"%f",DEVICE_WIDTH);
            viewFilterBudget.frame = CGRectMake(xx, 0, (DEVICE_WIDTH)-(xx*2),40);
            viewFilterBudget.backgroundColor = [UIColor clearColor];
            [cell addSubview:viewFilterBudget];
            

            UILabel *lblFilterCar =[[UILabel alloc]init];
            lblFilterCar.frame =CGRectMake(0,viewFilterBudget.frame.size.height/2-7,viewFilterBudget.frame.size.width,14);
            if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
            {
               lblFilterCar.textAlignment = NSTextAlignmentLeft;
            }else{
                lblFilterCar.textAlignment = NSTextAlignmentRight;
            }
            lblFilterCar.textColor= [UIColor lightGrayColor];
            lblFilterCar.backgroundColor=[UIColor clearColor];
            lblFilterCar.text =[TSLanguageManager localizedString: @"Filter cars by"];
            lblFilterCar.font = [UIFont systemFontOfSize:12.0];
            [viewFilterBudget addSubview:lblFilterCar];

            DVSwitch *switcher;
            if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
            {
                switcher = [[DVSwitch alloc] initWithStringsArray:@[@"EMI", [TSLanguageManager localizedString:@"Budget"]]];
            }else{
                switcher = [[DVSwitch alloc] initWithStringsArray:@[[TSLanguageManager localizedString:@"Budget"],@"EMI"]];
            }
            if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
            {
                switcher.frame = CGRectMake(viewFilterBudget.frame.size.width-140, 0, 140, 40);
            }else{
                switcher.frame = CGRectMake(0, 0, 140, 40);
                }
            switcher.backgroundColor = [UIColor colorWithRed:226.0/265.0 green:226.0/265.0 blue:226.0/265.0 alpha:1.0];
            switcher.sliderColor = [UIColor colorWithRed:4.0/265.0 green:180.0/265.0 blue:196.0/265.0 alpha:1.0];
            switcher.cornerRadius = 20;
            switcher.labelTextColorInsideSlider = [UIColor whiteColor];
            switcher.labelTextColorOutsideSlider = [UIColor blackColor];
            switcher.font = [UIFont systemFontOfSize:13.0];
            [viewFilterBudget addSubview:switcher];
            [switcher setPressedHandler:^(NSUInteger index) {
                
                NSLog(@"Did switch to index: %lu", (unsigned long)index);
                
            }];

            int y = 0;
            y=y+40+20;
            lblRange =[[UILabel alloc]initWithFrame:CGRectMake((DEVICE_WIDTH/2)-75,y,150,20)];
            lblRange.textColor= [UIColor blackColor];
            lblRange.backgroundColor=[UIColor clearColor];
            lblRange.text = [TSLanguageManager localizedString:@"All Range"];
            lblRange.textAlignment = NSTextAlignmentCenter;
            lblRange.font = [UIFont systemFontOfSize:15.0];
            [cell addSubview:lblRange];
            
            y=y+30;
            UIView *rangShowView =[[UIView alloc] init];
            if(IS_IPAD){
                rangShowView.frame =CGRectMake(212, y, DEVICE_WIDTH-424, 43);
            }else{
                rangShowView.frame =CGRectMake(65, y, DEVICE_WIDTH-130, 43);
            }
            rangShowView.backgroundColor = [UIColor clearColor];
            [cell addSubview:rangShowView];
            
            rangeSlider = [[TTRangeSlider alloc] init];
            if(IS_IPAD){
                rangeSlider.frame=CGRectMake(0, 0, DEVICE_WIDTH-424, 20);
            }else{
                rangeSlider.frame=CGRectMake(0, 0, DEVICE_WIDTH-130, 20);
            }
            rangeSlider.delegate=self;
            rangeSlider.minValue =1;
            rangeSlider.maxValue = 30;
            rangeSlider.selectedMinimum =1;
            rangeSlider.selectedMaximum = 30;
            rangeSlider.tintColorBetweenHandles = [UIColor colorWithRed:86.0/255.0 green:90.0/255.0 blue:92.0/255.0 alpha:1];
            rangeSlider.tintColor = [UIColor lightGrayColor];
            rangeSlider.handleColor = [UIColor whiteColor];
            rangeSlider.lineHeight = 4.0f;
            rangeSlider.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
            rangeSlider.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];
            [rangeSlider setHandleImage:[UIImage imageNamed:@"scrollcircle_icon"]];
            [rangeSlider addTarget:self action:@selector(changePriceRange:) forControlEvents:UIControlEventValueChanged];
            [rangShowView addSubview:rangeSlider];
            
           
            UILabel * lblmin =[[UILabel alloc]init];
            lblmin.frame = CGRectMake(0,30,rangShowView.frame.size.width,30);
            lblmin.textColor= [UIColor lightGrayColor];
            lblmin.backgroundColor=[UIColor clearColor];
            lblmin.text = [TSLanguageManager localizedString:@"Min"];
            if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"]){
            lblmin.textAlignment = NSTextAlignmentLeft;
            }else{
             lblmin.textAlignment = NSTextAlignmentRight;
            }
            lblmin.font = [UIFont systemFontOfSize:11.0];
            [rangShowView addSubview:lblmin];
            
            UILabel * lblmax =[[UILabel alloc]init];
            lblmax.frame=  CGRectMake(0,30,rangShowView.frame.size.width,30);
            lblmax.textColor= [UIColor lightGrayColor];
            lblmax.backgroundColor=[UIColor clearColor];
            lblmax.text = [TSLanguageManager localizedString:@"Max"];
            if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"]){
                lblmax.textAlignment = NSTextAlignmentRight;
            }else{
                lblmax.textAlignment = NSTextAlignmentLeft;
            }
            lblmax.font = [UIFont systemFontOfSize:11.0];
            [rangShowView addSubview:lblmax];
            
            y = y+30+5;
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            return cell;
        }
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Brand"]])
        {
            NSString *cellID = nil;
            BrandtblViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell != nil)
                return cell;
            cell=[[BrandtblViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.eventHandler=self;
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            [cell setGalleryDetail:[brandNameArr mutableCopy]  atIndexPath:indexPath imagePath:nil];
            return cell;
        }
        
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Fuel Type"]])
        {
            NSString *cellID = nil;
            FuleTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell != nil)
                return cell;
            cell=[[FuleTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            [cell setGalleryDetail:[fuelTypeArr mutableCopy]  atIndexPath:indexPath imagePath:nil];
            return cell;
        }
        
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Transmission Type"]])
        {
            NSString *cellID = nil;
            TransmisoonTypeTblViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell != nil)
                return cell;
            cell=[[TransmisoonTypeTblViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.eventHandler = self;
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            [cell setGalleryDetail:[transCarTypeArr mutableCopy]  atIndexPath:indexPath imagePath:nil];
            return cell;
        }
        
        if ([[[sectionArray objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:[TSLanguageManager localizedString:@"Body Type"]])
        {
            NSString *cellID = nil;
            lineBottom.hidden=YES;
            BodyTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell != nil)
                return cell;
            cell=[[BodyTypeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.eventHandler = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            [cell setGalleryDetail:[CarTypeArr mutableCopy]  atIndexPath:indexPath imagePath:nil];
            return cell;
        }
        return cell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     

}
#pragma mark -  webservices
-(void)GetCarTypeAndModel
{
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        NSString * webServiceName = @"getCarBrandAndType";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getCarBrandAndType";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_BRAND,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
    
    
}
- (void)onResult:(NSDictionary *)result
{
    NSLog(@"Result :%@",result);
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getCarBrandAndType"])
    {
        brandNameArr = [[result valueForKey:@"result"] valueForKey:@"car_brand"];
        [brandNameArr setValue:@"No" forKey:@"isSelect"];
        [tblFilter reloadData];
        
    }
   
}
-(void)onError:(NSError *)error
{
    NSLog(@"%@response",error);
}
#pragma mark - Range Slider

- (void)changePriceRange:(TTRangeSlider *)sender
{
  
}

-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum;
{
    if(selectedMinimum==1.0f && selectedMaximum==30.f)
    {
        lblRange.text =[TSLanguageManager localizedString:@"All Range"];
    }
    else
    {
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
        lblRange.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
        }else{
        lblRange.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f",  sender.selectedMaximum,sender.selectedMinimum];
        }

    }
}

#pragma mark - Button click


-(void)btnHeaderClicked:(id)sender
{
    btn = (UIButton *)sender;
    //[sectionArray setValue:@"No" forKey:@"isSelect"];
    
    if(btn.tag==4){
        [lineBottom removeFromSuperview];
    }
    if([[[sectionArray objectAtIndex:btn.tag]valueForKey:@"isSelect"]isEqualToString:@"yes"])
    {
        [[sectionArray objectAtIndex:btn.tag]setValue:@"No" forKey:@"isSelect"];
    }
    else
    {
         [[sectionArray objectAtIndex:btn.tag]setValue:@"yes" forKey:@"isSelect"];
    }
    [tblFilter reloadData];
}
-(void)btnClickPriceLevel:(id)sender
{
   if(!isSectedPrice)
   {
       upselectedDown.image = [UIImage imageNamed:@"up_grey"];
       DownselectedUp.image = [UIImage imageNamed:@"down_icon"];
       lblPricelevel.text =[TSLanguageManager localizedString:@"Price High to Low"];
       isSectedPrice = YES;
   }
   else
   {
       upselectedDown.image = [UIImage imageNamed:@"up_icon"];
       DownselectedUp.image = [UIImage imageNamed:@"down_grey"];
       lblPricelevel.text = [TSLanguageManager localizedString:@"Price Low to High"];
       isSectedPrice = NO;
     
   }
}
-(void)backbtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ResetButtonClicked:(id)sender
{
    [brandNameArr setValue:@"No" forKey:@"isSelect"];
    [CarTypeArr setValue:@"No" forKey:@"isSelect"];
    [fuelTypeArr setValue:@"No" forKey:@"isSelect"];
    [transCarTypeArr setValue:@"No" forKey:@"isSelect"];
    [brandNameArr setValue:@"No" forKey:@"isSelect"];
    [tblFilter reloadData];
}
-(void)selectBrand:(id)sender
{
    
    if ([[[brandNameArr objectAtIndex:[sender tag]] valueForKey:@"isSelect"] isEqualToString:@"YES"])
    {
        [[brandNameArr objectAtIndex:[sender tag]] setValue:@"No" forKey:@"isSelect"];
    }
    else
    {
        [[brandNameArr objectAtIndex:[sender tag]] setValue:@"YES" forKey:@"isSelect"];
    }
        [tblFilter reloadData];
    
    for (int a =0; a<[brandNameArr count]; a++)
    {
        if ([[[brandNameArr objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"YES"])
        {
            if ([strBrand length]==0)
            {
                strBrand = [strBrand stringByAppendingString:[NSString stringWithFormat:@"%@",[[brandNameArr objectAtIndex:a] valueForKey:@"brand_id"]]];
            }else
            {
                strBrand = [strBrand stringByAppendingString:[NSString stringWithFormat:@",%@",[[brandNameArr objectAtIndex:a] valueForKey:@"brand_id"]]];
            }
        }
    }
    
}

-(void)selectFuleType:(id)sender
{
    if ([[[fuelTypeArr objectAtIndex:[sender tag]] valueForKey:@"isSelect"] isEqualToString:@"YES"])
    {
        [[fuelTypeArr objectAtIndex:[sender tag]] setValue:@"No" forKey:@"isSelect"];
    }
    else     {
        [[fuelTypeArr objectAtIndex:[sender tag]] setValue:@"YES" forKey:@"isSelect"];
    }
    [tblFilter reloadData];
}
-(void)selectTransmisonType:(id)sender
{
    if ([[[transCarTypeArr objectAtIndex:[sender tag]] valueForKey:@"isSelect"] isEqualToString:@"YES"])
    {
        [[transCarTypeArr objectAtIndex:[sender tag]] setValue:@"No" forKey:@"isSelect"];
    }
    else
    {
        [[transCarTypeArr objectAtIndex:[sender tag]] setValue:@"YES" forKey:@"isSelect"];
    }
    [tblFilter reloadData];
}
-(void)selectBodyType:(id)sender
{
    if ([[[CarTypeArr objectAtIndex:[sender tag]] valueForKey:@"isSelect"] isEqualToString:@"YES"])
    {
        [[CarTypeArr objectAtIndex:[sender tag]] setValue:@"No" forKey:@"isSelect"];
        lineBottom.hidden=NO;
    }
    else
    {
        [[CarTypeArr objectAtIndex:[sender tag]] setValue:@"YES" forKey:@"isSelect"];
        lineBottom.hidden=YES;
    }
    
    [tblFilter reloadData];
}
-(void)btnApplyClicked:(id)sender
{
    strBrand = [NSString stringWithFormat:@""];
    strFuel = [NSString stringWithFormat:@""];
    strBodyType = [NSString stringWithFormat:@""];
    strTransmisooinType = [NSString stringWithFormat:@""];
    
    for (int a =0; a<[brandNameArr count]; a++)
    {
        if ([[[brandNameArr objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"YES"])
        {
            if ([strBrand length]==0)
            {
                 strBrand = [strBrand stringByAppendingString:[NSString stringWithFormat:@"%@",[[brandNameArr objectAtIndex:a] valueForKey:@"brand_id"]]];
            }else
            {
                 strBrand = [strBrand stringByAppendingString:[NSString stringWithFormat:@",%@",[[brandNameArr objectAtIndex:a] valueForKey:@"brand_id"]]];
            }
        }
    }
    
    for (int a =0; a<[fuelTypeArr count]; a++)
    {
        if ([[[fuelTypeArr objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"YES"])
        {
            if ([strFuel length]==0)
            {
                strFuel = [strFuel stringByAppendingString:[NSString stringWithFormat:@"%@",[[fuelTypeArr objectAtIndex:a] valueForKey:@"Fule_name"]]];
            }else
            {
                strFuel = [strFuel stringByAppendingString:[NSString stringWithFormat:@",%@",[[fuelTypeArr objectAtIndex:a] valueForKey:@"Fule_name"]]];
            }
        }
    }
    
    for (int a =0; a<[CarTypeArr count]; a++)
    {
        if ([[[CarTypeArr objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"YES"])
        {
            if ([strBodyType length]==0)
            {
                strBodyType = [strBodyType stringByAppendingString:[NSString stringWithFormat:@"%@",[[CarTypeArr objectAtIndex:a] valueForKey:@"car_type_name"]]];
            }else
            {
                strBodyType = [strBodyType stringByAppendingString:[NSString stringWithFormat:@",%@",[[CarTypeArr objectAtIndex:a] valueForKey:@"car_type_name"]]];
            }
        }
       
    }
    
    for (int a =0; a<[transCarTypeArr count]; a++)
    {
        if ([[[transCarTypeArr objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"YES"])
        {
            if ([strFuel length]==0)
            {
                strTransmisooinType = [strTransmisooinType stringByAppendingString:[NSString stringWithFormat:@"%@",[[transCarTypeArr objectAtIndex:a] valueForKey:@"Trans_name"]]];
            }else
            {
                strTransmisooinType = [strTransmisooinType stringByAppendingString:[NSString stringWithFormat:@",%@",[[transCarTypeArr objectAtIndex:a] valueForKey:@"Trans_name"]]];
            }
        }
      
    }

    NewCarOfferVC *vc = [[NewCarOfferVC   alloc] init];
    vc.strBrandGet = strBrand;
    vc.strBodyTypeGet = strBodyType;
    vc.strTrasmissionTypeGet = strTransmisooinType;
    vc.strFuelTypeGet =strFuel;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)CallServiceNewCar
{    [APP_DELEGATE showProcessHud];
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        if(![strBrand isEqualToString:@""])
        {
            [parameter_dict setObject:strBrand forKey:@"brand_ids"];
        }
        else
        {
            [parameter_dict setObject:@"" forKey:@"brand_ids"];
            
        }
        [parameter_dict setObject:strBodyType forKey:@"fuel_types"];
        [parameter_dict setObject:strTransmisooinType forKey:@"transmission_types"];
        [parameter_dict setObject:strBodyType forKey:@"car_types"];
        
        NSString * webServiceName = @"getCarModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getCarModels";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PickerView Delegate
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [priceLevelArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [lblPricelevel setText:[NSString stringWithFormat:@"%@",[priceLevelArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [priceLevelArray objectAtIndex:row];
    
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
