    //
//  HomeVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/4/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "HomeVC.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "FindCarVC.h"

@interface HomeVC ()
@end

static NSString *ItemIdentifier = @"ItemIdentifier";
@implementation HomeVC
@synthesize segmentedControl,rangeSlider,slider,LocationView,carTypeArray,carBrandArray,CompareCarArry,GetCarModel;

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    carTypeArray = [[NSMutableArray alloc] init];
    carBrandArray = [[NSMutableArray alloc]init];
    CompareCarArry = [[NSMutableArray alloc] init];
    GetCarModel = [[NSMutableArray alloc] init];
    [self headerFrame];
    ProgressHUD = [[MBProgressHUD alloc] init];
    ProgressHUD.hidden = YES;
    [self BrandNameAndCarType];
    [self compareCarWebServices];
    [self GetcarModels];
    [self locationViewFrame];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [self registerNotifications];
}
#pragma mark - HeaderFrame
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
    lblHeader.text=@"Home";
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
    
    locationBtn=[[UIButton alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-30,35,20,20)];
    [locationBtn addTarget:self action:@selector(btnLocationGet:) forControlEvents:UIControlEventTouchUpInside];
    locationBtn.backgroundColor=[UIColor orangeColor];
    [navView addSubview:locationBtn];
    
}

-(void)setViewFrame
{
    
    int yy=0;
    yy=yy+74;

    CGRect myFrame = CGRectMake(20, yy, DEVICE_WIDTH-40, 40.0f);
    NSArray *mySegments = [[NSArray alloc] initWithObjects: @"New Car",
                           @"Used Car", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:mySegments];
    segmentedControl.frame = myFrame;
    segmentedControl.tintColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [segmentedControl setSelectedSegmentIndex:0];
    [segmentedControl addTarget:self
                         action:@selector(carTypeClicked:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];


    yy=yy+50;

    scrolMain =[[UIScrollView alloc] initWithFrame:CGRectMake(0, yy, DEVICE_WIDTH, DEVICE_HEIGHT-yy)];
    scrolMain.delegate=self;
    scrolMain.bounces= NO;
    scrolMain.pagingEnabled=YES;
    [self.view addSubview:scrolMain];
    scrolMain.delaysContentTouches = NO;
    
    [scrolMain setContentSize:CGSizeMake(DEVICE_WIDTH*2,DEVICE_HEIGHT-yy)];
    
    scrolContent =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, scrolMain.frame.size.height)];
    scrolContent.delegate=self;
    scrolContent.bounces= NO;
//    scrolContent.pagingEnabled =YES;
    [scrolMain addSubview:scrolContent];
    
    scrolUsedCar =[[UIScrollView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, scrolMain.frame.size.height)];
    scrolUsedCar.delegate=self;
    scrolUsedCar.bounces= NO;
//    scrolUsedCar.pagingEnabled =YES;
    [scrolMain addSubview:scrolUsedCar];
    scrolUsedCar.delaysContentTouches = NO;


    int y=0;
    for (int i = 0; i<2; i++)
    {
        if (i==0)
        {
            UIView * viewNewCar = [[UIView alloc] initWithFrame:CGRectMake(5, 10, DEVICE_WIDTH-10, 150)];
            viewNewCar.backgroundColor = [UIColor whiteColor];
            viewNewCar.layer.shadowColor = [UIColor blackColor].CGColor;
            viewNewCar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            viewNewCar.layer.shadowOpacity = 0.5;
            viewNewCar.layer.shadowRadius = 1;
            [scrolContent addSubview:viewNewCar];
            
            UILabel * lblCarTitle =[[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
            lblCarTitle.text =@"Find New Cars";
            lblCarTitle.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            lblCarTitle.textAlignment=NSTextAlignmentLeft;
            lblCarTitle.textColor =[UIColor blackColor];
            [viewNewCar addSubview:lblCarTitle];
            
            [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[APP_DELEGATE colorWithHexString:App_Background_color]];
            
            [searchCars removeFromSuperview];
            searchCars=[[UISearchBar alloc] initWithFrame:CGRectMake(30, 42, DEVICE_WIDTH-60, 40)];
            searchCars.delegate=self;
            searchCars.backgroundColor=[APP_DELEGATE colorWithHexString:App_Background_color];
            searchCars.placeholder=@"Type car name, e.g. Honda city";
            searchCars.layer.borderColor=[UIColor clearColor].CGColor;
            searchCars.layer.borderWidth=0.0f;
            [searchCars setBackgroundImage: [UIImage new]];
            searchCars.layer.cornerRadius=5.0;
            [viewNewCar addSubview:searchCars];
            [searchCars setTintColor:[APP_DELEGATE colorWithHexString:AppHeaderColor]];
            
            UITextField *txfSearchField = [searchCars valueForKey:@"_searchField"];
            [txfSearchField setLeftView:UITextFieldViewModeNever];
            txfSearchField.backgroundColor=[APP_DELEGATE colorWithHexString:App_Background_color];
            txfSearchField.autocorrectionType = UITextAutocorrectionTypeNo;
            txfSearchField.textAlignment=NSTextAlignmentLeft;
            txfSearchField.userInteractionEnabled=YES;
            
            btnFindCar = [UIButton buttonWithType:UIButtonTypeCustom];
            btnFindCar.frame=CGRectMake(30, 95, DEVICE_WIDTH-60, 40);
            btnFindCar.layer.cornerRadius=5;
            btnFindCar.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
            [btnFindCar setTitle:@"Find Car" forState:UIControlStateNormal];
            [btnFindCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFindCar addTarget:self action:@selector(btnFindCarClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewNewCar addSubview:btnFindCar];
            
            [tblSearchCar removeFromSuperview];
//            tblSearchCar = [[UITableView alloc] initWithFrame:CGRectMake(30,132,DEVICE_WIDTH-60,DEVICE_HEIGHT-132) style:UITableViewStylePlain];
//            tblSearchCar.delegate = self;
//            tblSearchCar.dataSource = self;
//            tblSearchCar.backgroundColor=[UIColor blackColor];
//            tblSearchCar.alpha=0.2;
//            tblSearchCar.separatorStyle=normal;
//            
//            [scrolContent addSubview:tblSearchCar];
//            tblSearchCar.hidden=YES;
            
            y=y+170;
            UIView * viewCompareCar = [[UIView alloc] initWithFrame:CGRectMake(5, y, DEVICE_WIDTH-10, 230)];
            viewCompareCar.backgroundColor = [UIColor whiteColor];
            viewCompareCar.layer.shadowColor = [UIColor blackColor].CGColor;
            viewCompareCar.layer.shadowOffset = CGSizeMake(0, 1);
            viewCompareCar.layer.shadowOpacity = 1;
            viewCompareCar.layer.shadowRadius = 1;
            [scrolContent addSubview:viewCompareCar];
            
            UILabel * lblCompareCar = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
            lblCompareCar.text =@"Compare Cars";
            lblCompareCar.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            lblCompareCar.textAlignment=NSTextAlignmentLeft;
            lblCompareCar.textColor =[UIColor blackColor];
            [viewCompareCar addSubview:lblCompareCar];
            
            UIButton * btnViewAll = [UIButton buttonWithType:UIButtonTypeCustom];
            btnViewAll.frame = CGRectMake(DEVICE_WIDTH-100, 0, 100, 44);
            btnViewAll.backgroundColor =[UIColor clearColor];
            [btnViewAll setTitle:@"View all" forState:UIControlStateNormal];
            [btnViewAll setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btnViewAll addTarget:self action:@selector(btnViewAllClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btnViewAll.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [viewCompareCar addSubview:btnViewAll];
            
            UILabel * lblSep =[[UILabel alloc] initWithFrame:CGRectMake(5, 42, DEVICE_WIDTH-20, 1)];
            lblSep.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
            [viewCompareCar addSubview:lblSep];
            
            self.compareCars=[[iCarousel alloc]initWithFrame:CGRectMake(5, 44, DEVICE_WIDTH-90, 160)];
            self.compareCars.delegate=self;
            self.compareCars.dataSource=self;
            self.compareCars.type = iCarouselTypeLinear;
            [viewCompareCar addSubview:self.compareCars];
            
            UIButton * btnDetailsl = [UIButton buttonWithType:UIButtonTypeCustom];
            btnDetailsl.frame = CGRectMake(DEVICE_WIDTH-100, viewCompareCar.frame.size.height-35, 100, 40);
            btnDetailsl.backgroundColor =[UIColor clearColor];
            [btnDetailsl setTitle:@"Details..." forState:UIControlStateNormal];
            [btnDetailsl setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btnDetailsl addTarget:self action:@selector(btnViewAllClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btnDetailsl.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [viewCompareCar addSubview:btnDetailsl];
            
            y=y+240;
            UIView * viewCheckPrice = [[UIView alloc] initWithFrame:CGRectMake(5, y, DEVICE_WIDTH-10, 150)];
            viewCheckPrice.backgroundColor = [UIColor whiteColor];
            viewCheckPrice.layer.shadowColor = [UIColor blackColor].CGColor;
            viewCheckPrice.layer.shadowOffset = CGSizeMake(0, 1);
            viewCheckPrice.layer.shadowOpacity = 1;
            viewCheckPrice.layer.shadowRadius = 1;
            [scrolContent addSubview:viewCheckPrice];
            
            
            UILabel * lblCarCheckpoint =[[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
            lblCarCheckpoint.text =@"Check on road Price";
            lblCarCheckpoint.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            lblCarCheckpoint.textAlignment=NSTextAlignmentLeft;
            lblCarCheckpoint.textColor =[UIColor blackColor];
            [viewCheckPrice addSubview:lblCarCheckpoint];
            
            [searchPrice removeFromSuperview];
            searchPrice=[[UISearchBar alloc] initWithFrame:CGRectMake(30, 40, DEVICE_WIDTH-60, 40)];
            searchPrice.delegate=self;
            searchPrice.backgroundColor=[APP_DELEGATE colorWithHexString:App_Background_color];
            searchPrice.placeholder=@"Type car name, e.g. Honda city";
            searchPrice.layer.borderColor=[UIColor clearColor].CGColor;
            searchPrice.layer.borderWidth=0.0f;
            [searchPrice setBackgroundImage: [UIImage new]];
            searchPrice.layer.cornerRadius=5.0;
            [viewCheckPrice addSubview:searchPrice];
            [searchPrice setTintColor:[APP_DELEGATE colorWithHexString:AppHeaderColor]];
            
            UITextField *txtPriceField = [searchPrice valueForKey:@"_searchField"];
            [txtPriceField setLeftView:UITextFieldViewModeNever];
            txtPriceField.backgroundColor=[APP_DELEGATE colorWithHexString:App_Background_color];
            txtPriceField.autocorrectionType = UITextAutocorrectionTypeNo;
            txtPriceField.textAlignment=NSTextAlignmentLeft;
            txtPriceField.userInteractionEnabled=YES;
            
            UIButton * btnCheckNoow = [UIButton buttonWithType:UIButtonTypeCustom];
            btnCheckNoow.frame=CGRectMake(30, 90, DEVICE_WIDTH-60, 44);
            btnCheckNoow.layer.cornerRadius=5;
            btnCheckNoow.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
            [btnCheckNoow setTitle:@"Check Now" forState:UIControlStateNormal];
            [btnCheckNoow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnCheckNoow addTarget:self action:@selector(btnCheckNowClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewCheckPrice addSubview:btnCheckNoow];
            
            y=y+160;//
            
            UIView * viewCarOffers = [[UIView alloc] initWithFrame:CGRectMake(5, y, DEVICE_WIDTH-10, 250)];
            viewCarOffers.backgroundColor = [UIColor whiteColor];
            viewCarOffers.layer.shadowColor = [UIColor blackColor].CGColor;
            viewCarOffers.layer.shadowOffset = CGSizeMake(0, 1);
            viewCarOffers.layer.shadowOpacity = 1;
            viewCarOffers.layer.shadowRadius = 1;
            [scrolContent addSubview:viewCarOffers];
            
            UILabel * lblCarOffers = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
            lblCarOffers.text =@"New Car Offers";
            lblCarOffers.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            lblCarOffers.textAlignment=NSTextAlignmentLeft;
            lblCarOffers.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblCarOffers];
            
            UIButton * btnNewCarsViewAll = [UIButton buttonWithType:UIButtonTypeCustom];
            btnNewCarsViewAll.frame = CGRectMake(DEVICE_WIDTH-100, 0, 100, 44);
            btnNewCarsViewAll.backgroundColor =[UIColor clearColor];
            [btnNewCarsViewAll setTitle:@"View all" forState:UIControlStateNormal];
            [btnNewCarsViewAll setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btnNewCarsViewAll addTarget:self action:@selector(btnNewCarsViewAllClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btnNewCarsViewAll.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [viewCarOffers addSubview:btnNewCarsViewAll];
            
            
            UILabel * lblSep1 =[[UILabel alloc] initWithFrame:CGRectMake(5, 42, DEVICE_WIDTH-20, 1)];
            lblSep1.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
            [viewCarOffers addSubview:lblSep1];
            
            UILabel * lblSep4 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 144, DEVICE_WIDTH/2, 1)];
            lblSep4.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
            [viewCarOffers addSubview:lblSep4];
            
            UILabel * lblSep3 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-1, 50, 1, viewCarOffers.frame.size.height-60)];
            lblSep3.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
            [viewCarOffers addSubview:lblSep3];
            
            
            AsyncImageView * imgCarOffer1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 50, viewCarOffers.frame.size.width/2-20, viewCarOffers.frame.size.height-100)];
            url = [NSURL URLWithString:[[GetCarModel objectAtIndex:0]valueForKey:@"model_image"]];
            imgCarOffer1.imageURL = url;
            imgCarOffer1.clipsToBounds=YES;
            imgCarOffer1.contentMode = UIViewContentModeScaleAspectFit;
            imgCarOffer1.layer.borderWidth=2;
            imgCarOffer1.layer.borderColor =[APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
            imgCarOffer1.layer.cornerRadius=3;
            [viewCarOffers addSubview:imgCarOffer1];
            
            UILabel * lblCarNames = [[UILabel alloc] initWithFrame:CGRectMake(10, viewCarOffers.frame.size.height-45,DEVICE_WIDTH/2-20, 20)];
            lblCarNames.text =[[GetCarModel objectAtIndex:0]valueForKey:@"car_model_name"];
            lblCarNames.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            lblCarNames.textAlignment=NSTextAlignmentLeft;
            lblCarNames.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblCarNames];
            
            UILabel * lblOfferPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewCarOffers.frame.size.height-25,DEVICE_WIDTH/4, 20)];
            lblOfferPrice.text =[[GetCarModel objectAtIndex:0]valueForKey:@"price"];
            lblOfferPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            lblOfferPrice.textAlignment=NSTextAlignmentLeft;
            lblOfferPrice.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblOfferPrice];
            
            UILabel * lblActualPrice = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/4+10, viewCarOffers.frame.size.height-25,DEVICE_WIDTH/4, 20)];
            
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[[GetCarModel objectAtIndex:0]valueForKey:@"price"]];
            [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                    value:@2
                                    range:NSMakeRange(0, [attributeString length])];
            lblActualPrice.attributedText=attributeString;
            lblActualPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            lblActualPrice.textAlignment=NSTextAlignmentLeft;
            lblActualPrice.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblActualPrice];
            
            
            AsyncImageView * imgCarOffer2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+10, 50, viewCarOffers.frame.size.width/2-80, 85)];
            NSURL  *url2 = [NSURL URLWithString:[[GetCarModel objectAtIndex:1]valueForKey:@"model_image"]];
            imgCarOffer2.imageURL = url2;
            imgCarOffer2.clipsToBounds=YES;
            imgCarOffer2.contentMode = UIViewContentModeScaleAspectFit;
            [viewCarOffers addSubview:imgCarOffer2];
            
            
            UILabel * lblCarNames1 = [[UILabel alloc] initWithFrame:CGRectMake(viewCarOffers.frame.size.width-60, 40,60, 20)];
            lblCarNames1.text =[[GetCarModel objectAtIndex:1]valueForKey:@"car_model_name"];
            lblCarNames1.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
            lblCarNames1.textAlignment=NSTextAlignmentLeft;
            lblCarNames1.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblCarNames1];
            
            UILabel * lblOfferPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewCarOffers.frame.size.width-60, 62,60, 20)];
            lblOfferPrice1.text =[[GetCarModel objectAtIndex:1]valueForKey:@"price"];
            lblOfferPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
            lblOfferPrice1.textAlignment=NSTextAlignmentLeft;
            lblOfferPrice1.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblOfferPrice1];
            
            UILabel * lblActualPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewCarOffers.frame.size.width-60, 80,60, 20)];
            NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:[[GetCarModel objectAtIndex:0]valueForKey:@"price"]];
            [attributeString1 addAttribute:NSStrikethroughStyleAttributeName
                                     value:@2
                                     range:NSMakeRange(0, [attributeString1 length])];
            lblActualPrice1.attributedText=attributeString1;
            lblActualPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
            lblActualPrice1.textAlignment=NSTextAlignmentLeft;
            lblActualPrice1.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblActualPrice1];
            
            AsyncImageView * imgCarOffer3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewCarOffers.frame.size.width/2+10, 155,  viewCarOffers.frame.size.width/2-80, 85)];
            NSURL  *url3 = [NSURL URLWithString:[[GetCarModel objectAtIndex:2]valueForKey:@"model_image"]];
            imgCarOffer3.imageURL = url3;
            imgCarOffer3.clipsToBounds=YES;
            imgCarOffer3.contentMode = UIViewContentModeScaleAspectFit;
            [viewCarOffers addSubview:imgCarOffer3];
            
            UILabel * lblCarNames2 = [[UILabel alloc] initWithFrame:CGRectMake(viewCarOffers.frame.size.width-60, 155,60, 20)];
            lblCarNames2.text =[[GetCarModel objectAtIndex:1]valueForKey:@"car_model_name"];
            lblCarNames2.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
            lblCarNames2.textAlignment=NSTextAlignmentLeft;
            lblCarNames2.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblCarNames2];
            
            UILabel * lblOfferPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(viewCarOffers.frame.size.width-60, 175,60, 20)];
            lblOfferPrice2.text =[[GetCarModel objectAtIndex:1]valueForKey:@"price"];
            lblOfferPrice2.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
            lblOfferPrice2.textAlignment=NSTextAlignmentLeft;
            lblOfferPrice2.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblOfferPrice2];
            
            UILabel * lblActualPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(viewCarOffers.frame.size.width-60, 190,60, 20)];
            NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc] initWithString:[[GetCarModel objectAtIndex:1]valueForKey:@"price"]];
            [attributeString2 addAttribute:NSStrikethroughStyleAttributeName
                                     value:@2
                                     range:NSMakeRange(0, [attributeString2 length])];
            lblActualPrice2.attributedText=attributeString2;
            lblActualPrice2.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
            lblActualPrice2.textAlignment=NSTextAlignmentLeft;
            lblActualPrice2.textColor =[UIColor blackColor];
            [viewCarOffers addSubview:lblActualPrice2];


            
            y=y+260;
            
            UILabel * lblFeaturedCars = [[UILabel alloc] initWithFrame:CGRectMake(5, y,DEVICE_WIDTH-10, 20)];
            lblFeaturedCars.text =@"Featured Cars";
            lblFeaturedCars.font =[UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
            lblFeaturedCars.textAlignment=NSTextAlignmentCenter;
            lblFeaturedCars.textColor =[UIColor blackColor];
            [scrolContent addSubview:lblFeaturedCars];
            
            y=y+30;
            
            
            UIView * viewFeaturedCars = [[UIView alloc] initWithFrame:CGRectMake(5, y, DEVICE_WIDTH-10, 300)];
            viewFeaturedCars.backgroundColor = [UIColor whiteColor];
            viewFeaturedCars.layer.shadowColor = [UIColor blackColor].CGColor;
            viewFeaturedCars.layer.shadowOffset = CGSizeMake(0, 1);
            viewFeaturedCars.layer.shadowOpacity = 1;
            viewFeaturedCars.layer.shadowRadius = 1;
            [scrolContent addSubview:viewFeaturedCars];
            
            
            
            UIButton * btnUpcomimgCars = [UIButton buttonWithType:UIButtonTypeCustom];
            btnUpcomimgCars.frame=CGRectMake(5, 0, DEVICE_WIDTH/2, 40);
            [btnUpcomimgCars setTitle:@"Upcoming Cars" forState:UIControlStateNormal];
            [btnUpcomimgCars setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnUpcomimgCars.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            [btnUpcomimgCars addTarget:self action:@selector(btnUpcomingCarssClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewFeaturedCars addSubview:btnUpcomimgCars];
            
            sepFeatureCar = [[UILabel alloc] initWithFrame:CGRectMake(5, 38, DEVICE_WIDTH/2, 2)];
            sepFeatureCar.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
            [viewFeaturedCars addSubview:sepFeatureCar];
            
            UIButton * btnJustLaunched = [UIButton buttonWithType:UIButtonTypeCustom];
            btnJustLaunched.frame=CGRectMake(DEVICE_WIDTH/2,0, DEVICE_WIDTH/2, 40);
            [btnJustLaunched setTitle:@"Just Launched" forState:UIControlStateNormal];
            [btnJustLaunched setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnJustLaunched.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            [btnJustLaunched addTarget:self action:@selector(btnJustLacuncedClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewFeaturedCars addSubview:btnJustLaunched];
            
            
            
            scrolFeatures =[[UIScrollView alloc] initWithFrame:CGRectMake(4, 41, DEVICE_WIDTH-4, viewFeaturedCars.frame.size.height-81)];
            scrolFeatures.delegate=self;
            scrolFeatures.showsVerticalScrollIndicator=NO;
            scrolFeatures.showsHorizontalScrollIndicator=NO;
            scrolFeatures.bounces= NO;
            scrolFeatures.pagingEnabled =YES;
            [viewFeaturedCars addSubview:scrolFeatures];
            
            [scrolFeatures setContentSize:CGSizeMake(DEVICE_WIDTH*2, viewFeaturedCars.frame.size.height-81)];
            
            
            viewUpcomingCars =[[UIView alloc]initWithFrame:CGRectMake(4, 0, DEVICE_WIDTH-4, scrolFeatures.frame.size.height)];
            [scrolFeatures addSubview:viewUpcomingCars];
            
            viewJustLaunchedCars =[[UIView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, scrolFeatures.frame.size.height)];
            [scrolFeatures addSubview:viewJustLaunchedCars];
            
            /*--UpcomingView-----*/
            [self upComingViewFrame];
            
            /*-----Lust LaunchedView------*/
            
            [self JustLaunchedFrame];
            
            
            UIButton * btnMoerUpcomingCars = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMoerUpcomingCars.frame=CGRectMake(30, viewFeaturedCars.frame.size.height-40, DEVICE_WIDTH-60, 40);
            [btnMoerUpcomingCars setTitle:@"View More upcoming Cars" forState:UIControlStateNormal];
            [btnMoerUpcomingCars setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btnMoerUpcomingCars.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [btnMoerUpcomingCars addTarget:self action:@selector(btnMoreUpcomingCarsClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewFeaturedCars addSubview:btnMoerUpcomingCars];
            
            y=y+310;
            
            UILabel * lblCarUpdate = [[UILabel alloc] initWithFrame:CGRectMake(5, y,DEVICE_WIDTH-10, 20)];
            lblCarUpdate.text =@"Latest Cars Update";
            lblCarUpdate.font =[UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
            lblCarUpdate.textAlignment=NSTextAlignmentCenter;
            lblCarUpdate.textColor =[UIColor blackColor];
            [scrolContent addSubview:lblCarUpdate];
            
            y=y+30;
            
            UIView * viewCarUpdates = [[UIView alloc] initWithFrame:CGRectMake(5, y, DEVICE_WIDTH-10, 250)];
            viewCarUpdates.backgroundColor = [UIColor whiteColor];
            viewCarUpdates.layer.shadowColor = [UIColor blackColor].CGColor;
            viewCarUpdates.layer.shadowOffset = CGSizeMake(0, 1);
            viewCarUpdates.layer.shadowOpacity = 1;
            viewCarUpdates.layer.shadowRadius = 1;
            [scrolContent addSubview:viewCarUpdates];
            
            UIButton * btnCarsUpdates = [UIButton buttonWithType:UIButtonTypeCustom];
            btnCarsUpdates.frame=CGRectMake(0, 5, DEVICE_WIDTH/2, 40);
            [btnCarsUpdates setTitle:@"Car News" forState:UIControlStateNormal];
            [btnCarsUpdates setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnCarsUpdates.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            [btnCarsUpdates addTarget:self action:@selector(btnCarUpdatesClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewCarUpdates addSubview:btnCarsUpdates];
            
            sepLatestCars =[[UILabel alloc] initWithFrame:CGRectMake(4, 38, DEVICE_WIDTH/2, 2)];
            sepLatestCars.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
            [viewCarUpdates addSubview:sepLatestCars];
            
            UIButton * btnVideos = [UIButton buttonWithType:UIButtonTypeCustom];
            btnVideos.frame=CGRectMake(DEVICE_WIDTH/2, 5, DEVICE_WIDTH/2, 40);
            [btnVideos setTitle:@"Videos" forState:UIControlStateNormal];
            [btnVideos setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnVideos.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            [btnVideos addTarget:self action:@selector(btnVideosClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewCarUpdates addSubview:btnVideos];
            
            
            scrolCarUpdates =[[UIScrollView alloc] initWithFrame:CGRectMake(5, 41, DEVICE_WIDTH-4, viewCarUpdates.frame.size.height-81)];
            scrolCarUpdates.delegate=self;
            scrolCarUpdates.showsVerticalScrollIndicator=NO;
            scrolFeatures.showsHorizontalScrollIndicator=NO;
            scrolCarUpdates.bounces= NO;
            scrolCarUpdates.pagingEnabled =YES;
            [viewCarUpdates addSubview:scrolCarUpdates];
            
            [scrolCarUpdates setContentSize:CGSizeMake(DEVICE_WIDTH*2-40, viewCarUpdates.frame.size.height-81)];
            
            
            viewCarNews =[[UIView alloc]initWithFrame:CGRectMake(4, 0, DEVICE_WIDTH-4, scrolCarUpdates.frame.size.height)];
            [scrolCarUpdates addSubview:viewCarNews];
            
            viewVideos =[[UIView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH-4, scrolFeatures.frame.size.height)];
            [scrolCarUpdates addSubview:viewVideos];
            
            /*--CarsNews frame-----*/
            
            [self carsNewFrame];
            
            /*-----Videos Frame-----*/
            
            [self VideosFrame];
            
            UIButton * btnMoerDetails = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMoerDetails.frame=CGRectMake(30, 200, DEVICE_WIDTH-60, 40);
            [btnMoerDetails setTitle:@"View More upcoming Cars" forState:UIControlStateNormal];
            [btnMoerDetails setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btnMoerDetails.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [btnMoerDetails addTarget:self action:@selector(btnMoreDetailsClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewCarUpdates addSubview:btnMoerDetails];
            
            y=y+270;
            [scrolContent setContentSize:CGSizeMake(0,y)];

            
        }else
        {
            int y1=0;
            
            viewRangeCar = [[UIView alloc] initWithFrame:CGRectMake(5, y1, DEVICE_WIDTH-10, 180)];
            viewRangeCar.backgroundColor = [UIColor whiteColor];
            viewRangeCar.layer.shadowColor = [UIColor blackColor].CGColor;
            viewRangeCar.layer.shadowOffset = CGSizeMake(0, 1);
            viewRangeCar.layer.shadowOpacity = 1;
            viewRangeCar.layer.shadowRadius = 1;
            [scrolUsedCar addSubview:viewRangeCar];
            
            /////// ### Range View Frame #######/////
            [self rangeViewFrame];
            
            UIButton *  btnfindCaeWittRange = [UIButton buttonWithType:UIButtonTypeCustom];
            btnfindCaeWittRange.frame=CGRectMake(30, 130, DEVICE_WIDTH-60, 40);
            btnfindCaeWittRange.layer.cornerRadius=5;
            btnfindCaeWittRange.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
            [btnfindCaeWittRange setTitle:@"Find Car" forState:UIControlStateNormal];
            [btnfindCaeWittRange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnfindCaeWittRange addTarget:self action:@selector(btnFindCarWithRangeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewRangeCar addSubview:btnfindCaeWittRange];

            
            y1=y1+ 190;
            
            viewLastVisited = [[UIView alloc] initWithFrame:CGRectMake(4, y1, DEVICE_WIDTH-10, 250)];
            viewLastVisited.backgroundColor = [UIColor whiteColor];
            viewLastVisited.layer.shadowColor = [UIColor blackColor].CGColor;
            viewLastVisited.layer.shadowOffset = CGSizeMake(0, 1);
            viewLastVisited.layer.shadowOpacity = 1;
            viewLastVisited.layer.shadowRadius = 1;
            [scrolUsedCar addSubview:viewLastVisited];
            
            /////// ### Last visit View Frame #######/////
            [self lastVisitViewFrame];
            
            y1=y1+ 260;
            
            viewPopularCars = [[UIView alloc] initWithFrame:CGRectMake(5, y1, DEVICE_WIDTH-10, 250)];
            viewPopularCars.backgroundColor = [UIColor whiteColor];
            viewPopularCars.layer.shadowColor = [UIColor blackColor].CGColor;
            viewPopularCars.layer.shadowOffset = CGSizeMake(0, 1);
            viewPopularCars.layer.shadowOpacity = 1;
            viewPopularCars.layer.shadowRadius = 1;
            [scrolUsedCar addSubview:viewPopularCars];
            
            /////// ### Popular View Frame #######/////
            [self popularCarsViewFrame];
            
            
            y1=y1+260;
            
            viewBuying = [[UIView alloc] initWithFrame:CGRectMake(5, y1, DEVICE_WIDTH-10, 230)];
            viewBuying.backgroundColor = [UIColor whiteColor];
            viewBuying.layer.shadowColor = [UIColor blackColor].CGColor;
            viewBuying.layer.shadowOffset = CGSizeMake(0, 1);
            viewBuying.layer.shadowOpacity = 1;
            viewBuying.layer.shadowRadius = 1;
            [scrolUsedCar addSubview:viewBuying];
            
            /////// ### Buying car View Frame #######/////
            [self buyingCarViewFrame];
            
            y1=y1+270;
            [scrolUsedCar setContentSize:CGSizeMake(0,y1)];
        }
    }
}

-(void)upComingViewFrame
{
    UILabel * lblSep6 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lblSep6.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewUpcomingCars addSubview:lblSep6];
    
    UILabel * lblSep7 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 120, DEVICE_WIDTH/2, 1)];
    lblSep7.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewUpcomingCars addSubview:lblSep7];
    
    AsyncImageView * imgFeaturedCars = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 10, viewUpcomingCars.frame.size.width/2-20, viewUpcomingCars.frame.size.height-70)];
    NSURL  *url1 = [NSURL URLWithString:[[GetCarModel objectAtIndex:4]valueForKey:@"model_image"]];
    imgFeaturedCars.imageURL = url1;
    imgFeaturedCars.clipsToBounds=YES;
    imgFeaturedCars.contentMode = UIViewContentModeScaleAspectFit;
    imgFeaturedCars.layer.borderWidth=2;
    imgFeaturedCars.layer.borderColor =[APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    imgFeaturedCars.layer.cornerRadius=3;
    [viewUpcomingCars addSubview:imgFeaturedCars];
    
    UILabel * lblFeaturedCarName = [[UILabel alloc] initWithFrame:CGRectMake(10,viewUpcomingCars.frame.size.height-55,viewUpcomingCars.frame.size.width/2-20, 20)];
    lblFeaturedCarName.text =[[GetCarModel objectAtIndex:4]valueForKey:@"car_model_name"];
    lblFeaturedCarName.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblFeaturedCarName.textAlignment=NSTextAlignmentCenter;
    lblFeaturedCarName.textColor =[UIColor blackColor];
    [viewUpcomingCars addSubview:lblFeaturedCarName];
    
    UILabel * lblFeaturedCarPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewUpcomingCars.frame.size.height-35,viewUpcomingCars.frame.size.height-35, 20)];
   // NSString *stringLBL = [NSString stringWithFormat: @"%@%@", [GetCarModel objectAtIndex:4]valueForKey:@"currency_symbol"] ,[];
    lblFeaturedCarPrice.text = [[GetCarModel objectAtIndex:4]valueForKey:@"price"];
    lblFeaturedCarPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice.textColor =[UIColor blackColor];
    [viewUpcomingCars addSubview:lblFeaturedCarPrice];
    
    UILabel * lblExpectedPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewUpcomingCars.frame.size.height-20,viewUpcomingCars.frame.size.height-20, 20)];
    lblExpectedPrice.text =@"Expected Price";
    lblExpectedPrice.font =[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
    lblExpectedPrice.textAlignment=NSTextAlignmentLeft;
    lblExpectedPrice.textColor =[UIColor grayColor];
    [viewUpcomingCars addSubview:lblExpectedPrice];
    
    UILabel * lblFeaturedCarExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewUpcomingCars.frame.size.width/2-20)-60, viewUpcomingCars.frame.size.height-35,65, 20)];
    lblFeaturedCarExpectedDate.text =[[GetCarModel objectAtIndex:4]valueForKey:@"launching_date"];
    lblFeaturedCarExpectedDate.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarExpectedDate.textAlignment=NSTextAlignmentRight;
    lblFeaturedCarExpectedDate.textColor =[UIColor blackColor];
    [viewUpcomingCars addSubview:lblFeaturedCarExpectedDate];
    
    UILabel * lblExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewUpcomingCars.frame.size.width/2-20)-60, viewUpcomingCars.frame.size.height-20,65, 20)];
    lblExpectedDate.text =@"Expected date";
    lblExpectedDate.font =[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
    lblExpectedDate.textAlignment=NSTextAlignmentRight;
    lblExpectedDate.textColor =[UIColor grayColor];
    [viewUpcomingCars addSubview:lblExpectedDate];
    
    
    UILabel * lblSep8 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-1, 0, 1, viewUpcomingCars.frame.size.height)];
    lblSep8.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewUpcomingCars addSubview:lblSep8];
    
    AsyncImageView * imgExpectedCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewUpcomingCars.frame.size.width/2+10, 10, viewUpcomingCars.frame.size.width/2-80, 100)];
    NSURL  *url2 = [NSURL URLWithString:[[GetCarModel objectAtIndex:1]valueForKey:@"car_model_name"]];
    imgFeaturedCars.imageURL = url2;
    imgExpectedCar2.clipsToBounds=YES;
    imgExpectedCar2.contentMode = UIViewContentModeScaleAspectFill;
    [viewUpcomingCars addSubview:imgExpectedCar2];
    
    
    UILabel * lblFeaturedCarName2 = [[UILabel alloc] initWithFrame:CGRectMake(viewUpcomingCars.frame.size.width-60, 10,60, 20)];
    lblFeaturedCarName2.text =[[GetCarModel objectAtIndex:1]valueForKey:@"car_model_name"];
    lblFeaturedCarName2.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName2.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName2.textColor =[UIColor blackColor];
    [viewUpcomingCars addSubview:lblFeaturedCarName2];
    
    UILabel * lblFeaturedCarPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewUpcomingCars.frame.size.width-60, 30,60, 20)];
    lblFeaturedCarPrice1.text =[[GetCarModel objectAtIndex:1]valueForKey:@"price"];
    lblFeaturedCarPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice1.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice1.textColor =[UIColor blackColor];
    [viewUpcomingCars addSubview:lblFeaturedCarPrice1];
    
    AsyncImageView * imgFeaturedCar3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewUpcomingCars.frame.size.width/2+10, 130,  viewUpcomingCars.frame.size.width/2-80, 100)];
    NSURL  *url3 = [NSURL URLWithString:[[GetCarModel objectAtIndex:2]valueForKey:@"model_image"]];
    imgFeaturedCar3.imageURL = url3;
    imgFeaturedCar3.clipsToBounds=YES;
    imgFeaturedCar3.contentMode = UIViewContentModeScaleAspectFill;
    [viewUpcomingCars addSubview:imgFeaturedCar3];
    
    UILabel * lblFeaturedCarName3 = [[UILabel alloc] initWithFrame:CGRectMake(viewUpcomingCars.frame.size.width-60, 130,60, 20)];
    lblFeaturedCarName3.text =[[GetCarModel objectAtIndex:2]valueForKey:@"car_model_name"];
    lblFeaturedCarName3.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName3.textColor =[UIColor blackColor];
    [viewUpcomingCars addSubview:lblFeaturedCarName3];
    
    UILabel * lblFeaturedCarPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(viewUpcomingCars.frame.size.width-60, 150,60, 20)];
    lblFeaturedCarPrice3.text =[[GetCarModel objectAtIndex:2]valueForKey:@"price"];
    lblFeaturedCarPrice3.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice3.textColor =[UIColor blackColor];
    [viewUpcomingCars addSubview:lblFeaturedCarPrice3];
}
-(void)JustLaunchedFrame
{
    UILabel * lblSep6 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lblSep6.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewJustLaunchedCars addSubview:lblSep6];
    
    UILabel * lblSep7 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 120, DEVICE_WIDTH/2, 1)];
    lblSep7.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewJustLaunchedCars addSubview:lblSep7];
    
    AsyncImageView * imgFeaturedCars = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 10, viewJustLaunchedCars.frame.size.width/2-20, viewJustLaunchedCars.frame.size.height-70)];
    imgFeaturedCars.image = [UIImage imageNamed:@"demo7.jpg"];
    imgFeaturedCars.clipsToBounds=YES;
    imgFeaturedCars.contentMode = UIViewContentModeScaleAspectFill;
    imgFeaturedCars.layer.borderWidth=2;
    imgFeaturedCars.layer.borderColor =[APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    imgFeaturedCars.layer.cornerRadius=3;
    [viewJustLaunchedCars addSubview:imgFeaturedCars];
    
    UILabel * lblFeaturedCarName = [[UILabel alloc] initWithFrame:CGRectMake(10,viewJustLaunchedCars.frame.size.height-55,viewJustLaunchedCars.frame.size.width/2-20, 20)];
    lblFeaturedCarName.text =@"Honda City";
    lblFeaturedCarName.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblFeaturedCarName.textAlignment=NSTextAlignmentCenter;
    lblFeaturedCarName.textColor =[UIColor blackColor];
    [viewJustLaunchedCars addSubview:lblFeaturedCarName];
    
    UILabel * lblFeaturedCarPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewJustLaunchedCars.frame.size.height-35,viewJustLaunchedCars.frame.size.height-35, 20)];
    lblFeaturedCarPrice.text =@"$ 14,500";
    lblFeaturedCarPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice.textColor =[UIColor blackColor];
    [viewJustLaunchedCars addSubview:lblFeaturedCarPrice];
    
    UILabel * lblExpectedPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewUpcomingCars.frame.size.height-20,viewUpcomingCars.frame.size.height-20, 20)];
    lblExpectedPrice.text =@"Expected Price";
    lblExpectedPrice.font =[UIFont systemFontOfSize:8.0 weight:UIFontWeightRegular];
    lblExpectedPrice.textAlignment=NSTextAlignmentLeft;
    lblExpectedPrice.textColor =[UIColor grayColor];
    [viewJustLaunchedCars addSubview:lblExpectedPrice];
    
    UILabel * lblFeaturedCarExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewJustLaunchedCars.frame.size.width/2-20)-60, viewJustLaunchedCars.frame.size.height-35,65, 20)];
    lblFeaturedCarExpectedDate.text =@"Oce 5th";
    lblFeaturedCarExpectedDate.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarExpectedDate.textAlignment=NSTextAlignmentRight;
    lblFeaturedCarExpectedDate.textColor =[UIColor blackColor];
    [viewJustLaunchedCars addSubview:lblFeaturedCarExpectedDate];
    
    UILabel * lblExpectedDate = [[UILabel alloc] initWithFrame:CGRectMake((viewJustLaunchedCars.frame.size.width/2-20)-60, viewUpcomingCars.frame.size.height-20,65, 20)];
    lblExpectedDate.text =@"Expected date";
    lblExpectedDate.font =[UIFont systemFontOfSize:8.0 weight:UIFontWeightRegular];
    lblExpectedDate.textAlignment=NSTextAlignmentRight;
    lblExpectedDate.textColor =[UIColor grayColor];
    [viewJustLaunchedCars addSubview:lblExpectedDate];
    
    
    UILabel * lblSep8 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-1, 0, 1, viewJustLaunchedCars.frame.size.height)];
    lblSep8.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewJustLaunchedCars addSubview:lblSep8];
    
    AsyncImageView * imgExpectedCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewJustLaunchedCars.frame.size.width/2+10, 10, viewJustLaunchedCars.frame.size.width/2-80, 100)];
    imgExpectedCar2.image = [UIImage imageNamed:@"demo9.jpg"];
    imgExpectedCar2.clipsToBounds=YES;
    imgExpectedCar2.contentMode = UIViewContentModeScaleAspectFill;
    [viewJustLaunchedCars addSubview:imgExpectedCar2];
    
    
    UILabel * lblFeaturedCarName2 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunchedCars.frame.size.width-60, 10,60, 20)];
    lblFeaturedCarName2.text =@"Audy Q8";
    lblFeaturedCarName2.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName2.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName2.textColor =[UIColor blackColor];
    [viewJustLaunchedCars addSubview:lblFeaturedCarName2];
    
    UILabel * lblFeaturedCarPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunchedCars.frame.size.width-60, 30,60, 20)];
    lblFeaturedCarPrice1.text =@"$ 10,500";
    lblFeaturedCarPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice1.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice1.textColor =[UIColor blackColor];
    [viewJustLaunchedCars addSubview:lblFeaturedCarPrice1];
    
    AsyncImageView * imgFeaturedCar3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewJustLaunchedCars.frame.size.width/2+10, 130,  viewJustLaunchedCars.frame.size.width/2-80, 100)];
    imgFeaturedCar3.image = [UIImage imageNamed:@"demo8.jpg"];
    imgFeaturedCar3.clipsToBounds=YES;
    imgFeaturedCar3.contentMode = UIViewContentModeScaleAspectFill;
    [viewJustLaunchedCars addSubview:imgFeaturedCar3];
    
    UILabel * lblFeaturedCarName3 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunchedCars.frame.size.width-60, 130,60, 20)];
    lblFeaturedCarName3.text =@"Audy Q8";
    lblFeaturedCarName3.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblFeaturedCarName3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarName3.textColor =[UIColor blackColor];
    [viewJustLaunchedCars addSubview:lblFeaturedCarName3];
    
    UILabel * lblFeaturedCarPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(viewJustLaunchedCars.frame.size.width-60, 150,60, 20)];
    lblFeaturedCarPrice3.text =@"$ 8,500";
    lblFeaturedCarPrice3.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblFeaturedCarPrice3.textAlignment=NSTextAlignmentLeft;
    lblFeaturedCarPrice3.textColor =[UIColor blackColor];
    [viewJustLaunchedCars addSubview:lblFeaturedCarPrice3];
}

-(void)carsNewFrame
{
    UILabel * lblSep9 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lblSep9.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewCarNews addSubview:lblSep9];
    
    AsyncImageView * imgCars = [[AsyncImageView alloc] initWithFrame:CGRectMake(20, 0, DEVICE_WIDTH/2-40, 80)];
    imgCars.image = [UIImage imageNamed:@"demo8.jpg"];
    imgCars.clipsToBounds=YES;
    imgCars.contentMode = UIViewContentModeScaleAspectFill;
    [viewCarNews addSubview:imgCars];
    
    UILabel * lblCarName = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, DEVICE_WIDTH/2-40, 15)];
    lblCarName.text =@"Audy Q8";
    lblCarName.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblCarName.textAlignment=NSTextAlignmentLeft;
    lblCarName.textColor =[UIColor blackColor];
    [viewCars addSubview:lblCarName];
    
    UILabel * lblTime= [[UILabel alloc] initWithFrame:CGRectMake(20, 128, DEVICE_WIDTH/2-40, 15)];
    lblTime.text =@"28 mins ago";
    lblTime.font =[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
    lblTime.textAlignment=NSTextAlignmentLeft;
    lblTime.textColor =[UIColor lightGrayColor];
    [viewCarNews addSubview:lblTime];
    
    UILabel * lblCompany= [[UILabel alloc] initWithFrame:CGRectMake(20, 145, DEVICE_WIDTH/2-30, 15)];
    lblCompany.text =@"By Lucifer Morningstar";
    lblCompany.font =[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
    lblCompany.textAlignment=NSTextAlignmentLeft;
    lblCompany.textColor =[UIColor lightGrayColor];
    [viewCarNews addSubview:lblCompany];
    
    UILabel * lbDiscription= [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+10, 0, DEVICE_WIDTH/2-20, 180)];
    lbDiscription.text =@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua, Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo conequat.";
    lbDiscription.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lbDiscription.textAlignment=NSTextAlignmentLeft;
    lbDiscription.textColor =[UIColor blackColor];
    lbDiscription.numberOfLines=10;
    lbDiscription.lineBreakMode=NSLineBreakByWordWrapping;
    [viewCarNews addSubview:lbDiscription];
    
    
    UILabel * lblSep10 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lblSep10.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewVideos addSubview:lblSep10];
    
    AsyncImageView * imgVido = [[AsyncImageView alloc] initWithFrame:CGRectMake(20, 20, DEVICE_WIDTH-40, viewVideos.frame.size.height-60)];
    imgVido.image = [UIImage imageNamed:@"demo8.jpg"];
    imgVido.clipsToBounds=YES;
    imgVido.contentMode = UIViewContentModeScaleAspectFill;
    [viewVideos addSubview:imgVido];
    
    UILabel * lblVideoName= [[UILabel alloc] initWithFrame:CGRectMake(20, viewVideos.frame.size.height-20, DEVICE_WIDTH-40, 20)];
    lblVideoName.text =@"Tata Nexon";
    lblVideoName.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblVideoName.textAlignment=NSTextAlignmentLeft;
    lblVideoName.textColor =[UIColor blackColor];
    lblVideoName.lineBreakMode=NSLineBreakByWordWrapping;
    [viewVideos addSubview:lblVideoName];
}
-(void)VideosFrame
{
    
}
-(void)rangeViewFrame
{
    UILabel * lblTitle =[[UILabel alloc] initWithFrame:CGRectMake(5, 8, DEVICE_WIDTH-10, 25)];
    lblTitle.text =@"Your are in  Ahmedabad";
    lblTitle.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblTitle.textAlignment=NSTextAlignmentCenter;
    lblTitle.textColor =[UIColor blackColor];
    [viewRangeCar addSubview:lblTitle];
    
    UILabel * lblselectPriceTitle =[[UILabel alloc] initWithFrame:CGRectMake(5, 30, DEVICE_WIDTH-10, 16)];
    lblselectPriceTitle.text =@"Select your price range";
    lblselectPriceTitle.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblselectPriceTitle.textAlignment=NSTextAlignmentCenter;
    lblselectPriceTitle.textColor =[APP_DELEGATE colorWithHexString:App_Background_color];
    [viewRangeCar addSubview:lblselectPriceTitle];
    
    
    lblPriceRange  =[[UILabel alloc] initWithFrame:CGRectMake(5, 50, DEVICE_WIDTH-10, 25)];
    lblPriceRange.text =@"$ 8k - $ 20k";
    lblPriceRange.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblPriceRange.textAlignment=NSTextAlignmentCenter;
    lblPriceRange.textColor =[UIColor blackColor];
    [viewRangeCar addSubview:lblPriceRange];
    

    rangeSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(25, 80, DEVICE_WIDTH-50, 40)];
    rangeSlider.minValue =1;
    rangeSlider.maxValue = 30;
    rangeSlider.selectedMinimum =1;
    rangeSlider.selectedMaximum = 30;
    rangeSlider.tintColorBetweenHandles = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.handleColor = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];

    [rangeSlider addTarget:self action:@selector(logControlEvent:) forControlEvents:UIControlEventValueChanged];
    [viewRangeCar addSubview:rangeSlider];
}
-(void)lastVisitViewFrame
{
    UILabel * lblCarOffers = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
    lblCarOffers.text =@"Last Car Visited";
    lblCarOffers.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblCarOffers.textAlignment=NSTextAlignmentLeft;
    lblCarOffers.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblCarOffers];
    
    UIButton * btnNewCarsViewAll = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNewCarsViewAll.frame = CGRectMake(DEVICE_WIDTH-100, 0, 100, 44);
    btnNewCarsViewAll.backgroundColor =[UIColor clearColor];
    [btnNewCarsViewAll setTitle:@"View all" forState:UIControlStateNormal];
    [btnNewCarsViewAll setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnNewCarsViewAll addTarget:self action:@selector(btnlastVisitedCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnNewCarsViewAll.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [viewLastVisited addSubview:btnNewCarsViewAll];
    
    
    UILabel * lblSep1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 38, DEVICE_WIDTH, 1)];
    lblSep1.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewLastVisited addSubview:lblSep1];
    
    UILabel * lblSep4 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 144, DEVICE_WIDTH/2, 1)];
    lblSep4.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewLastVisited addSubview:lblSep4];
    
    UILabel * lblSep3 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-1, 50, 1, viewLastVisited.frame.size.height-60)];
    lblSep3.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewLastVisited addSubview:lblSep3];
    
    
    AsyncImageView * imgCarOffer1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 50, viewLastVisited.frame.size.width/2-20, viewLastVisited.frame.size.height-100)];
    imgCarOffer1.image = [UIImage imageNamed:@"demo7.jpg"];
    imgCarOffer1.clipsToBounds=YES;
    imgCarOffer1.contentMode = UIViewContentModeScaleAspectFill;
    imgCarOffer1.layer.borderWidth=2;
    imgCarOffer1.layer.borderColor =[APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    imgCarOffer1.layer.cornerRadius=3;
    [viewLastVisited addSubview:imgCarOffer1];
    
    UILabel * lblCarNames = [[UILabel alloc] initWithFrame:CGRectMake(10, viewLastVisited.frame.size.height-45,DEVICE_WIDTH/2-20, 20)];
    lblCarNames.text =@"Honda City";
    lblCarNames.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblCarNames.textAlignment=NSTextAlignmentLeft;
    lblCarNames.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblCarNames];
    
    UILabel * lblOfferPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewLastVisited.frame.size.height-25,DEVICE_WIDTH/4, 20)];
    lblOfferPrice.text =@"$ 14,500";
    lblOfferPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblOfferPrice.textAlignment=NSTextAlignmentLeft;
    lblOfferPrice.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblOfferPrice];
    
    UILabel * lblActualPrice = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/4+10, viewLastVisited.frame.size.height-25,DEVICE_WIDTH/4, 20)];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"$ 16,500"];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    lblActualPrice.attributedText=attributeString;
    lblActualPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblActualPrice.textAlignment=NSTextAlignmentLeft;
    lblActualPrice.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblActualPrice];
    
    
    AsyncImageView * imgCarOffer2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+10, 50, viewLastVisited.frame.size.width/2-80, 85)];
    imgCarOffer2.image = [UIImage imageNamed:@"demo9.jpg"];
    imgCarOffer2.clipsToBounds=YES;
    imgCarOffer2.contentMode = UIViewContentModeScaleAspectFill;
    [viewLastVisited addSubview:imgCarOffer2];
    
    
    UILabel * lblCarNames1 = [[UILabel alloc] initWithFrame:CGRectMake(viewLastVisited.frame.size.width-60, 40,60, 20)];
    lblCarNames1.text =@"Audy Q8";
    lblCarNames1.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblCarNames1.textAlignment=NSTextAlignmentLeft;
    lblCarNames1.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblCarNames1];
    
    UILabel * lblOfferPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewLastVisited.frame.size.width-60, 62,60, 20)];
    lblOfferPrice1.text =@"$ 10,500";
    lblOfferPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblOfferPrice1.textAlignment=NSTextAlignmentLeft;
    lblOfferPrice1.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblOfferPrice1];
    
    UILabel * lblActualPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewLastVisited.frame.size.width-60, 80,60, 20)];
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:@"$ 16,500"];
    [attributeString1 addAttribute:NSStrikethroughStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString1 length])];
    lblActualPrice1.attributedText=attributeString1;
    lblActualPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblActualPrice1.textAlignment=NSTextAlignmentLeft;
    lblActualPrice1.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblActualPrice1];
    
    AsyncImageView * imgCarOffer3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewLastVisited.frame.size.width/2+10, 155,  viewLastVisited.frame.size.width/2-80, 85)];
    imgCarOffer3.image = [UIImage imageNamed:@"demo8.jpg"];
    imgCarOffer3.clipsToBounds=YES;
    imgCarOffer3.contentMode = UIViewContentModeScaleAspectFill;
    [viewLastVisited addSubview:imgCarOffer3];
    
    UILabel * lblCarNames2 = [[UILabel alloc] initWithFrame:CGRectMake(viewLastVisited.frame.size.width-60, 155,60, 20)];
    lblCarNames2.text =@"Audy Q8";
    lblCarNames2.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblCarNames2.textAlignment=NSTextAlignmentLeft;
    lblCarNames2.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblCarNames2];
    
    UILabel * lblOfferPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(viewLastVisited.frame.size.width-60, 175,60, 20)];
    lblOfferPrice2.text =@"$ 8,500";
    lblOfferPrice2.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblOfferPrice2.textAlignment=NSTextAlignmentLeft;
    lblOfferPrice2.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblOfferPrice2];
    
    UILabel * lblActualPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(viewLastVisited.frame.size.width-60, 190,60, 20)];
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc] initWithString:@"$ 14,500"];
    [attributeString2 addAttribute:NSStrikethroughStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString2 length])];
    lblActualPrice2.attributedText=attributeString2;
    lblActualPrice2.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblActualPrice2.textAlignment=NSTextAlignmentLeft;
    lblActualPrice2.textColor =[UIColor blackColor];
    [viewLastVisited addSubview:lblActualPrice2];
}
-(void)popularCarsViewFrame
{
    UILabel * lblCarOffers = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
    lblCarOffers.text =@"Popular cars in New York";
    lblCarOffers.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblCarOffers.textAlignment=NSTextAlignmentLeft;
    lblCarOffers.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblCarOffers];
    
    UIButton * btnNewCarsViewAll = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNewCarsViewAll.frame = CGRectMake(DEVICE_WIDTH-100, 0, 100, 44);
    btnNewCarsViewAll.backgroundColor =[UIColor clearColor];
    [btnNewCarsViewAll setTitle:@"View all" forState:UIControlStateNormal];
    [btnNewCarsViewAll setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnNewCarsViewAll addTarget:self action:@selector(btnPopularCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnNewCarsViewAll.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [viewPopularCars addSubview:btnNewCarsViewAll];
    
    
    UILabel * lblSep1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 38, DEVICE_WIDTH, 1)];
    lblSep1.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewPopularCars addSubview:lblSep1];
    
    UILabel * lblSep4 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 144, DEVICE_WIDTH/2, 1)];
    lblSep4.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewPopularCars addSubview:lblSep4];
    
    UILabel * lblSep3 =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-1, 50, 1, viewLastVisited.frame.size.height-60)];
    lblSep3.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewPopularCars addSubview:lblSep3];
    
    
    AsyncImageView * imgCarOffer1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 50, viewPopularCars.frame.size.width/2-20, viewPopularCars.frame.size.height-100)];
    imgCarOffer1.image = [UIImage imageNamed:@"demo7.jpg"];
    imgCarOffer1.clipsToBounds=YES;
    imgCarOffer1.contentMode = UIViewContentModeScaleAspectFill;
    imgCarOffer1.layer.borderWidth=2;
    imgCarOffer1.layer.borderColor =[APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    imgCarOffer1.layer.cornerRadius=3;
    [viewPopularCars addSubview:imgCarOffer1];
    
    UILabel * lblCarNames = [[UILabel alloc] initWithFrame:CGRectMake(10, viewPopularCars.frame.size.height-45,DEVICE_WIDTH/2-20, 20)];
    lblCarNames.text =@"Honda City";
    lblCarNames.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblCarNames.textAlignment=NSTextAlignmentLeft;
    lblCarNames.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblCarNames];
    
    UILabel * lblOfferPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, viewPopularCars.frame.size.height-25,DEVICE_WIDTH/4, 20)];
    lblOfferPrice.text =@"$ 14,500";
    lblOfferPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblOfferPrice.textAlignment=NSTextAlignmentLeft;
    lblOfferPrice.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblOfferPrice];
    
    UILabel * lblActualPrice = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/4+10, viewPopularCars.frame.size.height-25,DEVICE_WIDTH/4, 20)];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"$ 16,500"];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    lblActualPrice.attributedText=attributeString;
    lblActualPrice.font =[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    lblActualPrice.textAlignment=NSTextAlignmentLeft;
    lblActualPrice.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblActualPrice];
    
    
    AsyncImageView * imgCarOffer2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+10, 50, viewPopularCars.frame.size.width/2-80, 85)];
    imgCarOffer2.image = [UIImage imageNamed:@"demo9.jpg"];
    imgCarOffer2.clipsToBounds=YES;
    imgCarOffer2.contentMode = UIViewContentModeScaleAspectFill;
    [viewPopularCars addSubview:imgCarOffer2];
    
    
    UILabel * lblCarNames1 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopularCars.frame.size.width-60, 40,60, 20)];
    lblCarNames1.text =@"Audy Q8";
    lblCarNames1.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblCarNames1.textAlignment=NSTextAlignmentLeft;
    lblCarNames1.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblCarNames1];
    
    UILabel * lblOfferPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopularCars.frame.size.width-60, 62,60, 20)];
    lblOfferPrice1.text =@"$ 10,500";
    lblOfferPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblOfferPrice1.textAlignment=NSTextAlignmentLeft;
    lblOfferPrice1.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblOfferPrice1];
    
    UILabel * lblActualPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopularCars.frame.size.width-60, 80,60, 20)];
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:@"$ 16,500"];
    [attributeString1 addAttribute:NSStrikethroughStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString1 length])];
    lblActualPrice1.attributedText=attributeString1;
    lblActualPrice1.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblActualPrice1.textAlignment=NSTextAlignmentLeft;
    lblActualPrice1.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblActualPrice1];
    
    AsyncImageView * imgCarOffer3 = [[AsyncImageView alloc] initWithFrame:CGRectMake(viewPopularCars.frame.size.width/2+10, 155,  viewPopularCars.frame.size.width/2-80, 85)];
    imgCarOffer3.image = [UIImage imageNamed:@"demo8.jpg"];
    imgCarOffer3.clipsToBounds=YES;
    imgCarOffer3.contentMode = UIViewContentModeScaleAspectFill;
    [viewPopularCars addSubview:imgCarOffer3];
    
    UILabel * lblCarNames2 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopularCars.frame.size.width-60, 155,60, 20)];
    lblCarNames2.text =@"Audy Q8";
    lblCarNames2.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblCarNames2.textAlignment=NSTextAlignmentLeft;
    lblCarNames2.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblCarNames2];
    
    UILabel * lblOfferPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopularCars.frame.size.width-60, 175,60, 20)];
    lblOfferPrice2.text =@"$ 8,500";
    lblOfferPrice2.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblOfferPrice2.textAlignment=NSTextAlignmentLeft;
    lblOfferPrice2.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblOfferPrice2];
    
    UILabel * lblActualPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(viewPopularCars.frame.size.width-60, 190,60, 20)];
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc] initWithString:@"$ 14,500"];
    [attributeString2 addAttribute:NSStrikethroughStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString2 length])];
    lblActualPrice2.attributedText=attributeString2;
    lblActualPrice2.font =[UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    lblActualPrice2.textAlignment=NSTextAlignmentLeft;
    lblActualPrice2.textColor =[UIColor blackColor];
    [viewPopularCars addSubview:lblActualPrice2];
}
-(void)buyingCarViewFrame
{
    UILabel * lblCarOffers = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, DEVICE_WIDTH-60, 25)];
    lblCarOffers.text =@"Car buying tool";
    lblCarOffers.font =[UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    lblCarOffers.textAlignment=NSTextAlignmentLeft;
    lblCarOffers.textColor =[UIColor blackColor];
    [viewBuying addSubview:lblCarOffers];
    
    UILabel * lblSep1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 38, DEVICE_WIDTH, 1)];
    lblSep1.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [viewBuying addSubview:lblSep1];
    
    UILabel * lblgetPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, DEVICE_WIDTH-40, 25)];
    lblgetPrice.text =@"Get the best price for your car";
    lblgetPrice.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblgetPrice.textAlignment=NSTextAlignmentCenter;
    lblgetPrice.textColor =[UIColor blackColor];
    [viewBuying addSubview:lblgetPrice];
    
    btnSellCar= [UIButton buttonWithType:UIButtonTypeCustom];
    btnSellCar.frame=CGRectMake(30, 85, DEVICE_WIDTH-60, 40);
    btnSellCar.layer.cornerRadius=5;
    btnSellCar.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [btnSellCar setTitle:@"Sell Car" forState:UIControlStateNormal];
    [btnSellCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSellCar addTarget:self action:@selector(btnSellCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewBuying addSubview:btnSellCar];
    
    UILabel * lblMarketValue = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, DEVICE_WIDTH-40, 25)];
    lblMarketValue.text =@"Find true narket value for your car";
    lblMarketValue.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblMarketValue.textAlignment=NSTextAlignmentCenter;
    lblMarketValue.textColor =[UIColor blackColor];
    [viewBuying addSubview:lblMarketValue];
    
    btnCheckValue= [UIButton buttonWithType:UIButtonTypeCustom];
    btnCheckValue.frame=CGRectMake(30, 170, DEVICE_WIDTH-60, 40);
    btnCheckValue.layer.cornerRadius=5;
    btnCheckValue.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    [btnCheckValue setTitle:@"Check Value" forState:UIControlStateNormal];
    [btnCheckValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCheckValue addTarget:self action:@selector(btncheckValueClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewBuying addSubview:btnCheckValue];
}
-(void)locationViewFrame
{
    BackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    BackView.backgroundColor=[UIColor blackColor];
    BackView.alpha = 0.5;
    BackView.hidden=YES;
    [self.view addSubview:BackView];
  
    LocationView= [[UIView alloc]initWithFrame:CGRectMake(20, DEVICE_HEIGHT/2-120,DEVICE_WIDTH-40, 250)];
    LocationView.backgroundColor = [UIColor whiteColor];
    LocationView.hidden=YES;
    [self.view addSubview:LocationView];
    
    UIButton *cancleBtn = [[UIButton alloc]init];
    cancleBtn.frame = CGRectMake(LocationView.frame.size.width-20,0,20, 20);
    cancleBtn.backgroundColor = [UIColor blackColor];
    [cancleBtn addTarget:self action:@selector(btnHideLocationView:) forControlEvents:UIControlEventTouchUpInside];
    [LocationView addSubview:cancleBtn];
    
    UIImageView *LocatioLogoImg = [[UIImageView alloc] init];
    LocatioLogoImg.frame = CGRectMake(LocationView.frame.size.width/2-20,20 , 50, 50);
    LocatioLogoImg.backgroundColor = [UIColor grayColor];
    [LocationView addSubview:LocatioLogoImg];
    
    UILabel *yourCityLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,80,LocationView.frame.size.width,30)];
    yourCityLbl.text=@"Please Tell Us Your City";
    yourCityLbl.textColor = [UIColor blackColor];
    yourCityLbl.textAlignment=NSTextAlignmentCenter;
    [yourCityLbl setFont:[UIFont systemFontOfSize:16.0]];
    [LocationView addSubview:yourCityLbl];
    
    UITextField *txtEnterCity = [[UITextField alloc]init];
    txtEnterCity.frame = CGRectMake(20,130,LocationView.frame.size.width-40 ,30);
    txtEnterCity.placeholder = @"Enter City";
    [txtEnterCity setBorderStyle:UITextBorderStyleLine];
    [LocationView addSubview:txtEnterCity];
    
    UIButton *ConfirmCityButton = [[UIButton alloc]init];
    ConfirmCityButton.frame = CGRectMake(20,180,LocationView.frame.size.width-40, 30);
    ConfirmCityButton.backgroundColor = [UIColor orangeColor];
    [ConfirmCityButton setTitle:@"CONFIRM CITY" forState:UIControlStateNormal];
    [ConfirmCityButton addTarget:self action:@selector(btnConfirmCityClick:) forControlEvents:UIControlEventTouchUpInside];
    [LocationView addSubview:ConfirmCityButton];

}

#pragma mark - Button Action
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}
-(void)btnNewCarsClicked:(id)sender
{
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:lblSelerator cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.5 animations:^{
        lblSelerator.frame=CGRectMake(20, 122, DEVICE_WIDTH/2-20, 3);
    } completion:^(BOOL finished) {
    }];
}
-(void)btnUsedCarsClicked:(id)sender
{
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:lblSelerator cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.5 animations:^{
        lblSelerator.frame=CGRectMake(DEVICE_WIDTH/2, 122, DEVICE_WIDTH/2-20, 3);
    } completion:^(BOOL finished) {
    }];
}
-(void)btnViewAllClicked:(id)sender
{
    
}
-(void)btnFindCarClicked:(id)sender
{
   
}
-(void)btnMoreUpcomingCarsClicked:(id)sender
{
    
}
-(void)btnUpcomingCarssClicked:(id)sender
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
-(void)btnCarUpdatesClicked:(id)sender
{
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepLatestCars cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.5 animations:^{
        sepLatestCars.frame=CGRectMake(0, 38, DEVICE_WIDTH/2, 2);
    } completion:^(BOOL finished) {
    }];
    [scrolCarUpdates setContentOffset:CGPointMake(0, 0) animated:YES];

}
-(void)btnVideosClicked:(id)sender
{
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepLatestCars cache:YES];
    [UIView commitAnimations];
    [UIView animateWithDuration:.5 animations:^{
        sepLatestCars.frame=CGRectMake(DEVICE_WIDTH/2, 38, DEVICE_WIDTH/2, 2);
    } completion:^(BOOL finished) {
    }];
    [scrolCarUpdates setContentOffset:CGPointMake(DEVICE_WIDTH, 0) animated:YES];
}
-(void)btnMoreDetailsClicked:(id)sender
{
    
}
-(void)btnNewCarsViewAllClicked:(id)sender
{
    
}
-(void)btnFindCarWithRangeClicked:(id)sender
{
    
}
-(void)btnlastVisitedCarClicked:(id)sender
{
    
}
-(void)btnPopularCarClicked:(id)sender
{
    
}
-(void)btnSellCarClicked:(id)sender
{
    
}
-(void)btncheckValueClicked:(id)sender
{
    
}
-(void)btnCheckNowClicked:(id)sender
{
    
}
-(void)btnLocationGet:(id)sender
{
    presentView.hidden=NO;
    BackView.hidden=NO;
    LocationView.hidden=NO;
    
}
-(void)btnHideLocationView:(id)sender
{
     presentView.hidden=YES;
    BackView.hidden=YES;
    LocationView.hidden=YES;
}
-(void)btnConfirmCityClick:(id)sender
{

}
-(void)btnViewAllUpcomingCar:(id)sender
{
    
}
-(void)btnViewPopularCar:(id)sender
{
    
}
-(void)btnViewCheckOnRoadPrice:(id)sender
{

}

#pragma mark - Segment Clicked
-(void)carTypeClicked:(id)sender
{
    if ([sender selectedSegmentIndex]==0)
    {
        [scrolMain setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        [scrolMain setContentOffset:CGPointMake(DEVICE_WIDTH, 0) animated:YES];
    }
}

#pragma mark - Notifications Methods
-(void)registerNotifications
{
    [self clearNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)clearNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - Webservice

-(void)BrandNameAndCarType
{
    ProgressHUD.hidden = NO;
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
    ProgressHUD.hidden = NO;
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        NSString * webServiceName = @"getModalComparison";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getModalComparison";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
        
    }
    
}

-(void)GetcarModels
{
    ProgressHUD.hidden = NO;
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
      
        NSString * webServiceName = @"getModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getModels";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    
    }


}
#pragma mark - WebServices Delegate


-(void)onResult:(NSDictionary *)result
{
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getCarBrandAndType"])
    {
        ProgressHUD.hidden = YES;
        carBrandArray = [[result valueForKey:@"result"] valueForKey:@"car_brand"];
        carTypeArray = [[result valueForKey:@"result"] valueForKey:@"car_type"];
       
        
    }
   else if([[result valueForKey:@"commandName"] isEqualToString:@"getModalComparison"])
    {
         ProgressHUD.hidden = YES;
        NSLog(@"%@response",result);
       
        CompareCarArry = [[result valueForKey:@"result"] valueForKey:@"comparison_list"];
        NSLog(@"Compare Car Array:%@",CompareCarArry);
       
    }
    else if([[result valueForKey:@"commandName"] isEqualToString:@"getModels"])
    {
         ProgressHUD.hidden = YES;
        NSLog(@"%@response",result);
        GetCarModel = [[result valueForKey:@"result"] valueForKey:@"car_model"];
        NSLog(@"%@response",GetCarModel);
         [self setViewFrame];
        
    }

}
- (void)onError:(NSError *)error
{
    NSLog(@"The error is...%@", error);
}

#pragma mark -  UISearchBar Delegates
- (BOOL)searchDisplayController:(UISearchBar *)controller shouldReloadTableForSearchString:(NSString *)searchString;
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText1
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *searchStr1 = [NSString stringWithFormat:@"%@",searchBar.text];
    
    if ([searchText1 length]>0)
    {
        
        tblSearchCar.backgroundColor = [UIColor whiteColor];
        tblSearchCar.alpha=1;
//        [self placeAutocomplete:searchStr1];
    }else
    {
        
        [arraySearchCars removeAllObjects];
        tblSearchCar.backgroundColor = [UIColor blackColor];
        tblSearchCar.alpha=0.2;
        [tblSearchCar reloadData];
    }
    searchBar.showsCancelButton = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchStr1 = [NSString stringWithFormat:@"%@",searchBar.text];
    
//    [self placeAutocomplete:searchStr1];
    if (searchStr1.length >0)
    {
        searchBar.showsCancelButton = YES;
    }
    [searchBar resignFirstResponder];
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    searchBar.showsCancelButton = YES;

    UIView *view = [searchBar.subviews objectAtIndex:0];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton *)subView;
            [cancelButton setTitleColor:[APP_DELEGATE colorWithHexString:AppHeaderColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[APP_DELEGATE colorWithHexString:AppHeaderColor] forState:UIControlStateHighlighted];
        }
    }
//    [self showPropertiesType:NO];
//    Searchbar.frame=CGRectMake(18, 38, self.view.frame.size.width-36, 40);
    tblSearchCar.hidden=NO;
    [arraySearchCars removeAllObjects];
    [tblSearchCar reloadData];
    tblSearchCar.backgroundColor = [UIColor blackColor];
    tblSearchCar.alpha=0.2;
    searchImgGlass.hidden=YES;
    searchBar.text=@"";
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
//    [self showPropertiesType:NO];
    tblSearchCar.hidden=YES;
    searchBar.text = @"";
    searchBar.text=@"";
    searchBar.showsCancelButton = NO;
    searchImgGlass.hidden=NO;
//    Searchbar.frame=CGRectMake(18, 38, self.view.frame.size.width-120, 40);
    tblSearchCar.hidden=YES;
    tblSearchCar.backgroundColor = [UIColor blackColor];
    tblSearchCar.alpha=0.2;
    [arraySearchCars removeAllObjects];
    [searchBar resignFirstResponder];
    [searchBar resignFirstResponder];
}
#pragma mark - Keyboard notification methods
-(void) keyboardWillShow:(NSNotification *)note
{
    
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    CGRect tableviewframe=tblSearchCar.frame;
    tableviewframe.size.height=self.view.bounds.size.height - keyboardBounds.size.height-30;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    tblSearchCar.frame=tableviewframe;
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    CGRect tableviewframe=tblSearchCar.frame;
    tableviewframe.size.height=self.view.bounds.size.height-60;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    tblSearchCar.frame=tableviewframe;
    [UIView commitAnimations];
}

#pragma mark - UITableview Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraySearchCars count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell.backgroundColor=[UIColor clearColor];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = nil;

        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.text = [arraySearchCars objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
        UILabel * lblseperator = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, DEVICE_WIDTH, 0.5)];
        lblseperator.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lblseperator];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - Collectionview Delegate Methiods
#pragma mark - UICollectionView DataSource & Delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CompareCarsCell *cell = (CompareCarsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}


#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return [CompareCarArry count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    [view removeFromSuperview];
    view =nil;
    if (view == nil)
    {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH-60,150)];
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 1.0;
        view.backgroundColor = [UIColor whiteColor];
        
        AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
        NSURL *url = [NSURL URLWithString:[[CompareCarArry objectAtIndex:index]valueForKey:@"image"]];
        imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        UILabel * lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(0, 120, view.frame.size.width/2-15, 20);
        lblCarName1.font=[UIFont boldSystemFontOfSize:10.0];
        lblCarName1.textAlignment=NSTextAlignmentCenter;
        lblCarName1.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
        lblCarName1.text=[[CompareCarArry objectAtIndex:index]valueForKey:@"first_model_name"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];

        
        UILabel * lblCarName2=[[UILabel alloc] init];
        lblCarName2.frame=CGRectMake(view.frame.size.width/2+15, 120, view.frame.size.width/2-15, 20);
        lblCarName2.font=[UIFont boldSystemFontOfSize:10.0];
        lblCarName2.textAlignment=NSTextAlignmentCenter;
        lblCarName2.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
        lblCarName2.text=[[CompareCarArry objectAtIndex:index]valueForKey:@"second_model_name"];
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
    }else if (scrollView ==scrolCarUpdates)
    {
        int page = floor((scrollView.contentOffset.x - pageWidth / 2 ) / pageWidth) + 1; //this provide you the page number
        if (page==0)
        {
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepFeatureCar cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:.5 animations:^{
                sepLatestCars.frame=CGRectMake(0, 38, DEVICE_WIDTH/2, 2);
            } completion:^(BOOL finished) {
            }];
        }else
        {
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sepFeatureCar cache:YES];
            [UIView commitAnimations];
            [UIView animateWithDuration:.5 animations:^{
                sepLatestCars.frame=CGRectMake(DEVICE_WIDTH/2, 38, DEVICE_WIDTH/2, 2);
            } completion:^(BOOL finished) {
            }];
        }
    }else if(scrolMain==scrollView)
    {
        int page = floor((scrollView.contentOffset.x - pageWidth / 2 ) / pageWidth) + 1; //this
        if (page==0)
        {
            [segmentedControl setSelectedSegmentIndex:0];
        }else
        {
            [segmentedControl setSelectedSegmentIndex:1];
        }

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

#pragma mark -  Slider Value
- (void)logControlEvent:(TTRangeSlider *)sender
{
    NSLog(@"Standard slider updated. Min Value: %.0f Max Value: %.0f", sender.selectedMinimum, sender.selectedMaximum);
    
    lblPriceRange.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
    
//    strMinimumvalue = [NSString stringWithFormat:@"%.0f",sender.selectedMinimum];
    
//    strMaximumvalue = [NSString stringWithFormat:@"%.0f",sender.selectedMaximum];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self clearNotifications];
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
