//
//  FIndCarVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/8/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "FindCarVC.h"
#import "CarBarndAndTypeCell.h"
#import "CarBrandAndTypeFlowlayout.h"
@interface FindCarVC ()

@end

@implementation FindCarVC
@synthesize rangeSlider;

#pragma mark - View Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    isCarBarnd = YES;
    isCarType = NO;
    CarTypeArr = [[NSMutableArray alloc] init];
    [self BrandNameAndCarType];
    self.navigationController.navigationBarHidden=YES;
    
    self.view.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    // Do any additional setup after loading the view.
    
    ////## Header frame####////
    [self headerFrame];
    
    //// #### Scrol view Frame ####//// We 
   
}
-(void)headerFrame
{
    viewHeader =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    viewHeader.backgroundColor =APP_HEADER_COLOR;
    [self.view addSubview:viewHeader];
    
//    lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, DEVICE_WIDTH-80, 44)];
//    lblHeaderTitle.text =@"New Cars";
//    lblHeaderTitle.textColor = [UIColor whiteColor];
//    lblHeaderTitle.textAlignment = NSTextAlignmentCenter;
//    [viewHeader addSubview:lblHeaderTitle];
    
//    btnBack =[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 44)];
//    [btnBack addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [viewHeader addSubview:btnBack];
    btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    [btnBack setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [viewHeader addSubview:btnBack];
    
    lblHeaderTitle =[[UILabel alloc]initWithFrame:CGRectMake(60,20,150,44)];
    lblHeaderTitle.textColor= [UIColor whiteColor];
    lblHeaderTitle.backgroundColor=[UIColor clearColor];
    lblHeaderTitle.textAlignment=NSTextAlignmentLeft;
    lblHeaderTitle.text = @"Used Cars";
    lblHeaderTitle.font = [UIFont boldSystemFontOfSize:20];
    [viewHeader addSubview:lblHeaderTitle];

}

-(void)scrlFrame
{
    scrolContent =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    scrolContent.backgroundColor =[UIColor clearColor];
    scrolContent.delegate=self;
    scrolContent.bounces= NO;
    [self.view addSubview:scrolContent];
    [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH,DEVICE_HEIGHT-64)];
    scrolContent.delaysContentTouches = NO;

    
    
    int yy=0;
    yy=yy+10;
    viewCarBrands = [[UIView alloc] initWithFrame:CGRectMake(0, yy, DEVICE_WIDTH, 325)];
    viewCarBrands.backgroundColor = [UIColor whiteColor];
    viewCarBrands.layer.shadowColor = [UIColor blackColor].CGColor;
    viewCarBrands.layer.shadowOffset = CGSizeMake(0, 1);
    viewCarBrands.layer.shadowOpacity = 1;
    viewCarBrands.layer.shadowRadius = 1;
    [scrolContent addSubview:viewCarBrands];

    btnBrands = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBrands.frame=CGRectMake(0, 0, DEVICE_WIDTH/3, 44);
    btnBrands.backgroundColor =[UIColor clearColor];
    [btnBrands setTitle:@"Brands" forState:UIControlStateNormal];
    [btnBrands setTitleColor:[APP_DELEGATE colorWithHexString:AppHeaderColor] forState:UIControlStateNormal];
    [btnBrands addTarget:self action:@selector(btnBrandsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewCarBrands addSubview:btnBrands];
    
    btnBudget = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBudget.frame=CGRectMake( DEVICE_WIDTH/3, 0, DEVICE_WIDTH/3, 44);
    btnBudget.backgroundColor =[UIColor clearColor];
    [btnBudget setTitle:@"Budget" forState:UIControlStateNormal];
    [btnBudget setTitleColor:[APP_DELEGATE colorWithHexString:AppHeaderColor] forState:UIControlStateNormal];
    [btnBudget addTarget:self action:@selector(btnButgetClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewCarBrands addSubview:btnBudget];
    
    btnBodyType = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBodyType.frame=CGRectMake( 2*DEVICE_WIDTH/3, 0, DEVICE_WIDTH/3, 44);
    btnBodyType.backgroundColor =[UIColor clearColor];
    [btnBodyType setTitle:@"Body Type" forState:UIControlStateNormal];
    [btnBodyType setTitleColor:[APP_DELEGATE colorWithHexString:AppHeaderColor] forState:UIControlStateNormal];
    [btnBodyType addTarget:self action:@selector(btnBodyTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewCarBrands addSubview:btnBodyType];
    
    sepCarDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, DEVICE_WIDTH/3, 2)];
    sepCarDetails.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [viewCarBrands addSubview:sepCarDetails];
    
  
    scrolCarDeatils = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 46, DEVICE_WIDTH, viewCarBrands.frame.size.height-46)];
    scrolCarDeatils.delegate=self;
    scrolCarDeatils.bounces= NO;
    scrolCarDeatils.pagingEnabled= YES;

    [viewCarBrands addSubview:scrolCarDeatils];
    [scrolCarDeatils setContentSize:CGSizeMake(DEVICE_WIDTH*3, viewCarBrands.frame.size.height-46)];
    scrolCarDeatils.delaysContentTouches = NO;
    
    [self carDetailFrame];
    
    
    yy=yy+335;
    lblFeaturedCars = [[UILabel alloc] initWithFrame:CGRectMake(0, yy,DEVICE_WIDTH, 20)];
    lblFeaturedCars.text =@"Featured Cars";
    lblFeaturedCars.font =[UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
    lblFeaturedCars.textAlignment=NSTextAlignmentCenter;
    lblFeaturedCars.textColor =[UIColor blackColor];
    [scrolContent addSubview:lblFeaturedCars];

    
    yy=yy+ 30;
    
    viewPopularCar = [[UIView alloc] initWithFrame:CGRectMake(0, yy, DEVICE_WIDTH, 300)];
    viewPopularCar.backgroundColor = [UIColor whiteColor];
    viewPopularCar.layer.shadowColor = [UIColor blackColor].CGColor;
    viewPopularCar.layer.shadowOffset = CGSizeMake(0, 1);
    viewPopularCar.layer.shadowOpacity = 1;
    viewPopularCar.layer.shadowRadius = 1;
    [scrolContent addSubview:viewPopularCar];
    
    btnPopular = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPopular.frame=CGRectMake(0, 0, DEVICE_WIDTH/2, 40);
    [btnPopular setTitle:@"Popular cars" forState:UIControlStateNormal];
    [btnPopular setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPopular.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [btnPopular addTarget:self action:@selector(btnUPopularClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewPopularCar addSubview:btnPopular];
    
    sepFeatureCar = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, DEVICE_WIDTH/2, 2)];
    sepFeatureCar.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [viewPopularCar addSubview:sepFeatureCar];
    
    btnJustLaunched = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJustLaunched.frame=CGRectMake(DEVICE_WIDTH/2,0, DEVICE_WIDTH/2, 40);
    [btnJustLaunched setTitle:@"Just Launched" forState:UIControlStateNormal];
    [btnJustLaunched setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnJustLaunched.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [btnJustLaunched addTarget:self action:@selector(btnJustLacuncedClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewPopularCar addSubview:btnJustLaunched];
    
    scrolFeatures =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 41, DEVICE_WIDTH, viewPopularCar.frame.size.height-81)];
    scrolFeatures.delegate=self;
    scrolFeatures.showsVerticalScrollIndicator=NO;
    scrolFeatures.showsHorizontalScrollIndicator=NO;
    scrolFeatures.bounces= NO;
    scrolFeatures.pagingEnabled =YES;
//    scrolFeatures.backgroundColor =[UIColor redColor];
    [viewPopularCar addSubview:scrolFeatures];
    
    [scrolFeatures setContentSize:CGSizeMake(DEVICE_WIDTH*2, viewPopularCar.frame.size.height-81)];
    
    viewPopular =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, scrolFeatures.frame.size.height)];
//    viewPopular.backgroundColor =[UIColor redColor];
    [scrolFeatures addSubview:viewPopular];
    
    viewJustLaunched =[[UIView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, scrolFeatures.frame.size.height)];
    [scrolFeatures addSubview:viewJustLaunched];
//    viewJustLaunched.backgroundColor =[UIColor redColor];
    
    /////// ### Popular View Frame #######/////
    [self popularCarsViewFrame];
    
    
    /////// ### Just Launched View Frame #######/////

    [self JustLaunchedFrame];
    
    
    btnmoreFeatureCars = [UIButton buttonWithType:UIButtonTypeCustom];
    btnmoreFeatureCars.frame=CGRectMake(30, viewPopularCar.frame.size.height-40, DEVICE_WIDTH-60, 40);
    [btnmoreFeatureCars setTitle:@"View More upcoming Cars" forState:UIControlStateNormal];
    [btnmoreFeatureCars setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnmoreFeatureCars.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [btnmoreFeatureCars addTarget:self action:@selector(btnMoreFeatureCarsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewPopularCar addSubview:btnmoreFeatureCars];

    

    
    
    yy=yy+ 310;
    
    viewComareCars = [[UIView alloc] initWithFrame:CGRectMake(0, yy, DEVICE_WIDTH, 230)];
    viewComareCars.backgroundColor = [UIColor whiteColor];
    viewComareCars.layer.shadowColor = [UIColor blackColor].CGColor;
    viewComareCars.layer.shadowOffset = CGSizeMake(0, 1);
    viewComareCars.layer.shadowOpacity = 1;
    viewComareCars.layer.shadowRadius = 1;
    [scrolContent addSubview:viewComareCars];
    
    /////// ### Popular View Frame #######/////
    [self compareCarsFrame];
    
    
    yy=yy+ 260;
    
    viewBuyingTools = [[UIView alloc] initWithFrame:CGRectMake(0, yy, DEVICE_WIDTH, 230)];
    viewBuyingTools.backgroundColor = [UIColor whiteColor];
    viewBuyingTools.layer.shadowColor = [UIColor blackColor].CGColor;
    viewBuyingTools.layer.shadowOffset = CGSizeMake(0, 1);
    viewBuyingTools.layer.shadowOpacity = 1;
    viewBuyingTools.layer.shadowRadius = 1;
    [scrolContent addSubview:viewBuyingTools];
    
    /////// ### Buying car View Frame #######/////
    [self buyingCarViewFrame];
    
    yy=yy+ 260;
    
    [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH,yy)];
}


#pragma mark - Button Action
-(void)backButtonClicked:(id)sender
{
   // [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}
-(void)btnUPopularClicked:(id)sender
{
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepFeatureCar cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.5 animations:^{
        sepFeatureCar.frame=CGRectMake(0, 38, DEVICE_WIDTH/2, 2);
        //        viewUpcomingCars.frame=CGRectMake(0, 41, DEVICE_WIDTH, 219);
        //        viewJustLaunchedCars.frame=CGRectMake(DEVICE_WIDTH, 41, DEVICE_WIDTH, 219);
    } completion:^(BOOL finished) {
    }];
    [scrolFeatures setContentOffset:CGPointMake(0, 0) animated:YES];

}
-(void)btnJustLacuncedClicked:(id)sender
{
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepFeatureCar cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.5 animations:^{
        sepFeatureCar.frame=CGRectMake(DEVICE_WIDTH/2, 38, DEVICE_WIDTH/2, 2);
        //        viewUpcomingCars.frame=CGRectMake(-DEVICE_WIDTH, 41, DEVICE_WIDTH, 219);
        //        viewJustLaunchedCars.frame=CGRectMake(0, 41, DEVICE_WIDTH, 219);
    } completion:^(BOOL finished) {
    }];
    
    [scrolFeatures setContentOffset:CGPointMake(DEVICE_WIDTH, 0) animated:YES];

}
-(void)btnBrandsClicked:(id)sender
{
    isCarBarnd =YES;
    isCarType = NO;
    [carBrnadAndTypeCollectionView reloadData];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepCarDetails cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.2 animations:^{
        sepCarDetails.frame=CGRectMake(0, 40, DEVICE_WIDTH/3, 2);
        carBrnadAndTypeCollectionView.frame=CGRectMake(0, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height);
    } completion:^(BOOL finished) {
    }];
    [scrolCarDeatils setContentOffset:CGPointMake(0, 0) animated:NO];

}
-(void)btnButgetClicked:(id)sender
{
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepCarDetails cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.2 animations:^{
        sepCarDetails.frame=CGRectMake(DEVICE_WIDTH/3, 40, DEVICE_WIDTH/3, 2);
    } completion:^(BOOL finished) {
    }];
    [scrolCarDeatils setContentOffset:CGPointMake(DEVICE_WIDTH, 0) animated:NO];

}
-(void)btnBodyTypeClicked:(id)sender
{
    isCarType= YES;
    isCarBarnd =NO;
    [carBrnadAndTypeCollectionView reloadData];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepCarDetails cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.2 animations:^{
        sepCarDetails.frame=CGRectMake(2*DEVICE_WIDTH/3, 40, DEVICE_WIDTH/3, 2);
        carBrnadAndTypeCollectionView.frame=CGRectMake(2*DEVICE_WIDTH, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height);
    } completion:^(BOOL finished) {
    }];
    [scrolCarDeatils setContentOffset:CGPointMake(2*DEVICE_WIDTH, 0) animated:NO];

}
-(void)btnViewAllClicked:(id)sender
{
    
}
-(void)btnDetailsClicked:(id)sende
{
    
}
-(void)btnSellCarClicked:(id)sender
{
    
}
-(void)btncheckValueClicked:(id)sender
{
    
}
-(void)btnMoreFeatureCarsClicked:(id)sender
{
    
}
-(void)btnSelectCarClicked:(id)sender
{
   
}
-(void)btnFindCarClicked:(id)sender
{
  
}
-(void)btnBodyTypeDetailsClicked:(id)sender
{
   

}
#pragma mark -  Webservices
-(void)BrandNameAndCarType
{
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        NSString * webServiceName = @"getCarBrandAndType";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getCarBrandAndType";
       
        
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_BRAND,webServiceName] withParameters:parameter_dict andValidation:NO];
        
    }
    
    
    
}
-(void)compareCarWebServices
{
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        NSString * webServiceName = @"compareModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getCarBrandAndType";
        
        
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_BRAND,webServiceName] withParameters:parameter_dict andValidation:NO];
        
    }

}
-(void)GetCarModelServices
{
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
     NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
            [parameter_dict setObject:[[brandNameArr objectAtIndex:1] valueForKey:@"brand_id"] forKey:@"brand_ids"];
            NSString * webServiceName = @"getCarModels";
            NSLog(@"There IS internet connection");
            URLManager *manager = [[URLManager alloc] init];
            manager.delegate = self;
            manager.commandName = @"getCarModels";
            [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }


}
#pragma mark - UrlManager Delegate
- (void)onResult:(NSDictionary *)result
{
    NSLog(@"Result :%@",result);
    
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getCarBrandAndType"])
    {
        brandNameArr = [[result valueForKey:@"result"] valueForKey:@"car_brand"];
        CarTypeArr = [[result valueForKey:@"result"] valueForKey:@"car_type"];
         [self scrlFrame];
        [self GetCarModelServices];
  
    }
    if([[result valueForKey:@"commandName"] isEqualToString:@"compareModels"])
    {
     
        
    }
    if([[result valueForKey:@"commandName"] isEqualToString:@"getCarModels"])
    {
        NSLog(@"%@response",result);
        
    }

}
-(void)onError:(NSError *)error
{
    NSLog(@"ERROR%@",error);
    
}

#pragma mark -  Slider Value
- (void)changePriceRange:(TTRangeSlider *)sender
{
    NSLog(@"Standard slider updated. Min Value: %.0f Max Value: %.0f", sender.selectedMinimum, sender.selectedMaximum);
    lblPrice.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
}

#pragma mark - ChildView frames

-(void)popularCarsViewFrame
{
    UILabel * lblSep6 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lblSep6.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewPopular addSubview:lblSep6];
    
    UILabel * lblSep7 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 120, DEVICE_WIDTH/2, 1)];
    lblSep7.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewPopular addSubview:lblSep7];
    
    AsyncImageView * imgFeaturedCars = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 10, viewPopularCar.frame.size.width/2-20, viewPopular.frame.size.height-70)];
    imgFeaturedCars.image = [UIImage imageNamed:@"demo7.jpg"];
    imgFeaturedCars.clipsToBounds=YES;
    imgFeaturedCars.contentMode = UIViewContentModeScaleAspectFill;
    imgFeaturedCars.layer.borderWidth=2;
    imgFeaturedCars.layer.borderColor =[APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    imgFeaturedCars.layer.cornerRadius=3;
    [viewPopular addSubview:imgFeaturedCars];
    
    UILabel * lblFeaturedCarName = [[UILabel alloc] initWithFrame:CGRectMake(10,viewPopular.frame.size.height-55,viewPopularCar.frame.size.width/2-20, 20)];
    lblFeaturedCarName.text =@"Honda City";
    lblFeaturedCarName.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblFeaturedCarName.textAlignment=NSTextAlignmentCenter;
    lblFeaturedCarName.textColor =[UIColor blackColor];
    [viewPopular addSubview:lblFeaturedCarName];
    
    UILabel * lblFeaturedCarPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewPopular.frame.size.height-35,viewPopularCar.frame.size.height-35, 20)];
    lblFeaturedCarPrice.text =@"$ 14,500";
    lblFeaturedCarPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice.textColor =[UIColor blackColor];
    [viewPopular addSubview:lblFeaturedCarPrice];
    
    UILabel * lblExpectedPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewPopular.frame.size.height-20,viewPopularCar.frame.size.height-20, 20)];
    lblExpectedPrice.text =@"Expected Price";
    lblExpectedPrice.font =[UIFont systemFontOfSize:8.0 weight:UIFontWeightRegular];
    lblExpectedPrice.textAlignment=NSTextAlignmentLeft;
    lblExpectedPrice.textColor =[UIColor grayColor];
    [viewPopular addSubview:lblExpectedPrice];
    
    UILabel * lblFeaturedCarExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewPopular.frame.size.width/2-20)-60, viewPopular.frame.size.height-35,65, 20)];
    lblFeaturedCarExpectedDate.text =@"Oce 5th";
    lblFeaturedCarExpectedDate.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarExpectedDate.textAlignment=NSTextAlignmentRight;
    lblFeaturedCarExpectedDate.textColor =[UIColor blackColor];
    [viewPopular addSubview:lblFeaturedCarExpectedDate];
    
    UILabel * lblExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewPopular.frame.size.width/2-20)-60, viewPopular.frame.size.height-20,65, 20)];
    lblExpectedDate.text =@"Expected date";
    lblExpectedDate.font =[UIFont systemFontOfSize:8.0 weight:UIFontWeightRegular];
    lblExpectedDate.textAlignment=NSTextAlignmentRight;
    lblExpectedDate.textColor =[UIColor grayColor];
    [viewPopular addSubview:lblExpectedDate];
    
    
    UILabel * lblSep8 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-1, 0, 1, viewPopular.frame.size.height)];
    lblSep8.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewPopular addSubview:lblSep8];
    
    AsyncImageView * imgExpectedCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewPopular.frame.size.width/2+10, 10, viewPopular.frame.size.width/2-80, 100)];
    imgExpectedCar2.image = [UIImage imageNamed:@"demo9.jpg"];
    imgExpectedCar2.clipsToBounds=YES;
    imgExpectedCar2.contentMode = UIViewContentModeScaleAspectFill;
    [viewPopular addSubview:imgExpectedCar2];
    
    
    UILabel * lblFeaturedCarName2 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopular.frame.size.width-60, 10,60, 20)];
    lblFeaturedCarName2.text =@"Audy Q8";
    lblFeaturedCarName2.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName2.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName2.textColor =[UIColor blackColor];
    [viewPopular addSubview:lblFeaturedCarName2];
    
    UILabel * lblFeaturedCarPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopular.frame.size.width-60, 30,60, 20)];
    lblFeaturedCarPrice1.text =@"$ 10,500";
    lblFeaturedCarPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice1.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice1.textColor =[UIColor blackColor];
    [viewPopular addSubview:lblFeaturedCarPrice1];
    
    AsyncImageView * imgFeaturedCar3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewPopular.frame.size.width/2+10, 130,  viewJustLaunched.frame.size.width/2-80, 100)];
    imgFeaturedCar3.image = [UIImage imageNamed:@"demo8.jpg"];
    imgFeaturedCar3.clipsToBounds=YES;
    imgFeaturedCar3.contentMode = UIViewContentModeScaleAspectFill;
    [viewPopular addSubview:imgFeaturedCar3];
    
    UILabel * lblFeaturedCarName3 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopular.frame.size.width-60, 130,60, 20)];
    lblFeaturedCarName3.text =@"Audy Q8";
    lblFeaturedCarName3.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName3.textColor =[UIColor blackColor];
    [viewPopular addSubview:lblFeaturedCarName3];
    
    UILabel * lblFeaturedCarPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopular.frame.size.width-60, 150,60, 20)];
    lblFeaturedCarPrice3.text =@"$ 8,500";
    lblFeaturedCarPrice3.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice3.textColor =[UIColor blackColor];
    [viewPopular addSubview:lblFeaturedCarPrice3];
}
-(void)JustLaunchedFrame
{
    UILabel * lblSep6 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lblSep6.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewJustLaunched addSubview:lblSep6];
    
    UILabel * lblSep7 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 120, DEVICE_WIDTH/2, 1)];
    lblSep7.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewJustLaunched addSubview:lblSep7];
    
    AsyncImageView * imgFeaturedCars = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 10, viewJustLaunched.frame.size.width/2-20, viewJustLaunched.frame.size.height-70)];
    imgFeaturedCars.image = [UIImage imageNamed:@"demo7.jpg"];
    imgFeaturedCars.clipsToBounds=YES;
    imgFeaturedCars.contentMode = UIViewContentModeScaleAspectFill;
    imgFeaturedCars.layer.borderWidth=2;
    imgFeaturedCars.layer.borderColor =[APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    imgFeaturedCars.layer.cornerRadius=3;
    [viewJustLaunched addSubview:imgFeaturedCars];
    
    UILabel * lblFeaturedCarName = [[UILabel alloc] initWithFrame:CGRectMake(10,viewJustLaunched.frame.size.height-55,viewJustLaunched.frame.size.width/2-20, 20)];
    lblFeaturedCarName.text =@"Honda City";
    lblFeaturedCarName.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblFeaturedCarName.textAlignment=NSTextAlignmentCenter;
    lblFeaturedCarName.textColor =[UIColor blackColor];
    [viewJustLaunched addSubview:lblFeaturedCarName];
    
    UILabel * lblFeaturedCarPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewJustLaunched.frame.size.height-35,viewJustLaunched.frame.size.height-35, 20)];
    lblFeaturedCarPrice.text =@"$ 14,500";
    lblFeaturedCarPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice.textColor =[UIColor blackColor];
    [viewJustLaunched addSubview:lblFeaturedCarPrice];
    
    UILabel * lblExpectedPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewJustLaunched.frame.size.height-20,viewJustLaunched.frame.size.height-20, 20)];
    lblExpectedPrice.text =@"Expected Price";
    lblExpectedPrice.font =[UIFont systemFontOfSize:8.0 weight:UIFontWeightRegular];
    lblExpectedPrice.textAlignment=NSTextAlignmentLeft;
    lblExpectedPrice.textColor =[UIColor grayColor];
    [viewJustLaunched addSubview:lblExpectedPrice];
    
    UILabel * lblFeaturedCarExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewJustLaunched.frame.size.width/2-20)-60, viewJustLaunched.frame.size.height-35,65, 20)];
    lblFeaturedCarExpectedDate.text =@"Oce 5th";
    lblFeaturedCarExpectedDate.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarExpectedDate.textAlignment=NSTextAlignmentRight;
    lblFeaturedCarExpectedDate.textColor =[UIColor blackColor];
    [viewJustLaunched addSubview:lblFeaturedCarExpectedDate];
    
    UILabel * lblExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewJustLaunched.frame.size.width/2-20)-60, viewJustLaunched.frame.size.height-20,65, 20)];
    lblExpectedDate.text =@"Expected date";
    lblExpectedDate.font =[UIFont systemFontOfSize:8.0 weight:UIFontWeightRegular];
    lblExpectedDate.textAlignment=NSTextAlignmentRight;
    lblExpectedDate.textColor =[UIColor grayColor];
    [viewJustLaunched addSubview:lblExpectedDate];
    
    
    UILabel * lblSep8 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-1, 0, 1, viewJustLaunched.frame.size.height)];
    lblSep8.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewJustLaunched addSubview:lblSep8];
    
    AsyncImageView * imgExpectedCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewJustLaunched.frame.size.width/2+10, 10, viewJustLaunched.frame.size.width/2-80, 100)];
    imgExpectedCar2.image = [UIImage imageNamed:@"demo9.jpg"];
    imgExpectedCar2.clipsToBounds=YES;
    imgExpectedCar2.contentMode = UIViewContentModeScaleAspectFill;
    [viewJustLaunched addSubview:imgExpectedCar2];
    
    
    UILabel * lblFeaturedCarName2 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunched.frame.size.width-60, 10,60, 20)];
    lblFeaturedCarName2.text =@"Audy Q8";
    lblFeaturedCarName2.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName2.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName2.textColor =[UIColor blackColor];
    [viewJustLaunched addSubview:lblFeaturedCarName2];
    
    UILabel * lblFeaturedCarPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunched.frame.size.width-60, 30,60, 20)];
    lblFeaturedCarPrice1.text =@"$ 10,500";
    lblFeaturedCarPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice1.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice1.textColor =[UIColor blackColor];
    [viewJustLaunched addSubview:lblFeaturedCarPrice1];
    
    AsyncImageView * imgFeaturedCar3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewJustLaunched.frame.size.width/2+10, 130,  viewJustLaunched.frame.size.width/2-80, 100)];
    imgFeaturedCar3.image = [UIImage imageNamed:@"demo8.jpg"];
    imgFeaturedCar3.clipsToBounds=YES;
    imgFeaturedCar3.contentMode = UIViewContentModeScaleAspectFill;
    [viewJustLaunched addSubview:imgFeaturedCar3];
    
    UILabel * lblFeaturedCarName3 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunched.frame.size.width-60, 130,60, 20)];
    lblFeaturedCarName3.text =@"Audy Q8";
    lblFeaturedCarName3.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName3.textColor =[UIColor blackColor];
    [viewJustLaunched addSubview:lblFeaturedCarName3];
    
    UILabel * lblFeaturedCarPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunched.frame.size.width-60, 150,60, 20)];
    lblFeaturedCarPrice3.text =@"$ 8,500";
    lblFeaturedCarPrice3.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice3.textColor =[UIColor blackColor];
    [viewJustLaunched addSubview:lblFeaturedCarPrice3];
}

-(void)compareCarsFrame
{
    
    UILabel * lblCompareCar = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
    lblCompareCar.text =@"Compare Cars";
    lblCompareCar.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblCompareCar.textAlignment=NSTextAlignmentLeft;
    lblCompareCar.textColor =[UIColor blackColor];
    [viewComareCars addSubview:lblCompareCar];
    
    btnViewAllCars= [UIButton buttonWithType:UIButtonTypeCustom];
    btnViewAllCars.frame = CGRectMake(DEVICE_WIDTH-100, 0, 100, 44);
    btnViewAllCars.backgroundColor =[UIColor clearColor];
    [btnViewAllCars setTitle:@"View all" forState:UIControlStateNormal];
    [btnViewAllCars setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnViewAllCars addTarget:self action:@selector(btnViewAllClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnViewAllCars.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [viewComareCars addSubview:btnViewAllCars];
    
    UILabel * lblSep =[[UILabel alloc] initWithFrame:CGRectMake(0, 42, DEVICE_WIDTH, 1)];
    lblSep.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewComareCars addSubview:lblSep];
    
    self.compareCars=[[iCarousel alloc]initWithFrame:CGRectMake(0, 44, DEVICE_WIDTH, 160)];
    self.compareCars.delegate=self;
    self.compareCars.dataSource=self;
    self.compareCars.type = iCarouselTypeLinear;
    [viewComareCars addSubview:self.compareCars];
    
    btnDetails = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDetails.frame = CGRectMake(DEVICE_WIDTH-100, viewComareCars.frame.size.height-35, 100, 40);
    btnDetails.backgroundColor =[UIColor clearColor];
    [btnDetails setTitle:@"Details..." forState:UIControlStateNormal];
    [btnDetails setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnDetails addTarget:self action:@selector(btnDetailsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnDetails.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [viewComareCars addSubview:btnDetails];
}
-(void)buyingCarViewFrame
{
    UILabel * lblCarOffers = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
    lblCarOffers.text =@"Car buying tool";
    lblCarOffers.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblCarOffers.textAlignment=NSTextAlignmentLeft;
    lblCarOffers.textColor =[UIColor blackColor];
    [viewBuyingTools addSubview:lblCarOffers];
    
    UILabel * lblSep1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 38, DEVICE_WIDTH, 1)];
    lblSep1.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewBuyingTools addSubview:lblSep1];
    
    UILabel * lblgetPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, DEVICE_WIDTH-40, 25)];
    lblgetPrice.text =@"Get the best price for your car";
    lblgetPrice.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblgetPrice.textAlignment=NSTextAlignmentCenter;
    lblgetPrice.textColor =[UIColor blackColor];
    [viewBuyingTools addSubview:lblgetPrice];
    
    btnSeller= [UIButton buttonWithType:UIButtonTypeCustom];
    btnSeller.frame=CGRectMake(30, 85, DEVICE_WIDTH-60, 40);
    btnSeller.layer.cornerRadius=5;
    btnSeller.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [btnSeller setTitle:@"Sell Car" forState:UIControlStateNormal];
    [btnSeller setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSeller addTarget:self action:@selector(btnSellCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewBuyingTools addSubview:btnSeller];
    
    UILabel * lblMarketValue = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, DEVICE_WIDTH-40, 25)];
    lblMarketValue.text =@"Find true narket value for your car";
    lblMarketValue.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblMarketValue.textAlignment=NSTextAlignmentCenter;
    lblMarketValue.textColor =[UIColor blackColor];
    [viewBuyingTools addSubview:lblMarketValue];
    
    btnCheckValue= [UIButton buttonWithType:UIButtonTypeCustom];
    btnCheckValue.frame=CGRectMake(30, 170, DEVICE_WIDTH-60, 40);
    btnCheckValue.layer.cornerRadius=5;
    btnCheckValue.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [btnCheckValue setTitle:@"Check Value" forState:UIControlStateNormal];
    [btnCheckValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCheckValue addTarget:self action:@selector(btncheckValueClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewBuyingTools addSubview:btnCheckValue];
}
-(void)carDetailFrame
{
    viewBrand = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height)];
    viewBrand.backgroundColor = [UIColor clearColor];
    [scrolCarDeatils addSubview:viewBrand];
    
    CarBrandAndTypeFlowlayout *layout = [[CarBrandAndTypeFlowlayout alloc] init];
    carBrnadAndTypeCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height) collectionViewLayout:layout];
    
    [carBrnadAndTypeCollectionView setDataSource:self];
    [carBrnadAndTypeCollectionView setDelegate:self];
    [scrolCarDeatils addSubview:carBrnadAndTypeCollectionView];
    [carBrnadAndTypeCollectionView registerClass:[CarBarndAndTypeCell class] forCellWithReuseIdentifier:@"CellID"];
    [carBrnadAndTypeCollectionView setBackgroundColor:[UIColor clearColor]];
    
    [scrolCarDeatils addSubview:carBrnadAndTypeCollectionView];
    
    viewBudget  = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height)];
    viewBudget.backgroundColor = [UIColor clearColor];
    [scrolCarDeatils addSubview:viewBudget];
    
    scrolBudget = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, viewBudget.frame.size.height)];
    scrolBudget.delegate=self;
    scrolBudget.bounces= NO;
    scrolBudget.pagingEnabled=NO;
    scrolBudget.backgroundColor = [UIColor clearColor];
    [viewBudget addSubview:scrolBudget];
    scrolBudget.delaysContentTouches = NO;
    
    UILabel * lbltext = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, DEVICE_WIDTH, 20)];
    lbltext.text=@"Select your price range";
    lbltext.font = [UIFont systemFontOfSize:12.0];
    lbltext.textColor =[APP_DELEGATE colorWithHexString:App_Background_color];
    lbltext.textAlignment=NSTextAlignmentCenter;
    [scrolBudget addSubview:lbltext];
    
    lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, DEVICE_WIDTH, 25)];
    lblPrice.text =@"$ 8k - $ 20k";
    lblPrice.font = [UIFont systemFontOfSize:16.0];
    lblPrice.textColor =[UIColor blackColor];
    lblPrice.textAlignment=NSTextAlignmentCenter;
    [scrolBudget addSubview:lblPrice];
    
    
    rangeSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(25, 140, DEVICE_WIDTH-50, 40)];
    rangeSlider.minValue =1;
    rangeSlider.maxValue = 30;
    rangeSlider.selectedMinimum =1;
    rangeSlider.selectedMaximum = 30;
    rangeSlider.tintColorBetweenHandles = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.handleColor = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];
    
    [rangeSlider addTarget:self action:@selector(changePriceRange:) forControlEvents:UIControlEventValueChanged];
    [scrolBudget addSubview:rangeSlider];
    
    btnFindCar= [UIButton buttonWithType:UIButtonTypeCustom];
    btnFindCar.frame=CGRectMake(30, 200, DEVICE_WIDTH-60, 40);
    btnFindCar.layer.cornerRadius=5;
    btnFindCar.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [btnFindCar setTitle:@"Find Car" forState:UIControlStateNormal];
    [btnFindCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFindCar addTarget:self action:@selector(btnFindCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrolBudget addSubview:btnFindCar];


}
-(void)carDetailFrames
{
    //[self BrandNameAndCarType];
    viewBrand = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height)];
    viewBrand.backgroundColor = [UIColor clearColor];
    [scrolCarDeatils addSubview:viewBrand];
    
    scrolBrand = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, viewBrand.frame.size.height)];
    scrolBrand.delegate=self;
    scrolBrand.bounces= YES;
    scrolBrand.backgroundColor = [UIColor clearColor];
    scrolBrand.pagingEnabled=NO;
    [viewBrand addSubview:scrolBrand];
    
    
//    NSArray * itemArr = [[NSArray alloc] initWithObjects:@"Sedan",@"Hatch",@"Wagon",@"Convertible",@"Coupe",@"People Mover",@"SUV",@"Utility",@"Cab Chassis", @"Extra Cab",@"Dual Cab",@"Van",@"4x2",@"4x4",@"Other",@"Single Cab",@"3rd row seats",@"Seats No", nil];
    
    int remainCount = ([brandNameArr count])%3;
    int rows =(int)([brandNameArr count] - remainCount)/3;
    
    if (remainCount==0)
    {
        
    }
    else{
        rows=rows+1;
    }

    int xx=0, yy=0;
    int count = 0;
    
    for (int i=0; i<rows; i++)
    {
        xx=0;
        for (int j=0; j<[brandNameArr count]; j++)
        {
            UILabel * lblTmp = [[UILabel alloc] init];
            lblTmp.frame = CGRectMake(xx, yy, DEVICE_WIDTH/3, 60);
//            lblTmp.backgroundColor = [self randomColor];
            lblTmp.userInteractionEnabled = YES;
            [scrolBrand addSubview:lblTmp];
 
            UIButton * btnCar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH/3, 60)];
            btnCar.tag=count;
            [btnCar addTarget:self action:@selector(btnSelectCarClicked:) forControlEvents:UIControlEventTouchUpInside];
            [lblTmp addSubview:btnCar];

            UIImageView * imgCar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH/3, 40)];
            imgCar.contentMode=UIViewContentModeScaleAspectFit;
            imgCar.clipsToBounds=YES;
            NSURL *url = [NSURL URLWithString:[[brandNameArr objectAtIndex:j]valueForKey:@"brand_logo"]];
            imgCar.imageURL =url;
            [lblTmp addSubview:imgCar];

            UILabel * lblName = [[UILabel alloc] init];
            lblName.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[brandNameArr objectAtIndex:j]valueForKey:@"brand_name"]]];
            lblName.frame = CGRectMake(0, 40, DEVICE_WIDTH/3,20);
            lblName.textAlignment = NSTextAlignmentCenter;
            [lblName setFont:[UIFont systemFontOfSize:12.0]];
            lblName.textColor = [self randomColor];
            [lblTmp addSubview:lblName];
            
            xx = DEVICE_WIDTH/3 + xx;
            count = count + 1;
        }
        yy = yy + 60 + 10;
    }
    
    [scrolBrand setContentSize:CGSizeMake(DEVICE_WIDTH, yy)];

    
    viewBudget  = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height)];
    viewBudget.backgroundColor = [UIColor clearColor];
    [scrolCarDeatils addSubview:viewBudget];
    
    scrolBudget = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, viewBudget.frame.size.height)];
    scrolBudget.delegate=self;
    scrolBudget.bounces= NO;
    scrolBudget.pagingEnabled=NO;
    scrolBudget.backgroundColor = [UIColor clearColor];
    [viewBudget addSubview:scrolBudget];
    scrolBudget.delaysContentTouches = NO;
    
    UILabel * lbltext = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, DEVICE_WIDTH, 20)];
    lbltext.text=@"Select your price range";
    lbltext.font = [UIFont systemFontOfSize:12.0];
    lbltext.textColor =[APP_DELEGATE colorWithHexString:App_Background_color];
    lbltext.textAlignment=NSTextAlignmentCenter;
    [scrolBudget addSubview:lbltext];
    
    lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, DEVICE_WIDTH, 25)];
    lblPrice.text =@"$ 8k - $ 20k";
    lblPrice.font = [UIFont systemFontOfSize:16.0];
    lblPrice.textColor =[UIColor blackColor];
    lblPrice.textAlignment=NSTextAlignmentCenter;
    [scrolBudget addSubview:lblPrice];
    
    
    rangeSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(25, 140, DEVICE_WIDTH-50, 40)];
    rangeSlider.minValue =1;
    rangeSlider.maxValue = 30;
    rangeSlider.selectedMinimum =1;
    rangeSlider.selectedMaximum = 30;
    rangeSlider.tintColorBetweenHandles = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.handleColor = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];
    
    [rangeSlider addTarget:self action:@selector(changePriceRange:) forControlEvents:UIControlEventValueChanged];
    [scrolBudget addSubview:rangeSlider];
    
    btnFindCar= [UIButton buttonWithType:UIButtonTypeCustom];
    btnFindCar.frame=CGRectMake(30, 200, DEVICE_WIDTH-60, 40);
    btnFindCar.layer.cornerRadius=5;
    btnFindCar.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [btnFindCar setTitle:@"Find Car" forState:UIControlStateNormal];
    [btnFindCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFindCar addTarget:self action:@selector(btnFindCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrolBudget addSubview:btnFindCar];

    
    viewBodyType  = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH*2, 0, DEVICE_WIDTH, scrolCarDeatils.frame.size.height)];
    viewBodyType.backgroundColor = [UIColor clearColor];
    [scrolCarDeatils addSubview:viewBodyType];
    
    scrolBodyType = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, viewBodyType.frame.size.height)];
    scrolBodyType.delegate=self;
    scrolBodyType.bounces= YES;
    scrolBodyType.pagingEnabled=NO;
    scrolBodyType.backgroundColor = [UIColor clearColor];
    [viewBodyType addSubview:scrolBodyType];
    
//    NSArray * itemBodyType = [[NSArray alloc] initWithObjects:@"Sedan",@"Hatch",@"Wagon",@"Convertible",@"Coupe",@"People Mover",@"SUV",@"Utility",@"Cab Chassis", @"Extra Cab",@"Dual Cab",@"Van",@"4x2",@"4x4", nil];
    
    int remainCount2 = ([CarTypeArr count])%3;
    int rows2 =(int)([CarTypeArr count] - remainCount2)/3;
    
    if (remainCount2==0)
    {
    }else
    {
        rows2=rows2+1;
    }

    int xxx=0, yyy=0;
    int count1 = 0;
    for (int i=0; i<rows2; i++)
    {
        xxx=0;
        for (int j=0; j<[CarTypeArr count]; j++)
        {
            UILabel * lblTmp = [[UILabel alloc] init];
            lblTmp.frame = CGRectMake(xxx, yyy, DEVICE_WIDTH/3, 60);
            lblTmp.userInteractionEnabled = YES;
            [scrolBodyType addSubview:lblTmp];
            
            UIButton * btnCar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH/3, 60)];
            btnCar.tag=count;
            [btnCar addTarget:self action:@selector(btnBodyTypeDetailsClicked:) forControlEvents:UIControlEventTouchUpInside];
            [lblTmp addSubview:btnCar];
            
            AsyncImageView * imgCar = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH/3, 40)];
            imgCar.contentMode=UIViewContentModeScaleAspectFit;
            imgCar.clipsToBounds=YES;
            NSURL *url = [NSURL URLWithString:[[CarTypeArr objectAtIndex:j]valueForKey:@"car_type_image"]];
            imgCar.imageURL =url;
            [lblTmp addSubview:imgCar];
            
            UILabel * lblName = [[UILabel alloc] init];
            lblName.text = [NSString stringWithFormat:@"%@",[[CarTypeArr objectAtIndex:j]valueForKey:@"car_type_name"]];
            lblName.frame = CGRectMake(0, 40, DEVICE_WIDTH/3,20);
            lblName.textAlignment = NSTextAlignmentCenter;
            [lblName setFont:[UIFont systemFontOfSize:12.0]];
            lblName.textColor = [self randomColor];
            [lblTmp addSubview:lblName];
//            NSLog(@"count1==>%d [itemBodyType objectAtIndex:count1]==>%@",count1,[itemBodyType objectAtIndex:count1]);
            
            xxx = DEVICE_WIDTH/3 + xxx;
            if(count1 == [CarTypeArr count]-1)
            {
                yyy = yyy + 60 + 10;
                [scrolBodyType setContentSize:CGSizeMake(DEVICE_WIDTH, yyy)];
                return;
            }else
            {
                count1 = count1 + 1;
            }
        }
        yyy = yyy + 60 + 10;
    }

    [scrolBodyType setContentSize:CGSizeMake(DEVICE_WIDTH, yyy)];
}
- (UIColor *)randomColor
{
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    NSLog(@"%@", color);
    return color;
}

#pragma mark - UIcollectioview Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(isCarBarnd)
    {
        return brandNameArr.count;
    }
    else
    {
        return CarTypeArr.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarBarndAndTypeCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
   //NSURL *url = [NSURL URLWithString:[[brandNameArr objectAtIndex:indexPath.row]valueForKey:@"brand_logo"]];
    if(isCarBarnd)
    {
        NSDictionary * dict = [brandNameArr objectAtIndex:indexPath.row];
        NSString *StrigUrl = [dict objectForKey:@"brand_logo"];
        NSURL *url = [NSURL URLWithString:StrigUrl];
        [cell.btnCar addTarget:self action:@selector(btnSelectCarClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.imgCar2.imageURL = url;
    NSString *StrigName = [dict objectForKey:@"brand_name"];
    cell.CarBrnadNTypeLbl.text =StrigName;
    return cell;
    }
    else
    {
        NSDictionary * dict = [CarTypeArr objectAtIndex:indexPath.row];
        NSString *StrigUrl = [dict objectForKey:@"car_type_image"];
        NSURL *url = [NSURL URLWithString:StrigUrl];
        [cell.btnCar addTarget:self action:@selector(btnSelectCarClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.imgCar2.imageURL = url;
        NSString *StrigName = [dict objectForKey:@"car_type_name"];
        cell.CarBrnadNTypeLbl.text =StrigName;
        
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picDimension = (self.view.frame.size.width-30) / 3;
    return CGSizeMake(picDimension, 70);
}



#pragma mark iCarousel methods
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return 5;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    [view removeFromSuperview];
    view =nil;
    if (view == nil)
    {
        view =[[UIView alloc] initWithFrame:CGRectMake(30, 5, DEVICE_WIDTH-60,150)];
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 1.0;
        view.backgroundColor = [UIColor whiteColor];
        
        AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/2-15, 100)];
        imgCar1.image = [UIImage imageNamed:@"demo4.jpg"];
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        UILabel * lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(0, 120, view.frame.size.width/2-15, 20);
        lblCarName1.font=[UIFont boldSystemFontOfSize:10.0];
        lblCarName1.textAlignment=NSTextAlignmentCenter;
        lblCarName1.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
        lblCarName1.text=@"Tayota innova Crysta";
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        UILabel * lblCompare=[[UILabel alloc] init];
        lblCompare.frame=CGRectMake(view.frame.size.width/2-8, 42, 16, 16);
        lblCompare.font=[UIFont boldSystemFontOfSize:8.0];
        lblCompare.textAlignment=NSTextAlignmentCenter;
        lblCompare.textColor=[UIColor whiteColor];
        lblCompare.backgroundColor = [APP_DELEGATE colorWithHexString:AppHeaderColor];
        lblCompare.layer.cornerRadius=8;
        lblCompare.text=@"VS";
        lblCompare.clipsToBounds=YES;
        [view addSubview:lblCompare];
        
        AsyncImageView * imgCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(view.frame.size.width/2+15, 0, view.frame.size.width/2-15, 100)];
        imgCar2.image = [UIImage imageNamed:@"demo1.jpg"];
        imgCar2.clipsToBounds=YES;
        imgCar2.userInteractionEnabled=YES;
        imgCar2.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar2];
        
        UILabel * lblCarName2=[[UILabel alloc] init];
        lblCarName2.frame=CGRectMake(view.frame.size.width/2+15, 120, view.frame.size.width/2-15, 20);
        lblCarName2.font=[UIFont boldSystemFontOfSize:10.0];
        lblCarName2.textAlignment=NSTextAlignmentCenter;
        lblCarName2.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
        lblCarName2.text=@"Audi Q3";
        lblCarName2.clipsToBounds=YES;
        [view addSubview:lblCarName2];
    }
    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, DEVICE_WIDTH/2-60, 100)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"demo1.jpg"];
        view.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.compareCars.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.compareCars.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    //    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}


#pragma mark - page Controller
#pragma mark - Scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    if (scrollView ==scrolFeatures)
    {
        int page = floor((scrollView.contentOffset.x - pageWidth / 2 ) / pageWidth) + 1; //this provide you the page number
        if (page==0)
        {
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepFeatureCar cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:.5 animations:^{
                sepFeatureCar.frame=CGRectMake(0, 38, DEVICE_WIDTH/2, 2);
            } completion:^(BOOL finished) {
            }];
        }else
        {
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepFeatureCar cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:.5 animations:^{
                sepFeatureCar.frame=CGRectMake(DEVICE_WIDTH/2, 38, DEVICE_WIDTH/2, 2);
            } completion:^(BOOL finished) {
            }];
        }
    }
    else  if (scrollView ==scrolCarDeatils)
    {
        int page = floor((scrollView.contentOffset.x - pageWidth / 2 ) / pageWidth) + 1; //this provide you the page number
        if (page==0)
        {
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepCarDetails cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:.5 animations:^{
                sepCarDetails.frame=CGRectMake(0, 40, DEVICE_WIDTH/3, 2);
            } completion:^(BOOL finished) {
            }];
        }else if(page==1)
        {
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepCarDetails cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:.5 animations:^{
                sepCarDetails.frame=CGRectMake(DEVICE_WIDTH/3, 40, DEVICE_WIDTH/3, 2);
            } completion:^(BOOL finished) {
            }];
            
        }else
        {
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepCarDetails cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:.5 animations:^{
                sepCarDetails.frame=CGRectMake(2*DEVICE_WIDTH/3, 40, DEVICE_WIDTH/3, 2);
            } completion:^(BOOL finished) {
            }];
        }
    }else if (scrollView ==scrolContent)
    {
        int page = floor((scrollView.contentOffset.x - pageWidth / 2 ) / pageWidth) + 1; //this provide you the page number
    }
}

#pragma mark - Prevent UISlider with UIscrollView
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
    if ([view isKindOfClass:[UISlider class]])
    {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:view];
        CGRect thumbRect;
        UISlider *mySlide = (UISlider*) view;
        CGRect trackRect = [mySlide trackRectForBounds:mySlide.bounds];
        thumbRect = [mySlide thumbRectForBounds:mySlide.bounds trackRect:trackRect value:mySlide.value];
        if (CGRectContainsPoint(thumbRect, location))
            return YES;
    }
    return NO;
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
