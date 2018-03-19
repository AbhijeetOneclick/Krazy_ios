//
//  CarDetailVC.m
//  carwale
//
//  Created by i-MaC on 14/08/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CarDetailVC.h"

@interface CarDetailVC ()

@end

static NSString *ItemIdentifier = @"ItemIdentifier";

@implementation CarDetailVC

@synthesize carFlowLayout,collectionviewCars,dictCar,videoPageController;

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view removeFromSuperview];
    self.navigationController.navigationBarHidden = YES;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    NSLog(@"car detail ==> %@",dictCar);
    isFualClick=NO;
    sizeOfx = [[NSMutableArray alloc] init];
    arrCarImages = [[NSMutableArray alloc] init];
    arrCarVideos = [[NSMutableArray alloc] init];
    arrFual = [[NSMutableArray alloc] init];
    optionsAry = [[NSMutableArray alloc] init];
    arrTransmission = [[NSMutableArray alloc] init];
    dictModelDetail = [[NSMutableDictionary alloc] init];
    arrVerionList = [[NSMutableArray alloc] init];

    isVersionLess=NO;
    isColorLess=NO;
    isShowTab=NO;

    [self scrolViewFrame];
    [self setFrameToCreateTabBar];
    [self setCarImagesFrame];
    scrolltabBar.hidden=YES;
    /*-----Webservice calling---*/
    [self getModeldetailsById];
}

#pragma mark - Scrollview fram
-(void)scrolViewFrame
{
    int yy=0;

    [scrolContent removeFromSuperview];
    scrolContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yy, DEVICE_WIDTH, DEVICE_HEIGHT)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrolContent.delegate=self;
    scrolContent.bounces=NO;
    scrolContent.showsVerticalScrollIndicator=NO;
    scrolContent.showsHorizontalScrollIndicator=NO;
    scrolContent.clipsToBounds = YES;
    scrolContent.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrolContent];


    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeTextInput:)];
    tapGesture.cancelsTouchesInView = NO;
    [scrolContent addGestureRecognizer:tapGesture];

}
-(void)setCarImagesFrame
{
    /*-----Car images frame------*/
    [viewCarImages removeFromSuperview];
    viewCarImages = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 240)];
    viewCarImages.backgroundColor = [UIColor clearColor];
    viewCarImages.clipsToBounds=YES;
    [scrolContent addSubview:viewCarImages];

    self.carFlowLayout = [[CarImagesFlowLayout alloc] init];
    collectionviewCars=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,240) collectionViewLayout: self.carFlowLayout];
    collectionviewCars.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [collectionviewCars setDataSource:self];
    [collectionviewCars setDelegate:self];
    [collectionviewCars registerClass:[CarImageCell class] forCellWithReuseIdentifier:ItemIdentifier];
    [collectionviewCars setBackgroundColor:[UIColor clearColor]];
    [self.carFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionviewCars.showsHorizontalScrollIndicator = NO;

    [viewCarImages addSubview:collectionviewCars];
    collectionviewCars.pagingEnabled = YES;

    btnShowGallery = [[UIButton alloc] initWithFrame:CGRectMake(0,0 ,(collectionviewCars.frame.size.width)*([arrCarImages count]),(collectionviewCars.frame.size.height))];
    [btnShowGallery setBackgroundColor:[UIColor clearColor]];
    [btnShowGallery addTarget:self action:@selector(btnGalleryClick:) forControlEvents:UIControlEventTouchUpInside];
    [collectionviewCars addSubview:btnShowGallery];


    /*-----Header frame-----*/

    btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 64)];
    [btnBack addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewCarImages addSubview:btnBack];

    UIImageView *gradientback = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 54)];
    gradientback.image = [UIImage imageNamed:@"gradient-detailed-screen"];
    //gradientback.contentMode = UIViewContentModeScaleAspectFit;
    // gradientback.clipsToBounds = YES;
    [viewCarImages addSubview:gradientback];

    imgbackImge = [[UIImageView alloc] initWithFrame:CGRectMake(20,20, 22, 22)];
    imgbackImge.image = [UIImage imageNamed:@"back-blue"];
    [viewCarImages addSubview:imgbackImge];

    imgFav = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-100,20, 22, 22)];
    imgFav.image = [UIImage imageNamed:@"heart"];
    [viewCarImages addSubview:imgFav];

    imgShare = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-50,20, 22, 22)];
    imgShare.image = [UIImage imageNamed:@"share"];
    [viewCarImages addSubview:imgShare];

    UIView *showImgCout = [[UIView alloc] init];
    showImgCout.frame = CGRectMake(DEVICE_WIDTH-66, viewCarImages.frame.size.height-24, 66, 24);
    showImgCout.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];

    [viewCarImages addSubview:showImgCout];

    UIImageView *imageShow = [[UIImageView alloc] init];
    NSLog(@"%f",showImgCout.frame.size.height);
    imageShow.frame = CGRectMake(11,(showImgCout.frame.size.height/2)-8,16, 16 );
    imageShow.image = [UIImage imageNamed:@"img_detail_count"];
    imageShow.clipsToBounds = YES;
    imageShow.contentMode = UIViewContentModeScaleAspectFit;
    [showImgCout addSubview:imageShow];

    lblCountImages = [[UILabel alloc] initWithFrame:CGRectMake(showImgCout.frame.size.width-34, (showImgCout.frame.size.height/2)-7, 23, 14)];
    lblCountImages.backgroundColor = [UIColor clearColor];
    lblCountImages.textColor = [UIColor whiteColor];
    lblCountImages.textAlignment = NSTextAlignmentCenter;
    lblCountImages.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
    [showImgCout addSubview:lblCountImages];
    lblCountImages.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)[arrCarImages count]];

}
-(void)setCarDeatils
{
    [viewModelDetails removeFromSuperview];
    viewModelDetails = [[UIView alloc] initWithFrame:CGRectMake(0, viewCarImages.frame.origin.y + viewCarImages.frame.size.height-20, DEVICE_WIDTH, 140)];
    viewModelDetails.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewModelDetails];
    int y =10;

    lblCarName = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-20, 22)];
    lblCarName.text =[[dictModelDetail valueForKey:@"model_details"] valueForKey:@"car_brand_name"];
    lblCarName.textAlignment=NSTextAlignmentLeft;
    lblCarName.textColor = [UIColor blackColor];
    lblCarName.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
    [viewModelDetails addSubview:lblCarName];

    y=y+ 30;

    //  carRating = [RateView rateViewWithRating:2.5];
    carRating = [RateView rateViewWithRating:[[[dictModelDetail valueForKey:@"model_details"] valueForKey:@"model_rating"] floatValue]];

    carRating.frame = CGRectMake(15, y, 100, 25);
    [viewModelDetails addSubview:carRating];

    lblReviewCount = [[UILabel alloc] initWithFrame:CGRectMake(carRating.frame.size.width+40, y, 150, 25)];
    lblReviewCount.text =[NSString stringWithFormat:@"%lu Reviews",[[dictModelDetail  valueForKey:@"rating_list"] count]];
    lblReviewCount.textAlignment=NSTextAlignmentCenter;
    lblReviewCount.textColor = [APP_DELEGATE colorWithHexString:@"04B3C4"];
    lblReviewCount.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    lblReviewCount.layer.cornerRadius =5;
    lblReviewCount.layer.borderWidth=1;
    lblReviewCount.layer.borderColor = [APP_DELEGATE colorWithHexString:@"04B3C4"].CGColor;
    [viewModelDetails addSubview:lblReviewCount];
    CGSize yourLabelSize = [lblReviewCount.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold]}];
    lblReviewCount.frame = CGRectMake(carRating.frame.size.width+40, y, yourLabelSize.width+15, 25);

    y=y+33;

    NSDictionary *arialDict = @{
                                NSFontAttributeName : [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold],
                                NSForegroundColorAttributeName : [UIColor blackColor]
                                };
    NSString *priceCar = [NSString stringWithFormat:@"%ld",[[[dictModelDetail valueForKey:@"model_details"] valueForKey:@"price"] integerValue] ];
    ;
    NSString *getPrice = [APP_DELEGATE datafromServer:priceCar];
    NSString *finalprice = [NSString stringWithFormat:@"%@ %@",[[dictModelDetail valueForKey:@"model_details"] valueForKey:@"currency_symbol"],getPrice];

    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalprice ] attributes: arialDict];

    NSDictionary *arialDict2 = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular],
                                 NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                 };
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"  onwords" attributes: arialDict2];
    [aAttrString1 appendAttributedString:aAttrString2];

    lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-20, 25)];
    lblPrice.textAlignment=NSTextAlignmentLeft;
    lblPrice.attributedText = aAttrString1;
    [viewModelDetails addSubview:lblPrice];

    y=y+26;

    lblAddress= [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-20, 25)];
    lblAddress.text =@"Ex.showroom, Ahmedabad";
    lblAddress.textAlignment=NSTextAlignmentLeft;
    lblAddress.textColor = [UIColor lightGrayColor];
    lblAddress.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [viewModelDetails addSubview:lblAddress];

    y=y+31;

    btnOnRoadPrice = [[UIButton alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 30)];
    [btnOnRoadPrice setTitle:@"Check On-Road price" forState:UIControlStateNormal];
    [btnOnRoadPrice setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
    btnOnRoadPrice.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    btnOnRoadPrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnOnRoadPrice.titleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
    [btnOnRoadPrice addTarget:self action:@selector(btnClickOnRoadPriceClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewModelDetails addSubview:btnOnRoadPrice];

    y=y+30;

    viewModelDetails.frame =CGRectMake(0, viewCarImages.frame.origin.y + viewCarImages.frame.size.height, DEVICE_WIDTH, y);
}

-(void)setEMIFrame
{
    [emiView removeFromSuperview];
    emiView = [[UIView alloc] initWithFrame:CGRectMake(0, viewModelDetails.frame.origin.y+viewModelDetails.frame.size.height, DEVICE_WIDTH, 55)];
    emiView.layer.borderWidth=0.5;
    emiView.layer.borderColor = [APP_DELEGATE colorWithHexString:@"C5C5C5"].CGColor;
    [scrolContent addSubview:emiView];


    emiView.backgroundColor = [APP_DELEGATE colorWithHexString:@"F5F3F4"];

    lblGetEMItext = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, DEVICE_WIDTH-40, 20)];
    lblGetEMItext.textAlignment = NSTextAlignmentLeft;
    lblGetEMItext.text = @"EMI Starts at 4.311";
    lblGetEMItext.textColor = [APP_DELEGATE colorWithHexString:@"333333"];
    lblGetEMItext.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
    [emiView addSubview:lblGetEMItext];

    btnGetLoan = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, DEVICE_WIDTH, 30)];
    [btnGetLoan setTitle:[NSString stringWithFormat:@"Get Car Loan Offers"] forState:UIControlStateNormal];
    btnGetLoan.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    btnGetLoan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnGetLoan setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
    btnGetLoan.titleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
    [emiView addSubview:btnGetLoan];
}
#pragma mark - Dynamic frames
-(void)setFrameforFeatureList
{
    [carAccessories removeFromSuperview];

    carAccessories = [[NAUIViewWithBorders alloc] initWithFrame:CGRectMake(0, emiView.frame.origin.y+emiView.frame.size.height+5, DEVICE_WIDTH, 120)];
    carAccessories.borderWidths      = UIEdgeInsetsMake(0, 0, 0, 0);
    carAccessories.borderColorTop    = [UIColor clearColor];
    carAccessories.borderColorRight  = [UIColor lightGrayColor];
    carAccessories.borderColorBottom = [UIColor lightGrayColor];
    carAccessories.borderColorLeft   = [UIColor lightGrayColor];
    carAccessories.backgroundColor = [UIColor clearColor];
    [scrolContent addSubview:carAccessories];

    UILabel * lblSeperator = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, DEVICE_WIDTH, 60)];
    lblSeperator.backgroundColor = [APP_DELEGATE colorWithHexString:@"DFDFDF"];
    [carAccessories addSubview:lblSeperator];

    scrollAccessories = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 120)];
    [scrollAccessories setBackgroundColor:[UIColor clearColor]];
    scrollAccessories.showsHorizontalScrollIndicator = NO;
    scrollAccessories.pagingEnabled = YES;
    [carAccessories addSubview:scrollAccessories];
    scrollAccessories.delegate = self;

    int x =20 ;
    for (int i = 0; i<[dictModelDetail count]; i++)
    {
        if (i == 0)
        {
            if ([dictModelDetail valueForKey:@"version_list"])
            {
                [optionsAry addObject:@"Versions"];
                AsyncImageView * imgProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(x, 20, 78, 78)];
                imgProduct.image = [UIImage imageNamed:@"Version_details"];
                imgProduct.contentMode = UIViewContentModeScaleAspectFit;
                [scrollAccessories addSubview:imgProduct];
                UILabel * lblAccessoryName  = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, 78, 20)];
                lblAccessoryName.text = @"Versions";
                lblAccessoryName.textAlignment =NSTextAlignmentCenter;
                lblAccessoryName.textColor = [UIColor blackColor];
                lblAccessoryName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium];
                [scrollAccessories addSubview:lblAccessoryName];
                x = x+100;
            }

        }else if (i==1)
        {
            if ([dictModelDetail valueForKey:@"mileage"])
            {
                [optionsAry addObject:@"Mileage"];
                AsyncImageView * imgProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(x, 20, 78, 78)];
                imgProduct.image = [UIImage imageNamed:@"Mileage_detail"];
                imgProduct.contentMode = UIViewContentModeScaleAspectFit;
                [scrollAccessories addSubview:imgProduct];
                UILabel * lblAccessoryName  = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, 78, 20)];
                lblAccessoryName.text = @"Mileage";
                lblAccessoryName.textAlignment =NSTextAlignmentCenter;
                lblAccessoryName.textColor = [UIColor blackColor];
                lblAccessoryName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium];
                [scrollAccessories addSubview:lblAccessoryName];
                x = x+100;
            }

        } else if (i==2)
        {
            if ([dictModelDetail valueForKey:@"color_list"])
            {
                [optionsAry addObject:@"Colors"];
                AsyncImageView * imgProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(x, 20, 78, 78)];
                imgProduct.image = [UIImage imageNamed:@"color_detail"];
                imgProduct.contentMode = UIViewContentModeScaleAspectFit;
                [scrollAccessories addSubview:imgProduct];
                UILabel * lblAccessoryName  = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, 78, 20)];
                lblAccessoryName.text = @"Colors";
                lblAccessoryName.textAlignment =NSTextAlignmentCenter;
                lblAccessoryName.textColor = [UIColor blackColor];
                lblAccessoryName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium];
                [scrollAccessories addSubview:lblAccessoryName];
                x = x+100;
            }
        }else if (i==3)
        {
            if ([dictModelDetail valueForKey:@"image_list"])
            {
                [optionsAry addObject:@"Images"];
                AsyncImageView * imgProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(x, 20, 78, 78)];
                imgProduct.image = [UIImage imageNamed:@"image_detail"];
                imgProduct.contentMode = UIViewContentModeScaleAspectFit;
                [scrollAccessories addSubview:imgProduct];
                UILabel * lblAccessoryName  = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, 78, 20)];
                lblAccessoryName.text = @"Images";
                lblAccessoryName.textAlignment =NSTextAlignmentCenter;
                lblAccessoryName.textColor = [UIColor blackColor];
                lblAccessoryName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium];
                [scrollAccessories addSubview:lblAccessoryName];
                x = x+100;
            }
        }else if (i==4)
        {
            if ([dictModelDetail valueForKey:@"video_list"])
            {
                [optionsAry addObject:@"Videos"];
                AsyncImageView * imgProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(x, 20, 78, 78)];
                imgProduct.image = [UIImage imageNamed:@"Video_detail"];
                imgProduct.contentMode = UIViewContentModeScaleAspectFit;
                [scrollAccessories addSubview:imgProduct];
                UILabel * lblAccessoryName  = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, 78, 20)];
                lblAccessoryName.text = @"Videos";
                lblAccessoryName.textAlignment =NSTextAlignmentCenter;
                lblAccessoryName.textColor = [UIColor blackColor];
                lblAccessoryName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium];
                [scrollAccessories addSubview:lblAccessoryName];
                x = x+100;
            }
        }else if (i==5)
        {
            if ([dictModelDetail valueForKey:@"alternative_model_list"])
            {
                [optionsAry addObject:@"Alternatives"];
                AsyncImageView * imgProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(x, 20, 78, 78)];
                imgProduct.image = [UIImage imageNamed:@"Alternative_detail"];
                imgProduct.contentMode = UIViewContentModeScaleAspectFit;
                [scrollAccessories addSubview:imgProduct];
                UILabel * lblAccessoryName  = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, 78, 20)];
                lblAccessoryName.text = @"Alternatives";
                lblAccessoryName.textAlignment =NSTextAlignmentCenter;
                lblAccessoryName.textColor = [UIColor blackColor];
                lblAccessoryName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium];
                [scrollAccessories addSubview:lblAccessoryName];
                x = x+100;
            }
        }
    }
    [scrollAccessories setContentSize:CGSizeMake(x, 100)];
    versionY = (carAccessories.frame.origin.y)+(carAccessories.frame.size.height);
    NSLog(@"Version Y %f",versionY);

}
-(void)setFrameForVersion
{
    [viewVersion removeFromSuperview];
    viewVersion = [[UIView alloc] initWithFrame:CGRectMake(0, carAccessories.frame.origin.y+carAccessories.frame.size.height+20, DEVICE_WIDTH, 80)];
    viewVersion.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewVersion];

    lblVersionCount = [[UILabel alloc] initWithFrame:CGRectMake(14, 5, DEVICE_WIDTH-28, 20)];
    lblVersionCount.textAlignment = NSTextAlignmentLeft;
    lblVersionCount.text = [NSString stringWithFormat:@"Versions (%lu)",[[dictModelDetail valueForKey:@"version_list"] count]];
    lblVersionCount.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightSemibold];
    lblVersionCount.textColor = [UIColor blackColor];
    lblVersionCount.backgroundColor = [UIColor clearColor];
    [viewVersion addSubview:lblVersionCount];

    NSSet *uniqueFuelTypes = [NSSet setWithArray:[[dictModelDetail valueForKey:@"version_list"] valueForKey:@"fuel_type"]];
    NSSet *uniqueTransmissionType = [NSSet setWithArray:[[dictModelDetail valueForKey:@"version_list"] valueForKey:@"transmission_type"]];

    NSArray * arrtempFual = [NSArray arrayWithArray:[uniqueFuelTypes allObjects]];

    for (int a =0; a<[arrtempFual count]; a++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[arrtempFual objectAtIndex:a] forKey:@"title"];
        [dict setValue:@"no" forKey:@"isSelect"];
        [arrFual addObject:dict];
    }

    NSArray * arrtempTeans = [NSArray arrayWithArray:[uniqueTransmissionType allObjects]];
    for (int a =0; a<[arrtempTeans count]; a++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[arrtempTeans objectAtIndex:a] forKey:@"title"];
        [dict setValue:@"no" forKey:@"isSelect"];
        [arrTransmission addObject:dict];
    }

    UILabel * lblSep1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, DEVICE_WIDTH, 0.5)] ;
    lblSep1.backgroundColor = [APP_DELEGATE colorWithHexString:@"C5C5C5"];;
    [viewVersion addSubview:lblSep1];

    UILabel * lblSep3 = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-0.25, 30, 0.5, 40)];
    lblSep3.backgroundColor = [APP_DELEGATE colorWithHexString:@"C5C5C5"];
    [viewVersion addSubview:lblSep3];

    UILabel * lblSep2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30+39, DEVICE_WIDTH, 0.5)] ;
    lblSep2.backgroundColor = [APP_DELEGATE colorWithHexString:@"C5C5C5"];
    [viewVersion addSubview:lblSep2];

    lblFuelType = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, DEVICE_WIDTH/2-0.5, 40)];
    lblFuelType.textAlignment=NSTextAlignmentCenter;
    lblFuelType.text = @"Fuel Type";
    lblFuelType.textColor = [UIColor blackColor];
    lblFuelType.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [viewVersion addSubview:lblFuelType];
    btnFuel = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, DEVICE_WIDTH/2, 40)];
    [btnFuel addTarget:self action:@selector(btnFuelClicked:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [viewVersion addSubview:btnFuel];

    lblTransmission = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+0.5, 30, DEVICE_WIDTH/2, 40)];
    lblTransmission.textAlignment=NSTextAlignmentCenter;
    lblTransmission.text = @"Transmission";
    lblTransmission.textColor = [UIColor blackColor];
    lblTransmission.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [viewVersion addSubview:lblTransmission];
    UIImageView *showArrow = [[UIImageView alloc]init];



    btnTransmission = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 30, DEVICE_WIDTH/2, 40)];
    [btnTransmission addTarget:self action:@selector(btnTransmissionClicked:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [viewVersion addSubview:btnTransmission];

}
-(void)changeFrameBasedOnFilter
{
    [viewCarModelTypes removeFromSuperview];

    viewCarModelTypes = [[UIView alloc] initWithFrame:CGRectMake(0, viewVersion.frame.origin.y+viewVersion.frame.size.height+5, DEVICE_WIDTH, 100)];
    viewCarModelTypes.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewCarModelTypes];

    selectVersion = [[UIButton alloc] init];
    selectVersion.frame = CGRectMake(0, viewVersion.frame.origin.y+viewVersion.frame.size.height+5, DEVICE_WIDTH, 100);
    selectVersion.backgroundColor = [UIColor clearColor];
    [selectVersion addTarget:self action:@selector(BtnVersion:) forControlEvents:UIControlEventTouchUpInside];
    [viewCarModelTypes addSubview:selectVersion];

    int y=0;

    if ([arrVerionList count]>3)
    {
        if (isVersionLess == NO)
        {
            for (a=0;a<3; a++)
            {
                UILabel * lblVersionType = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 18)];
                lblVersionType.textAlignment=NSTextAlignmentLeft;
                lblVersionType.text = [NSString stringWithFormat:@"%@",[[arrVerionList objectAtIndex:a] valueForKey:@"car_name"]];
                lblVersionType.textColor = [UIColor blackColor];
                lblVersionType.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
                [viewCarModelTypes addSubview:lblVersionType];


                selectVersionCar = [[UIButton alloc] init];
                selectVersionCar.frame = CGRectMake(viewCarModelTypes.frame.size.width-30, y, 16, 16);
                selectVersionCar.layer.borderColor = [APP_DELEGATE colorWithHexString:@"565A5C"].CGColor;
                selectVersionCar.layer.borderWidth = 1.0f;
                selectVersionCar.layer.cornerRadius = 2.0f;
                selectVersionCar.clipsToBounds = YES;
                selectVersionCar.contentMode = UIViewContentModeScaleAspectFit;
                selectVersionCar.tag=a;
                selectVersionCar.backgroundColor = [UIColor clearColor];
                if([[[arrVerionList objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"yes"])
                {
                    [selectVersionCar setImage:[UIImage imageNamed:@"select_Verion"] forState:UIControlStateNormal];
                }else{
                    [selectVersionCar setImage:[UIImage imageNamed:@"rectangle-light"] forState:UIControlStateNormal];
                }

                [selectVersionCar addTarget:self action:@selector(BtnVersionCar:) forControlEvents:UIControlEventTouchUpInside];
                [viewCarModelTypes addSubview:selectVersionCar];

                y=y+20;

                UILabel * lblFuelDetails = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 16)];
                lblFuelDetails.textAlignment=NSTextAlignmentLeft;
                NSString *jsonString =[[arrVerionList objectAtIndex:a]valueForKey:@"key_specification"];
                 NSArray* arrSeparation = [jsonString componentsSeparatedByString: @","];
                for(int i=0 ; i<[arrSeparation count];i++)
                {
                   NSArray *RSIatAddr = [arrSeparation objectAtIndex:i] ;
                    NSLog(@"%@",RSIatAddr);

                }

                NSString* Length=@"";
                if ([arrSeparation count]>0) {
                    Length=[NSString stringWithFormat:@"%@",[arrSeparation objectAtIndex: 0]] ;
                }

                NSString* Displacement=@"";
                if ([arrSeparation count]>1) {
                    Displacement=[NSString stringWithFormat:@"%@",[arrSeparation objectAtIndex: 1]] ;

                }

                NSString* Transmission=@"";
                if ([arrSeparation count]>2) {
                    Transmission=[NSString stringWithFormat:@"%@",[arrSeparation objectAtIndex: 2]] ;
                    
                }
                Displacement  = [Displacement stringByReplacingOccurrencesOfString:@"Displacement:" withString:@" "];
                Displacement = [Displacement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

                lblFuelDetails.text = [NSString stringWithFormat:@"%@,%@,%@",Displacement,[[arrVerionList objectAtIndex:a]valueForKey:@"fuel_type"],[[arrVerionList objectAtIndex:a]valueForKey:@"transmission_type"]];
                lblFuelDetails.textColor = [UIColor lightGrayColor];
                lblFuelDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
                [viewCarModelTypes addSubview:lblFuelDetails];

                y=y+20;

                UILabel * lblPriceDetails = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 16)];
                lblPriceDetails.textAlignment=NSTextAlignmentLeft;

                NSString *priceCar = [NSString stringWithFormat:@"%ld",[[[arrVerionList objectAtIndex:a] valueForKey:@"price"] integerValue]];
                NSString *getPrice = [APP_DELEGATE datafromServer:priceCar];
                NSString *finalprice = [NSString stringWithFormat:@"%@ %@",[[arrVerionList objectAtIndex:a] valueForKey:@"currency_symbol"],getPrice];
                lblPriceDetails.text = finalprice;

                lblPriceDetails.textColor = [UIColor blackColor];
                lblPriceDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightSemibold];
                [viewCarModelTypes addSubview:lblPriceDetails];

                y=y+20;

                UIButton * btnPrice = [[UIButton alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 30)];
                [btnPrice setTitle:@"Check On-Road price" forState:UIControlStateNormal];
                [btnPrice setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
                btnPrice.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
                btnPrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btnPrice.titleLabel.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
                [viewCarModelTypes addSubview:btnPrice];

                y=y+28;

                UILabel * lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 0.5)] ;
                lblSep.backgroundColor = [APP_DELEGATE colorWithHexString:@"E9E9E9"];
                [viewCarModelTypes addSubview:lblSep];

                y=y+10;
            }
        }else
        {
            for (a =0 ; a<[arrVerionList count]; a++)
            {
                UILabel * lblVersionType = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 18)];
                lblVersionType.textAlignment=NSTextAlignmentLeft;
                lblVersionType.text = [NSString stringWithFormat:@"%@",[[arrVerionList objectAtIndex:a] valueForKey:@"car_name"]];
                lblVersionType.textColor = [UIColor blackColor];
                lblVersionType.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
                [viewCarModelTypes addSubview:lblVersionType];


                selectVersionCar = [[UIButton alloc] init];
                selectVersionCar.frame = CGRectMake(viewCarModelTypes.frame.size.width-30, y, 16, 16);
                selectVersionCar.layer.borderColor = [APP_DELEGATE colorWithHexString:@"565A5C"].CGColor;
                selectVersionCar.layer.borderWidth = 1.0f;
                selectVersionCar.layer.cornerRadius = 2.0f;
                selectVersionCar.clipsToBounds = YES;
                selectVersionCar.contentMode = UIViewContentModeScaleAspectFit;
                selectVersionCar.tag=a;
                selectVersionCar.backgroundColor = [UIColor clearColor];
                if([[[arrVerionList objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"yes"])
                {
                    [selectVersionCar setImage:[UIImage imageNamed:@"select_Verion"] forState:UIControlStateNormal];
                }else{
                    [selectVersionCar setImage:[UIImage imageNamed:@"rectangle-light"] forState:UIControlStateNormal];
                }

                [selectVersionCar addTarget:self action:@selector(BtnVersionCar:) forControlEvents:UIControlEventTouchUpInside];
                [viewCarModelTypes addSubview:selectVersionCar];

                y=y+20;

                UILabel * lblFuelDetails = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 16)];
                lblFuelDetails.textAlignment=NSTextAlignmentLeft;
                lblFuelDetails.text = [NSString stringWithFormat:@"%@,%@,%@",[[arrVerionList objectAtIndex:a]valueForKey:@"key_specification"],[[arrVerionList objectAtIndex:a]valueForKey:@"fuel_type"],[[arrVerionList objectAtIndex:a]valueForKey:@"transmission_type"]];
                lblFuelDetails.textColor = [UIColor lightGrayColor];
                lblFuelDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
                [viewCarModelTypes addSubview:lblFuelDetails];

                y=y+20;

                UILabel * lblPriceDetails = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 16)];
                lblPriceDetails.textAlignment=NSTextAlignmentLeft;

                NSString *priceCar = [NSString stringWithFormat:@"%ld",[[[arrVerionList objectAtIndex:a] valueForKey:@"price"] integerValue]];
                NSString *getPrice = [APP_DELEGATE datafromServer:priceCar];
                NSString *finalprice = [NSString stringWithFormat:@"%@ %@",[[arrVerionList objectAtIndex:a] valueForKey:@"currency_symbol"],getPrice];
                lblPriceDetails.text = finalprice;

                lblPriceDetails.textColor = [UIColor blackColor];
                lblPriceDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightSemibold];
                [viewCarModelTypes addSubview:lblPriceDetails];

                y=y+20;

                UIButton * btnPrice = [[UIButton alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 30)];
                [btnPrice setTitle:@"Check On-Road price" forState:UIControlStateNormal];
                [btnPrice setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
                btnPrice.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
                btnPrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btnPrice.titleLabel.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
                [viewCarModelTypes addSubview:btnPrice];

                y=y+28;

                UILabel * lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 0.5)] ;
                lblSep.backgroundColor = [APP_DELEGATE colorWithHexString:@"E9E9E9"];
                [viewCarModelTypes addSubview:lblSep];

                y=y+10;
            }
        }

        viewVersionSize = [[UIView alloc] initWithFrame:CGRectMake(0, y-10, DEVICE_WIDTH, 50)];
        viewVersionSize.backgroundColor =[UIColor whiteColor];
        viewVersionSize.layer.borderColor=[APP_DELEGATE colorWithHexString:@"E9E9E9"].CGColor;
        viewVersionSize.layer.borderWidth=0.8;
        [viewCarModelTypes addSubview:viewVersionSize];


        btnVersionSize = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 50)];
        if (isVersionLess == NO)
        {
            [btnVersionSize setTitle:[NSString stringWithFormat:@"View %lu more verions",[arrVerionList count]-3] forState:UIControlStateNormal];

        }else
        {
            [btnVersionSize setTitle:[NSString stringWithFormat:@"View less verions"] forState:UIControlStateNormal];

        }
        btnVersionSize.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        btnVersionSize.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnVersionSize setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
        btnVersionSize.titleLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
        [btnVersionSize addTarget:self action:@selector(btnClickMore:) forControlEvents:UIControlEventTouchUpInside];
        [viewVersionSize addSubview:btnVersionSize];
        y=y+60;
    }else
    {

        for (a =0 ; a<[arrVerionList count]; a++)
        {
            UILabel * lblVersionType = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 18)];
            lblVersionType.textAlignment=NSTextAlignmentLeft;
            lblVersionType.text = [NSString stringWithFormat:@"%@",[[arrVerionList objectAtIndex:a] valueForKey:@"car_name"]];
            lblVersionType.textColor = [UIColor blackColor];
            lblVersionType.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
            [viewCarModelTypes addSubview:lblVersionType];


            selectVersionCar = [[UIButton alloc] init];
            selectVersionCar.frame = CGRectMake(viewCarModelTypes.frame.size.width-30, y, 16, 16);
            selectVersionCar.layer.borderColor = [APP_DELEGATE colorWithHexString:@"565A5C"].CGColor;
            selectVersionCar.layer.borderWidth = 1.0f;
            selectVersionCar.layer.cornerRadius = 2.0f;
            selectVersionCar.clipsToBounds = YES;
            selectVersionCar.contentMode = UIViewContentModeScaleAspectFit;
            selectVersionCar.tag=a;
            selectVersionCar.backgroundColor = [UIColor clearColor];
            if([[[arrVerionList objectAtIndex:a] valueForKey:@"isSelect"] isEqualToString:@"yes"])
            {
                [selectVersionCar setImage:[UIImage imageNamed:@"select_Verion"] forState:UIControlStateNormal];
            }else{
                [selectVersionCar setImage:[UIImage imageNamed:@"rectangle-light"] forState:UIControlStateNormal];
            }

            [selectVersionCar addTarget:self action:@selector(BtnVersionCar:) forControlEvents:UIControlEventTouchUpInside];
            [viewCarModelTypes addSubview:selectVersionCar];

            y=y+20;

            UILabel * lblFuelDetails = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 16)];
            lblFuelDetails.textAlignment=NSTextAlignmentLeft;
            lblFuelDetails.text = [NSString stringWithFormat:@"%@,%@,%@",[[arrVerionList objectAtIndex:a]valueForKey:@"key_specification"],[[arrVerionList objectAtIndex:a]valueForKey:@"fuel_type"],[[arrVerionList objectAtIndex:a]valueForKey:@"transmission_type"]];
            lblFuelDetails.textColor = [UIColor lightGrayColor];
            lblFuelDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            [viewCarModelTypes addSubview:lblFuelDetails];

            y=y+20;

            UILabel * lblPriceDetails = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 16)];
            lblPriceDetails.textAlignment=NSTextAlignmentLeft;

            NSString *priceCar = [NSString stringWithFormat:@"%ld",[[[arrVerionList objectAtIndex:a] valueForKey:@"price"] integerValue]];
            NSString *getPrice = [APP_DELEGATE datafromServer:priceCar];
            NSString *finalprice = [NSString stringWithFormat:@"%@ %@",[[arrVerionList objectAtIndex:a] valueForKey:@"currency_symbol"],getPrice];
            lblPriceDetails.text = finalprice;

            lblPriceDetails.textColor = [UIColor blackColor];
            lblPriceDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightSemibold];
            [viewCarModelTypes addSubview:lblPriceDetails];

            y=y+20;

            UIButton * btnPrice = [[UIButton alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 30)];
            [btnPrice setTitle:@"Check On-Road price" forState:UIControlStateNormal];
            [btnPrice setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
            btnPrice.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            btnPrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btnPrice.titleLabel.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
            [viewCarModelTypes addSubview:btnPrice];

            y=y+28;

            UILabel * lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 0.5)] ;
            lblSep.backgroundColor = [APP_DELEGATE colorWithHexString:@"E9E9E9"];
            [viewCarModelTypes addSubview:lblSep];

            y=y+10;
        }
    }

    viewCarModelTypes.frame = CGRectMake(0, viewVersion.frame.origin.y+viewVersion.frame.size.height+5, DEVICE_WIDTH, y+5);
    colorsY =  (viewVersion.frame.origin.y)+(viewVersion.frame.size.height);

}
-(void)setFrameForMileage
{
    [viewMileage removeFromSuperview];
    mileageY =  viewCarModelTypes.frame.origin.y+viewCarModelTypes.frame.size.height+5;
    viewMileage = [[UIView alloc] initWithFrame:CGRectMake(0, mileageY, DEVICE_WIDTH, 100)];
    viewMileage.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewMileage];

    int y =0;


    lblMileage = [[UILabel alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-40, 20)];
    lblMileage.textAlignment = NSTextAlignmentLeft;
    lblMileage.text = @"Mileages (5)";
    lblMileage.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    lblMileage.textColor = [UIColor blackColor];
    [viewMileage addSubview:lblMileage];

    y=y+30;

    for (a =0 ; a<5; a++)
    {
        UIView * viewCard = [[UIView alloc] initWithFrame:CGRectMake(20, y, DEVICE_WIDTH-50, 80)];
        viewCard.backgroundColor = [UIColor whiteColor];
        [viewMileage addSubview:viewCard];

        [self setShadowForView:viewCard];

        UILabel * lblMileageCount = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
        lblMileageCount.textAlignment=NSTextAlignmentCenter;
        lblMileageCount.text = @"21.9 \n kmpl";
        lblMileageCount.textColor = [UIColor blackColor];
        lblMileageCount.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
        lblMileageCount.numberOfLines=2;
        [viewCard addSubview:lblMileageCount];

        UILabel * lblSep = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 0.5, 60)];
        lblSep.backgroundColor = [UIColor lightGrayColor];
        [viewCard addSubview:lblSep];

        UILabel * lblFuelDetails = [[UILabel alloc] initWithFrame:CGRectMake(140, 20, DEVICE_WIDTH-120, 40)];
        lblFuelDetails.textAlignment=NSTextAlignmentLeft;
        lblFuelDetails.text = @"624cc Petrol Manual \n 23.5 kmpl";
        lblFuelDetails.textColor = [UIColor lightGrayColor];
        lblFuelDetails.numberOfLines=2;
        lblFuelDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
        [viewCard addSubview:lblFuelDetails];


        AsyncImageView * imgMileageProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-50, y+20, 39, 39)];
        imgMileageProduct.image = [UIImage imageNamed:@"car-home.png"];
        imgMileageProduct.contentMode = UIViewContentModeScaleAspectFit;
        [viewMileage addSubview:imgMileageProduct];
        y=y+90;
    }

    viewMileage.frame=CGRectMake(0, viewCarModelTypes.frame.origin.y+viewCarModelTypes.frame.size.height, DEVICE_WIDTH, y);
    colorsY = (viewCarModelTypes.frame.origin.y)+(viewCarModelTypes.frame.size.height);
}
-(void)setFrameForColors
{
    [viewColors removeFromSuperview];
    viewColors = [[UIView alloc] initWithFrame:CGRectMake(0, viewMileage.frame.origin.y+viewMileage.frame.size.height, DEVICE_WIDTH, 160)];
    viewColors.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewColors];

    int y =0;

    lblColor = [[UILabel alloc] initWithFrame:CGRectMake(14, y, DEVICE_WIDTH-28, 20)];
    lblColor.textAlignment = NSTextAlignmentLeft;
    lblColor.text = [NSString stringWithFormat:@"Colors (%lu)",[[dictModelDetail valueForKey:@"color_list"] count]];
    lblColor.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    lblColor.textColor = [UIColor blackColor];
    [viewColors addSubview:lblColor];

    y = y +30;

    viewColorSize = [[UIView alloc] initWithFrame:CGRectMake(14, y, DEVICE_WIDTH-28, 80)];
    viewColorSize.backgroundColor = [UIColor whiteColor];
    [viewColors addSubview:viewColorSize];

    if ([[dictModelDetail valueForKey:@"color_list"] count]>4)
    {
        int viewColorSiZeHeight = 0;
        if (isColorLess == NO)
        {
            int xx =15 ;
            for (int i = 0; i<4; i++)
            {
                UILabel * lblColorType = [[UILabel alloc] initWithFrame:CGRectMake(xx, 20, (viewColorSize.frame.size.width-75)/4, (viewColorSize.frame.size.width-75)/4)];
                lblColorType.layer.cornerRadius =(viewColorSize.frame.size.width-75)/4/2;
                lblColorType.clipsToBounds=YES;
                NSString * strColor =  [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"color_list"] objectAtIndex:i] valueForKey:@"color_code"]];
                strColor = [strColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
                lblColorType.backgroundColor = [APP_DELEGATE colorWithHexString:strColor];
                [viewColorSize addSubview:lblColorType];

                UILabel * lblColorName  = [[UILabel alloc] initWithFrame:CGRectMake(xx-10, (viewColorSize.frame.size.width-75)/4+30, (viewColorSize.frame.size.width-75)/4+20, 20)];
                lblColorName.text = [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"color_list"] objectAtIndex:i] valueForKey:@"color_name"]];
                lblColorName.textAlignment =NSTextAlignmentCenter;
                lblColorName.textColor = [UIColor blackColor];
                lblColorName.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
                [viewColorSize addSubview:lblColorName];
                xx = xx+(viewColorSize.frame.size.width-75)/4+15;
            }
            viewColorSiZeHeight = (viewColorSize.frame.size.width-75)/4 +120;

            y=y+viewColorSiZeHeight+10;

        }else
        {
            int xx =15 ;
            int Height=20, count=0;
            for (int i = 0; i<[[dictModelDetail valueForKey:@"color_list"] count]; i++)
            {
                if (count==4)
                {
                    count=0;
                    Height= Height+ (viewColorSize.frame.size.width-75)/4+40;
                    xx=15;
                }
                UILabel * lblColorType = [[UILabel alloc] initWithFrame:CGRectMake(xx, Height, (viewColorSize.frame.size.width-75)/4, (viewColorSize.frame.size.width-75)/4)];
                lblColorType.layer.cornerRadius =(viewColorSize.frame.size.width-75)/4/2;
                lblColorType.clipsToBounds=YES;
                NSString * strColor =  [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"color_list"] objectAtIndex:i] valueForKey:@"color_code"]];
                strColor = [strColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
                lblColorType.backgroundColor = [APP_DELEGATE colorWithHexString:strColor];
                [viewColorSize addSubview:lblColorType];

                UILabel * lblColorName  = [[UILabel alloc] initWithFrame:CGRectMake(xx-10, Height + (viewColorSize.frame.size.width-75)/4 +10, (viewColorSize.frame.size.width-75)/4+20, 20)];
                lblColorName.text = [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"color_list"] objectAtIndex:i] valueForKey:@"color_name"]];
                lblColorName.textAlignment =NSTextAlignmentCenter;
                lblColorName.textColor = [UIColor blackColor];
                lblColorName.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
                [viewColorSize addSubview:lblColorName];
                xx = xx+(viewColorSize.frame.size.width-75)/4+15;
                count=count+1;
            }
            y = y + Height+(viewColorSize.frame.size.width-75)/4 + 100;
            viewColorSiZeHeight = Height +(viewColorSize.frame.size.width-75)/4 + 90;
        }
        viewColorSize.frame = CGRectMake(20, viewColorSize.frame.origin.y, DEVICE_WIDTH-40, viewColorSiZeHeight);

        viewBackgroundColor = [[UIView alloc] initWithFrame:CGRectMake(0, viewColorSize.frame.size.height-50, viewColorSize.frame.size.width, 50)];
        viewBackgroundColor.backgroundColor =[UIColor whiteColor];
        [viewColorSize addSubview:viewBackgroundColor];

        CALayer *upperBorder = [CALayer layer];
        upperBorder.backgroundColor = [APP_DELEGATE colorWithHexString:@"#000000"].CGColor;
        upperBorder.frame = CGRectMake(0, 0, CGRectGetWidth(viewBackgroundColor.frame), 1.0f);
        [viewBackgroundColor.layer addSublayer:upperBorder];

        btnColorSize = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 50)];
        if (isColorLess == NO)
        {
            [btnColorSize setTitle:[NSString stringWithFormat:@"View %lu more verions",[[dictModelDetail valueForKey:@"color_list"] count]-4] forState:UIControlStateNormal];
        }else
        {
            [btnColorSize setTitle:[NSString stringWithFormat:@"View less verions"] forState:UIControlStateNormal];
        }
        btnColorSize.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        btnVersionSize.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnColorSize setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
        btnColorSize.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
        [btnColorSize addTarget:self action:@selector(btnColorMore:) forControlEvents:UIControlEventTouchUpInside];
        [viewBackgroundColor addSubview:btnColorSize];
    }else
    {
        int xx =15 ;
        for (int i = 0; i<[[dictModelDetail valueForKey:@"color_list"] count]; i++)
        {
            UILabel * lblColorType = [[UILabel alloc] initWithFrame:CGRectMake(xx, 20, (viewColorSize.frame.size.width-75)/4, (viewColorSize.frame.size.width-75)/4)];
            lblColorType.layer.cornerRadius =(viewColorSize.frame.size.width-75)/4/2;
            lblColorType.clipsToBounds=YES;
            NSString * strColor =  [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"color_list"] objectAtIndex:i] valueForKey:@"color_code"]];
            strColor = [strColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
            lblColorType.backgroundColor = [APP_DELEGATE colorWithHexString:strColor];
            [viewColorSize addSubview:lblColorType];

            UILabel * lblColorName  = [[UILabel alloc] initWithFrame:CGRectMake(xx-10, (viewColorSize.frame.size.width-75)/4+30, (viewColorSize.frame.size.width-75)/4+20, 20)];
            lblColorName.text = [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"color_list"] objectAtIndex:i] valueForKey:@"color_name"]];
            lblColorName.textAlignment =NSTextAlignmentCenter;
            lblColorName.textColor = [UIColor blackColor];
            lblColorName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
            [viewColorSize addSubview:lblColorName];
            xx = xx+(viewColorSize.frame.size.width-75)/4+15;
        }
        y=y+(viewColorSize.frame.size.width-75)/4 +80;

        viewColorSize.frame = CGRectMake(20, viewColorSize.frame.origin.y, DEVICE_WIDTH-40, (viewColorSize.frame.size.width-75)/4 +60);
    }

    [self setShadowForView:viewColorSize];

    viewColors.frame = CGRectMake(0, viewMileage.frame.origin.y+viewMileage.frame.size.height+5, DEVICE_WIDTH, y);

    imagesY = (viewMileage.frame.origin.y)+(viewMileage.frame.size.height);
}
-(void)setFrameForImages
{
    [viewImages removeFromSuperview];

    viewImages = [[UIView alloc] initWithFrame:CGRectMake(0,viewColors.frame.origin.y+viewColors.frame.size.height+5, DEVICE_WIDTH, 170)];
    viewImages.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewImages];

    int y=0;

    lblImages = [[UILabel alloc] initWithFrame:CGRectMake(14, 5, DEVICE_WIDTH-28, 20)];
    lblImages.textAlignment = NSTextAlignmentLeft;
    lblImages.text = [NSString stringWithFormat:@"Images (%lu)",(unsigned long)[arrCarImages count]];
    lblImages.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    lblImages.textColor = [UIColor blackColor];
    [viewImages addSubview:lblImages];

    if ([arrCarImages count]>2)
    {
        y = y +30;

        UIView * viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 190)];
        viewBack.backgroundColor = [UIColor whiteColor];
        [viewImages addSubview:viewBack];
        [self setShadowForView:viewBack];

        NSURL *urlCar = [NSURL URLWithString:[arrCarImages objectAtIndex:0]];
        AsyncImageView * imgProductCar = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 190)];
        imgProductCar.image = [UIImage imageNamed:@"demo4.jpg"];
        imgProductCar.imageURL = urlCar;
        imgProductCar.contentMode = UIViewContentModeScaleAspectFit;
        [viewImages addSubview:imgProductCar];
        imgProductCar.clipsToBounds=YES;

        y=y+200;

        UIView * viewBack1 = [[UIView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH/2-5, 150)];
        viewBack1.backgroundColor = [UIColor whiteColor];
        [viewImages addSubview:viewBack1];
        [self setShadowForView:viewBack1];

        AsyncImageView * imgProductCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH/2-5, 150)];
        NSURL *urlCar1 = [NSURL URLWithString:[arrCarImages objectAtIndex:1]];
        imgProductCar1.image = [UIImage imageNamed:@"demo4.jpg"];
        imgProductCar1.imageURL = urlCar1;
        imgProductCar1.contentMode = UIViewContentModeScaleAspectFit;
        [viewImages addSubview:imgProductCar1];
        imgProductCar1.clipsToBounds=YES;

        UIView * viewBack2 = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+5, y, DEVICE_WIDTH/2-5, 150)];
        viewBack1.backgroundColor = [UIColor whiteColor];
        [viewImages addSubview:viewBack2];
        [self setShadowForView:viewBack2];

        AsyncImageView * imgProductCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2+5, y, DEVICE_WIDTH/2-5, 150)];
        imgProductCar2.image = [UIImage imageNamed:@"demo4.jpg"];
        NSURL *urlCar2 = [NSURL URLWithString:[arrCarImages objectAtIndex:2]];
        imgProductCar2.imageURL = urlCar2;
        imgProductCar2.contentMode = UIViewContentModeScaleAspectFill;
        [viewImages addSubview:imgProductCar2];
        imgProductCar2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imgProductCar2.layer.borderWidth=0.5;
        imgProductCar2.clipsToBounds=YES;

        if ([arrCarImages count]>3)
        {
            UILabel * lblImagesCount = [[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2+5, y, DEVICE_WIDTH/2-5, 150)];
            lblImagesCount.backgroundColor = [UIColor blackColor];
            lblImagesCount.alpha=0.7;
            [viewImages addSubview:lblImagesCount];
            lblImagesCount.textColor =[UIColor whiteColor];
            lblImagesCount.text = [NSString stringWithFormat:@"\u2022 \u2022 \u2022 \n %lu more",[arrCarImages count]-3];
            lblImagesCount.textAlignment =NSTextAlignmentCenter;
            lblImagesCount.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
            lblImagesCount.numberOfLines=2;
        }

        y = y+ 154;
    }else if ([arrCarImages count]==2)
    {
        y = y +30;

        UIView * viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 190)];
        viewBack.backgroundColor = [UIColor whiteColor];
        [viewImages addSubview:viewBack];
        [self setShadowForView:viewBack];

        NSURL *urlCar = [NSURL URLWithString:[arrCarImages objectAtIndex:0]];
        AsyncImageView * imgProductCar = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 190)];

        imgProductCar.image = [UIImage imageNamed:@"demo4.jpg"];
        imgProductCar.imageURL = urlCar;

        imgProductCar.contentMode = UIViewContentModeScaleAspectFill;
        [viewImages addSubview:imgProductCar];
        imgProductCar.clipsToBounds=YES;

        y=y+194;

        UIView * viewBack1 = [[UIView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH/2-5, 150)];
        viewBack1.backgroundColor = [UIColor whiteColor];
        [viewImages addSubview:viewBack1];
        [self setShadowForView:viewBack1];

        AsyncImageView * imgProductCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH/2-5, 150)];

        NSURL *urlCar1 = [NSURL URLWithString:[arrCarImages objectAtIndex:1]];
        imgProductCar1.image = [UIImage imageNamed:@"demo4.jpg"];
        imgProductCar1.imageURL = urlCar1;
        imgProductCar1.contentMode = UIViewContentModeScaleAspectFill;
        [viewImages addSubview:imgProductCar1];
        imgProductCar1.clipsToBounds=YES;

        y = y+ 154;
    }else if ([arrCarImages count]==1)
    {
        y = y +30;

        UIView * viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 190)];
        viewBack.backgroundColor = [UIColor whiteColor];
        [viewImages addSubview:viewBack];
        [self setShadowForView:viewBack];

        NSURL *urlCar = [NSURL URLWithString:[arrCarImages objectAtIndex:0]];
        AsyncImageView * imgProductCar = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 190)];
        imgProductCar.image = [UIImage imageNamed:@"demo4.jpg"];
        imgProductCar.imageURL = urlCar;
        imgProductCar.contentMode = UIViewContentModeScaleAspectFill;
        [viewImages addSubview:imgProductCar];
        imgProductCar.clipsToBounds=YES;

        y = y+ 194;
    }

    viewImages.frame = CGRectMake(0, viewColors.frame.origin.y+viewColors.frame.size.height+5, DEVICE_WIDTH, y+5);


}
-(void)setFrameForVideos
{
    [viewVideos removeFromSuperview];
    videoY = viewImages.frame.origin.y+viewImages.frame.size.height+5;
    viewVideos = [[UIView alloc] initWithFrame:CGRectMake(0,videoY, DEVICE_WIDTH, 200)];
    viewVideos.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewVideos];

    int y =0;
    lblVideos = [[UILabel alloc] initWithFrame:CGRectMake(14, 5, DEVICE_WIDTH-28, 20)];
    lblVideos.textAlignment = NSTextAlignmentLeft;
    lblVideos.text = [NSString stringWithFormat:@"Videos (%lu)",(unsigned long)[arrCarVideos count]];
    lblVideos.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    lblVideos.textColor = [UIColor blackColor];
    [viewVideos addSubview:lblVideos];

    videoPageController = [[UIPageControl alloc] init];
    videoPageController.frame = CGRectMake(0, y, DEVICE_WIDTH, 200);
    videoPageController.numberOfPages = 2;
    videoPageController.currentPage = 0;
    [viewVideos addSubview:videoPageController];
    
    y=y+30;
    self.carsList=[[iCarousel alloc]initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 180)];
    self.carsList.delegate=self;
    self.carsList.dataSource=self;
    self.carsList.type = iCarouselTypeLinear;
    [viewVideos addSubview:self.carsList];

    y = y + 180;
    viewVideos.frame = CGRectMake(0, viewImages.frame.origin.y+viewImages.frame.size.height+5, DEVICE_WIDTH, y+5);

}
-(void)setFrameForExpertReviews
{
    [viewExpertReviews removeFromSuperview];
    viewExpertReviews = [[UIView alloc] initWithFrame:CGRectMake(0, viewVideos.frame.origin.y+viewVideos.frame.size.height+5, DEVICE_WIDTH, 100)];
    viewExpertReviews.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewExpertReviews];

    int y =0;
    lblReviews = [[UILabel alloc] initWithFrame:CGRectMake(14, y, DEVICE_WIDTH-28, 20)];
    lblReviews.textAlignment = NSTextAlignmentLeft;
    lblReviews.text = @"Expert Reviews";
    lblReviews.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    lblReviews.textColor = [UIColor blackColor];
    [viewExpertReviews addSubview:lblReviews];

    y=y+30;
    for (a =0 ; a<[[dictModelDetail valueForKey:@"expert_review_list"] count]; a++)
    {
        UIView * viewReviews = [[UIView alloc] initWithFrame:CGRectMake(14, y, DEVICE_WIDTH-28, 95)];
        viewReviews.backgroundColor = [UIColor whiteColor];
        [viewExpertReviews addSubview:viewReviews];

        [self setShadowForView:viewReviews];

        AsyncImageView * imgProduct = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 123, viewReviews.frame.size.height)];
        NSString * strURL = [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"expert_review_list"] objectAtIndex:a] valueForKey:@"cover_photo"]];
        if ([strURL length]>0)
        {
            NSURL *url = [NSURL URLWithString:strURL];
            imgProduct.imageURL = url;
        }
        imgProduct.clipsToBounds=YES;
        imgProduct.contentMode = UIViewContentModeScaleAspectFill;
        [viewReviews addSubview:imgProduct];

        UIView *viewRoadTest = [[UIView alloc] init];
        viewRoadTest.frame = CGRectMake(0, 0, 70, 18);
        viewRoadTest.backgroundColor = [APP_DELEGATE colorWithHexString:@"0E405B"];
        [viewReviews addSubview:viewRoadTest];

        UILabel * lblTypeReview = [[UILabel alloc] initWithFrame:CGRectMake(0, viewRoadTest.frame.size.height/2-6.5,viewRoadTest.frame.size.width , 13)];
        lblTypeReview.text =@"ROAD TEST";
        lblTypeReview.textAlignment=NSTextAlignmentCenter;
        lblTypeReview.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightRegular];
        lblTypeReview.textColor = [UIColor whiteColor];
        [viewRoadTest addSubview:lblTypeReview];

        UILabel * lblCarDetails = [[UILabel alloc] initWithFrame:CGRectMake(imgProduct.frame.size.width+8, 10, viewReviews.frame.size.width/2-15, 40)];
        lblCarDetails.textAlignment=NSTextAlignmentLeft;
        lblCarDetails.text = [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"expert_review_list"] objectAtIndex:a] valueForKey:@"description"]];
        lblCarDetails.textColor = [UIColor blackColor];
        lblCarDetails.numberOfLines=2;
        lblCarDetails.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
        [viewReviews addSubview:lblCarDetails];

        UILabel * lblReviewData = [[UILabel alloc] initWithFrame:CGRectMake(imgProduct.frame.size.width+8, viewReviews.frame.size.height-35, 80, 30)];
        lblReviewData.textAlignment=NSTextAlignmentLeft;

        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MMM d, yyyy"];
        NSDate *date = [[NSDate alloc] init];
        date  = [df dateFromString:[[[dictModelDetail valueForKey:@"expert_review_list"] objectAtIndex:a] valueForKey:@"review_date"]];
        NSString *ago = [date timeAgo];
        lblReviewData.text = [NSString stringWithFormat:@"%@",ago];
        ;
        lblReviewData.textColor = [APP_DELEGATE colorWithHexString:@"#333333"];
        lblReviewData.numberOfLines=2;
        UIFontDescriptor * fontD = [lblReviewData.font.fontDescriptor
                                    fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
        [viewReviews addSubview:lblReviewData];
        lblReviewData.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightLight];

        UILabel * lblUserByName = [[UILabel alloc] initWithFrame:CGRectMake(viewReviews.frame.size.width-86, viewReviews.frame.size.height-35, 80, 30)];
        lblUserByName.textAlignment=NSTextAlignmentRight;
        lblUserByName.text = [NSString stringWithFormat:@"By %@",[[[dictModelDetail valueForKey:@"expert_review_list"] objectAtIndex:a] valueForKey:@"expert_name"]];
        lblUserByName.textColor = [APP_DELEGATE colorWithHexString:@"#333333"];
        lblUserByName.numberOfLines=2;
        lblUserByName.font = [UIFont systemFontOfSize:11.0 weight:UIFontWeightLight];
        [viewReviews addSubview:lblUserByName];

        y=y+120;
    }
    alternativeY = (viewVideos.frame.origin.y)+(viewVideos.frame.size.height+5);
    viewExpertReviews.frame = CGRectMake(0, viewVideos.frame.origin.y+viewVideos.frame.size.height+5, DEVICE_WIDTH, y+ 5);

    [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+50)];

}
-(void)setFrameForAlternatives
{
    [viewAlternative removeFromSuperview];

    viewAlternative = [[UIView alloc] initWithFrame:CGRectMake(0, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+5, DEVICE_WIDTH, 320)];
    viewAlternative.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewAlternative];

    int  y = 0;

    lblAlternatives = [[UILabel alloc] initWithFrame:CGRectMake(14, y, DEVICE_WIDTH-28, 20)];
    lblAlternatives.textAlignment = NSTextAlignmentLeft;
    lblAlternatives.text = [NSString stringWithFormat:@"Alternative (%lu)",    [[dictModelDetail valueForKey:@"alternative_model_list"] count]];
    lblAlternatives.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    lblAlternatives.textColor = [UIColor blackColor];
    [viewAlternative addSubview:lblAlternatives];

    y=y+30;
    self.carsAlternative=[[iCarousel alloc]initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 300)];
    self.carsAlternative.delegate=self;
    self.carsAlternative.dataSource=self;
    self.carsAlternative.type = iCarouselTypeLinear;
    [viewAlternative addSubview:self.carsAlternative];

    [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewAlternative.frame.origin.y+viewAlternative.frame.size.height+50)];
}
-(void)setFrameToCreateTabBar
{
    NSLog(@"%@", optionsAry);
    [scrolltabBar removeFromSuperview];
    scrolltabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20,DEVICE_WIDTH , 44)];
    scrolltabBar.scrollEnabled=YES;
    if(isShowTab==YES)
    {
        scrolltabBar.hidden=NO;
    }else{
        scrolltabBar.hidden=YES;
    }
    self.automaticallyAdjustsScrollViewInsets= NO;
    scrolltabBar.userInteractionEnabled= YES;
    scrolltabBar.showsHorizontalScrollIndicator = NO;
    scrolltabBar.showsVerticalScrollIndicator = NO;
    scrolltabBar.delegate=self;
    scrolltabBar.backgroundColor = [UIColor colorWithRed:7/255.0 green:99/255.0 blue:150/255.0 alpha:1];
    [self.view addSubview:scrolltabBar];

    int buffer = 0;
    int xy=0;
    int buttonWidth =DEVICE_WIDTH/5,buttonHeight=44;

    showBoder = [[UILabel alloc] init];
    showBoder.frame =  CGRectMake(0,43,buttonWidth,3);
    showBoder.backgroundColor = APP_BUTTON_COLOR;
    [scrolltabBar addSubview:showBoder];

    for (buttonId = 0; buttonId < [optionsAry count]; buttonId++)
    {
        [sizeOfx addObject:[NSNumber numberWithInt:xy]];
        BtnCategory = [[UIButton alloc] init];
        BtnCategory=[UIButton buttonWithType:UIButtonTypeCustom];
        BtnCategory.frame     = CGRectMake(xy, 0,buttonWidth,buttonHeight );
        [BtnCategory addTarget:self action:@selector(btnTabClick:) forControlEvents:UIControlEventTouchUpInside];
        [BtnCategory setTitle: [NSString stringWithFormat:@"%@",[optionsAry objectAtIndex:buttonId]] forState:UIControlStateNormal];
        [BtnCategory setBackgroundColor:[UIColor clearColor]];
        BtnCategory.tag=buttonId;
        BtnCategory.titleLabel.textColor= [UIColor blackColor];
        BtnCategory.titleLabel.textAlignment= NSTextAlignmentCenter;
        BtnCategory.titleLabel.font= [UIFont systemFontOfSize:11.0];

        xy = buttonWidth + xy + buffer;
        [scrolltabBar addSubview:BtnCategory];
    }
    [scrolltabBar setContentSize:CGSizeMake(xy, 0)];
}
-(void)btnTabClick:(id)sender
{
    if([sender tag]==0)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        [UIView animateWithDuration:.5 animations:^{
            NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
            int xy = [firstNumber intValue];

            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        [scrolContent setContentOffset:CGPointMake(0,versionY)animated:YES];
    }if([sender tag]==1)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        [scrolContent setContentOffset:CGPointMake(0,mileageY)animated:YES];
    }if([sender tag]==2)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        [scrolContent setContentOffset:CGPointMake(0,colorsY)animated:YES];
    }
    if([sender tag]==3)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        [scrolContent setContentOffset:CGPointMake(0,imagesY)animated:YES];
    }
    if([sender tag]==4)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        [scrolContent setContentOffset:CGPointMake(0,videoY)animated:YES];
    }
    if([sender tag]==5)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 2);
        } completion:^(BOOL finished) {
        }];
        [scrolContent setContentOffset:CGPointMake(0,alternativeY)animated:YES];
    }

}
-(void)setFrameIfDataNotAvailable
{
    [viewCarImages removeFromSuperview];
    viewCarImages = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    viewCarImages.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewCarImages];
    viewModelDetails = [[UIView alloc] initWithFrame:CGRectMake(0, viewCarImages.frame.origin.y + viewCarImages.frame.size.height, DEVICE_WIDTH, 140)];
    viewModelDetails.backgroundColor = [UIColor whiteColor];
    [scrolContent addSubview:viewModelDetails];
    emiView = [[UIView alloc] initWithFrame:CGRectMake(0, viewModelDetails.frame.origin.y+viewModelDetails.frame.size.height+10, DEVICE_WIDTH, 55)];
    [scrolContent addSubview:emiView];
}
#pragma mark - Collectionview Delegate Methiods
#pragma mark - UICollectionView DataSource & Delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrCarImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavCarCell *cell = (FavCarCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];

    NSURL *url = [NSURL URLWithString:[arrCarImages objectAtIndex:indexPath.row]];
    cell.imgCar.imageURL = url;


    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - iCrousal Delegate methods

#pragma mark iCarousel methods
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    if (carousel == _carsList)
    {
        return [arrCarVideos count];
    }else if (carousel == self.carsAlternative)
    {
        return [[dictModelDetail valueForKey:@"alternative_model_list"] count];
    }
    else
    {
        return 10;
    }
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (carousel == self.carsList)
    {
        [view removeFromSuperview];
        view =nil;
        if (view == nil)
        {
            view =[[UIView alloc] initWithFrame:CGRectMake(30, 5, DEVICE_WIDTH-60,170)];
            view.backgroundColor = [UIColor whiteColor];
            [self setShadowForView:view];

            AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
            imgCar1.image = [UIImage imageNamed:@"demo4.jpg"];
            imgCar1.clipsToBounds=YES;
            imgCar1.userInteractionEnabled=YES;
            imgCar1.contentMode = UIViewContentModeScaleAspectFill;
            [view addSubview:imgCar1];

            UILabel * lblTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, view.frame.size.width, 20)];
            lblTime.textAlignment = NSTextAlignmentLeft;
            lblTime.text = @"4.23";
            lblTime.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            lblTime.textColor = [UIColor blackColor];

            UILabel * lblCarType=[[UILabel alloc] init];
            lblCarType.frame=CGRectMake(10, 120, view.frame.size.width, 20);
            lblCarType.font=[UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
            lblCarType.textAlignment=NSTextAlignmentLeft;
            lblCarType.textColor=[UIColor blackColor];
            lblCarType.text=@"First Drive: Tata Nano GenX";
            lblCarType.clipsToBounds=YES;
            [view addSubview:lblCarType];

            UILabel * lblDescription=[[UILabel alloc] init];
            lblDescription.frame=CGRectMake(10, 140, view.frame.size.width/2, 16);
            lblDescription.font=[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            lblDescription.textAlignment=NSTextAlignmentLeft;
            lblDescription.textColor=[UIColor lightGrayColor];
            lblDescription.text=@"First drive impress..";
            lblDescription.clipsToBounds=YES;
            [view addSubview:lblDescription];


            UILabel * lblViews=[[UILabel alloc] init];
            lblViews.frame=CGRectMake(view.frame.size.width/2+15, 140, view.frame.size.width/2-15, 20);
            lblViews.font=[UIFont boldSystemFontOfSize:10.0];
            lblViews.textAlignment=NSTextAlignmentLeft;
            lblViews.textColor=[UIColor lightGrayColor];
            lblViews.text=@"210.2K views";
            lblViews.clipsToBounds=YES;
            [view addSubview:lblViews];
        }

        return view;
    } else if (carousel == self.carsAlternative)
    {

        [view removeFromSuperview];
        view =nil;
        if (view == nil)
        {
            view =[[UIView alloc] initWithFrame:CGRectMake(30, 5, DEVICE_WIDTH-60,290)];
            view.backgroundColor = [UIColor whiteColor];
            [self setShadowForView:view];


            AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 160)];
            imgCar1.image = [UIImage imageNamed:@"demo4.jpg"];

            NSString * strUrl = [NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"alternative_model_list"] objectAtIndex:index] valueForKey:@"model_image"]];
            if (strUrl.length>0)
            {
                NSURL *url = [NSURL URLWithString:strUrl];
                imgCar1.imageURL = url;
            }

            imgCar1.clipsToBounds=YES;
            imgCar1.userInteractionEnabled=YES;
            imgCar1.contentMode = UIViewContentModeScaleAspectFill;
            [view addSubview:imgCar1];

            UILabel * lblname = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, view.frame.size.width, 20)];
            lblname.textAlignment = NSTextAlignmentLeft;
            lblname.text =[NSString stringWithFormat:@"%@",[[[dictModelDetail valueForKey:@"alternative_model_list"] objectAtIndex:index] valueForKey:@"car_model_name"]];
            lblname.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
            lblname.textColor = [UIColor blackColor];
            [view addSubview:lblname];


            UILabel * lblCarPrice=[[UILabel alloc] init];
            lblCarPrice.frame=CGRectMake(10, 195, view.frame.size.width, 20);
            lblCarPrice.font=[UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
            lblCarPrice.textAlignment=NSTextAlignmentLeft;

            NSDictionary *arialDict = @{
                                        NSFontAttributeName : [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold],
                                        NSForegroundColorAttributeName : [UIColor blackColor]
                                        };
            NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",[[[dictModelDetail valueForKey:@"alternative_model_list"] objectAtIndex:index] valueForKey:@"currency_symbol"],[[[dictModelDetail valueForKey:@"alternative_model_list"] objectAtIndex:index] valueForKey:@"price"]] attributes: arialDict];

            NSDictionary *arialDict2 = @{
                                         NSFontAttributeName : [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular],
                                         NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                         };
            NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"  onwords" attributes: arialDict2];
            [aAttrString1 appendAttributedString:aAttrString2];
            lblCarPrice.textAlignment=NSTextAlignmentLeft;
            lblCarPrice.attributedText = aAttrString1;
            lblCarPrice.textColor=[UIColor blackColor];
            lblCarPrice.clipsToBounds=YES;
            [view addSubview:lblCarPrice];

            UILabel * lblShowroomAddress=[[UILabel alloc] init];
            lblShowroomAddress.frame=CGRectMake(10, 215, view.frame.size.width/2, 16);
            lblShowroomAddress.font=[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            lblShowroomAddress.textAlignment=NSTextAlignmentLeft;
            lblShowroomAddress.textColor=[UIColor lightGrayColor];
            lblShowroomAddress.text=@"ex-showroom,Ahmedabad";
            lblShowroomAddress.clipsToBounds=YES;
            [view addSubview:lblShowroomAddress];

            UIButton * btnprice = [[UIButton alloc] initWithFrame:CGRectMake(10, 230, DEVICE_WIDTH-40, 30)];
            [btnprice setTitle:@"Check On-Road price" forState:UIControlStateNormal];
            [btnprice setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
            btnprice.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            btnprice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btnprice.titleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            [view addSubview:btnprice];

            UIButton * btnCompare = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, DEVICE_WIDTH-40, 30)];
            [btnCompare setTitle:@"Compare with Nano GenX" forState:UIControlStateNormal];
            [btnCompare setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btnCompare setTitleColor:[APP_DELEGATE colorWithHexString:@"0288CF"] forState:UIControlStateNormal];
            btnCompare.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            btnCompare.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btnCompare.titleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            [view addSubview:btnCompare];
        }
        return view;
    }
    else
    {
        [view removeFromSuperview];
        view =nil;
        if (view == nil)
        {
            view =[[UIView alloc] initWithFrame:CGRectMake(30, 5, DEVICE_WIDTH-60,290)];
            view.backgroundColor = [UIColor whiteColor];
            [self setShadowForView:view];

            AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 150)];
            imgCar1.image = [UIImage imageNamed:@"demo4.jpg"];
            imgCar1.clipsToBounds=YES;
            imgCar1.userInteractionEnabled=YES;
            imgCar1.contentMode = UIViewContentModeScaleAspectFill;
            [view addSubview:imgCar1];

            UILabel * lblname = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, view.frame.size.width, 20)];
            lblname.textAlignment = NSTextAlignmentLeft;
            lblname.text = @"Renault Kwid";
            lblname.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
            lblname.textColor = [UIColor blackColor];
            [view addSubview:lblname];


            UILabel * lblCarPrice=[[UILabel alloc] init];
            lblCarPrice.frame=CGRectMake(10, 180, view.frame.size.width, 20);
            lblCarPrice.font=[UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
            lblCarPrice.textAlignment=NSTextAlignmentLeft;
            lblCarPrice.textColor=[UIColor blackColor];
            lblCarPrice.text=@"2.36L on words";
            lblCarPrice.clipsToBounds=YES;
            lblCarPrice.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            [view addSubview:lblCarPrice];

            UILabel * lblShowroomAddress=[[UILabel alloc] init];
            lblShowroomAddress.frame=CGRectMake(10, 200, view.frame.size.width/2, 16);
            lblShowroomAddress.font=[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            lblShowroomAddress.textAlignment=NSTextAlignmentLeft;
            lblShowroomAddress.textColor=[UIColor lightGrayColor];
            lblShowroomAddress.text=@"ex-showroom,Ahmedabad";
            lblShowroomAddress.clipsToBounds=YES;
            [view addSubview:lblShowroomAddress];

            UIButton * btnprice = [[UIButton alloc] initWithFrame:CGRectMake(10, 230, DEVICE_WIDTH-40, 30)];
            [btnprice setTitle:@"Check On-Road price" forState:UIControlStateNormal];
            [btnprice setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            btnprice.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            btnprice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btnprice.titleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            [view addSubview:btnprice];

            UIButton * btnCompare = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, DEVICE_WIDTH-40, 30)];
            [btnCompare setTitle:@"Compare with Nano GenX" forState:UIControlStateNormal];
            [btnCompare setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            btnCompare.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            btnCompare.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btnCompare.titleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            [view addSubview:btnCompare];

        }

        return view;
    }
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
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carsList.itemWidth);
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
            if (self.carsList.type == iCarouselTypeCustom)
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


#pragma mark - Shadow View
-(void)setShadowForView:(UIView *)shadowView
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:shadowView.bounds];
    shadowView.layer.masksToBounds = false;
    shadowView.layer.shadowColor = [APP_DELEGATE colorWithHexString:@"000000"].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    shadowView.layer.shadowOpacity = 0.16f;
    shadowView.layer.shadowPath = shadowPath.CGPath;
}
#pragma mark - Get Randaom color
- (UIColor *)configureTheRandomColor
{
    UIColor * randomColor;
    CGFloat R = ( arc4random() % 256 / 256.0 );
    CGFloat G = ( arc4random() % 256 / 256.0 );
    CGFloat B = ( arc4random() % 256 / 256.0 );
    randomColor = [UIColor colorWithRed:R green:G blue:B alpha:1.0];
    return randomColor;
}


#pragma mark - Button actions
-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnClickOnRoadPriceClicked:(id)sender
{
}

-(void)closeTextInput:(UITapGestureRecognizer*)sender
{
}
-(BOOL)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //    UIView *view = touch.view;
    //    while (view.class != UIView.class) {
    //        // Check if superclass is of type dropdown
    //        if (view.class == dropDownFuel.class || view.class == dropDownTransmission.class) { // dropDown is an ivar; replace with your own
    //            NSLog(@"Is of type dropdown; returning NO");
    //            return NO;
    //        } else {
    //            view = view.superview;
    //        }
    //    }

    return YES;
}

-(void)btnFuelClicked:(UIButton *)sender withEvent:(UIEvent *)event
{
    isFualClick=YES;
    [self selectFualTransFrame];
}

-(void)btnTransmissionClicked:(UIButton *)sender withEvent:(UIEvent *)event
{
    isFualClick=NO;
    [self selectFualTransFrame];
}
-(void)btnClickMore:(id)sender
{
    isShowTab=YES;
    NSLog(@"Y Value=======> %f",scrolContent.contentOffset.y);
    if (isVersionLess==NO)
    {
        isVersionLess=YES;
    }else
    {
        isVersionLess=NO;
    }
    [self filterbyFualAndTransmission];
}
-(void)btnColorMore:(id)sender
{

    if (isColorLess==NO)
    {
        isColorLess=YES;
    }else
    {
        isColorLess=NO;
    }
    [self filterbyFualAndTransmission];
}
-(void)BtnVersionCar:(id)sender
{
    NSLog (@"%li",(long)[sender tag]);
    selectVersionCar = (UIButton *)sender;
    if([[[arrVerionList objectAtIndex:[sender tag]] valueForKey:@"isSelect"] isEqualToString:@"yes"])
    {
        [selectVersionCar setImage:[UIImage imageNamed:@"rectangle-light"] forState:UIControlStateNormal];
        [[arrVerionList objectAtIndex:[sender tag]]setValue:@"No" forKey:@"isSelect"];
    }else{
        [selectVersionCar setImage:[UIImage imageNamed:@"select_Verion"] forState:UIControlStateNormal];
        [[arrVerionList objectAtIndex:[sender tag]]setValue:@"yes" forKey:@"isSelect"];
    }
}
-(void)BtnVersion:(id)sender
{
    NSLog(@"Clicked Version");
}
-(void)btnGalleryClick:(id)sender
{
    galleryVC *vc = [[galleryVC  alloc] init];
    vc.arrImgExterior = [[dictModelDetail valueForKey:@"image_list"] valueForKey:@"Exterior"];
    //vc.arrImgVideo = arrCarVideos;
    vc.arrImgVideo = [[dictModelDetail valueForKey:@"image_list"] valueForKey:@"Exterior"];
    vc.arrImgInterior = [[dictModelDetail valueForKey:@"image_list"] valueForKey:@"Interior"];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"Gallery open");
}

#pragma mark - Webservice methods
-(void)getModeldetailsById
{
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {

    }else
    {
        [spinner removeFromSuperview];
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        if ([spinner isAnimating])
        {
        }else
        {
            [spinner startAnimating];
        }
        spinner.frame = CGRectMake(DEVICE_WIDTH/2-22, DEVICE_HEIGHT/2-22, 44, 44);

        [self.view addSubview:spinner];

        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        [parameter_dict setObject:[dictCar valueForKey:@"model_id"] forKey:@"model_id"];
        NSString * webServiceName = @"getModelDetails";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getModelDeatailsById";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}

#pragma mark - WebServices Delegate


-(void)onResult:(NSDictionary *)result
{
    NSLog(@"%@response",result);
    [spinner removeFromSuperview];

    if([[result valueForKey:@"commandName"] isEqualToString:@"getModelDeatailsById"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            dictModelDetail = [[[result valueForKey:@"result"] valueForKey:@"data"] mutableCopy];
            NSLog(@"dictModelDetail ==> %@",dictModelDetail);
            NSLog(@"[dictModelDetail count] ==> %lu",(unsigned long)[dictModelDetail count]);

            if ([dictModelDetail valueForKey:@"image_list"])
            {
                if ([[dictModelDetail valueForKey:@"image_list"] valueForKey:@"Exterior"])
                {
                    [arrCarImages addObjectsFromArray:[[dictModelDetail valueForKey:@"image_list"] valueForKey:@"Exterior"]];
                }
                if ([[dictModelDetail valueForKey:@"image_list"] valueForKey:@"Interior"])
                {
                    [arrCarImages addObjectsFromArray:[[dictModelDetail valueForKey:@"image_list"] valueForKey:@"Interior"]];
                }
            }
            if ([dictModelDetail valueForKey:@"video_list"])
            {
                if ([[dictModelDetail valueForKey:@"video_list"] valueForKey:@"Exterior"])
                {
                    [arrCarVideos addObjectsFromArray:[[dictModelDetail valueForKey:@"video_list"] valueForKey:@"Exterior"]];
                }
                if ([[dictModelDetail valueForKey:@"video_list"] valueForKey:@"Interior"])
                {
                    [arrCarVideos addObjectsFromArray:[[dictModelDetail valueForKey:@"video_list"] valueForKey:@"Interior"]];
                }
            }

            if ([dictModelDetail valueForKey:@"version_list"])
            {
                if ([[dictModelDetail valueForKey:@"version_list"] count]>0)
                {
                    arrVerionList = [[dictModelDetail valueForKey:@"version_list"] mutableCopy];
                    [arrVerionList setValue:@"No" forKey:@"isSelect"];
                }
            }
            for (int a =0; a< [dictModelDetail count]; a++)
            {
                if (a==0)
                {
                    if ([dictModelDetail valueForKey:@"model_details"])
                    {
                        [self setCarImagesFrame];
                        [self setCarDeatils];
                        [self setEMIFrame];
                    }else
                    {
                        [self setFrameIfDataNotAvailable];
                    }
                }else if (a==1)
                {
                    [self setFrameforFeatureList];
                    [self setFrameToCreateTabBar];

                }else if (a==2)
                {
                    if ([arrVerionList count]>0)
                    {
                        [self setFrameForVersion];
                        [self changeFrameBasedOnFilter];
                    }else
                    {
                        [viewVersion removeFromSuperview];
                        viewVersion = [[UIView alloc] initWithFrame:CGRectMake(0, carAccessories.frame.origin.y+carAccessories.frame.size.height+5, DEVICE_WIDTH, 0)];
                        viewVersion.backgroundColor = [UIColor whiteColor];
                        [scrolContent addSubview:viewVersion];

                        [viewCarModelTypes removeFromSuperview];
                        viewCarModelTypes = [[UIView alloc] initWithFrame:CGRectMake(0, viewVersion.frame.origin.y+viewVersion.frame.size.height+5, DEVICE_WIDTH, 0)];
                        viewCarModelTypes.backgroundColor = [UIColor whiteColor];
                        [scrolContent addSubview:viewCarModelTypes];
                    }
                }else if (a == 3)
                {
                    if ([dictModelDetail valueForKey:@"meilage"])
                    {
                        [self setFrameForMileage];
                    }else
                    {
                        [viewMileage removeFromSuperview];
                        viewMileage = [[UIView alloc] initWithFrame:CGRectMake(0, viewCarModelTypes.frame.origin.y+viewCarModelTypes.frame.size.height+5, DEVICE_WIDTH, 0)];
                        [scrolContent addSubview:viewMileage];
                    }
                }else if (a == 4)
                {
                    if ([dictModelDetail valueForKey:@"color_list"])
                    {
                        if ([[dictModelDetail valueForKey:@"color_list"] count]>0)
                        {
                            [self setFrameForColors];
                        }else
                        {
                            [viewColors removeFromSuperview];
                            viewMileage = [[UIView alloc] initWithFrame:CGRectMake(0, viewMileage.frame.origin.y+viewMileage.frame.size.height, DEVICE_WIDTH, 0)];
                            [scrolContent addSubview:viewMileage];                        }
                    }else
                    {
                        [viewColors removeFromSuperview];
                        viewMileage = [[UIView alloc] initWithFrame:CGRectMake(0, viewMileage.frame.origin.y+viewMileage.frame.size.height, DEVICE_WIDTH, 0)];
                        [scrolContent addSubview:viewMileage];
                    }
                }else if (a ==5)
                {
                    if ([arrCarImages count]>0)
                    {
                        [self setFrameForImages];
                    }
                    else
                    {
                        viewImages = [[UIView alloc] initWithFrame:CGRectMake(0, viewColors.frame.origin.y+viewColors.frame.size.height+5, DEVICE_WIDTH, 0)];
                        viewImages.backgroundColor = [UIColor whiteColor];
                        [scrolContent addSubview:viewImages];
                    }
                }else if (a==6)
                {

                    if ([arrCarVideos count]>0)
                    {
                        [self setFrameForVideos];
                    }
                    else
                    {
                        [viewVideos removeFromSuperview];
                        viewVideos = [[UIView alloc] initWithFrame:CGRectMake(0, viewImages.frame.origin.y+viewImages.frame.size.height+5, DEVICE_WIDTH,0)];
                        [scrolContent addSubview:viewVideos];
                        [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewVideos.frame.origin.y+viewVideos.frame.size.height+50)];
                    }
                } else if (a == 7)
                {
                    if ([dictModelDetail valueForKey:@"expert_review_list"])
                    {
                        if ([[dictModelDetail valueForKey:@"expert_review_list"] count]>0)
                        {
                            [self setFrameForExpertReviews];
                        }else
                        {
                            [viewExpertReviews removeFromSuperview];
                            viewExpertReviews = [[UIView alloc] initWithFrame:CGRectMake(0, viewVideos.frame.origin.y+viewVideos.frame.size.height+5, DEVICE_WIDTH, 0)];
                            [scrolContent addSubview:viewExpertReviews];
                            [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+50)];

                        }
                    }else
                    {
                        [viewExpertReviews removeFromSuperview];
                        viewExpertReviews = [[UIView alloc] initWithFrame:CGRectMake(0, viewVideos.frame.origin.y+viewVideos.frame.size.height+5, DEVICE_WIDTH, 0)];
                        [scrolContent addSubview:viewExpertReviews];
                        [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+50)];
                    }
                }else if (a == 8)
                {
                    if ([dictModelDetail valueForKey:@"alternative_model_list"])
                    {
                        if ([[dictModelDetail valueForKey:@"alternative_model_list"] count]>0)
                        {
                            [self setFrameForAlternatives];
                        }else
                        {
                            [viewAlternative removeFromSuperview];
                            viewAlternative = [[UIView alloc] initWithFrame:CGRectMake(0, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+5, DEVICE_WIDTH, 0)];
                            [scrolContent addSubview:viewAlternative];
                            [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewAlternative.frame.origin.y+viewAlternative.frame.size.height+50)];
                        }
                    }else
                    {
                        [viewAlternative removeFromSuperview];
                        viewAlternative = [[UIView alloc] initWithFrame:CGRectMake(0, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+5, DEVICE_WIDTH, 0)];
                        [scrolContent addSubview:viewAlternative];
                        [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewAlternative.frame.origin.y+viewAlternative.frame.size.height+50)];
                    }
                }
            }
        }
    }
}
- (void)onError:(NSError *)error
{
    [spinner removeFromSuperview];

    NSLog(@"The error is...%@", error);
}

-(void)selectFualTransFrame
{
    [viewFuel removeFromSuperview];
    viewFuel = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, 250)];
    [viewFuel setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewFuel];

    UIButton * btnDone1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone1 setFrame:CGRectMake(0 , 0, DEVICE_WIDTH, 34)];
    [btnDone1 setBackgroundColor:[UIColor colorWithRed:132.0/255.0 green:160.0/255.0 blue:183.0/255.0 alpha:1]];
    [btnDone1 setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDone1 setTag:1];
    [btnDone1 addTarget:self action:@selector(btnDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewFuel addSubview:btnDone1];

    tblFualTrans = [[UITableView alloc] initWithFrame:CGRectMake(0, 34, DEVICE_WIDTH, 216) style:UITableViewStylePlain];
    tblFualTrans.dataSource=self;
    tblFualTrans.delegate=self;
    tblFualTrans.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblFualTrans.backgroundColor=[UIColor clearColor];
    tblFualTrans.showsVerticalScrollIndicator = NO;
    [viewFuel addSubview:tblFualTrans];
    [self showPicker:YES andView:viewFuel];
}

#pragma mark - TableView Delegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFualClick==YES)
    {
        return [arrFual count];
    }else
    {
        return [arrTransmission count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentity =nil;

    FualTransmissionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    cell = [[FualTransmissionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    if (isFualClick==YES)
    {
        cell.lblTitle.text = [[arrFual objectAtIndex:indexPath.row] valueForKey:@"title"];
        if ([[[arrFual objectAtIndex:indexPath.row] valueForKey:@"isSelect"] isEqualToString:@"no"])
        {
            cell.imgOption.backgroundColor = [UIColor redColor];
        }else
        {
            cell.imgOption.backgroundColor = [UIColor blueColor];
        }
    }else
    {
        cell.lblTitle.text = [[arrTransmission objectAtIndex:indexPath.row] valueForKey:@"title"];
        if ([[[arrTransmission objectAtIndex:indexPath.row] valueForKey:@"isSelect"] isEqualToString:@"no"])
        {
            cell.imgOption.backgroundColor = [UIColor redColor];
        }else
        {
            cell.imgOption.backgroundColor = [UIColor blueColor];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isFualClick==YES)
    {
        if ([[[arrFual objectAtIndex:indexPath.row] valueForKey:@"isSelect"] isEqualToString:@"no"])
        {
            [[arrFual objectAtIndex:indexPath.row] setValue:@"yes" forKey:@"isSelect"];
        }else
        {
            [[arrFual objectAtIndex:indexPath.row] setValue:@"no" forKey:@"isSelect"];
        }
    }else
    {
        if ([[[arrTransmission objectAtIndex:indexPath.row] valueForKey:@"isSelect"] isEqualToString:@"no"])
        {
            [[arrTransmission objectAtIndex:indexPath.row] setValue:@"yes" forKey:@"isSelect"];
        }else
        {
            [[arrTransmission objectAtIndex:indexPath.row] setValue:@"no" forKey:@"isSelect"];
        }
    }

    [tblFualTrans reloadData];
}

-(void)btnDoneClicked:(id)sender
{
    [self showPicker:NO andView:viewFuel];
    [self filterbyFualAndTransmission];
}

#pragma mark - Filter by Fual and Transmission
-(void)filterbyFualAndTransmission
{
    [arrVerionList removeAllObjects];
    [optionsAry removeAllObjects];
    for (int a=0; a< [arrFual count]; a++)
    {
        if ([[[arrFual objectAtIndex:a]valueForKey:@"isSelect"]isEqualToString:@"yes"]) {
            NSArray *filtered = [[dictModelDetail valueForKey:@"version_list"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(fuel_type == %@)", [[arrFual objectAtIndex:a]valueForKey:@"title"]]];
            if ([filtered count]>0)
            {

                for (int b  = 0 ; b<[filtered count]; b++)
                {
                    if (![arrVerionList containsObject:[filtered objectAtIndex:b]])
                    {
                        [arrVerionList addObject:[filtered objectAtIndex:b]];

                    }
                }

            }else
            {

            }
        }
    }

    for (int a=0; a< [arrTransmission count]; a++)
    {
        if ([[[arrTransmission objectAtIndex:a]valueForKey:@"isSelect"]isEqualToString:@"yes"])
        {
            NSArray *filtered = [[dictModelDetail valueForKey:@"version_list"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(transmission_type == %@)", [[arrTransmission objectAtIndex:a]valueForKey:@"title"]]];
            if ([filtered count]>0)
            {
                for (int b  = 0 ; b<[filtered count]; b++)
                {
                    if (![arrVerionList containsObject:[filtered objectAtIndex:b]])
                    {
                        [arrVerionList addObject:[filtered objectAtIndex:b]];
                    }
                }
            }
        }
    }
    if ([arrVerionList count]==0)
    {
        if ([dictModelDetail valueForKey:@"version_list"])
        {
            if ([[dictModelDetail valueForKey:@"version_list"] count]>0)
            {
                arrVerionList = [[dictModelDetail valueForKey:@"version_list"] mutableCopy];
            }
        }
    }

    [self updateFramesAfterChangeVersion];

}
-(void)updateFramesAfterChangeVersion
{
    for (int a =0; a< [dictModelDetail count]; a++)
    {
        if (a==0)
        {
        }else if (a==1)
        {
            [self setFrameforFeatureList];
            [self setFrameToCreateTabBar];

        }else if (a==2)
        {
            [self changeFrameBasedOnFilter];
        }else if (a == 3)
        {
            if ([dictModelDetail valueForKey:@"meilage"])
            {
                [self setFrameForMileage];
            }else
            {
                [viewMileage removeFromSuperview];
                viewMileage = [[UIView alloc] initWithFrame:CGRectMake(0, viewCarModelTypes.frame.origin.y+viewCarModelTypes.frame.size.height+5, DEVICE_WIDTH, 0)];
                [scrolContent addSubview:viewMileage];
            }
        }else if (a == 4)
        {
            if ([dictModelDetail valueForKey:@"color_list"])
            {
                if ([[dictModelDetail valueForKey:@"color_list"] count]>0)
                {
                    [self setFrameForColors];
                }else
                {
                    [viewColors removeFromSuperview];
                    viewMileage = [[UIView alloc] initWithFrame:CGRectMake(0, viewMileage.frame.origin.y+viewMileage.frame.size.height, DEVICE_WIDTH, 0)];
                    [scrolContent addSubview:viewMileage];                        }
            }else
            {
                [viewColors removeFromSuperview];
                viewMileage = [[UIView alloc] initWithFrame:CGRectMake(0, viewMileage.frame.origin.y+viewMileage.frame.size.height, DEVICE_WIDTH, 0)];
                [scrolContent addSubview:viewMileage];
            }
        }else if (a ==5)
        {
            if ([arrCarImages count]>0)
            {
                [self setFrameForImages];
            }
            else
            {
                viewImages = [[UIView alloc] initWithFrame:CGRectMake(0, viewColors.frame.origin.y+viewColors.frame.size.height+5, DEVICE_WIDTH, 0)];
                viewImages.backgroundColor = [UIColor whiteColor];
                [scrolContent addSubview:viewImages];
            }
        }else if (a==6)
        {

            if ([arrCarVideos count]>0)
            {
                [self setFrameForVideos];
            }
            else
            {
                [viewVideos removeFromSuperview];
                viewVideos = [[UIView alloc] initWithFrame:CGRectMake(0, viewImages.frame.origin.y+viewImages.frame.size.height+5, DEVICE_WIDTH,0)];
                [scrolContent addSubview:viewVideos];
                [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewVideos.frame.origin.y+viewVideos.frame.size.height+50)];
            }
        } else if (a == 7)
        {
            if ([dictModelDetail valueForKey:@"expert_review_list"])
            {
                if ([[dictModelDetail valueForKey:@"expert_review_list"] count]>0)
                {
                    [self setFrameForExpertReviews];
                }else
                {
                    [viewExpertReviews removeFromSuperview];
                    viewExpertReviews = [[UIView alloc] initWithFrame:CGRectMake(0, viewVideos.frame.origin.y+viewVideos.frame.size.height+5, DEVICE_WIDTH, 0)];
                    [scrolContent addSubview:viewExpertReviews];
                    [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+50)];

                }
            }else
            {
                [viewExpertReviews removeFromSuperview];
                viewExpertReviews = [[UIView alloc] initWithFrame:CGRectMake(0, viewVideos.frame.origin.y+viewVideos.frame.size.height+5, DEVICE_WIDTH, 0)];
                [scrolContent addSubview:viewExpertReviews];
                [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+50)];
            }
        }else if (a == 8)
        {
            if ([dictModelDetail valueForKey:@"alternative_model_list"])
            {
                if ([[dictModelDetail valueForKey:@"alternative_model_list"] count]>0)
                {
                    [self setFrameForAlternatives];
                }else
                {
                    [viewAlternative removeFromSuperview];
                    viewAlternative = [[UIView alloc] initWithFrame:CGRectMake(0, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+5, DEVICE_WIDTH, 0)];
                    [scrolContent addSubview:viewAlternative];
                    [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewAlternative.frame.origin.y+viewAlternative.frame.size.height+50)];
                }
            }else
            {
                [viewAlternative removeFromSuperview];
                viewAlternative = [[UIView alloc] initWithFrame:CGRectMake(0, viewExpertReviews.frame.origin.y+viewExpertReviews.frame.size.height+5, DEVICE_WIDTH, 0)];
                [scrolContent addSubview:viewAlternative];
                [scrolContent setContentSize:CGSizeMake(DEVICE_WIDTH, viewAlternative.frame.origin.y+viewAlternative.frame.size.height+50)];
            }
        }
    }

}

#pragma mark - show Picker

-(void)showPicker:(BOOL)isShow andView:(UIView *)myView
{
    if (isShow == YES)
    {

        [UIView transitionWithView:myView duration:0.4
                           options:UIViewAnimationOptionCurveEaseIn
                        animations:^{

                            [myView setFrame:CGRectMake(0, DEVICE_HEIGHT-250,DEVICE_WIDTH, 250)];
                        }
                        completion:^(BOOL finished)
         {
         }];
    }
    else
    {
        [UIView transitionWithView:myView duration:0.4
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            [myView setFrame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, 250)];
                        }
                        completion:^(BOOL finished)
         {
         }];
    }
}


#pragma mark scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]])
    {
        CGRect visibleRect = (CGRect){.origin = collectionviewCars.contentOffset, .size = collectionviewCars.bounds.size};
        CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        NSIndexPath *visibleIndexPath = [collectionviewCars indexPathForItemAtPoint:visiblePoint];
        lblCountImages.text = [NSString stringWithFormat:@" %ld/%lu",(long)visibleIndexPath.row+1,(unsigned long)[arrCarImages count]];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"progress %f", scrollContent.parallaxHeader.progress);
    offsetY = scrolContent.contentOffset.y;
    NSLog(@"progress=====> %f", offsetY);
    NSLog(@"Version Y=====> %f", versionY);
    if(offsetY < versionY)
    {
        scrolltabBar.hidden=YES;
    }else{
        scrolltabBar.hidden=NO;
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
