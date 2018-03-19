//
//  UsedcarNewVC.m
//  carwale
//
//  Created by Oneclick IT Solution on 12/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "UsedcarNewVC.h"
#import "SelectCityVC.h"
#import "usedCarListVC.h"
#import "RecentSerchCarCell.h"
#import "RecentAddCarcellCollectionViewCell.h"
#import "CertifiedCarCell.h"

#define NAVBAR_CHANGE_POINT -64

@interface UsedcarNewVC ()

@end

@implementation UsedcarNewVC
@synthesize rangeSlider,recentSearchCarCollectionView,recentAddCarCollectionview,certifiedCarCollectionView;

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    GetCarModelArray = [[NSMutableArray alloc] init];
    [self GetcarModels];
    [self setFrame];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    
    
    if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        
    }
    else
    {
        GetCarModelArray = (NSMutableArray*) [[GetCarModelArray reverseObjectEnumerator]allObjects];
        [self scrollToBottomAnimated:YES];
    }
}
#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"progress %f", scrollContent.parallaxHeader.progress);
    UIColor * color = [UIColor colorWithRed:7/255.0 green:99/255.0 blue:150/255.0 alpha:1];
    CGFloat offsetY = scrollContent.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 20 - offsetY) / 20));
        [navView setBackgroundColor:color];
        
    } else {
        [navView setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark Properties

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    scrollContent.parallaxHeader.minimumHeight = self.topLayoutGuide.length;
}

#pragma mark - Set Frame
-(void)setFrame
{
    scrollContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    scrollContent.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollContent.bounces = NO;
    scrollContent.contentInset = UIEdgeInsetsMake(0,0,0,0);
    scrollContent.showsVerticalScrollIndicator = NO;
    scrollContent.showsHorizontalScrollIndicator = NO;
    scrollContent.clipsToBounds =YES;
    [self.view addSubview:scrollContent];
    
    backGroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"used-car-background"]];
    if(IS_IPHONE_X)
    {
        backGroundImg.frame = CGRectMake(0, 0,DEVICE_WIDTH,300);
    }else{
        backGroundImg.frame = CGRectMake(0, 0,DEVICE_WIDTH,320);
    }
    backGroundImg.userInteractionEnabled=YES;
    backGroundImg.clipsToBounds=YES;
    backGroundImg.contentMode=UIViewContentModeScaleAspectFill;
    [scrollContent addSubview:backGroundImg];
    int yy=0;
    
    [navView removeFromSuperview];
    if(IS_IPHONE_X)
    {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,yy,DEVICE_WIDTH , 88)];
    }else{
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,yy,DEVICE_WIDTH , 64)];
    }
    navView.backgroundColor = [UIColor clearColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    if(IS_IPHONE_X)
    {
        yy=yy+44;
    }else{
        yy=yy+20;
    }
    
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, yy, 50, 44)];
    }else{
        btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-50, yy
                                                                 , 50, 44)];
    }
    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
    [btnSideMenu addTarget:self action:@selector(btnSideMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btnSideMenu];
    
    UILabel * lblNewCars =[[UILabel alloc]init];
    lblNewCars.frame=CGRectMake(DEVICE_WIDTH/2-100,yy+12,200,20);
    lblNewCars.textAlignment=NSTextAlignmentLeft;
    lblNewCars.textColor= [UIColor whiteColor];
    lblNewCars.backgroundColor=[UIColor clearColor];
    lblNewCars.textAlignment=NSTextAlignmentCenter;
    lblNewCars.text = [TSLanguageManager localizedString:@"Used Cars"];
    lblNewCars.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblNewCars];
    
     yy=yy+12+46+20;
    
    UILabel * lblAreaDetail =[[UILabel alloc]initWithFrame:CGRectMake((DEVICE_WIDTH/2)-94,yy,94,15)];
    lblAreaDetail.textColor= [UIColor whiteColor];
    lblAreaDetail.backgroundColor=[UIColor clearColor];
    lblAreaDetail.textAlignment=NSTextAlignmentRight;
    lblAreaDetail.text = [TSLanguageManager localizedString:@"View cars from"];
    lblAreaDetail.font = [UIFont systemFontOfSize:13.0];
    [backGroundImg addSubview:lblAreaDetail];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:@"AHMEDABAD"];
    [titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:(NSUnderlinePatternDash|NSUnderlineStyleSingle)] range:NSMakeRange(0, [titleString length])];
    [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [titleString length])];
    
    UILabel * lblcityName =[[UILabel alloc]initWithFrame:CGRectMake((DEVICE_WIDTH/2)+13,yy-1,90,16)];
    lblcityName.textColor= [UIColor whiteColor];
    lblcityName.backgroundColor=[UIColor clearColor];
    lblcityName.textAlignment=NSTextAlignmentLeft;
    lblcityName.attributedText = titleString;
    lblcityName.font = [UIFont systemFontOfSize:14.0];
    [backGroundImg addSubview:lblcityName];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(DEVICE_WIDTH/2+13,yy-1,90,20);
  
//    [btn setAttributedTitle: titleString forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [backGroundImg addSubview:btn];

    yy=yy+18+21;
    
    lblRange =[[UILabel alloc]initWithFrame:CGRectMake((DEVICE_WIDTH/2)-75,yy,150,13)];
    lblRange.textColor= [UIColor whiteColor];
    lblRange.backgroundColor=[UIColor clearColor];
    lblRange.text = [TSLanguageManager localizedString:@"All Range"];
    lblRange.textAlignment = NSTextAlignmentCenter;
//    lblRange.font = [UIFont fontWithName:@"Roboto-Regular" size:12.0];
      lblRange.font = [UIFont systemFontOfSize:11.0f];
    [backGroundImg addSubview:lblRange];
    
    yy=yy+13+31;
    if(IS_IPAD)
    {
     rangeSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(180, yy, DEVICE_WIDTH-360, 20)];
    }else{
     rangeSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(38, yy, DEVICE_WIDTH-76, 20)];
    }
    rangeSlider.delegate=self;
    rangeSlider.minValue =1.0f;
    rangeSlider.maxValue = 30.0f;
    rangeSlider.selectedMinimum =1.0f;
    rangeSlider.selectedMaximum = 30.0f;
    rangeSlider.tintColorBetweenHandles = [UIColor lightGrayColor];
    rangeSlider.tintColor = [UIColor blackColor];
    rangeSlider.handleColor = [UIColor whiteColor];
    rangeSlider.lineHeight = 4.0f;
    rangeSlider.minLabelColour = [APP_DELEGATE colorWithHexString:App_green_color];
    rangeSlider.maxLabelColour =  [APP_DELEGATE colorWithHexString:App_green_color];
    [rangeSlider setHandleImage:[UIImage imageNamed:@"scrollcircle_icon"]];
    [rangeSlider addTarget:self action:@selector(changePriceRange:) forControlEvents:UIControlEventValueChanged];
    [backGroundImg addSubview:rangeSlider];
    
    yy=yy+20+10;
    UILabel * lblmin =[[UILabel alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblmin.frame = CGRectMake((rangeSlider.frame.origin.x),yy,22,13);
    }else{
        if(IS_IPAD){
            lblmin.frame = CGRectMake(DEVICE_WIDTH-201,yy,22,13);
        }else{
            lblmin.frame = CGRectMake(DEVICE_WIDTH-63,yy,22,13);
        }
    }
    lblmin.textColor= [UIColor whiteColor];
    lblmin.backgroundColor=[UIColor clearColor];
    lblmin.text = [TSLanguageManager localizedString:@
                   "Min" ];
    lblmin.textAlignment = NSTextAlignmentCenter;
    lblmin.font = [UIFont systemFontOfSize:11.0f];
    [backGroundImg addSubview:lblmin];
    
    UILabel * lblmax =[[UILabel alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
    if(IS_IPAD){
        lblmax.frame = CGRectMake(DEVICE_WIDTH-201,yy,22,13);
    }else{
    lblmax.frame = CGRectMake(DEVICE_WIDTH-63,yy,22,13);
    }
    }
    else{
    lblmax.frame = CGRectMake((rangeSlider.frame.origin.x),yy,22,13);
    }
    lblmax.textColor= [UIColor whiteColor];
    lblmax.backgroundColor=[UIColor clearColor];
    lblmax.text = [TSLanguageManager localizedString:@
                   "Max" ];
    lblmax.textAlignment = NSTextAlignmentCenter;
    lblmax.font = [UIFont systemFontOfSize:11.0f];
    [backGroundImg addSubview:lblmax];
    
    yy= yy+35;
    
    btnFindCar= [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPAD)
    {
        btnFindCar.frame=CGRectMake(94, yy, DEVICE_WIDTH-188, 40);
    }
    else
    {
        btnFindCar.frame=CGRectMake(14, yy, DEVICE_WIDTH-28, 40);
    }
    btnFindCar.backgroundColor = APP_BUTTON_COLOR;
    [btnFindCar setTitle:[TSLanguageManager localizedString:@"Find Car"] forState:UIControlStateNormal];
   // [btnFindCar setImage:[UIImage imageNamed:@"Find_car_btn"] forState:UIControlStateNormal];
    [btnFindCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnFindCar.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    btnFindCar.layer.cornerRadius=2.0;
    [btnFindCar addTarget:self action:@selector(btnFindCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundImg addSubview:btnFindCar];
    
    scrollContent.parallaxHeader.view = backGroundImg;
    if(IS_IPHONE_X)
    {
        scrollContent.parallaxHeader.height = 300;
    }else{
        scrollContent.parallaxHeader.height = 320;
    }
    scrollContent.parallaxHeader.mode = MXParallaxHeaderModeFill;
    scrollContent.parallaxHeader.minimumHeight = self.topLayoutGuide.length;
    scrollContent.delegate = self;
    
    //===========================Outside View=============================//
    
     int yy1 = 24;
    
    UILabel * lblRecentSearchLbl =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblRecentSearchLbl.textColor= [UIColor blackColor];
    lblRecentSearchLbl.backgroundColor=[UIColor clearColor];
    lblRecentSearchLbl.textAlignment=NSTextAlignmentCenter;
    lblRecentSearchLbl.text = [TSLanguageManager localizedString: @"YOU RECENTLY SEARCHED"];
    lblRecentSearchLbl.font = [UIFont boldSystemFontOfSize:15];
    [scrollContent addSubview:lblRecentSearchLbl];
    
    yy1=yy1+18+8.5;
    
    UILabel * lblRecentSearchLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1, 60,1)];
    lblRecentSearchLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblRecentSearchLine];
    
    yy1=yy1+21;
    
    self.recentSearchCar=[[iCarousel alloc]initWithFrame:CGRectMake(-20,yy1 , DEVICE_WIDTH-90, 240)];
    
    self.recentSerchFlowLayout=[[RecentSerchCarFlowLayout alloc] init];
    recentSearchCarCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 250) collectionViewLayout:self.recentSerchFlowLayout];
    [self.recentSerchFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [recentSearchCarCollectionView setDataSource:self];
    [recentSearchCarCollectionView setDelegate:self];
    recentSearchCarCollectionView.showsVerticalScrollIndicator= NO;
    recentSearchCarCollectionView.showsHorizontalScrollIndicator = NO;
    [recentSearchCarCollectionView registerClass:[RecentSerchCarCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [recentSearchCarCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:recentSearchCarCollectionView];
    
    
    yy1=yy1+250+24;
    
    UILabel * lblBrowseBY =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblBrowseBY.textColor= [UIColor blackColor];
    lblBrowseBY.backgroundColor=[UIColor clearColor];
    lblBrowseBY.textAlignment=NSTextAlignmentCenter;
    lblBrowseBY.text = [TSLanguageManager localizedString:@"POPULAR USED CAR SEGMENTS"];
    lblBrowseBY.font = [UIFont boldSystemFontOfSize:16];
    [scrollContent addSubview:lblBrowseBY];
    
    yy1=yy1+18+8.5;
    
    UILabel * lblBrowseBYLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1, 60,1)];
    lblBrowseBYLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblBrowseBYLine];
    
    if(IS_IPHONE_5)
    {
        yy1=yy1+31;
    }
    if(IS_IPHONE_6plus)
    {
        yy1=yy1+8;
    }
    if(IS_IPAD)
    {
        yy1=yy1+2;
    }
    else
    {
        yy1=yy1+21;
    }
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackGround"]];
    backImage.frame = CGRectMake(0, yy1, DEVICE_WIDTH,300);
    backImage.userInteractionEnabled=YES;
    backImage.clipsToBounds=YES;
    backImage.contentMode=UIViewContentModeScaleToFill;
    [scrollContent addSubview:backImage];
   
if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
       yy1=yy1+50;
   
            int deviceWidth = scrollContent.frame.size.width/2;
            UIView * mainView  = [[UIView alloc ]init];
            if (IS_IPAD)
            {
                mainView.frame = CGRectMake(95,yy1,deviceWidth-85,90);
            }
            else
            {
                mainView.frame = CGRectMake(14,yy1,deviceWidth-20,90);
            }
            mainView.backgroundColor = [UIColor whiteColor];
            mainView.layer.cornerRadius = 3.0f;
            mainView.layer.shadowOffset = CGSizeMake(0, 0);
            mainView.layer.shadowRadius = 5.0;
            mainView.layer.shadowOpacity = 0.50f;
            mainView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
            [scrollContent addSubview:mainView];
            
            
            UIImageView* imgHatchbackcar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView.frame.size.width/2-64/2,-32, 64, 64)];
            imgHatchbackcar.image = [UIImage imageNamed:@"hatchback"];
            imgHatchbackcar.clipsToBounds = YES;
            imgHatchbackcar.contentMode = UIViewContentModeScaleAspectFill;
            [mainView addSubview:imgHatchbackcar];
            
            
            int yyy = 32+12;
            
            UILabel * lblHatchbackcar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy, mainView.frame.size.width,14)];
            lblHatchbackcar.textColor= [UIColor blackColor];
            lblHatchbackcar.backgroundColor=[UIColor clearColor];
            lblHatchbackcar.textAlignment=NSTextAlignmentCenter;
            lblHatchbackcar.text = [TSLanguageManager localizedString:@"Hatchback"];
            lblHatchbackcar.textColor = [UIColor grayColor];
            lblHatchbackcar.font = [UIFont boldSystemFontOfSize:12];
            [mainView addSubview:lblHatchbackcar];
            
            yyy = yyy + 23;
            
            UILabel * lblHatchbackcarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy, mainView.frame.size.width,12)];
            lblHatchbackcarDetail.textColor= [UIColor grayColor];
            lblHatchbackcarDetail.backgroundColor=[UIColor clearColor];
            lblHatchbackcarDetail.textAlignment=NSTextAlignmentCenter;
            lblHatchbackcarDetail.text = @"Total 969 cars listed";
            lblHatchbackcarDetail.font = [UIFont systemFontOfSize:10];
            [mainView addSubview:lblHatchbackcarDetail];
            
            UIView * mainView1  = [[UIView alloc ]init];
            if (IS_IPAD)
            {
                mainView1.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
            }
            else
            {
                mainView1.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
            }
            mainView1.backgroundColor = [UIColor whiteColor];
            mainView1.layer.cornerRadius = 3.0f;
            mainView1.layer.shadowOffset = CGSizeMake(0, 0);
            mainView1.layer.shadowRadius = 5.0;
            mainView1.layer.shadowOpacity = 0.50f;
            mainView1.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
            [scrollContent addSubview:mainView1];
        
            UIImageView* imgSedanCar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView1.frame.size.width/2-64/2,-32, 64, 64)];
            imgSedanCar.image = [UIImage imageNamed:@"sedan"];
            imgSedanCar.clipsToBounds = YES;
            imgSedanCar.contentMode = UIViewContentModeScaleAspectFill;
            [mainView1 addSubview:imgSedanCar];
            
            int yyy1 = 32+12;
            
            UILabel * lblSedanCar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, mainView1.frame.size.width,14)];
            lblSedanCar.textColor= [UIColor blackColor];
            lblSedanCar.backgroundColor=[UIColor clearColor];
            lblSedanCar.textAlignment=NSTextAlignmentCenter;
            lblSedanCar.text =[TSLanguageManager localizedString:@"Sedan"];
            lblSedanCar.textColor = [UIColor grayColor];
            lblSedanCar.font = [UIFont boldSystemFontOfSize:12];
            [mainView1 addSubview:lblSedanCar];
            
            yyy1 = yyy1 + 23;
            
            UILabel * lblSedanCarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, mainView1.frame.size.width,11)];
            lblSedanCarDetail.textColor= [UIColor grayColor];
            lblSedanCarDetail.backgroundColor=[UIColor clearColor];
            lblSedanCarDetail.textAlignment=NSTextAlignmentCenter;
            lblSedanCarDetail.text = [TSLanguageManager localizedString: @"Total 969 cars listed"];
            lblSedanCarDetail.font = [UIFont systemFontOfSize:10];
            [mainView1 addSubview:lblSedanCarDetail];
            
            yy1=yy1+150;
            
            UIView * mainView2  = [[UIView alloc ]init];
            if (IS_IPAD)
            {
                mainView2.frame = CGRectMake(95,yy1,deviceWidth-85,90);
            }
            else
            {
                mainView2.frame = CGRectMake(14,yy1,deviceWidth-20,90);
            }
            mainView2.backgroundColor = [UIColor whiteColor];
            mainView2.layer.cornerRadius = 3.0f;
            mainView2.layer.shadowOffset = CGSizeMake(0, 0);
            mainView2.layer.shadowRadius = 5.0;
            mainView2.layer.shadowOpacity = 0.50f;
            mainView2.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
            [scrollContent addSubview:mainView2];
        
            
            
            UIImageView* imgSUVCar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView2.frame.size.width/2-64/2,-32, 64, 64)];
            imgSUVCar.image = [UIImage imageNamed:@"SUV"];
            imgSUVCar.clipsToBounds = YES;
            imgSUVCar.contentMode = UIViewContentModeScaleAspectFill;
            [mainView2 addSubview:imgSUVCar];
            
            int yyy2 = 32+12;
            
            UILabel * lblSUVCar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2, mainView2.frame.size.width,14)];
            lblSUVCar.textColor= [UIColor grayColor];
            lblSUVCar.backgroundColor=[UIColor clearColor];
            lblSUVCar.textAlignment=NSTextAlignmentCenter;
            lblSUVCar.text = [TSLanguageManager localizedString:@"SUV/MUV"];
            lblSUVCar.font = [UIFont boldSystemFontOfSize:12];
            [mainView2 addSubview:lblSUVCar];
            
            yyy2 = yyy2 + 23;
            
            UILabel * lblSUVCarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2, mainView2.frame.size.width,12)];
            lblSUVCarDetail.textColor= [UIColor grayColor];
            lblSUVCarDetail.backgroundColor=[UIColor clearColor];
            lblSUVCarDetail.textAlignment=NSTextAlignmentCenter;
            lblSUVCarDetail.text = [TSLanguageManager localizedString:@"Total 969 cars listed"];
            lblSUVCarDetail.font = [UIFont systemFontOfSize:10];
            [mainView2 addSubview:lblSUVCarDetail];
            
            
            
            UIView * mainView3  = [[UIView alloc ]init];
            if (IS_IPAD)
            {
                mainView3.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
            }
            else
            {
                mainView3.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
            }
            mainView3.backgroundColor = [UIColor whiteColor];
            mainView3.layer.cornerRadius = 3.0f;
            mainView3.layer.shadowOffset = CGSizeMake(0, 0);
            mainView3.layer.shadowRadius = 5.0;
            mainView3.layer.shadowOpacity = 0.50f;
            mainView3.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
            [scrollContent addSubview:mainView3];
        
            UIImageView* imgPetrolCar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView3.frame.size.width/2-64/2,-32, 64, 64)];
            imgPetrolCar.image = [UIImage imageNamed:@"petrol"];
            imgPetrolCar.clipsToBounds = YES;
            imgPetrolCar.contentMode = UIViewContentModeScaleAspectFill;
            [mainView3 addSubview:imgPetrolCar];
            
            int yyy3 = 32+12;
            
            UILabel * lblPetrolCar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3,mainView3.frame.size.width,14)];
            lblPetrolCar.textColor= [UIColor grayColor];
            lblPetrolCar.backgroundColor=[UIColor clearColor];
            lblPetrolCar.text = [TSLanguageManager localizedString:@"Petrol cars"];
            lblPetrolCar.textAlignment=NSTextAlignmentCenter;
            lblPetrolCar.font = [UIFont boldSystemFontOfSize:12];
            [mainView3 addSubview:lblPetrolCar];
            
            yyy3 = yyy3 + 23;
            
            UILabel * lblPetrolCarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3, mainView3.frame.size.width,12)];
            lblPetrolCarDetail.textColor= [UIColor grayColor];
            lblPetrolCarDetail.backgroundColor=[UIColor clearColor];
            lblPetrolCarDetail.text = [TSLanguageManager localizedString:@"Total 969 cars listed"];
            lblPetrolCarDetail.textAlignment=NSTextAlignmentCenter;
            lblPetrolCarDetail.font = [UIFont systemFontOfSize:10];
            [mainView3 addSubview:lblPetrolCarDetail];
    }
    else
    {
        yy1=yy1+50;
        int deviceWidth = scrollContent.frame.size.width/2;
        
        UIView * mainView1;
        mainView1  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            mainView1.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            mainView1.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
        mainView1.backgroundColor = [UIColor whiteColor];
        mainView1.layer.cornerRadius = 3.0f;
        mainView1.layer.shadowOffset = CGSizeMake(0, 0);
        mainView1.layer.shadowRadius = 5.0;
        mainView1.layer.shadowOpacity = 0.50f;
        mainView1.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        
        [scrollContent addSubview:mainView1];
        
        
        UIImageView* imgSedanCar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView1.frame.size.width/2-64/2,-32, 64, 64)];
        imgSedanCar.image = [UIImage imageNamed:@"sedan"];
        imgSedanCar.clipsToBounds = YES;
        imgSedanCar.contentMode = UIViewContentModeScaleAspectFill;
        [mainView1 addSubview:imgSedanCar];
        
        int yyy1 = 32+12;
        
        UILabel * lblSedanCar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, mainView1.frame.size.width,14)];
        lblSedanCar.textColor= [UIColor blackColor];
        lblSedanCar.backgroundColor=[UIColor clearColor];
        lblSedanCar.textAlignment=NSTextAlignmentCenter;
        lblSedanCar.text = [TSLanguageManager localizedString:@"Sedan"];
        lblSedanCar.textColor = [UIColor grayColor];
        lblSedanCar.font = [UIFont boldSystemFontOfSize:12];
        [mainView1 addSubview:lblSedanCar];
        
        yyy1 = yyy1 + 23;
        
        UILabel * lblSedanCarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, mainView1.frame.size.width,12)];
        lblSedanCarDetail.textColor= [UIColor grayColor];
        lblSedanCarDetail.backgroundColor=[UIColor clearColor];
        lblSedanCarDetail.textAlignment=NSTextAlignmentCenter;
        lblSedanCarDetail.text = [TSLanguageManager localizedString:@"Total 969 cars listed"];
        lblSedanCarDetail.font = [UIFont systemFontOfSize:10];
        [mainView1 addSubview:lblSedanCarDetail];
        
        UIView * mainView;
        mainView  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            mainView.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            mainView.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
        mainView.backgroundColor = [UIColor whiteColor];
        mainView.layer.cornerRadius = 3.0f;
        mainView.layer.shadowOffset = CGSizeMake(0, 0);
        mainView.layer.shadowRadius = 5.0;
        mainView.layer.shadowOpacity = 0.50f;
        mainView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:mainView];
        
        
        UIImageView* imgHatchbackcar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView.frame.size.width/2-64/2,-32, 64, 64)];
        imgHatchbackcar.image = [UIImage imageNamed:@"hatchback"];
        imgHatchbackcar.clipsToBounds = YES;
        imgHatchbackcar.contentMode = UIViewContentModeScaleAspectFill;
        [mainView addSubview:imgHatchbackcar];
        
        int yyy = 32+12;
        
        UILabel * lblHatchbackcar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy, mainView.frame.size.width,14)];
        lblHatchbackcar.textColor= [UIColor blackColor];
        lblHatchbackcar.backgroundColor=[UIColor clearColor];
        lblHatchbackcar.textAlignment=NSTextAlignmentCenter;
        lblHatchbackcar.text =[TSLanguageManager localizedString:@"Hatchback"];
        lblHatchbackcar.textColor = [UIColor grayColor];
        lblHatchbackcar.font = [UIFont boldSystemFontOfSize:12];
        [mainView addSubview:lblHatchbackcar];
        
        yyy = yyy + 23;
        
        UILabel * lblHatchbackcarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy, mainView.frame.size.width,11)];
        lblHatchbackcarDetail.textColor= [UIColor grayColor];
        lblHatchbackcarDetail.backgroundColor=[UIColor clearColor];
        lblHatchbackcarDetail.textAlignment=NSTextAlignmentCenter;
        lblHatchbackcarDetail.text = [TSLanguageManager localizedString:@"Total 969 cars listed"];
        lblHatchbackcarDetail.font = [UIFont systemFontOfSize:10];
        [mainView addSubview:lblHatchbackcarDetail];
        
        
        
        yy1=yy1+150;
        
        UIView * mainView3;
        mainView3  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            mainView3.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            mainView3.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
        mainView3.backgroundColor = [UIColor whiteColor];
        mainView3.layer.cornerRadius = 3.0f;
        mainView3.layer.shadowOffset = CGSizeMake(0, 0);
        mainView3.layer.shadowRadius = 5.0;
        mainView3.layer.shadowOpacity = 0.50f;
        mainView3.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:mainView3];
        
        
        UIImageView* imgPetrolCar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView3.frame.size.width/2-64/2,-32, 64, 64)];
        imgPetrolCar.image = [UIImage imageNamed:@"petrol"];
        imgPetrolCar.clipsToBounds = YES;
        imgPetrolCar.contentMode = UIViewContentModeScaleAspectFill;
        [mainView3 addSubview:imgPetrolCar];
        
        int yyy3 = 32+12;
        
        UILabel * lblPetrolCar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3, mainView3.frame.size.width,14)];
        lblPetrolCar.textColor= [UIColor grayColor];
        lblPetrolCar.backgroundColor=[UIColor clearColor];
        lblPetrolCar.text =[TSLanguageManager localizedString:@"Petrol cars"];
        lblPetrolCar.textAlignment=NSTextAlignmentCenter;
        lblPetrolCar.font = [UIFont boldSystemFontOfSize:12];
        [mainView3 addSubview:lblPetrolCar];
        
        yyy3 = yyy3 + 23;
        
        UILabel * lblPetrolCarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3, mainView3.frame.size.width,12)];
        lblPetrolCarDetail.textColor= [UIColor grayColor];
        lblPetrolCarDetail.backgroundColor=[UIColor clearColor];
        lblPetrolCarDetail.text =[TSLanguageManager localizedString:@"Total 969 cars listed"];
        lblPetrolCarDetail.textAlignment=NSTextAlignmentCenter;
        lblPetrolCarDetail.font = [UIFont systemFontOfSize:10];
        [mainView3 addSubview:lblPetrolCarDetail];
        
        UIView * mainView2;
        mainView2  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            mainView2.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            mainView2.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
        mainView2.backgroundColor = [UIColor whiteColor];
        mainView2.layer.cornerRadius = 3.0f;
        mainView2.layer.shadowOffset = CGSizeMake(0, 0);
        mainView2.layer.shadowRadius = 5.0;
        mainView2.layer.shadowOpacity = 0.50f;
        mainView2.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:mainView2];
        
        UIImageView* imgSUVCar = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainView2.frame.size.width/2-64/2,-32, 64, 64)];
        imgSUVCar.image = [UIImage imageNamed:@"SUV"];
        imgSUVCar.clipsToBounds = YES;
        imgSUVCar.contentMode = UIViewContentModeScaleAspectFill;
        [mainView2 addSubview:imgSUVCar];
        
        int yyy2 = 32+12;
        
        UILabel * lblSUVCar =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2,mainView3.frame.size.width,14)];
        lblSUVCar.textColor= [UIColor grayColor];
        lblSUVCar.backgroundColor=[UIColor clearColor];
        lblSUVCar.textAlignment=NSTextAlignmentCenter;
        lblSUVCar.text =[TSLanguageManager localizedString:@"SUV/MUV"];
        lblSUVCar.font = [UIFont boldSystemFontOfSize:12];
        [mainView2 addSubview:lblSUVCar];
        
        yyy2 = yyy2 + 23;
        
        UILabel * lblSUVCarDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2, mainView2.frame.size.width,11)];
        lblSUVCarDetail.textColor= [UIColor grayColor];
        lblSUVCarDetail.backgroundColor=[UIColor clearColor];
        lblSUVCarDetail.textAlignment=NSTextAlignmentCenter;
        lblSUVCarDetail.text = [TSLanguageManager localizedString:@"Total 969 cars listed"];
        lblSUVCarDetail.font = [UIFont systemFontOfSize:10];
        [mainView2 addSubview:lblSUVCarDetail];
        
        
    }
   yy1 = yy1+150+14;
    
    UILabel * lblJustLaunchedCarLbl =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblJustLaunchedCarLbl.textColor= [UIColor blackColor];
    lblJustLaunchedCarLbl.backgroundColor=[UIColor clearColor];
    lblJustLaunchedCarLbl.textAlignment=NSTextAlignmentCenter;
    lblJustLaunchedCarLbl.text = [TSLanguageManager localizedString:@"CERTIFIED CARS"];
    lblJustLaunchedCarLbl.font = [UIFont boldSystemFontOfSize:15];
    [scrollContent addSubview:lblJustLaunchedCarLbl];
    
    yy1=yy1+8.5+18;
    UILabel * lblJustLaunchedCarLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1, 60,1)];
    lblJustLaunchedCarLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblJustLaunchedCarLine];
    
    yy1=yy1+1+14;
    
    self.recentLauchedCar=[[iCarousel alloc]initWithFrame:CGRectMake(-20,yy1 , DEVICE_WIDTH-90, 240)];
    
    self.recentSerchFlowLayout=[[RecentSerchCarFlowLayout alloc] init];
    certifiedCarCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 250) collectionViewLayout:self.recentSerchFlowLayout];
    [self.recentSerchFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [certifiedCarCollectionView setDataSource:self];
    [certifiedCarCollectionView setDelegate:self];
    certifiedCarCollectionView.showsVerticalScrollIndicator= NO;
    certifiedCarCollectionView.showsHorizontalScrollIndicator = NO;
    [certifiedCarCollectionView registerClass:[CertifiedCarCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [certifiedCarCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:certifiedCarCollectionView];
    
    yy1=yy1+250+11;
    
    btnViewAllUpcomingCar = [[UIButton alloc] init];
    btnViewAllUpcomingCar.frame  = CGRectMake(DEVICE_WIDTH/2-30,yy1 ,70,40 );
    [btnViewAllUpcomingCar addTarget:self action:@selector(btnViewAllUpcomingCar:) forControlEvents:UIControlEventTouchUpInside];
    [btnViewAllUpcomingCar setTitle:[TSLanguageManager localizedString:@"View all"] forState:UIControlStateNormal];
    [btnViewAllUpcomingCar setTitleColor:[UIColor colorWithRed:3.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [scrollContent addSubview:btnViewAllUpcomingCar];
    
    yy1=yy1+40+21;

    UILabel * lblTools =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblTools.textColor= [UIColor blackColor];
    lblTools.backgroundColor=[UIColor clearColor];
    lblTools.textAlignment=NSTextAlignmentCenter;
    lblTools.text = [TSLanguageManager localizedString:@"TOOLS YOU CAN USE"];
    lblTools.font = [UIFont boldSystemFontOfSize:15];
    [scrollContent addSubview:lblTools];
    
    yy1 =yy1+18+8.5;
    
    UILabel * lblToolsBYLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1, 60,1)];
    lblToolsBYLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblToolsBYLine];
    
  
    if(IS_IPHONE_5)
    {
        yy1=yy1+31;
    }
    if(IS_IPHONE_6plus)
    {
        yy1=yy1+8;
    }
    if(IS_IPAD)
    {
        yy1=yy1+2;
    }
    else
    {
        yy1=yy1+21;
    }


    UIImageView *backImageSecond = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackGround"]];
    if(IS_IPAD)
    {
        backImageSecond.frame = CGRectMake(0, yy1+30, DEVICE_WIDTH,148);
    }
    else
    {
         backImageSecond.frame = CGRectMake(0, yy1+30, DEVICE_WIDTH,148);
    }
    backImageSecond.userInteractionEnabled=YES;
    backImageSecond.clipsToBounds=YES;
    backImageSecond.contentMode=UIViewContentModeScaleToFill;
    [scrollContent addSubview:backImageSecond];
    
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        yy1=yy1+68;
        int deviceWidth = scrollContent.frame.size.width/2;
    UIView * mainNewView;
    mainNewView  = [[UIView alloc ]init];
    if (IS_IPAD)
    {
        mainNewView.frame = CGRectMake(95,yy1,deviceWidth-85,90);
    }
    else
    {
        mainNewView.frame = CGRectMake(14,yy1,deviceWidth-20,90);
    }
    mainNewView.backgroundColor = [UIColor whiteColor];
    mainNewView.layer.cornerRadius = 3.0f;
    mainNewView.layer.shadowOffset = CGSizeMake(0, 0);
    mainNewView.layer.shadowRadius = 5.0;
    mainNewView.layer.shadowOpacity = 0.50f;
    mainNewView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    [scrollContent addSubview:mainNewView];

    UIImageView* imgRightPrice = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainNewView.frame.size.width/2-64/2,-32, 64, 64)];
    imgRightPrice.image = [UIImage imageNamed:@"right-price"];
    imgRightPrice.clipsToBounds = YES;
    imgRightPrice.contentMode = UIViewContentModeScaleAspectFill;
    [mainNewView addSubview:imgRightPrice];

    int yyyy = 32+12;

    UILabel * lblRightPrice =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy, mainNewView.frame.size.width,14)];
    lblRightPrice.textColor= [UIColor blackColor];
    lblRightPrice.backgroundColor=[UIColor clearColor];
    lblRightPrice.textAlignment=NSTextAlignmentCenter;
    lblRightPrice.text = [TSLanguageManager localizedString: @"Right Price"];
    lblRightPrice.textColor = [UIColor grayColor];
    lblRightPrice.font = [UIFont boldSystemFontOfSize:12];
    [mainNewView addSubview:lblRightPrice];

    yyyy = yyyy + 23;

    UILabel * lblRightPriceDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy, mainNewView.frame.size.width,12)];
    lblRightPriceDetail.textColor= [UIColor grayColor];
    lblRightPriceDetail.backgroundColor=[UIColor clearColor];
    lblRightPriceDetail.textAlignment=NSTextAlignmentCenter;
    lblRightPriceDetail.text =[TSLanguageManager localizedString: @"Check market value"];
    lblRightPriceDetail.font = [UIFont systemFontOfSize:10];
    [mainNewView addSubview:lblRightPriceDetail];

    UIView * mainNewView1;
    mainNewView1  = [[UIView alloc ]init];
    if (IS_IPAD)
    {
            mainNewView1.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
    }
    else
    {
            mainNewView1.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
    }
    mainNewView1.backgroundColor = [UIColor whiteColor];
    mainNewView1.layer.cornerRadius = 3.0f;
    mainNewView1.layer.shadowOffset = CGSizeMake(0, 0);
    mainNewView1.layer.shadowRadius = 5.0;
    mainNewView1.layer.shadowOpacity = 0.50f;
    mainNewView1.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    [scrollContent addSubview:mainNewView1];

    UIImageView* imgBodytType =  [[AsyncImageView alloc]initWithFrame:CGRectMake(mainNewView1.frame.size.width/2-64/2,-32, 64, 64)];
    imgBodytType.image = [UIImage imageNamed:@"bodytype"];
    imgBodytType.clipsToBounds = YES;
    imgBodytType.contentMode = UIViewContentModeScaleAspectFill;
    [mainNewView1 addSubview:imgBodytType];

    int yyyy1 = 32+12;

    UILabel * lblBodytType =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy1, mainNewView1.frame.size.width,14)];
    lblBodytType.textColor= [UIColor blackColor];
    lblBodytType.backgroundColor=[UIColor clearColor];
    lblBodytType.textAlignment=NSTextAlignmentCenter;
    lblBodytType.text = [TSLanguageManager localizedString:@"Sell Car"];
    lblBodytType.textColor = [UIColor grayColor];
    lblBodytType.font = [UIFont boldSystemFontOfSize:12];
    [mainNewView1 addSubview:lblBodytType];

    yyyy1 = yyyy1 + 23;
    
    UILabel * lblNewEmail1 =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy1, mainNewView1.frame.size.width,11)];
    lblNewEmail1.textColor= [UIColor grayColor];
    lblNewEmail1.backgroundColor=[UIColor clearColor];
    lblNewEmail1.textAlignment=NSTextAlignmentCenter;
    lblNewEmail1.text =[TSLanguageManager localizedString:@"Lists Cars in 3 steps"];
    lblNewEmail1.font = [UIFont systemFontOfSize:10];
    [mainNewView1 addSubview:lblNewEmail1];
    }
    else
    {
        yy1=yy1+68;
        int deviceWidth = scrollContent.frame.size.width/2;
        
        UIView * mainNewView1;
        mainNewView1  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            mainNewView1.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            mainNewView1.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
        mainNewView1.backgroundColor = [UIColor whiteColor];
        mainNewView1.layer.cornerRadius = 3.0f;
        mainNewView1.layer.shadowOffset = CGSizeMake(0, 0);
        mainNewView1.layer.shadowRadius = 5.0;
        mainNewView1.layer.shadowOpacity = 0.50f;
        mainNewView1.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:mainNewView1];
        
        
        UIImageView* imgBodytType = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainNewView1.frame.size.width/2-64/2,-32, 64, 64)];
        imgBodytType.image = [UIImage imageNamed:@"bodytype"];
        imgBodytType.clipsToBounds = YES;
        imgBodytType.contentMode = UIViewContentModeScaleAspectFill;
        [mainNewView1 addSubview:imgBodytType];
        
        int yyyy1 = 32+12;
        
        UILabel * lblBodytType =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy1, mainNewView1.frame.size.width,14)];
        lblBodytType.textColor= [UIColor blackColor];
        lblBodytType.backgroundColor=[UIColor clearColor];
        lblBodytType.textAlignment=NSTextAlignmentCenter;
        lblBodytType.text = [TSLanguageManager localizedString:@"Sell Car"];
        lblBodytType.textColor = [UIColor grayColor];
        lblBodytType.font = [UIFont boldSystemFontOfSize:12];
        [mainNewView1 addSubview:lblBodytType];
        
        yyyy1 = yyyy1 + 23;
        
        UILabel * lblNewEmail1 =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy1, mainNewView1.frame.size.width,12)];
        lblNewEmail1.textColor= [UIColor grayColor];
        lblNewEmail1.backgroundColor=[UIColor clearColor];
        lblNewEmail1.textAlignment=NSTextAlignmentCenter;
        lblNewEmail1.text =[TSLanguageManager localizedString:@"Lists Cars in 3 steps"];
        lblNewEmail1.font = [UIFont systemFontOfSize:11];
        [mainNewView1 addSubview:lblNewEmail1];
       
        UIView * mainNewView;
        mainNewView  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            mainNewView.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            mainNewView.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
        mainNewView.backgroundColor = [UIColor whiteColor];
        mainNewView.layer.cornerRadius = 3.0f;
        mainNewView.layer.shadowOffset = CGSizeMake(0, 0);
        mainNewView.layer.shadowRadius = 5.0;
        mainNewView.layer.shadowOpacity = 0.50f;
        mainNewView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:mainNewView];
        
        UIImageView* imgRightPrice = [[AsyncImageView alloc]initWithFrame:CGRectMake(mainNewView.frame.size.width/2-64/2,-32, 64, 64)];
        imgRightPrice.image = [UIImage imageNamed:@"right-price"];
        imgRightPrice.clipsToBounds = YES;
        imgRightPrice.contentMode = UIViewContentModeScaleAspectFill;
        [mainNewView addSubview:imgRightPrice];
        
        int yyyy = 32+12;
        
        UILabel * lblRightPrice =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy, mainNewView.frame.size.width,14)];
        lblRightPrice.textColor= [UIColor blackColor];
        lblRightPrice.backgroundColor=[UIColor clearColor];
        lblRightPrice.textAlignment=NSTextAlignmentCenter;
        lblRightPrice.text =[TSLanguageManager localizedString:@"Right Price"];
        lblRightPrice.textColor = [UIColor grayColor];
        lblRightPrice.font = [UIFont boldSystemFontOfSize:13];
        [mainNewView addSubview:lblRightPrice];
        
        yyyy = yyyy + 23;
        
        UILabel * lblRightPriceDetail =[[UILabel alloc]initWithFrame:CGRectMake(0,yyyy, mainNewView.frame.size.width,11)];
        lblRightPriceDetail.textColor= [UIColor grayColor];
        lblRightPriceDetail.backgroundColor=[UIColor clearColor];
        lblRightPriceDetail.textAlignment=NSTextAlignmentCenter;
        lblRightPriceDetail.text =[TSLanguageManager localizedString:@"Check market value"];
        lblRightPriceDetail.font = [UIFont systemFontOfSize:10];
        [mainNewView addSubview:lblRightPriceDetail];
        
        
    }
     yy1 = yy1+150+24;
    
    UILabel * lblCertifiedCar =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblCertifiedCar.textColor= [UIColor blackColor];
    lblCertifiedCar.backgroundColor=[UIColor clearColor];
    lblCertifiedCar.textAlignment=NSTextAlignmentCenter;
    lblCertifiedCar.text =[TSLanguageManager localizedString:@"RECENTLY ADDED CARS"];
    lblCertifiedCar.font = [UIFont boldSystemFontOfSize:15.0f];
    [scrollContent addSubview:lblCertifiedCar];
    
    yy1=yy1+18+8.5;
    
    UILabel * lblCertifiedCarLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+8.5, 60,1)];
    lblCertifiedCarLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblCertifiedCarLine];
    
    yy1=yy1+21+1;
    
    self.certifiedCar=[[iCarousel alloc]initWithFrame:CGRectMake(-20,yy1 , DEVICE_WIDTH-90, 245)];
    
    self.recentSerchFlowLayout=[[RecentSerchCarFlowLayout alloc] init];
    recentAddCarCollectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 250) collectionViewLayout:self.recentSerchFlowLayout];
    [self.recentSerchFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [recentAddCarCollectionview setDataSource:self];
    [recentAddCarCollectionview setDelegate:self];
    recentAddCarCollectionview.showsVerticalScrollIndicator= NO;
    recentAddCarCollectionview.showsHorizontalScrollIndicator = NO;
    [recentAddCarCollectionview registerClass:[RecentAddCarcellCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [recentAddCarCollectionview setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:recentAddCarCollectionview];
    
    yy1=yy1+250+11;
    
    UIButton *btnAllCompareCars = [[UIButton alloc] init];
    btnAllCompareCars.frame  = CGRectMake(DEVICE_WIDTH/2-30,yy1 ,70,40 );
    [btnAllCompareCars addTarget:self action:@selector(btnAllCompareCarsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnAllCompareCars setTitle:[TSLanguageManager localizedString:@"View all"] forState:UIControlStateNormal];
    [btnAllCompareCars setTitleColor:[UIColor colorWithRed:3.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [scrollContent addSubview:btnAllCompareCars];

    yy1=yy1+46;
    
    [scrollContent setContentSize:CGSizeMake(DEVICE_WIDTH, yy1+60)];
    
}


- (void)scrollToBottomAnimated:(BOOL)animated
{
    if(recentSearchCarCollectionView)
    {
        if ([GetCarModelArray count]>0)
        {
            [recentSearchCarCollectionView reloadData];
            NSInteger section = [recentSearchCarCollectionView numberOfSections] - 1;
            NSInteger item = [recentSearchCarCollectionView numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [recentSearchCarCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }
    if(certifiedCarCollectionView)
    {
        if ([GetCarModelArray count]>0)
        {
            [certifiedCarCollectionView reloadData];
            NSInteger section = [certifiedCarCollectionView numberOfSections] - 1;
            NSInteger item = [certifiedCarCollectionView numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [certifiedCarCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }
    if(recentAddCarCollectionview)
    {
        if ([GetCarModelArray count]>0)
        {
            [recentAddCarCollectionview reloadData];
            NSInteger section = [recentAddCarCollectionview numberOfSections] - 1;
            NSInteger item = [recentAddCarCollectionview numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [recentAddCarCollectionview scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }
}
#pragma mark - Button Click Event
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        }];
    }
    else
    {
        [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        }];
    }
    
}
-(void)btnViewAllUpcomingCar:(id)sender
{

}
-(void)btnFindCarClicked:(id)sender
{
    usedCarListVC *usdecarVC =[[usedCarListVC alloc] init];
    [self.navigationController pushViewController:usdecarVC animated:YES];
}
-(void)selectCity:(id)sender
{
    SelectCityVC * destinationForRegister = [[SelectCityVC alloc ]init];
    [self.navigationController pushViewController:destinationForRegister animated:YES];
}


#pragma mark - Range Slider
- (void)changePriceRange:(TTRangeSlider *)sender
{
   
}
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum;
{
    if(selectedMinimum==1.0f && selectedMaximum==30.f)
    {
         lblRange.text =@"All Range";
    }
    else
    {
        lblRange.text =[NSString stringWithFormat:@"$ %.0f - $ %.0f", sender.selectedMinimum, sender.selectedMaximum];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Uicollectionview Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView==recentSearchCarCollectionView)
    {
        return [GetCarModelArray count];
    }
    if(collectionView==certifiedCarCollectionView)
    {
        return [GetCarModelArray count];
    }
    if(collectionView==recentAddCarCollectionview)
    {
        return [GetCarModelArray count];
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == recentSearchCarCollectionView)
    {
        RecentSerchCarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"model_image"]];
        cell.imgCar1.imageURL=url;
        
        cell.lblCarName1.text=[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"car_model_name"];
        
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@",[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"currency_symbol"],[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"price"]];
        cell.lblCarPrice.text=strigPrice ;
        cell.yearlbl.text =@"2018";
        cell.totalDrivenLbl.text = @"5000Km";
        cell.fuelTypeLbl.text =[TSLanguageManager localizedString:@"Petrol"];
       // cell.lblCarLauchDate.text=[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"launching_date"];
        return cell;
    }
    if(collectionView == certifiedCarCollectionView)
    {
        CertifiedCarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"model_image"]];
        cell.imgCar1.imageURL=url;
        
        cell.lblCarName1.text=[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"car_model_name"];;
        
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@",[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"currency_symbol"],[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"price"]];
        cell.lblCarPrice.text=strigPrice ;
        cell.lblCarLauchDate.text=[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"launching_date"];
        cell.yearlbl.text =@"2018";
        cell.totalDrivenLbl.text = @"5000Km";
        cell.fuelTypeLbl.text =[TSLanguageManager localizedString:@"Petrol"];
        return cell;
    }
    if(collectionView == recentAddCarCollectionview)
    {
        RecentAddCarcellCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"model_image"]];
        cell.imgCar1.imageURL=url;
        
        cell.lblCarName1.text=[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"car_model_name"];;
        
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@",[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"currency_symbol"],[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"price"]];
        cell.lblCarPrice.text=strigPrice ;
        cell.lblCarLauchDate.text=[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"launching_date"];
        cell.yearlbl.text =@"2018";
        cell.totalDrivenLbl.text = @"5000Km";
        cell.fuelTypeLbl.text =[TSLanguageManager localizedString:@"Petrol"];
        return cell;
    }
    return nil;
}


#pragma mark -iCarousel Delegate

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    if(carousel == _recentLauchedCar)
    {
        return [GetCarModelArray count];
    }
    else if(carousel == _recentSearchCar)
    {
        return [GetCarModelArray count];
    }
    else
    {
        return [GetCarModelArray count];
    }
}


- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if(carousel == _recentLauchedCar)
    {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH-150,220)];
        view.layer.shadowColor = [UIColor grayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 1.0;
        view.backgroundColor = [UIColor whiteColor];
    
        AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
        NSURL *url = [NSURL URLWithString:[[GetCarModelArray objectAtIndex:index]valueForKey:@"model_image"]];
        imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgCar1];
    
        int y=115;
        UILabel * lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarName1.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarName1.textColor=[UIColor grayColor];
        lblCarName1.text=[[GetCarModelArray objectAtIndex:index]valueForKey:@"car_model_name"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
    
        y=y+25;
    
        UILabel * lblCarLauchDate=[[UILabel alloc] init];
    
        lblCarLauchDate.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarLauchDate.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarLauchDate.textColor=[UIColor grayColor];
        lblCarLauchDate.text=[[GetCarModelArray objectAtIndex:index]valueForKey:@"launching_date"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarLauchDate];
        
        y=y+25;
    
        UILabel * lblCarPrice=[[UILabel alloc] init];
        lblCarPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarPrice.textColor=[UIColor blackColor];
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@",[[GetCarModelArray objectAtIndex:index]valueForKey:@"currency_symbol"],[[GetCarModelArray objectAtIndex:index]valueForKey:@"price"]];
    lblCarPrice.text=strigPrice;
    lblCarPrice.clipsToBounds=YES;
    [view addSubview:lblCarPrice];
    
    y=y+25;
    
    UILabel * lblEstimetedPrice=[[UILabel alloc] init];
    lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
    lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:15.0];
    lblEstimetedPrice.textColor=[UIColor grayColor];
    lblEstimetedPrice.text=@"Estimated price";
    lblEstimetedPrice.clipsToBounds=YES;
    [view addSubview:lblEstimetedPrice];
    
}
    
  else  if(carousel == _certifiedCar)
    {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH-150,220)];
        view.layer.shadowColor = [UIColor grayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 1.0;
        view.backgroundColor = [UIColor whiteColor];
        
        AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
        NSURL *url = [NSURL URLWithString:[[GetCarModelArray objectAtIndex:index]valueForKey:@"model_image"]];
        imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgCar1];
        
        int y=115;
        UILabel * lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarName1.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarName1.textColor=[UIColor grayColor];
        lblCarName1.text=[[GetCarModelArray objectAtIndex:index]valueForKey:@"car_model_name"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        y=y+25;
        
        UILabel * lblCarLauchDate=[[UILabel alloc] init];
        
        lblCarLauchDate.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarLauchDate.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarLauchDate.textColor=[UIColor grayColor];
        lblCarLauchDate.text=[[GetCarModelArray objectAtIndex:index]valueForKey:@"launching_date"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarLauchDate];
        
        
        y=y+25;
        
        UILabel * lblCarPrice=[[UILabel alloc] init];
        lblCarPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarPrice.textColor=[UIColor blackColor];
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@",[[GetCarModelArray objectAtIndex:index]valueForKey:@"currency_symbol"],[[GetCarModelArray objectAtIndex:index]valueForKey:@"price"]];
        lblCarPrice.text=strigPrice;
        lblCarPrice.clipsToBounds=YES;
        [view addSubview:lblCarPrice];

        y=y+25;
        
        UILabel * lblEstimetedPrice=[[UILabel alloc] init];
        lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblEstimetedPrice.textColor=[UIColor grayColor];
        lblEstimetedPrice.text=@"Estimated price";
        lblEstimetedPrice.clipsToBounds=YES;
        [view addSubview:lblEstimetedPrice];
    }
    
    else if(carousel == _recentSearchCar)
    {
        
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH-150,220)];
        view.layer.shadowColor = [UIColor grayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 1.0;
        view.backgroundColor = [UIColor whiteColor];
        
        AsyncImageView * imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
        NSURL *url = [NSURL URLWithString:[[GetCarModelArray objectAtIndex:index]valueForKey:@"model_image"]];
        imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgCar1];
        
        int y=115;
        UILabel * lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarName1.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarName1.textColor=[UIColor grayColor];
        lblCarName1.text=[[GetCarModelArray objectAtIndex:index]valueForKey:@"car_model_name"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        y=y+25;
        
        UILabel * lblCarLauchDate=[[UILabel alloc] init];
        
        lblCarLauchDate.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarLauchDate.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarLauchDate.textColor=[UIColor grayColor];
        lblCarLauchDate.text=[[GetCarModelArray objectAtIndex:index]valueForKey:@"launching_date"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarLauchDate];
        
        
        y=y+25;
        
        UILabel * lblCarPrice=[[UILabel alloc] init];
        lblCarPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarPrice.textColor=[UIColor blackColor];
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@",[[GetCarModelArray objectAtIndex:index]valueForKey:@"currency_symbol"],[[GetCarModelArray objectAtIndex:index]valueForKey:@"price"]];
        lblCarPrice.text=strigPrice;
        lblCarPrice.clipsToBounds=YES;
        [view addSubview:lblCarPrice];
        
        y=y+25;
        
        UILabel * lblEstimetedPrice=[[UILabel alloc] init];
        lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblEstimetedPrice.textColor=[UIColor grayColor];
        lblEstimetedPrice.text=@"Estimated price";
        lblEstimetedPrice.clipsToBounds=YES;
        [view addSubview:lblEstimetedPrice];
        
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
    if (carousel==self.recentLauchedCar)
    {
        transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
        return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.recentLauchedCar.itemWidth);
    }
    if(carousel==self.recentSearchCar)
    {
        transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
        return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.recentSearchCar.itemWidth);
    }
    else
    {
        transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
        return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.certifiedCar.itemWidth);
    }
    
    
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
           
            if (self.recentLauchedCar.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            if(self.recentSearchCar.type == iCarouselTypeCustom)
            {
                return 0.0f;
            }
            if (self.certifiedCar.type == iCarouselTypeCustom)
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

#pragma mark - Webservice
-(void)GetcarModels
{
   
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        NSString * webServiceName = @"getModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getModels";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}
-(void)onResult:(NSDictionary *)result
{
   
   if ([[result valueForKey:@"commandName"] isEqualToString:@"getModels"])
    {
        NSLog(@"%@response",result);
        GetCarModelArray = [[result valueForKey:@"result"] valueForKey:@"car_model"];
        [recentAddCarCollectionview reloadData];
        [recentSearchCarCollectionView reloadData];
        [certifiedCarCollectionView reloadData];
    }
    if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        
    }
    else
    {
        GetCarModelArray = (NSMutableArray*) [[GetCarModelArray reverseObjectEnumerator]allObjects];
        [self scrollToBottomAnimated:YES];
    }
    
}
-(void)onError:(NSError *)error
{
    NSLog(@"Error Message =====>%@",error);
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
