 //
//  UsedCarFilterVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 18/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "UsedCarFilterVC.h"
#import "FuleTypeTblCell.h"
#import "ownerShipCell.h"
#import "TransmissionViewCell.h"
#import "BodyTypeViewCell.h"
@interface UsedCarFilterVC ()

@end

@implementation UsedCarFilterVC

@synthesize rangeSlider3,rangeSlider6,rangeSlider7;

#pragma mark -life Cycle Method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    filterArr = [[NSMutableArray alloc]init];
    sortByArr = [[NSMutableArray alloc]init];
    fuelTypeArr = [[NSMutableArray alloc] init];
    ownerShipArr = [[NSMutableArray alloc] init];
    transMissionArr = [[NSMutableArray alloc] init];
    bodyTypeArr = [[NSMutableArray alloc] init];
    ismainTable =YES;
//===============================filter Table=======================================//
    for (int i=0; i<11; i++) {
        NSMutableDictionary *dicCategory =[[NSMutableDictionary alloc] init] ;
        
        if (i==0)
        {
            [dicCategory setValue:@"Select City" forKey:@"type"];
            [dicCategory setObject:@"location_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"location_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==1)
        {
            [dicCategory setValue:@"Certified Cars" forKey:@"type"];
            [dicCategory setObject:@"certified_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"certified_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==2)
        {
            [dicCategory setValue:@"Car with Photos" forKey:@"type"];
            [dicCategory setObject:@"images_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"images_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==3)
        {
            //=====car price range======//
            [dicCategory setValue:@"All Range" forKey:@"type"];
            [dicCategory setObject:@"price_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"price_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }else if (i==4)
        {
            [dicCategory setValue:@"Select Car" forKey:@"type"];
            [dicCategory setObject:@"bodytype_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"bodytype_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        else if (i==5)
        {
            [dicCategory setValue:@"Fuel Type" forKey:@"type"];
            [dicCategory setObject:@"fuel_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"fuel_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        else if (i==6)
        {
            // Year Of car
            [dicCategory setValue:@"All Range" forKey:@"type"];
            [dicCategory setObject:@"date_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"date_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        else if (i==7)
        {
            // km
            [dicCategory setValue:@"All Range" forKey:@"type"];
            [dicCategory setObject:@"range_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"range_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        
        else if (i==8)
        {
            // km
            [dicCategory setValue:@"Body Type" forKey:@"type"];
            [dicCategory setObject:@"bodytype_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"bodytype_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        
        else if (i==9)
        {
            [dicCategory setValue:@"Ownership" forKey:@"type"];
            [dicCategory setObject:@"user_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"user_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        else if(i==10)
        {
            // Year Of car
            [dicCategory setValue:@"Transmission" forKey:@"type"];
            [dicCategory setObject:@"transmission_used_unselected" forKey:@"image"];
            [dicCategory setObject:@"transmission_used_selected" forKey:@"image_selected"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        [filterArr addObject:dicCategory];
    }
//==============================Sort By filter=====================================//
    for (int i=0; i<9; i++) {
        NSMutableDictionary *dicCategory =[[NSMutableDictionary alloc] init] ;
        
        if (i==0)
        {
            [dicCategory setValue:@"Price(Low to High)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==1)
        {
            [dicCategory setValue:@"Price(High to Low)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==2)
        {
            [dicCategory setValue:@"Certification Score(High to Low)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==3)
        {
            [dicCategory setValue:@"Year (Oldest to Newest)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==4)
        {
            [dicCategory setValue:@"Year (Newest to Oldest)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==5)
        {
            [dicCategory setValue:@"Kilometers (Low to High)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==6)
        {
            [dicCategory setValue:@"Kilometers (Low to High)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==7)
        {
            [dicCategory setValue:@"Kilometers (High to low)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
            
        }
        if (i==8)
        {
            [dicCategory setValue:@"Last Updated (Oldest to Latest)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
        }
        if (i==9)
        {
            [dicCategory setValue:@"Last Updated (Latest to Oldest)" forKey:@"type_sortby"];
            [dicCategory setValue:@"No" forKey:@"isSelect"];
        }
        [sortByArr addObject:dicCategory];
    
    }
//======================================================================================//
    for (int i=0; i<2; i++) {
        NSMutableDictionary *dicCategory =[[NSMutableDictionary alloc] init] ;
        
        if (i==0)
        {
            [dicCategory setObject:@"auto_icon" forKey:@"Trans_img"];
            [dicCategory setObject:@"auto_selected" forKey:@"select_Trans_img"];
            [dicCategory setValue:@"Automatic" forKey:@"Trans_name"];
            
        }
        if (i==1)
        {
            [dicCategory setObject:@"manual_icon" forKey:@"Trans_img"];
            [dicCategory setObject:@"manual_selected" forKey:@"select_Trans_img"];
            [dicCategory setValue:@"Manual" forKey:@"Trans_name"];
            
        }
        [transCarTypeArr addObject:dicCategory];
        [transCarTypeArr setValue:@"No" forKey:@"isSelect"];
    }
//======================================================================================//
    for (int i=0; i<5; i++) {
        NSMutableDictionary *dicCategory =[[NSMutableDictionary alloc] init] ;
        
        if (i==0)
        {
            [dicCategory setObject:@"fuel_used_unselected" forKey:@"Fule_type_image"];
            [dicCategory setObject:@"fuel_used_selected" forKey:@"Selected_Fule_type_image"];
            
            [dicCategory setValue:@"Petrol" forKey:@"Fule_name"];
            
        }else if (i==1)
        {
            [dicCategory setObject:@"fuel_used_unselected" forKey:@"Fule_type_image"];
            [dicCategory setObject:@"fuel_used_selected" forKey:@"Selected_Fule_type_image"];
            [dicCategory setValue:@"Diesel" forKey:@"Fule_name"];
            
        }else if (i==2)
        {
            [dicCategory setObject:@"electric_used_unselected" forKey:@"Fule_type_image"];
            [dicCategory setObject:@"electric_used_selected" forKey:@"Selected_Fule_type_image"];
            [dicCategory setValue:@"Electric" forKey:@"Fule_name"];
            
        }else if (i==3)
        {
            [dicCategory setObject:@"cng_used_unselected" forKey:@"Fule_type_image"];
            [dicCategory setObject:@"cng_used_selected" forKey:@"Selected_Fule_type_image"];
            [dicCategory setValue:@"CNG" forKey:@"Fule_name"];
            
        }else if (i==4)
        {
            [dicCategory setObject:@"lpg_used_unselected" forKey:@"Fule_type_image"];
            [dicCategory setObject:@"lpg_used_selected" forKey:@"Selected_Fule_type_image"];
            [dicCategory setValue:@"LPG" forKey:@"Fule_name"];
            
        }
        [fuelTypeArr addObject:dicCategory];
        [fuelTypeArr setValue:@"No" forKey:@"isSelect"];
    }
    
    
//======================================================================================//
    for (int i=0; i<4; i++) {
        NSMutableDictionary *dicCategory =[[NSMutableDictionary alloc] init] ;
        if(i==0)
        {
            [dicCategory setObject:@"user_used_unselected" forKey:@"owner_type_image_unselected"];
            [dicCategory setObject:@"user_used_selected" forKey:@"owner_type_image_selected"];
            [dicCategory setValue:@"First Owner" forKey:@"owner_type_name"];
        }
        if(i==1)
        {
            [dicCategory setObject:@"two_plus_used_unselected" forKey:@"owner_type_image_unselected"];
            [dicCategory setObject:@"two_plus_used_selected" forKey:@"owner_type_image_selected"];
            [dicCategory setValue:@"Second Owner" forKey:@"owner_type_name"];
        }
        if(i==2)
        {
            [dicCategory setObject:@"two_plus_used_unselected" forKey:@"owner_type_image_unselected"];
            [dicCategory setObject:@"two_plus_used_selected" forKey:@"owner_type_image_selected"];
            [dicCategory setValue:@"Third or More Owners" forKey:@"owner_type_name"];
        }
        if(i==3)
        {
            [dicCategory setObject:@"registered_used_unselected" forKey:@"owner_type_image_unselected"];
            [dicCategory setObject:@"registered_used_selected" forKey:@"owner_type_image_selected"];
            [dicCategory setValue:@"Unregistered Cars" forKey:@"owner_type_name"];
        }
        [ownerShipArr addObject:dicCategory];
        [ownerShipArr setValue:@"No" forKey:@"isSelect"];
    }
//======================================================================================//
    for (int i=0; i<2; i++) {
        NSMutableDictionary *dicCategory =[[NSMutableDictionary alloc] init] ;
        if(i==0)
        {
            [dicCategory setObject:@"autoauto_used_unselected" forKey:@"transmission_type_image_unselected"];
            [dicCategory setObject:@"autoauto_used_selected" forKey:@"transmission_type_image_selected"];
            [dicCategory setValue:@"Automatic" forKey:@"trans_type_name"];
        }
        if(i==1)
        {
            [dicCategory setObject:@"manual_used_unselected" forKey:@"transmission_type_image_unselected"];
            [dicCategory setObject:@"manual_used_selected.png" forKey:@"transmission_type_image_selected"];
            [dicCategory setValue:@"Manual" forKey:@"trans_type_name"];
        }
        [transMissionArr addObject:dicCategory];
        [transMissionArr setValue:@"No" forKey:@"isSelect"];
    }
//===============================================================================//
    for (int i=0; i<6; i++) {
        NSMutableDictionary *dicCategory =[[NSMutableDictionary alloc] init] ;
        if(i==0)
        {
            [dicCategory setObject:@"sedan_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory setObject:@"sedan_selected" forKey:@"Body_type_image_selected"];
            [dicCategory setValue:@"Sendan" forKey:@"body_type_name"];
        }
        if(i==1)
        {
            [dicCategory setObject:@"Minivan_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory setObject:@"Minivan_selected" forKey:@"Body_type_image_selected"];
            [dicCategory setValue:@"Minivan" forKey:@"body_type_name"];
        }
        if(i==2)
        {
            [dicCategory setObject:@"hatchback_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory setObject:@"hatchback_selected" forKey:@"Body_type_image_selected"];
            [dicCategory setValue:@"Hatchback" forKey:@"body_type_name"];
        }
        if(i==3)
        {
            [dicCategory setObject:@"suv_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory setObject:@"suv_selected" forKey:@"Body_type_image_selected"];
            [dicCategory setValue:@"SUV" forKey:@"body_type_name"];
        }
        if(i==4)
        {
            [dicCategory setObject:@"truck_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory setObject:@"truck_selected" forKey:@"Body_type_image_selected"];
            [dicCategory setValue:@"Truck" forKey:@"body_type_name"];
        }
        if(i==5)
        {
            [dicCategory setObject:@"couple_unselected" forKey:@"Body_type_image_unselected"];
            [dicCategory setObject:@"couple_selected" forKey:@"Body_type_image_selected"];
            [dicCategory setValue:@"Couple" forKey:@"body_type_name"];
        }
        [bodyTypeArr addObject:dicCategory];
        [bodyTypeArr setValue:@"No" forKey:@"isSelect"];
    }
    
//===============================================================================//
    cityNameArr =[[NSMutableArray alloc]init];
    [cityNameArr addObject:@"New Delhi"];
    [cityNameArr addObject:@"Mumbai"];
    [cityNameArr addObject:@"Ahmedabad"];
    [cityNameArr addObject:@"Pune"];
    [cityNameArr addObject:@"Banalore"];
    [cityNameArr addObject:@"Kolkata"];
    [cityNameArr addObject:@"Chennai"];
//===============================================================================//
    [self headerFrame];
    [self setframe];
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
    lblHeader.text = @"Used Cars Filter";
    lblHeader.font = [UIFont boldSystemFontOfSize:15];
    [navView addSubview:lblHeader];
}
-(void)setframe
{
    int y=64;
    selectFilterTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, y,DEVICE_WIDTH , 40)];
    selectFilterTypeView.backgroundColor =[UIColor clearColor];
    selectFilterTypeView.userInteractionEnabled=YES;
    [self.view addSubview:selectFilterTypeView];
    
//===================Segment Controler For filter,SortBy and Reset ====================//
    
    segmentedControlFilter = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"FILTERS", @"SORT"]];
    [segmentedControlFilter setFrame:CGRectMake(0, 0, DEVICE_WIDTH-40, 40)];
    [segmentedControlFilter setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Selected index %ld (via block)", (long)index);
        
        if(index==1)
        {
            [tblFilter reloadData];
        }
        else
        {
            [tblFilter reloadData];
        }
    }];
    segmentedControlFilter.selectionIndicatorHeight = 1.5f;
    segmentedControlFilter.backgroundColor = [UIColor clearColor];
    segmentedControlFilter.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor]};
    segmentedControlFilter.selectedSegmentIndex = 0;
    segmentedControlFilter.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    segmentedControlFilter.selectionIndicatorColor = [UIColor orangeColor];
    segmentedControlFilter.selectionIndicatorBoxColor = [UIColor clearColor];
    segmentedControlFilter.selectionIndicatorBoxOpacity = 1.0;
    segmentedControlFilter.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControlFilter.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControlFilter.shouldAnimateUserSelection = YES;
    segmentedControlFilter.tag = 2;
    [segmentedControlFilter addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [selectFilterTypeView addSubview:segmentedControlFilter];
    
    UIImageView *btnRestimg = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-35, 5,20 ,20)];
    btnRestimg.image = [UIImage imageNamed:@"reload_filter_icon"];
    btnRestimg.clipsToBounds=YES;
    btnRestimg.contentMode = UIViewContentModeScaleAspectFit;
    [selectFilterTypeView addSubview:btnRestimg];
    
    UILabel *lblRestBtn = [[UILabel alloc] init];
    lblRestBtn.frame = CGRectMake(DEVICE_WIDTH-45, 25, 40, 20);
    lblRestBtn.text = @"Reset";
    lblRestBtn.textAlignment = NSTextAlignmentCenter;
    lblRestBtn.font = [UIFont systemFontOfSize:10.0];
    lblRestBtn.font = [UIFont systemFontOfSize:10.0];
    lblRestBtn.textColor = [UIColor lightGrayColor];
    [selectFilterTypeView addSubview:lblRestBtn];
    
    UIButton *btnRest = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-40, 0, 40, 40)];
    btnRest.backgroundColor = [UIColor clearColor];
    [btnRest addTarget:self action:@selector(btnRestClicked:) forControlEvents:UIControlEventTouchUpInside];
    [selectFilterTypeView addSubview:btnRest];
    
//===================tableview Show Filter And sort by data====================//
   
    y=y+40;
    tblFilter =[[UITableView alloc]initWithFrame:CGRectMake(0,y,DEVICE_WIDTH, DEVICE_HEIGHT-y-10) style:UITableViewStylePlain];
    [tblFilter setBackgroundColor:[UIColor clearColor]];
    tblFilter.showsVerticalScrollIndicator = NO;
    tblFilter.showsHorizontalScrollIndicator=NO;
    [tblFilter setDelegate:self];
    [tblFilter setDataSource:self];
    tblFilter.bounces = NO;
    tblFilter.layer.masksToBounds = YES;
    [tblFilter setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblFilter];
}

#pragma mark -Segment-Controller Method
-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            [tblFilter reloadData];
            break;
        }
        case 1:{
            [tblFilter reloadData];
            break;
        }
    }
}

#pragma mark - UItableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(!ismainTable){
        return 1;
    }else{
        if(segmentedControlFilter.selectedSegmentIndex == 1){
                return [sortByArr count];
            }else{
                return [filterArr count];
            }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   if(!ismainTable){
       return 0;
    }else{
   if(segmentedControlFilter.selectedSegmentIndex == 1){
            return 45;
        }else{
            if(section==3||section==6||section==7)
            {
                return 95;
            }
            else
            {
                return 65;
            }
        }
    return 0;
}
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(!ismainTable)
    {
        return nil;
     
    }
    else
    {
        UIView * sectionHeader = [[UIView alloc] init];;
        if(segmentedControlFilter.selectedSegmentIndex == 1)
            {
                sectionHeader.frame = CGRectMake(0,0 , DEVICE_WIDTH, 40);
    sectionHeader.backgroundColor = [UIColor colorWithRed:223.0/265.0 green:224.0/265.0 blue:224.0/265.0 alpha:0.5];
        
                UIView *viewData = [[UIView alloc] initWithFrame:CGRectMake(10, 10, sectionHeader.frame.size.width-20,sectionHeader.frame.size.height-10 )];
                viewData.backgroundColor = [UIColor whiteColor];
                [sectionHeader addSubview:viewData];
        
                UILabel *lblFilterType2 = [[UILabel alloc] initWithFrame:CGRectMake(10, viewData.frame.size.height/2-10,viewData.frame.size.width-10, 20)];
                lblFilterType2.textAlignment = NSTextAlignmentLeft;
                lblFilterType2.text =[[sortByArr objectAtIndex:section]valueForKey:@"type_sortby"];
                
               // lblFilterType.font = [UIFont fontWithName:FONT size:15.0f];
                lblFilterType2.font = [UIFont systemFontOfSize:15.0f];
                [viewData addSubview:lblFilterType2];

    }
    else
    {
        if(section==3||section==6||section==7)
        {
            sectionHeader.frame = CGRectMake(0,0 , DEVICE_WIDTH, 90);
            sectionHeader.backgroundColor = [UIColor colorWithRed:223.0/265.0 green:224.0/265.0 blue:224.0/265.0 alpha:0.5];
            
            UIView *viewData = [[UIView alloc] initWithFrame:CGRectMake(10, 10, sectionHeader.frame.size.width-20,sectionHeader.frame.size.height-10 )];
            viewData.backgroundColor = [UIColor whiteColor];
            [sectionHeader addSubview:viewData];
        
           
            if(section==3)
            {
                imageShow3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44,22)];
                imageShow3.backgroundColor = [UIColor clearColor];
                imageShow3.image = [UIImage imageNamed:[[filterArr objectAtIndex:section]valueForKey:@"image"]];
                imageShow3.clipsToBounds=YES;
                imageShow3.contentMode = UIViewContentModeScaleAspectFit;
                [viewData addSubview:imageShow3];
                
                rangeSlider3 = [[TTRangeSlider alloc] initWithFrame:CGRectMake(10,30, DEVICE_WIDTH-50, 40)];
                rangeSlider3.tag=section;
                rangeSlider3.delegate=self;
                rangeSlider3.minValue =1;
                rangeSlider3.maxValue = 30;
                rangeSlider3.selectedMinimum =1;
                rangeSlider3.selectedMaximum = 30;
                rangeSlider3.tintColorBetweenHandles = [UIColor lightGrayColor];
                rangeSlider3.handleColor = [UIColor whiteColor];
                rangeSlider3.lineHeight = 4.0f;
                rangeSlider3.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
                rangeSlider3.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];
                [rangeSlider3 setHandleImage:[UIImage imageNamed:@"scrollcircle_icon"]];
                [rangeSlider3 addTarget:self action:@selector(changePriceRange:) forControlEvents:UIControlEventValueChanged];
                [viewData addSubview:rangeSlider3];
                
                lblrangeShow3 = [[UILabel alloc] initWithFrame:CGRectMake(70, 10,viewData.frame.size.width, 20)];
                lblrangeShow3.textAlignment = NSTextAlignmentLeft;
                lblrangeShow3.text =[[filterArr objectAtIndex:section]valueForKey:@"type"];
                [viewData addSubview:lblrangeShow3];
            }
            else if(section==6)
            {
                imageShow6 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44,22)];
                imageShow6.backgroundColor = [UIColor clearColor];
                imageShow6.image = [UIImage imageNamed:[[filterArr objectAtIndex:section]valueForKey:@"image"]];
                imageShow6.clipsToBounds=YES;
                imageShow6.contentMode = UIViewContentModeScaleAspectFit;
                [viewData addSubview:imageShow6];
                
                rangeSlider6 = [[TTRangeSlider alloc] initWithFrame:CGRectMake(10,30, DEVICE_WIDTH-50, 40)];
                rangeSlider6.tag=section;
                rangeSlider6.delegate=self;
                rangeSlider6.minValue =0;
                rangeSlider6.maxValue = 8;
                rangeSlider6.selectedMinimum =0;
                rangeSlider6.selectedMaximum = 8;
                rangeSlider6.tintColorBetweenHandles = [UIColor lightGrayColor];
                rangeSlider6.handleColor = [UIColor whiteColor];
                rangeSlider6.lineHeight = 4.0f;
                rangeSlider6.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
                rangeSlider6.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];
                [rangeSlider6 setHandleImage:[UIImage imageNamed:@"scrollcircle_icon"]];
                [rangeSlider6 addTarget:self action:@selector(changePriceRange:) forControlEvents:UIControlEventValueChanged];
                [viewData addSubview:rangeSlider6];
                
                lblrangeShow6 = [[UILabel alloc] initWithFrame:CGRectMake(70, 10,viewData.frame.size.width, 20)];
                lblrangeShow6.textAlignment = NSTextAlignmentLeft;
                lblrangeShow6.text =[[filterArr objectAtIndex:section]valueForKey:@"type"];
                [viewData addSubview:lblrangeShow6];
            }
            else if(section==7)
            {
                imageShow7 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44,22)];
                imageShow7.backgroundColor = [UIColor clearColor];
                imageShow7.image = [UIImage imageNamed:[[filterArr objectAtIndex:section]valueForKey:@"image"]];
                imageShow7.clipsToBounds=YES;
                imageShow7.contentMode = UIViewContentModeScaleAspectFit;
                [viewData addSubview:imageShow7];
                
                rangeSlider7 = [[TTRangeSlider alloc] initWithFrame:CGRectMake(10,30, DEVICE_WIDTH-50, 40)];
                rangeSlider7.tag=section;
                rangeSlider7.delegate=self;
                rangeSlider7.minValue =5000;
                rangeSlider7.maxValue = 80000;
                rangeSlider7.selectedMinimum =5000;
                rangeSlider7.selectedMaximum =80000;
                rangeSlider7.tintColorBetweenHandles = [UIColor lightGrayColor];
                rangeSlider7.handleColor = [UIColor whiteColor];
                rangeSlider7.lineHeight = 4.0f;
                rangeSlider7.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
                rangeSlider7.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];
                [rangeSlider7 setHandleImage:[UIImage imageNamed:@"scrollcircle_icon"]];
                [rangeSlider7 addTarget:self action:@selector(changePriceRange:) forControlEvents:UIControlEventValueChanged];
                [viewData addSubview:rangeSlider7];
                
                lblrangeShow7 = [[UILabel alloc] initWithFrame:CGRectMake(70, 10,viewData.frame.size.width, 20)];
                lblrangeShow7.textAlignment = NSTextAlignmentLeft;
                lblrangeShow7.text =[[filterArr objectAtIndex:section]valueForKey:@"type"];
                [viewData addSubview:lblrangeShow7];
            }
        }
        else
        {
            sectionHeader.frame = CGRectMake(0,0 , DEVICE_WIDTH, 60);
            sectionHeader.backgroundColor = [UIColor colorWithRed:223.0/265.0 green:224.0/265.0 blue:224.0/265.0 alpha:0.5];
            UIView *viewData = [[UIView alloc] initWithFrame:CGRectMake(10, 10, sectionHeader.frame.size.width-20,sectionHeader.frame.size.height-10 )];
            viewData.backgroundColor = [UIColor whiteColor];
            [sectionHeader addSubview:viewData];
            
            imageShow = [[UIImageView alloc] initWithFrame:CGRectMake(10, viewData.frame.size.height/2-11, 44, 22)];
            imageShow.backgroundColor = [UIColor clearColor];
            if ([[[filterArr objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
            {
                if(section==0)
                {
                    if (getCitYString == (id)[NSNull null] || getCitYString.length == 0 )
                    {
                        imageShow.image = [UIImage imageNamed:[[filterArr objectAtIndex:section]valueForKey:@"image"]];
                    }
                    else
                    {
                        imageShow.image = [UIImage imageNamed:[[filterArr objectAtIndex:section]valueForKey:@"image_selected"]];
                    }
                }
                else
                {
                    imageShow.image = [UIImage imageNamed:[[filterArr objectAtIndex:section]valueForKey:@"image_selected"]];
                }
            }
            else
            {
                imageShow.image = [UIImage imageNamed:[[filterArr objectAtIndex:section]valueForKey:@"image"]];
            }
            imageShow.clipsToBounds=YES;
            imageShow.contentMode = UIViewContentModeScaleAspectFit;
            [viewData addSubview:imageShow];
            
            lblFilterType = [[UILabel alloc] initWithFrame:CGRectMake(70, viewData.frame.size.height/2-10,viewData.frame.size.width, 20)];
            lblFilterType.textAlignment = NSTextAlignmentLeft;
            lblFilterType.text =[[filterArr objectAtIndex:section]valueForKey:@"type"];
            if ([[[filterArr objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
            {
                if(section==0)
                {
                    if (getCitYString == (id)[NSNull null] || getCitYString.length == 0 )
                    {
                        lblFilterType.textColor = Label_title_color;
                        lblFilterType.font = [UIFont systemFontOfSize:15.0f];
                    }
                    else
                    {
                        lblFilterType.textColor = [UIColor blackColor];
                        lblFilterType.font = [UIFont boldSystemFontOfSize:15.0f];
                    }
                }
                else
                {
                    lblFilterType.textColor = [UIColor blackColor];
                    lblFilterType.font = [UIFont boldSystemFontOfSize:15.0f];
                }
            }
            else
            {
                lblFilterType.textColor = Label_title_color;
                lblFilterType.font = [UIFont systemFontOfSize:15.0f];
            }
            [viewData addSubview:lblFilterType];
            
            if(section == 0 ||section == 4 || section == 5 || section == 8 || section == 9 || section == 10 )
            {
                imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(viewData.frame.size.width-20, viewData.frame.size.height/2-5, 14, 10)];
                imageArrow.backgroundColor = [UIColor clearColor];
                imageArrow.image = [UIImage imageNamed:@"right_filter_arrow"];
                imageArrow.clipsToBounds=YES;
                imageArrow.contentMode = UIViewContentModeScaleAspectFit;
                [viewData addSubview:imageArrow];
            }
            
            btnSelectFilterType = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , DEVICE_WIDTH, 90)];
            btnSelectFilterType.backgroundColor = [UIColor clearColor];
            [btnSelectFilterType addTarget:self action:@selector(btnHeaderClicked:) forControlEvents:UIControlEventTouchUpInside];
            btnSelectFilterType.tag = section;
            [sectionHeader addSubview:btnSelectFilterType];
            
            if ([[[filterArr objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
            {
                if(section==0)
                {
                    if (getCitYString == (id)[NSNull null] || getCitYString.length == 0 )
                    {
                        btnUnselectCity.hidden=YES;
                    }
                    else{
                        btnUnselectCity.hidden=NO;
                        imageArrow.hidden=YES;
                        btnUnselectCity = [[UIButton alloc] initWithFrame:CGRectMake(viewData.frame.size.width-20, viewData.frame.size.height/2, 20, 20)];
                        [btnUnselectCity setImage:[UIImage imageNamed:@"cancel_filter_icon"] forState:UIControlStateNormal];
                        btnUnselectCity.backgroundColor = [UIColor clearColor];
                        [btnUnselectCity addTarget:self action:@selector(btnUnselectCity:) forControlEvents:UIControlEventTouchUpInside];
                        [sectionHeader addSubview:btnUnselectCity];
                    }
                }
            }
        }
    }
    return sectionHeader;
}

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!ismainTable)
    {
        return 44;
    }
    else
    {
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Fuel Type"])
            {
                return 80.0;
            }
        
        }
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Ownership"])
            {
                return 50.0;
            }
            
        }
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Transmission"])
            {
                return 50.0;
            }
            
        }
        
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Body Type"])
            {
                return 80.0;
            }
        }
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!ismainTable)
    {
        if (isSearching == YES)
        {
            return searchResults.count;
        }
        else
        {
            return cityNameArr.count;
        }
        return 0;
    }
    else
    {
        if ([[[filterArr objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
             if ([[[filterArr objectAtIndex:section]valueForKey:@"type"]isEqualToString:@"Fuel Type"])
            {
                int no =[fuelTypeArr count] /3;
                return ([fuelTypeArr count] %3 > 0 ? no+1 : no);
            }
        }
        if ([[[filterArr objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:section]valueForKey:@"type"]isEqualToString:@"Ownership"])
            {
                return [ownerShipArr count];
            }
        }
        
        if ([[[filterArr objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:section]valueForKey:@"type"]isEqualToString:@"Body Type"])
            {
                int no =[bodyTypeArr count] /3;
                return ([bodyTypeArr count] %3 > 0 ? no+1 : no);
            }
            
        }
        if ([[[filterArr objectAtIndex:section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:section]valueForKey:@"type"]isEqualToString:@"Transmission"])
            {
                return [transMissionArr count];
            }
            
        }
            
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!ismainTable)
    {
        static NSString *stringIdntifier = @"Cellid";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringIdntifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringIdntifier];
        }
        if(isSearching)
        {
            cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
            
            return cell;
        }
        else
        {
            cell.textLabel.text = [cityNameArr objectAtIndex:indexPath.row];
            return cell;
        }
        return cell;
    }
    else
    {
     if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
     {
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Fuel Type"])
        {
            NSString *cellID = nil;
            FuleTypeTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell != nil)
                return cell;
            cell=[[FuleTypeTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            [cell setGalleryDetail:[fuelTypeArr mutableCopy]  atIndexPath:indexPath imagePath:nil];
            return cell;
        }
    }
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Body Type"])
            {
                NSString *cellID = nil;
                BodyTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell != nil)
                    return cell;
                cell=[[BodyTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.contentView setBackgroundColor:[UIColor clearColor]];
                [cell setGalleryDetail:[bodyTypeArr mutableCopy]  atIndexPath:indexPath imagePath:nil];
                return cell;
            }
        }
        
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Ownership"])
            {
                NSString *cellID = nil;
                ownerShipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell != nil)
                    return cell;
                cell=[[ownerShipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.ownerImg.image = [UIImage imageNamed:[[ownerShipArr objectAtIndex:indexPath.row] valueForKey:@"owner_type_image_unselected"]];
                cell.ownerlbl.text = [[ownerShipArr objectAtIndex:indexPath.row] valueForKey:@"owner_type_name"];

                return cell;
            }
        }
        if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            if ([[[filterArr objectAtIndex:indexPath.section]valueForKey:@"type"]isEqualToString:@"Transmission"])
            {
                NSString *cellID = nil;
                TransmissionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell != nil)
                    return cell;
                cell=[[TransmissionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.transImg.image = [UIImage imageNamed:[[transMissionArr objectAtIndex:indexPath.row] valueForKey:@"transmission_type_image_unselected"]];
                cell.translbl.text = [[transMissionArr objectAtIndex:indexPath.row] valueForKey:@"trans_type_name"];
                
                return cell;
            }
        }
    return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!ismainTable)
    {
        if(isSearching)
        {
            if(getCitYString == (id)[NSNull null] || getCitYString.length == 0 )
            {
                imageShow.hidden=NO;
                btnUnselectCity.hidden = YES;
                
            }
            else
            {
                btnUnselectCity.hidden = NO;
            }
            getCitYString = [searchResults objectAtIndex:indexPath.row];
            btnSelectFilterType.hidden=NO;
            selectFilterTypeView.hidden = NO;
            tblFilter.hidden = NO;
            selectLocatioView.hidden =YES;
            tblLocation.hidden =YES;
            ismainTable =YES;
            searchCity.showsCancelButton = NO;
            [searchCity resignFirstResponder];
            [tblFilter reloadData];
        }
        else
        {
            if(getCitYString == (id)[NSNull null] || getCitYString.length == 0 )
            {
                btnSelectFilterType.hidden=NO;
            }
            else
            {
                btnSelectFilterType.hidden=NO;
            }
            getCitYString = [cityNameArr objectAtIndex:indexPath.row];
            btnSelectFilterType.hidden=NO;
            selectFilterTypeView.hidden = NO;
            tblFilter.hidden = NO;
            selectLocatioView.hidden =YES;
            tblLocation.hidden =YES;
            ismainTable =YES;
            searchCity.showsCancelButton = NO;
            [searchCity resignFirstResponder];
            [tblFilter reloadData];
        }
    }
    else
    {
    
    
    }
}


#pragma mark - RangeSlider

- (void)changePriceRange:(TTRangeSlider *)sender
{
    NSLog(@"Standard slider updated. Min Value: %.0f Max Value: %.0f", sender.selectedMinimum, sender.selectedMaximum);
    
    [NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
    
    NSString * strmininumuValue = [NSString stringWithFormat:@"%.0f",sender.selectedMinimum];
    NSString * selectedMaximum = [NSString stringWithFormat:@"%.0f",sender.selectedMaximum];
    NSLog(@"Prabhuu==>%@",strmininumuValue);

    {
        if(sender == rangeSlider3)
        {
            if([strmininumuValue isEqualToString:@"1"] && [selectedMaximum isEqualToString:@"30"])
            {
                lblrangeShow3.text =@"All Range";
                imageShow3.image = [UIImage imageNamed:[[filterArr objectAtIndex:sender.tag]valueForKey:@"image"]];
            }
            else
            {
                if([strmininumuValue isEqualToString:@"1"])
                {
                    NSString *abovePrice = @"Below";
                    lblrangeShow3.text =[NSString stringWithFormat:@" %@  $ %.0f", abovePrice, sender.selectedMaximum];
                }
                else if ([selectedMaximum isEqualToString:@"30"])
                {
                    NSString *BelowPrice = @"Above";
                    lblrangeShow3.text =[NSString stringWithFormat:@" %@ - $ %.0f",BelowPrice, sender.selectedMinimum];
                }
                else
                {
                    lblrangeShow3.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
                }
                
                imageShow3.image = [UIImage imageNamed:[[filterArr objectAtIndex:sender.tag]valueForKey:@"image_selected"]];
            }
        }
       else if(sender == rangeSlider6)
        {
            if([strmininumuValue isEqualToString:@"0"] && [selectedMaximum isEqualToString:@"8"])
            {
                lblrangeShow6.text =@"All Range";
                imageShow6.image = [UIImage imageNamed:[[filterArr objectAtIndex:sender.tag]valueForKey:@"image"]];
            }
            else
            {
                if([strmininumuValue isEqualToString:@"0"])
                {
                    if([strmininumuValue isEqualToString:@"0"]  && [selectedMaximum isEqualToString:@"0"])
                    {
                        lblrangeShow6.text =@"Below Upto 1 year old";
                    }
                    else
                    {
                        lblrangeShow6.text =[NSString stringWithFormat:@"Below %.0f year old",sender.selectedMaximum];
                    }
                }
                else if ([selectedMaximum isEqualToString:@"8"])
                {
                    if([selectedMaximum isEqualToString:@"8"] && [strmininumuValue isEqualToString:@"8"])
                    {
                        lblrangeShow6.text =@"Above More than 8 Year old";
                    }else
                    {
                        lblrangeShow6.text =[NSString stringWithFormat:@"Above %.0f year old", sender.selectedMinimum];
                    }
                }
                
                else
                {
                    lblrangeShow6.text =[NSString stringWithFormat:@" %.0f year old -  %.0f year old", sender.selectedMinimum, sender.selectedMaximum];
                }
                 imageShow6.image = [UIImage imageNamed:[[filterArr objectAtIndex:sender.tag]valueForKey:@"image_selected"]];
            }
        }
       else if(sender == rangeSlider7)
        {
            if([strmininumuValue isEqualToString:@"5000"] && [selectedMaximum isEqualToString:@"80000"])
            {
                lblrangeShow7.text =@"All Range";
                imageShow7.image = [UIImage imageNamed:[[filterArr objectAtIndex:sender.tag]valueForKey:@"image"]];
            }
            else
            {
                if([strmininumuValue isEqualToString:@"5000"])
                {
                    if([strmininumuValue isEqualToString:@"5000"]  && [selectedMaximum isEqualToString:@"5000"])
                    {
                        lblrangeShow7.text =@"Below Upto 5000km";
                    }
                    else
                    {
                        lblrangeShow7.text =[NSString stringWithFormat:@"Below %.0f km",sender.selectedMaximum];
                    }
                }
                else if ([selectedMaximum isEqualToString:@"80000"])
                {
                    if([selectedMaximum isEqualToString:@"80000"] && [strmininumuValue isEqualToString:@"80000"])
                    {
                        lblrangeShow7.text =@"Above More than 80000km";
                    }else
                    {
                        lblrangeShow7.text =[NSString stringWithFormat:@"Above %.0fkm", sender.selectedMinimum];
                    }
                }
                else
                {
                    lblrangeShow7.text =[NSString stringWithFormat:@"%.0f km - $%.0f Km", sender.selectedMinimum, sender.selectedMaximum];
                }
             imageShow7.image = [UIImage imageNamed:[[filterArr objectAtIndex:sender.tag]valueForKey:@"image_selected"]];
            }
        }
        
    }
}
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum;
{
   /* if(sender.tag==3)
    {
        if(selectedMinimum==1.0f && selectedMaximum==30.f)
        {
            lblrangeShow.text =@"All Range";
        }
        else
        {
            lblrangeShow.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
        }
    }
    if(sender.tag==6)
    {
        if(selectedMinimum==1.0f && selectedMaximum==30.f)
        {
            lblrangeShow.text =@"All Range";
        }
        else
        {
            lblrangeShow.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
        }
    }
    if(sender.tag==7)
    {
        if(selectedMinimum==1.0f && selectedMaximum==30.f)
        {
            lblrangeShow.text =@"All Range";
        }
        else
        {
            lblrangeShow.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
        }
    }*/
    
}


#pragma mark - Search Delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText1
{
    
    
    if ([searchText1 length]>0)
    {
        [self filterContentForSearchText:searchText1];
        searchBar.showsCancelButton = YES;
        
    }
    else
    {
        searchCity.showsCancelButton = NO;
        [searchCity resignFirstResponder];
        isSearching = NO;
        [tblLocation reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchStr1 = [NSString stringWithFormat:@"%@",searchBar.text];
    
    if (searchStr1.length >0)
    {
        
        searchCity.showsCancelButton = YES;
        
    }
    [searchCity resignFirstResponder];
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    [self prefersStatusBarHidden];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    
}
-(void)filterContentForSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    searchResults =[[NSArray alloc] init];
    searchResults = [cityNameArr filteredArrayUsingPredicate:predicate];
    if (searchText == nil || [searchText isEqualToString:@""])
        isSearching = NO;
    else
        isSearching = YES;
    
    [tblLocation reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    searchBar.text = @"";
    isSearching=NO;
    [tblLocation reloadData];
    [searchBar resignFirstResponder];
    
}



#pragma mark - Button Action Method

-(void)backbtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)btnRestClicked:(id)sender
{

}
-(void)btnUnselectCity:(id)sender
{
     [[filterArr objectAtIndex:0]setValue:@"No" forKey:@"isSelect"];
        getCitYString=NULL;
    btnSelectFilterType.hidden=NO;
    [tblFilter reloadData];
    
}
-(void)btnHeaderClicked:(id)sender
{
     btnSelectFilterType.hidden=NO;
    btnSelectFilterType = (UIButton *)sender;
//    [filterArr setValue:@"No" forKey:@"isSelect"];
//    [[filterArr objectAtIndex:btnSelectFilterType.tag]setValue:@"yes" forKey:@"isSelect"];
    NSLog(@"Filter Array=====>%@",filterArr);
    
            if([[[filterArr objectAtIndex:btnSelectFilterType.tag]valueForKey:@"isSelect"]isEqualToString:@"yes"]){
                if ([[[filterArr objectAtIndex:btnSelectFilterType.tag]valueForKey:@"type"]isEqualToString:@"Select City"])
                {
                    if ([[[filterArr objectAtIndex:btnSelectFilterType.tag]valueForKey:@"type"]isEqualToString:@"Select City"])
                    {
                        ismainTable = NO;
                        isSearching = NO;
                        [self SelectLocationView];
                        tblLocation.hidden=NO;
                        tblFilter.hidden=YES;
                        [tblLocation reloadData];
                    }
                }
                else
                {
                 [[filterArr objectAtIndex:btnSelectFilterType.tag]setValue:@"No" forKey:@"isSelect"];
                lblFilterType.textColor = Label_title_color;
                lblFilterType.font = [UIFont systemFontOfSize:15.0f];
                }
            }
            else{
                [[filterArr objectAtIndex:btnSelectFilterType.tag]setValue:@"yes" forKey:@"isSelect"];
                
                if ([[[filterArr objectAtIndex:btnSelectFilterType.tag]valueForKey:@"type"]isEqualToString:@"Select City"])
                {
                    ismainTable = NO;
                    isSearching = NO;
                    [self SelectLocationView];
                    tblLocation.hidden=NO;
                    tblFilter.hidden=YES;
                    [tblLocation reloadData];
                }
                
                lblFilterType.textColor = [UIColor blackColor];
                lblFilterType.font = [UIFont boldSystemFontOfSize:15.0f];
            }
        [tblFilter reloadData];
}

-(void)SelectLocationView
{
    
    selectFilterTypeView.hidden = YES;
    tblFilter.hidden = YES;
    
    selectLocatioView = [[UIView alloc] initWithFrame:CGRectMake(0 ,64 , DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    selectLocatioView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectLocatioView];
    
    UIView *serchBarbtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,selectLocatioView.frame.size.width , 50)];
    serchBarbtnView.backgroundColor = [UIColor whiteColor];
    [selectLocatioView addSubview:serchBarbtnView];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    //btnBack.backgroundColor = [UIColor yellowColor];
    [btnBack setImage:[UIImage imageNamed:@"back_filters_icon"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBackToMainTbl:) forControlEvents:UIControlEventTouchUpInside];
    [serchBarbtnView addSubview:btnBack];
    
    UILabel *lblSelectCity = [[UILabel alloc] initWithFrame:CGRectMake(serchBarbtnView.frame.size.width/2-50,0 ,100 ,40 )];
    lblSelectCity.text = @"Select City";
    lblSelectCity.textAlignment = NSTextAlignmentCenter;
   // lblSelectCity.font = [UIFont fontWithName:FONT size:15];
    lblSelectCity.font = [UIFont systemFontOfSize:15.0f];
    [serchBarbtnView addSubview:lblSelectCity];
    
    UIView *serchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 50,selectLocatioView.frame.size.width , 50)];
    serchBarView.backgroundColor = [UIColor whiteColor];
    [selectLocatioView addSubview:serchBarView];
    
    searchCity = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0 , serchBarView.frame.size.width, 49)];
    searchCity.delegate = self;
    searchCity.placeholder = @"Select City";
    searchCity.tintColor = [UIColor whiteColor];
    searchCity.barTintColor = [UIColor whiteColor];
    searchCity.layer.borderColor=[UIColor whiteColor].CGColor;
    searchCity.layer.borderWidth=0.0;
    [serchBarView addSubview:searchCity];
    
    UILabel * lblSearchLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49,serchBarView.frame.size.width, 1)];
    [lblSearchLine setBackgroundColor:[UIColor blackColor]];
    [serchBarView addSubview:lblSearchLine];
    
    tblLocation = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, selectLocatioView.frame.size.width, selectLocatioView.frame.size.height-100)];
    [tblLocation setBackgroundColor:[UIColor clearColor]];
    tblLocation.showsVerticalScrollIndicator = NO;
    tblLocation.showsHorizontalScrollIndicator=YES;
    [tblLocation setDelegate:self];
    [tblLocation setDataSource:self];
    tblLocation.bounces = NO;
    tblLocation.layer.masksToBounds = YES;
    [tblLocation setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [selectLocatioView addSubview:tblLocation];

}
-(void)btnBackToMainTbl:(id)sender
{
    if(getCitYString == (id)[NSNull null] || getCitYString.length == 0 )
    {
        [[filterArr objectAtIndex:btnSelectFilterType.tag]setValue:@"No" forKey:@"isSelect"];
        btnUnselectCity.hidden = YES;
        btnSelectFilterType.hidden=NO;
    }
    else
    {
        imageArrow.hidden=YES;
        btnUnselectCity.hidden = NO;
    
    }
    selectFilterTypeView.hidden = NO;
    tblFilter.hidden = NO;
    selectLocatioView.hidden =YES;
    tblLocation.hidden =YES;
    ismainTable =YES;
    [tblFilter reloadData];
}

-(void)selectFuleType:(id)sender
{
    if ([[[fuelTypeArr objectAtIndex:[sender tag]] valueForKey:@"isSelect"] isEqualToString:@"yes"])
    {
        [[fuelTypeArr objectAtIndex:[sender tag]] setValue:@"No" forKey:@"isSelect"];
    }
    else
    {
        [[fuelTypeArr objectAtIndex:[sender tag]] setValue:@"yes" forKey:@"isSelect"];
    }
    [tblFilter reloadData];
}
-(void)selectBodyType:(id)sender
{
    if ([[[bodyTypeArr objectAtIndex:[sender tag]] valueForKey:@"isSelect"] isEqualToString:@"yes"])
    {
        [[bodyTypeArr objectAtIndex:[sender tag]] setValue:@"No" forKey:@"isSelect"];
    }
    else
    {
        [[bodyTypeArr objectAtIndex:[sender tag]] setValue:@"yes" forKey:@"isSelect"];
    }
    [tblFilter reloadData];
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
