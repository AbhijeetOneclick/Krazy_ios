//
//  NewHomeVC.m
//  carwale
//
//  Created by i-MaC on 11/10/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "NewHomeVC.h"
#import "SerchCarVC.h"
#import "popularCarCell.h"
#import "upcomingCarCollectionCell.h"
#import "justLaunchCarCollectionCell.h"
#import "NewsCollectionViewCell.h"
#import "VideoCarCollectionViewCell.h"
#import "PhotoCarCollectionCell.h"
#import "FilterCarVC.h"
#import "ParallaxHeaderView.h"
#import "compareCarCell.h"

#define NAVBAR_CHANGE_POINT -80


@interface NewHomeVC ()

@end

@implementation NewHomeVC
@synthesize LocationView,CompareCarArry,GetCarModelArray,GetNewsArray,arrUpcomingCars,arrLaunchedCars,popularCarCollectionView,compareCarCollectionview,justLaunchedCollectionView,newsCollectionview,upcomingCarCollectionview,photoCarCollectionView,VideoCollectionView,upcomingCarFlow,justLauchFlow,NewsCarFlow;

#pragma mark -Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
   
    CompareCarArry = [[NSMutableArray alloc] init];
    GetCarModelArray = [[NSMutableArray alloc]init];
    GetNewsArray = [[NSMutableArray alloc]init];
    arrUpcomingCars = [[NSMutableArray alloc] init];
    arrLaunchedCars = [[NSMutableArray alloc] init];
    

    [self setFrame];
    [self locationViewFrame];

  
    if(!isFirstLocationPopUp)
    {
        presentView.hidden=NO;
        BackView.hidden=NO;
        LocationView.hidden=NO;
        isFirstLocationPopUp = YES;
    }
    [APP_DELEGATE preferredStatusBarStyle];
    [self compareCarWebServices];
    
    [self GetPopularcarModels];
    [self getUpcomingcarModels];
    [self getLaunchedCars];
    [self GetNews];
}

#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"progress %f", scrollContent.parallaxHeader.progress);
    UIColor * color = [UIColor colorWithRed:7/255.0 green:99/255.0 blue:150/255.0 alpha:1];
    CGFloat offsetY = scrollContent.contentOffset.y;
    NSLog(@"progress=====> %f", offsetY);
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 20 - offsetY) / 20));
        [navView setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [navView setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark Properties

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    scrollContent.parallaxHeader.minimumHeight = self.topLayoutGuide.length;
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
        CompareCarArry = (NSMutableArray*) [[CompareCarArry reverseObjectEnumerator]allObjects];
        arrLaunchedCars =(NSMutableArray*) [[arrLaunchedCars reverseObjectEnumerator]allObjects];
        arrUpcomingCars =(NSMutableArray*) [[arrUpcomingCars reverseObjectEnumerator]allObjects];
        GetNewsArray = (NSMutableArray*) [[GetNewsArray reverseObjectEnumerator]allObjects];
        arrUpcomingCars=(NSMutableArray*) [[arrUpcomingCars reverseObjectEnumerator]allObjects];
        [self scrollToBottomAnimated:YES];
    }
}

#pragma mark -ScrollView
-(void)setFrame
{
    
     [APP_DELEGATE preferredStatusBarStyle];
   //==============================Header View===================================//
    
    scrollContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    scrollContent.backgroundColor = [UIColor whiteColor];
    scrollContent.bounces = NO;
    if(!IS_IPHONE_X){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    scrollContent.contentInset = UIEdgeInsetsMake(0,0,0,0);
    scrollContent.showsVerticalScrollIndicator = NO;
    scrollContent.showsHorizontalScrollIndicator = NO;
    scrollContent.clipsToBounds =YES;
    [self.view addSubview:scrollContent];
    
    backGroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hero-image"]];
    if(IS_IPHONE_X)
    {
        backGroundImg.frame = CGRectMake(0, 0,DEVICE_WIDTH,300);
    }
    else
    {
        backGroundImg.frame = CGRectMake(0, 0,DEVICE_WIDTH,320);
    }
    backGroundImg.userInteractionEnabled=YES;
    backGroundImg.clipsToBounds=YES;
    backGroundImg.contentMode=UIViewContentModeScaleAspectFill;
    [scrollContent addSubview:backGroundImg];
    
    int y=0;
 
    [navView removeFromSuperview];
    if(IS_IPHONE_X)
    {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,y,DEVICE_WIDTH , 88)];
    }
    else
    {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,y,DEVICE_WIDTH , 64)];
    }
    navView.backgroundColor = [UIColor clearColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    if(IS_IPHONE_X)
    {
        y=y+44;
    }
    else
    {
        y=y+20;
    }
    
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]) {
        btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, y, 50, 44)];
    } else {
        btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-50, y, 50, 44)];
    }
    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
    [btnSideMenu addTarget:self action:@selector(btnSideMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btnSideMenu];
    
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        btnNavgation = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-50, y, 50, 44)];
    }else
    {
        btnNavgation = [[UIButton alloc] initWithFrame:CGRectMake(0, y, 50, 44)];
    }
    [btnNavgation setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [btnNavgation addTarget:self action:@selector(btnLocationGet:) forControlEvents:UIControlEventTouchUpInside];
    btnNavgation.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [navView addSubview:btnNavgation];
    
    UILabel * lblNewCars =[[UILabel alloc]init];
    lblNewCars.frame=CGRectMake(DEVICE_WIDTH/2-75,y+12,150,20);
    lblNewCars.textAlignment=NSTextAlignmentCenter;
    lblNewCars.textColor= [UIColor whiteColor];
    lblNewCars.backgroundColor=[UIColor clearColor];
    lblNewCars.text= [TSLanguageManager localizedString:@"New Cars"];
    lblNewCars.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblNewCars];
    
    y=y+8+20+26;
    
    UILabel * lblAdd1 =[[UILabel alloc]init];
    lblAdd1.frame=CGRectMake(16,y,DEVICE_WIDTH-32,14);
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblAdd1.textAlignment=NSTextAlignmentLeft;
    }else{
        lblAdd1.textAlignment=NSTextAlignmentRight;
        }
    lblAdd1.textColor= [UIColor whiteColor];
    lblAdd1.backgroundColor=[UIColor clearColor];
    lblAdd1.text= [TSLanguageManager localizedString:@"Ad"];
    lblAdd1.font = [UIFont boldSystemFontOfSize:12];
    [backGroundImg addSubview:lblAdd1];
    
    y=y+14+6;
    UILabel * lblAdd2 =[[UILabel alloc]init];
    lblAdd2.frame=CGRectMake(16,y,DEVICE_WIDTH-32,15);
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblAdd2.textAlignment=NSTextAlignmentLeft;
    }else{
        lblAdd2.textAlignment=NSTextAlignmentRight;
    }
    lblAdd2.textColor= [UIColor whiteColor];
    lblAdd2.backgroundColor=[UIColor clearColor];
    lblAdd2.text= [TSLanguageManager localizedString:@"The Scorpio"];
    lblAdd2.font = [UIFont boldSystemFontOfSize:13];
    [backGroundImg addSubview:lblAdd2];
    
    y=y+15+7;
    UILabel *lbladd3 = [[UILabel alloc]init];
    lbladd3.frame=CGRectMake(16,y,DEVICE_WIDTH-32,16);
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lbladd3.textAlignment=NSTextAlignmentLeft;
    }else{
        lbladd3.textAlignment=NSTextAlignmentRight;
    }
    lbladd3.textColor= [UIColor whiteColor];
    lbladd3.backgroundColor=[UIColor clearColor];
    lbladd3.text= [TSLanguageManager localizedString:@"Request A Call back"];
    lbladd3.font = [UIFont boldSystemFontOfSize:14];
    [backGroundImg addSubview:lbladd3];
    
    y=y+14+1;
    UILabel *lbladdLine = [[UILabel alloc]init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
       lbladdLine.frame=CGRectMake(16,y,136,1);
    }else{
        lbladdLine.frame=CGRectMake(DEVICE_WIDTH-96,y+2,80,1);
    }
    
    lbladdLine.backgroundColor=[UIColor whiteColor];
    [backGroundImg addSubview:lbladdLine];
    
    y=y+107;
    
    UISearchBar*   Searchbar=[[UISearchBar alloc] init];
    if(IS_IPAD)
    {
        Searchbar.frame = CGRectMake(95, y, DEVICE_WIDTH-190, 40);
    }else
    {
        Searchbar.frame = CGRectMake(14, y, DEVICE_WIDTH-28, 40);
    }
    
    Searchbar.backgroundColor=[UIColor whiteColor];
    Searchbar.barTintColor=[UIColor clearColor];
    Searchbar.tintColor = [UIColor clearColor];
    Searchbar.placeholder=@"Search";
    Searchbar.barStyle = UIBarStyleBlack;
    Searchbar.userInteractionEnabled = YES;
   // Searchbar.textAlignment = NSTextAlignmentLeft;
    Searchbar.layer.borderColor=[UIColor clearColor].CGColor;
    Searchbar.delegate = self;
    Searchbar.layer.borderWidth=0.0f;
    Searchbar.layer.cornerRadius=0.0;
    [Searchbar setBackgroundImage: [UIImage new]];
    [backGroundImg addSubview:Searchbar];
    
    
    UITextField *searchField = [Searchbar valueForKey:@"searchField"];
    searchField.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2];
    searchField.textColor = [UIColor blackColor];
    
    NSString* str= [TSLanguageManager localizedString:@"What are you looking for?"];
    searchField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str];
        UILabel *placeholderLabel = [searchField valueForKey:@"placeholderLabel"];
    
    
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        placeholderLabel.textAlignment =NSTextAlignmentLeft;
    }
    else
    {
        placeholderLabel.textAlignment =NSTextAlignmentRight;
    }
    searchField.textAlignment = NSTextAlignmentLeft;
    placeholderLabel.textColor = [UIColor grayColor];
    [backGroundImg addSubview:serchCar];
    
    UIButton *showSearchCarBtn = [[UIButton alloc] init];
    if(IS_IPAD)
    {
        showSearchCarBtn.frame = CGRectMake(95, y, DEVICE_WIDTH-190, 40);
    }
    else
    {
        showSearchCarBtn.frame = CGRectMake(14, y, DEVICE_WIDTH-28, 40);
    }
    showSearchCarBtn.backgroundColor = [UIColor clearColor];
    [showSearchCarBtn addTarget:self action:@selector(BtnShowSearchCar:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundImg addSubview:showSearchCarBtn];
    
    y=y+40+12;
    
    UILabel *lblsearch=[[UILabel alloc]init];
    lblsearch.userInteractionEnabled = YES;
    lblsearch.numberOfLines=3;
    lblsearch.textColor =[UIColor whiteColor];
    lblsearch.lineBreakMode=NSLineBreakByWordWrapping;
    lblsearch.font =[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    NSString *strAdvance = [TSLanguageManager localizedString:@"Advanced Search"];
    NSMutableAttributedString *attributeStringLogin = [[NSMutableAttributedString alloc] initWithString:strAdvance];
    [attributeStringLogin addAttribute:NSUnderlineStyleAttributeName
                                 value:[NSNumber numberWithInt:1]
                                 range:(NSRange){0,[attributeStringLogin length]}];
    
    lblsearch.attributedText=attributeStringLogin;
//    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
//    {
//        lblsearch.frame = CGRectMake (DEVICE_WIDTH-130, 290, DEVICE_WIDTH-40, 18);
//    }
//    else
//    {
//        lblsearch.frame = CGRectMake (10, 290, DEVICE_WIDTH-40, 18);
//    }
    if(IS_IPAD){
        lblsearch.frame = CGRectMake(95, y, DEVICE_WIDTH-190, 14);
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            lblsearch.textAlignment=NSTextAlignmentRight;
        }else{
            lblsearch.textAlignment=NSTextAlignmentLeft;
        }
            
    }else{
        lblsearch.frame = CGRectMake(14, y, DEVICE_WIDTH-28, 14);
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            lblsearch.textAlignment=NSTextAlignmentRight;
        }else{
            lblsearch.textAlignment=NSTextAlignmentLeft;
        }
    }
    [backGroundImg addSubview:lblsearch];
    
    btnAdvanceSerch = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        if(IS_IPAD){
            btnAdvanceSerch.frame = CGRectMake(95, y, DEVICE_WIDTH-190, 14);
        }
        else{
            btnAdvanceSerch.frame = CGRectMake(14, y, DEVICE_WIDTH-28, 14);
        }
    }
    else
    {
        if(IS_IPAD){
            btnAdvanceSerch.frame = CGRectMake(95, y, DEVICE_WIDTH-190, 14);
        }
        else{
            btnAdvanceSerch.frame = CGRectMake(14, y, DEVICE_WIDTH-28, 14);
        }
    }
   
    btnAdvanceSerch.backgroundColor = [UIColor clearColor];
    [btnAdvanceSerch addTarget:self action:@selector(btnAdvanceSerchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundImg addSubview:btnAdvanceSerch];
    
    scrollContent.parallaxHeader.view = backGroundImg; // You can set the parallax header view from a nib.
    if(IS_IPHONE_X)
    {
        scrollContent.parallaxHeader.height = 300;
    }
    else
    {
         scrollContent.parallaxHeader.height = 320;
    }
    scrollContent.parallaxHeader.mode = MXParallaxHeaderModeFill;
    scrollContent.parallaxHeader.minimumHeight = self.topLayoutGuide.length;
    scrollContent.delegate = self;
    
    //====================Adverstising Show=====================================//
    
    int yy1=24;
  
    UILabel * lblAdTitile =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblAdTitile.textColor= [UIColor blackColor];
    lblAdTitile.backgroundColor=[UIColor clearColor];
    lblAdTitile.textAlignment=NSTextAlignmentCenter;
    lblAdTitile.text = [TSLanguageManager localizedString:@"All-New Ford EcoSport"];
    lblAdTitile.font = [UIFont boldSystemFontOfSize:18];
    [scrollContent addSubview:lblAdTitile];
    
    yy1=yy1+18+16;
    
    if(IS_IPAD)
    {
        UIView *viewShow = [[UIView alloc] initWithFrame:CGRectMake(95,yy1 ,DEVICE_WIDTH-190, 269)];
        viewShow.layer.shadowColor = [UIColor grayColor].CGColor;
        viewShow.layer.shadowOffset = CGSizeMake(0, 1);
        viewShow.layer.shadowOpacity = 1;
        viewShow.layer.shadowRadius = 1.0;
        viewShow.backgroundColor = [UIColor whiteColor];
        [scrollContent addSubview:viewShow];
        
        UIImageView * imgCar1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 40, viewShow.frame.size.width/2-10, 210)];
        imgCar1.image = [UIImage imageNamed:@"Image_Ad"];
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [viewShow addSubview:imgCar1];
        
        UILabel * lblAddName=[[UILabel alloc] init];
        lblAddName.frame=CGRectMake(viewShow.frame.size.width/2, 92, viewShow.frame.size.width/2, 20);
        lblAddName.font=[UIFont boldSystemFontOfSize:16.0];
        lblAddName.textAlignment=NSTextAlignmentCenter;
        lblAddName.textColor=[UIColor blackColor];
        lblAddName.text=[TSLanguageManager localizedString:@"It's on your side"];
        lblAddName.clipsToBounds=YES;
        [viewShow addSubview:lblAddName];
        
        UILabel * lblAddDescription=[[UILabel alloc] init];
        lblAddDescription.frame=CGRectMake(viewShow.frame.size.width/2, 122, viewShow.frame.size.width/2, 15);
        lblAddDescription.font=[UIFont boldSystemFontOfSize:15.0];
        lblAddDescription.textAlignment=NSTextAlignmentCenter;
        lblAddDescription.textColor=[UIColor grayColor];
        lblAddDescription.text=[TSLanguageManager localizedString: @"Styiles new exterior and interoer"];
        lblAddDescription.clipsToBounds=YES;
        [viewShow addSubview:lblAddDescription];
        
        UIButton *knowMoreBtn = [[UIButton alloc]init];
        knowMoreBtn.frame = CGRectMake((viewShow.frame.size.width/2)+57,152,144, 30);
        knowMoreBtn.backgroundColor = APP_BUTTON_COLOR;
        knowMoreBtn.layer.cornerRadius=2.0;
        [knowMoreBtn setTitle:[TSLanguageManager localizedString:@"knowmore"] forState:UIControlStateNormal];
        knowMoreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [knowMoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [viewShow addSubview:knowMoreBtn];
        
        UILabel * lblAd=[[UILabel alloc] init];
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            lblAd.frame=CGRectMake(viewShow.frame.size.width-40, 14, 20, 14);
        }
        else
        {
            lblAd.frame=CGRectMake(14, 14, 40, 14);
        }
        lblAd.font=[UIFont systemFontOfSize:14.0];
        lblAd.textAlignment=NSTextAlignmentCenter;
        lblAd.textColor=[UIColor grayColor];
        lblAd.text=[TSLanguageManager localizedString:@"Ad"];
        lblAd.clipsToBounds=YES;
        [viewShow addSubview:lblAd];
    }
    else
    {
    UIView *viewShow = [[UIView alloc] initWithFrame:CGRectMake(14,yy1 , DEVICE_WIDTH-28, 269)];
    viewShow.layer.shadowColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.21].CGColor;
    viewShow.layer.shadowOffset = CGSizeMake(0, 0);
    viewShow.layer.shadowOpacity = 1;
    viewShow.layer.shadowRadius = 2.0;
    viewShow.backgroundColor = [UIColor whiteColor];
    [scrollContent addSubview:viewShow];
        
    UILabel * lblAd=[[UILabel alloc] init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        lblAd.frame=CGRectMake(viewShow.frame.size.width-40, 14, 20, 14);
    }else{
            lblAd.frame=CGRectMake(14, 14, 40, 14);
        }
    lblAd.font=[UIFont systemFontOfSize:14.0];
    lblAd.textAlignment=NSTextAlignmentCenter;
    lblAd.textColor=[UIColor grayColor];
    lblAd.text=[TSLanguageManager localizedString:@"Ad"];
    lblAd.clipsToBounds=YES;
    [viewShow addSubview:lblAd];
        
        int yyy1 = 13;
    
    UIImageView * imgCar1 = [[UIImageView alloc] init];
        if (IS_IPHONE_5) {
            imgCar1.frame =CGRectMake(54, yyy1, (viewShow.frame.size.width/2)+54, 138);
        }else{
            imgCar1.frame =CGRectMake(54, yyy1, (viewShow.frame.size.width/2)+108, 138);
        }
    imgCar1.image = [UIImage imageNamed:@"Image_Ad"];
    imgCar1.clipsToBounds=YES;
    imgCar1.userInteractionEnabled=YES;
    imgCar1.contentMode = UIViewContentModeScaleAspectFit;
    [viewShow addSubview:imgCar1];
        
    yyy1=yyy1+138+10;
    
    UILabel * lblAddName=[[UILabel alloc] init];
    lblAddName.frame=CGRectMake(15, yyy1, viewShow.frame.size.width-8, 22);
    lblAddName.font=[UIFont boldSystemFontOfSize:18.0];
    lblAddName.textAlignment=NSTextAlignmentCenter;
    lblAddName.textColor=[UIColor blackColor];
    lblAddName.text=[TSLanguageManager localizedString:@"It's on your side"];
    lblAddName.clipsToBounds=YES;
    [viewShow addSubview:lblAddName];
        
    yyy1=yyy1+20+10;
    
    UILabel * lblAddDescription=[[UILabel alloc] init];
    lblAddDescription.frame=CGRectMake(15, yyy1, viewShow.frame.size.width-8, 18);
    lblAddDescription.font=[UIFont boldSystemFontOfSize:15.0];
    lblAddDescription.textAlignment=NSTextAlignmentCenter;
    lblAddDescription.textColor=[UIColor grayColor];
    lblAddDescription.text=[TSLanguageManager localizedString:@"Styiles new exterior and interoer"];
    lblAddDescription.clipsToBounds=YES;
    [viewShow addSubview:lblAddDescription];
        
    yyy1=yyy1+15+15;
 
    UIButton *knowMoreBtn = [[UIButton alloc]init];
    knowMoreBtn.frame = CGRectMake(viewShow.frame.size.width/2-57,yyy1,114, 30);
    //[knowMoreBtn setImage:[UIImage imageNamed:@"knowmore"] forState:UIControlStateNormal];
    knowMoreBtn.backgroundColor = APP_BUTTON_COLOR;
    knowMoreBtn.layer.cornerRadius=2.0;
    [knowMoreBtn setTitle:[TSLanguageManager localizedString:@"knowmore"] forState:UIControlStateNormal];
    knowMoreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [knowMoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewShow addSubview:knowMoreBtn];
        
    }
    yy1=yy1+269+24;
    
    //========Browse By car(Make,EMI/Budget,Body Type,Fuel Type)==============//
    
    UILabel * lblFilterCars =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblFilterCars.textColor= [UIColor blackColor];
    lblFilterCars.backgroundColor=[UIColor clearColor];
    lblFilterCars.textAlignment=NSTextAlignmentCenter;
    lblFilterCars.text = [TSLanguageManager localizedString:@"BROWSE CARS BY"];
    lblFilterCars.font = [UIFont boldSystemFontOfSize:18.0];
    [scrollContent addSubview:lblFilterCars];
    
    yy1=yy1+18+8.5;
    
    UILabel * lblFilterSep =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1, 60,1)];
    lblFilterSep.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblFilterSep];
    
 
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
        UIView * viewMake  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewMake.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
         viewMake.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
    viewMake.backgroundColor = [UIColor whiteColor];
    viewMake.layer.cornerRadius = 3.0f;
    viewMake.layer.shadowOffset = CGSizeMake(0, 0);
    viewMake.layer.shadowRadius = 5.0;
    viewMake.layer.shadowOpacity = 0.50f;
    viewMake.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    [scrollContent addSubview:viewMake];
    
    btnMake = [[UIButton alloc] init];
        if (IS_IPAD)
        {
            btnMake.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            btnMake.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
    btnMake.backgroundColor = [UIColor clearColor];
    [btnMake addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollContent addSubview:btnMake];

    
    UIImageView* imgMake = [[AsyncImageView alloc]initWithFrame:CGRectMake(viewMake.frame.size.width/2-64/2,-32, 64, 64)];
    imgMake.image = [UIImage imageNamed:@"star"];
    imgMake.clipsToBounds = YES;
    imgMake.contentMode = UIViewContentModeScaleAspectFill;
    [viewMake addSubview:imgMake];
    
    
    int yyy = 32+12;
    
    UILabel * lblMake =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy, viewMake.frame.size.width,14)];
    lblMake.textColor= [UIColor blackColor];
    lblMake.backgroundColor=[UIColor clearColor];
    lblMake.textAlignment=NSTextAlignmentCenter;
    lblMake.text = [TSLanguageManager localizedString:@"Make"];
    lblMake.textColor = [UIColor grayColor];
    lblMake.font = [UIFont boldSystemFontOfSize:12];
    [viewMake addSubview:lblMake];
    
    yyy = yyy + 23;
    
    UILabel * lblMakeDescription =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy, viewMake.frame.size.width,12)];
    lblMakeDescription.textColor= [UIColor grayColor];
    lblMakeDescription.backgroundColor=[UIColor clearColor];
    lblMakeDescription.textAlignment=NSTextAlignmentCenter;
    lblMakeDescription.text = @"See all car by make";
    lblMakeDescription.font = [UIFont systemFontOfSize:10];
    [viewMake addSubview:lblMakeDescription];
    
   UIView * viewEMI  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewEMI.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            viewEMI.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
    viewEMI.backgroundColor = [UIColor whiteColor];
    viewEMI.layer.cornerRadius = 3.0f;
    viewEMI.layer.shadowOffset = CGSizeMake(0, 0);
    viewEMI.layer.shadowRadius = 5.0;
    viewEMI.layer.shadowOpacity = 0.50f;
    viewEMI.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    [scrollContent addSubview:viewEMI];
    
    btnEmi = [[UIButton alloc] init];
        if(IS_IPAD)
        {
            btnEmi.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            btnEmi.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
    btnEmi.backgroundColor = [UIColor clearColor];
    [btnEmi addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollContent addSubview:btnEmi];

    
    UIImageView* imgEMI = [[AsyncImageView alloc]initWithFrame:CGRectMake(viewEMI.frame.size.width/2-64/2,-32, 64, 64)];
    imgEMI.image = [UIImage imageNamed:@"money"];
    imgEMI.clipsToBounds = YES;
    imgEMI.contentMode = UIViewContentModeScaleAspectFill;
    [viewEMI addSubview:imgEMI];
    
    int yyy1 = 32+12;
    
    UILabel * lblEMITitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, viewEMI.frame.size.width,14)];
    lblEMITitle.textColor= [UIColor blackColor];
    lblEMITitle.backgroundColor=[UIColor clearColor];
    lblEMITitle.textAlignment=NSTextAlignmentCenter;
    lblEMITitle.text =[TSLanguageManager localizedString:@"EMI/Budget"];
    lblEMITitle.textColor = [UIColor grayColor];
    lblEMITitle.font = [UIFont boldSystemFontOfSize:12];
    [viewEMI addSubview:lblEMITitle];
    
    yyy1 = yyy1 + 23;
    
    UILabel * lblEMIDescription =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, viewEMI.frame.size.width,12)];
    lblEMIDescription.textColor= [UIColor grayColor];
    lblEMIDescription.backgroundColor=[UIColor clearColor];
    lblEMIDescription.textAlignment=NSTextAlignmentCenter;
    lblEMIDescription.text = [TSLanguageManager localizedString: @"Car that fit your budget"];
    lblEMIDescription.font = [UIFont systemFontOfSize:10];
    [viewEMI addSubview:lblEMIDescription];
    
    yy1=yy1+150;
    
   UIView * viewBodyType  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewBodyType.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            viewBodyType.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
    viewBodyType.backgroundColor = [UIColor whiteColor];
    viewBodyType.layer.cornerRadius = 3.0f;
    viewBodyType.layer.shadowOffset = CGSizeMake(0, 0);
    viewBodyType.layer.shadowRadius = 5.0;
    viewBodyType.layer.shadowOpacity = 0.50f;
    viewBodyType.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    [scrollContent addSubview:viewBodyType];
    
    btnBodyType = [[UIButton alloc] init];
        if (IS_IPAD)
        {
            btnBodyType.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            btnBodyType.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
    [btnBodyType addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollContent addSubview:btnBodyType];

    
    UIImageView* imgBodytype = [[AsyncImageView alloc]initWithFrame:CGRectMake(viewBodyType.frame.size.width/2-64/2,-32, 64, 64)];
    imgBodytype.image = [UIImage imageNamed:@"car-home"];
    imgBodytype.clipsToBounds = YES;
    imgBodytype.contentMode = UIViewContentModeScaleAspectFill;
    [viewBodyType addSubview:imgBodytype];
    
    int yyy2 = 32+12;
    
    UILabel * lblBodyTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2, viewBodyType.frame.size.width,14)];
    lblBodyTitle.textColor= [UIColor grayColor];
    lblBodyTitle.backgroundColor=[UIColor clearColor];
    lblBodyTitle.textAlignment=NSTextAlignmentCenter;
    lblBodyTitle.text = [TSLanguageManager localizedString:@"Body Type"];
    lblBodyTitle.font = [UIFont boldSystemFontOfSize:12];
    [viewBodyType addSubview:lblBodyTitle];
    
    yyy2 = yyy2 + 23;
    
    UILabel * lblBodyDesc =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2, viewBodyType.frame.size.width,12)];
    lblBodyDesc.textColor= [UIColor grayColor];
    lblBodyDesc.backgroundColor=[UIColor clearColor];
    lblBodyDesc.textAlignment=NSTextAlignmentCenter;
    lblBodyDesc.text = [TSLanguageManager localizedString:@"View by body type"];
    lblBodyDesc.font = [UIFont systemFontOfSize:10];
    [viewBodyType addSubview:lblBodyDesc];
    
    
    
   UIView * viewFualType  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewFualType.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            viewFualType.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
    viewFualType.backgroundColor = [UIColor whiteColor];
    viewFualType.layer.cornerRadius = 3.0f;
    viewFualType.layer.shadowOffset = CGSizeMake(0, 0);
    viewFualType.layer.shadowRadius = 5.0;
    viewFualType.layer.shadowOpacity = 0.50f;
    viewFualType.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    [scrollContent addSubview:viewFualType];
    
    btnFuelType = [[UIButton alloc] init];
    if (IS_IPAD)
    {
            btnFuelType.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
    }
    else
    {
            btnFuelType.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
    }
    btnFuelType.frame = CGRectMake(DEVICE_WIDTH/2+10,yy1, DEVICE_WIDTH/2-20,100);
    [btnFuelType addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollContent addSubview:btnFuelType];

    
    UIImageView* imgFualType = [[AsyncImageView alloc]initWithFrame:CGRectMake(viewFualType.frame.size.width/2-64/2,-32, 64, 64)];
    imgFualType.image = [UIImage imageNamed:@"fuel-type"];
    imgFualType.clipsToBounds = YES;
    imgFualType.contentMode = UIViewContentModeScaleAspectFill;
    [viewFualType addSubview:imgFualType];
    
    int yyy3 = 32+12;
    
    UILabel * lblFualTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3,viewFualType.frame.size.width,14)];
    lblFualTitle.textColor= [UIColor grayColor];
    lblFualTitle.backgroundColor=[UIColor clearColor];
    lblFualTitle.text = [TSLanguageManager localizedString:@"Fuel Type"];
    lblFualTitle.textAlignment=NSTextAlignmentCenter;
    lblFualTitle.font = [UIFont boldSystemFontOfSize:12];
    [viewFualType addSubview:lblFualTitle];
    
    yyy3 = yyy3 + 23;
    
    UILabel * lblFualDesc =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3, viewFualType.frame.size.width,12)];
    lblFualDesc.textColor= [UIColor grayColor];
    lblFualDesc.backgroundColor=[UIColor clearColor];
    lblFualDesc.text = [TSLanguageManager localizedString:@"Check by fuel options"];
        
    lblFualDesc.textAlignment=NSTextAlignmentCenter;
    lblFualDesc.font = [UIFont systemFontOfSize:10];
    [viewFualType addSubview:lblFualDesc];
    }
    
    else
    {
        yy1=yy1+50;
        
        int deviceWidth = scrollContent.frame.size.width/2;
        
        UIView * viewEMI  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewEMI.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            viewEMI.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
        viewEMI.backgroundColor = [UIColor whiteColor];
        viewEMI.layer.cornerRadius = 3.0f;
        viewEMI.layer.shadowOffset = CGSizeMake(0, 0);
        viewEMI.layer.shadowRadius = 5.0;
        viewEMI.layer.shadowOpacity = 0.50f;
        viewEMI.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:viewEMI];
        
        btnEmi = [[UIButton alloc] init];
        if (IS_IPAD)
        {
            btnEmi.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            btnEmi.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
        btnEmi.backgroundColor = [UIColor clearColor];
        [btnEmi addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollContent addSubview:btnEmi];
        
        
        UIImageView* imgEMI = [[AsyncImageView alloc]initWithFrame:CGRectMake(btnEmi.frame.size.width/2-64/2,-32, 64, 64)];
        imgEMI.image = [UIImage imageNamed:@"money"];
        imgEMI.clipsToBounds = YES;
        imgEMI.contentMode = UIViewContentModeScaleAspectFill;
        [viewEMI addSubview:imgEMI];
        
        int yyy1 = 32+12;
        
        UILabel * lblEMITitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, viewEMI.frame.size.width,14)];
        lblEMITitle.textColor= [UIColor blackColor];
        lblEMITitle.backgroundColor=[UIColor clearColor];
        lblEMITitle.textAlignment=NSTextAlignmentCenter;
        lblEMITitle.text = [TSLanguageManager localizedString:@"EMI/Budget"];
        lblEMITitle.textColor = [UIColor grayColor];
        lblEMITitle.font = [UIFont boldSystemFontOfSize:12];
        [viewEMI addSubview:lblEMITitle];
        
        yyy1 = yyy1 + 23;
        
        UILabel * lblEMIDescription =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, viewEMI.frame.size.width,12)];
        lblEMIDescription.textColor= [UIColor grayColor];
        lblEMIDescription.backgroundColor=[UIColor clearColor];
        lblEMIDescription.textAlignment=NSTextAlignmentCenter;
        lblEMIDescription.text =[TSLanguageManager localizedString:@"Car that fit your budget"];
        lblEMIDescription.font = [UIFont systemFontOfSize:10];
        [viewEMI addSubview:lblEMIDescription];
        
        
        UIView * viewMake  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewMake.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            viewMake.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
        viewMake.backgroundColor = [UIColor whiteColor];
        viewMake.layer.cornerRadius = 3.0f;
        viewMake.layer.shadowOffset = CGSizeMake(0, 0);
        viewMake.layer.shadowRadius = 5.0;
        viewMake.layer.shadowOpacity = 0.50f;
        viewMake.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:viewMake];
        
        btnMake = [[UIButton alloc] init];
        if (IS_IPAD)
        {
            btnMake.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            btnMake.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
        btnMake.backgroundColor = [UIColor clearColor];
        [btnMake addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollContent addSubview:btnMake];
        
        
        UIImageView* imgMake = [[AsyncImageView alloc]initWithFrame:CGRectMake(viewMake.frame.size.width/2-64/2,-32, 64, 64)];
        imgMake.image = [UIImage imageNamed:@"star"];
        imgMake.clipsToBounds = YES;
        imgMake.contentMode = UIViewContentModeScaleAspectFill;
        [viewMake addSubview:imgMake];
        
        
        int yyy = 32+12;
        
        UILabel * lblMake =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy, viewEMI.frame.size.width,14)];
        lblMake.textColor= [UIColor blackColor];
        lblMake.backgroundColor=[UIColor clearColor];
        lblMake.textAlignment=NSTextAlignmentCenter;
        lblMake.text =[TSLanguageManager localizedString:@"Make"];
        lblMake.textColor = [UIColor grayColor];
        lblMake.font = [UIFont boldSystemFontOfSize:12];
        [viewMake addSubview:lblMake];
        
        yyy = yyy + 23;
        
        UILabel * lblMakeDescription =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy1, viewMake.frame.size.width,11)];
        lblMakeDescription.textColor= [UIColor grayColor];
        lblMakeDescription.backgroundColor=[UIColor clearColor];
        lblMakeDescription.textAlignment=NSTextAlignmentCenter;
        lblMakeDescription.text =[TSLanguageManager localizedString: @"See all car by make"];
        lblMakeDescription.font = [UIFont systemFontOfSize:10];
        [viewMake addSubview:lblMakeDescription];
        
        
        yy1=yy1+150;
        
        UIView * viewFualType  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewFualType.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            viewFualType.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
        viewFualType.backgroundColor = [UIColor whiteColor];
        viewFualType.layer.cornerRadius = 3.0f;
        viewFualType.layer.shadowOffset = CGSizeMake(0, 0);
        viewFualType.layer.shadowRadius = 5.0;
        viewFualType.layer.shadowOpacity = 0.50f;
        viewFualType.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:viewFualType];
        
        btnFuelType = [[UIButton alloc] init];
        if (IS_IPAD)
        {
            btnFuelType.frame = CGRectMake(95,yy1,deviceWidth-85,90);
        }
        else
        {
            btnFuelType.frame = CGRectMake(14,yy1,deviceWidth-20,90);
        }
        [btnFuelType addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollContent addSubview:btnFuelType];
        
        
        UIImageView* imgFualType = [[AsyncImageView alloc]initWithFrame:CGRectMake(viewFualType.frame.size.width/2-64/2,-32, 64, 64)];
        imgFualType.image = [UIImage imageNamed:@"fuel-type"];
        imgFualType.clipsToBounds = YES;
        imgFualType.contentMode = UIViewContentModeScaleAspectFill;
        [viewFualType addSubview:imgFualType];
        
        int yyy3 = 32+12;
        
        UILabel * lblFualTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3, viewFualType.frame.size.width,14)];
        lblFualTitle.textColor= [UIColor grayColor];
        lblFualTitle.backgroundColor=[UIColor clearColor];
        lblFualTitle.text =[TSLanguageManager localizedString:@"Fuel Type"];
        lblFualTitle.textAlignment=NSTextAlignmentCenter;
        lblFualTitle.font = [UIFont boldSystemFontOfSize:12];
        [viewFualType addSubview:lblFualTitle];
        
        yyy3 = yyy3 + 23;
        
        UILabel * lblFualDesc =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy3, viewFualType.frame.size.width,12)];
        lblFualDesc.textColor= [UIColor grayColor];
        lblFualDesc.backgroundColor=[UIColor clearColor];
        lblFualDesc.text = [TSLanguageManager localizedString:@"Check by fuel options"];
        lblFualDesc.textAlignment=NSTextAlignmentCenter;
        lblFualDesc.font = [UIFont systemFontOfSize:10];
        [viewFualType addSubview:lblFualDesc];
        
        UIView * viewBodyType  = [[UIView alloc ]init];
        if (IS_IPAD)
        {
            viewBodyType.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            viewBodyType.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
        viewBodyType.backgroundColor = [UIColor whiteColor];
        viewBodyType.layer.cornerRadius = 3.0f;
        viewBodyType.layer.shadowOffset = CGSizeMake(0, 0);
        viewBodyType.layer.shadowRadius = 5.0;
        viewBodyType.layer.shadowOpacity = 0.50f;
        viewBodyType.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        [scrollContent addSubview:viewBodyType];
        
        btnBodyType = [[UIButton alloc] init];
        if (IS_IPAD)
        {
            btnBodyType.frame = CGRectMake(deviceWidth+25,yy1, deviceWidth-95,90);
        }
        else
        {
            btnBodyType.frame = CGRectMake(deviceWidth+5,yy1, deviceWidth-19,90);
        }
        [btnBodyType addTarget:self action:@selector(btnMakeViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollContent addSubview:btnBodyType];
        
        
        UIImageView* imgBodytype = [[AsyncImageView alloc]initWithFrame:CGRectMake(viewBodyType.frame.size.width/2-50/2,-25, 50, 50)];
        imgBodytype.image = [UIImage imageNamed:@"car-home"];
        imgBodytype.clipsToBounds = YES;
        imgBodytype.contentMode = UIViewContentModeScaleAspectFill;
        [viewBodyType addSubview:imgBodytype];
        
        int yyy2 = 32+12;
        
        UILabel * lblBodyTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2,viewBodyType.frame.size.width,14)];
        lblBodyTitle.textColor= [UIColor grayColor];
        lblBodyTitle.backgroundColor=[UIColor clearColor];
        lblBodyTitle.textAlignment=NSTextAlignmentCenter;
        lblBodyTitle.text = [TSLanguageManager localizedString:@"Body Type"];
        lblBodyTitle.font = [UIFont boldSystemFontOfSize:12];
        [viewBodyType addSubview:lblBodyTitle];
        
        yyy2 = yyy2 + 23;
        
        UILabel * lblBodyDesc =[[UILabel alloc]initWithFrame:CGRectMake(0,yyy2, viewBodyType.frame.size.width,12)];
        lblBodyDesc.textColor= [UIColor grayColor];
        lblBodyDesc.backgroundColor=[UIColor clearColor];
        lblBodyDesc.textAlignment=NSTextAlignmentCenter;
        lblBodyDesc.text = [TSLanguageManager localizedString:@"View by body type"];
        lblBodyDesc.font = [UIFont systemFontOfSize:10];
        [viewBodyType addSubview:lblBodyDesc];
    
    }
        
    

    yy1 = yy1+150+24;


    //======================= Popular cars ================================//
    
    UILabel * lblPapularCarHeader =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblPapularCarHeader.textColor= [UIColor blackColor];
    lblPapularCarHeader.backgroundColor=[UIColor clearColor];
    lblPapularCarHeader.textAlignment=NSTextAlignmentCenter;
    lblPapularCarHeader.text = [TSLanguageManager localizedString:@"POPULAR CARS"];
    
    lblPapularCarHeader.font = [UIFont boldSystemFontOfSize:18];
    [scrollContent addSubview:lblPapularCarHeader];
    
    UILabel * lblSepPopularCar =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+18+8, 60,1)];
    lblSepPopularCar.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblSepPopularCar];
   
    yy1=yy1+18+8+21;
    
    
  //======popular Car Collection view========//
    
    self.popularCarFlow=[[popularCarFlowLayout alloc] init];
    popularCarCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 230) collectionViewLayout:self.popularCarFlow];
    [self.popularCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [popularCarCollectionView setDataSource:self];
    [popularCarCollectionView setDelegate:self];
    popularCarCollectionView.showsVerticalScrollIndicator= NO;
    popularCarCollectionView.showsHorizontalScrollIndicator = NO;
    [popularCarCollectionView registerClass:[popularCarCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [popularCarCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:popularCarCollectionView];
    
    lblPopulerError = [[UILabel alloc] initWithFrame:CGRectMake(0, yy1+110, DEVICE_WIDTH, 20)];
    lblPopulerError.text  = @"No Popular cars found";
    lblPopulerError.textColor =[UIColor blackColor];
    lblPopulerError.textAlignment =NSTextAlignmentCenter;
    lblPopulerError.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [scrollContent addSubview:lblPopulerError];
    lblPopulerError.hidden=YES;

    
    //====================== Popular car comparision ================================//

    yy1= yy1 + 230+24;
    
    UILabel * lblPopularCarCompareLbl =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblPopularCarCompareLbl.textColor= [UIColor blackColor];
    lblPopularCarCompareLbl.backgroundColor=[UIColor clearColor];
    lblPopularCarCompareLbl.textAlignment=NSTextAlignmentCenter;
    lblPopularCarCompareLbl.text = [TSLanguageManager localizedString:@"POPULAR CAR COMPARISONS"];
    lblPopularCarCompareLbl.font = [UIFont boldSystemFontOfSize:18];
    [scrollContent addSubview:lblPopularCarCompareLbl];
    
    UILabel * lblPopularCarCompareLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+18+8, 60,1)];
    lblPopularCarCompareLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblPopularCarCompareLine];
    
    yy1=yy1+18+8+21;
    
    self.compareCars=[[iCarousel alloc]initWithFrame:CGRectMake(20,yy1 , DEVICE_WIDTH-90, 160)];

    //====================== Popular car Collectionview ================================//
    
    self.compareCarFlow=[[compareCarFlowlayout alloc] init];
    compareCarCollectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 140) collectionViewLayout:self.compareCarFlow];
    [self.compareCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [compareCarCollectionview setDataSource:self];
    [compareCarCollectionview setDelegate:self];
    compareCarCollectionview.showsVerticalScrollIndicator= NO;
    compareCarCollectionview.showsHorizontalScrollIndicator = NO;
    [compareCarCollectionview registerClass:[compareCarCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [compareCarCollectionview setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:compareCarCollectionview];
    
    
    lblCompareError = [[UILabel alloc] initWithFrame:CGRectMake(0, yy1+110, DEVICE_WIDTH, 20)];
    lblCompareError.text  = @"No Compare cars found";
    lblCompareError.textColor =[UIColor blackColor];
    lblCompareError.textAlignment =NSTextAlignmentCenter;
    lblCompareError.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [scrollContent addSubview:lblPopulerError];
    lblCompareError.hidden=YES;
    
    yy1=yy1+140+11;
    
    btnAllCompareCars = [[UIButton alloc] init];
    btnAllCompareCars.frame  = CGRectMake(DEVICE_WIDTH/2-30,yy1 ,70,40);
    [btnAllCompareCars addTarget:self action:@selector(btnAllCompareCarsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnAllCompareCars setTitle:[TSLanguageManager localizedString:@"View all"] forState:UIControlStateNormal];
     [btnAllCompareCars setTitleColor:[UIColor colorWithRed:3.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [scrollContent addSubview:btnAllCompareCars];
    
    
    //====================== Upcoming car ================================//
//    yy1=yy1+40+24;
//    
//    UILabel * lblUpcomingCars =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
//    lblUpcomingCars.textColor= [UIColor blackColor];
//    lblUpcomingCars.backgroundColor=[UIColor clearColor];
//    lblUpcomingCars.textAlignment=NSTextAlignmentCenter;
//    lblUpcomingCars.text = [TSLanguageManager localizedString:@"UPCOMING LAUNCHES"];
//    lblUpcomingCars.font = [UIFont boldSystemFontOfSize:16];
//    [scrollContent addSubview:lblUpcomingCars];
//    
//    UILabel * lblSepUpcomingCars =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+18+8, 60,1)];
//    lblSepUpcomingCars.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
//    [scrollContent addSubview:lblSepUpcomingCars];
//    
//    yy1=yy1+18+8+21;

 /*    //====================== Upcoming car Collectionview =============================//
    self.upcomingCar=[[iCarousel alloc]initWithFrame:CGRectMake(-20,yy1 , DEVICE_WIDTH-90, 240)];
    
    upcomingCarFlow=[[upcomingLaunchCarFlowLayout alloc] init];
    upcomingCarCollectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 260) collectionViewLayout:upcomingCarFlow];
    [self.popularCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [upcomingCarCollectionview setDataSource:self];
    [upcomingCarCollectionview setDelegate:self];
    upcomingCarCollectionview.showsVerticalScrollIndicator= NO;
    upcomingCarCollectionview.showsHorizontalScrollIndicator = NO;
    [upcomingCarCollectionview registerClass:[upcomingCarCollectionCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [upcomingCarCollectionview setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:upcomingCarCollectionview];
    
    
    lblUpcomingCarError = [[UILabel alloc] initWithFrame:CGRectMake(0, yy1+110, DEVICE_WIDTH, 20)];
    lblUpcomingCarError.text  = @"No upcoming cars found";
    lblUpcomingCarError.textColor =[UIColor blackColor];
    lblUpcomingCarError.textAlignment =NSTextAlignmentCenter;
    lblUpcomingCarError.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [scrollContent addSubview:lblUpcomingCarError];
    lblUpcomingCarError.hidden=YES;
    
    yy1=yy1+240+16;
    btnViewAllUpcomingCar = [[UIButton alloc] init];
    btnViewAllUpcomingCar.frame  = CGRectMake(DEVICE_WIDTH/2-30,yy1 ,70,40 );
    [btnViewAllUpcomingCar addTarget:self action:@selector(btnViewAllUpcomingCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnViewAllUpcomingCar setTitle:[TSLanguageManager localizedString:@"View all"] forState:UIControlStateNormal];
    [btnViewAllUpcomingCar setTitleColor:[UIColor colorWithRed:3.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [scrollContent addSubview:btnViewAllUpcomingCar];
    
      //====================== Just launched car ================================//
   */
    
    yy1=yy1+40+21;

    UILabel * lblJustLaunched =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblJustLaunched.textColor= [UIColor blackColor];
    lblJustLaunched.backgroundColor=[UIColor clearColor];
    lblJustLaunched.textAlignment=NSTextAlignmentCenter;
    lblJustLaunched.text = [TSLanguageManager localizedString:@"JUST LAUNCHED"];
    lblJustLaunched.font = [UIFont boldSystemFontOfSize:18];
    [scrollContent addSubview:lblJustLaunched];
    
    UILabel * lblSepJustLaunched =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+18+8, 60,1)];
    lblSepJustLaunched.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblSepJustLaunched];
    
    yy1=yy1+18+8+21;
    
    self.launchedCars=[[iCarousel alloc]initWithFrame:CGRectMake(-20,yy1 , DEVICE_WIDTH-90, 210)];
    
    //=================== Just launched car Collectionview=============================//
    
    justLauchFlow=[[justLauchCarFlowLayout alloc] init];
    justLaunchedCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 210) collectionViewLayout:justLauchFlow];
    [justLauchFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [justLaunchedCollectionView setDataSource:self];
    [justLaunchedCollectionView setDelegate:self];
    justLaunchedCollectionView.showsVerticalScrollIndicator= NO;
    justLaunchedCollectionView.showsHorizontalScrollIndicator = NO;
    [justLaunchedCollectionView registerClass:[justLaunchCarCollectionCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [justLaunchedCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:justLaunchedCollectionView];
    

    
    yy1=yy1+210+24;
//////////////////////////////////////////////////////////////////////////////////////////
//    btnViewPopularCar = [[UIButton alloc] init];
//    btnViewPopularCar.frame  = CGRectMake(DEVICE_WIDTH/2-30,yy1 ,70,40 );
//    [btnViewPopularCar addTarget:self action:@selector(btnViewPopularCarClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btnViewPopularCar setTitle:@"View all" forState:UIControlStateNormal];
//    [btnViewPopularCar setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
////[scrollContent addSubview:btnViewPopularCar];
//    
//    yy1=yy1+20;


    UIImageView *newCarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,yy1 ,DEVICE_WIDTH ,230 )];
    [newCarImgView setImage:[UIImage imageNamed:@"checkonroadprice"]];
    newCarImgView.backgroundColor = [UIColor clearColor];
    newCarImgView.clipsToBounds=YES;
    newCarImgView.contentMode = UIViewContentModeScaleAspectFill;
    [scrollContent addSubview:newCarImgView];

    int yy=25;
    UILabel * lblCheckOnRoadPrice =[[UILabel alloc]initWithFrame:CGRectMake(0,yy, DEVICE_WIDTH,20)];
    lblCheckOnRoadPrice.textColor= [UIColor whiteColor];
    lblCheckOnRoadPrice.backgroundColor=[UIColor clearColor];
    lblCheckOnRoadPrice.textAlignment=NSTextAlignmentCenter;
    lblCheckOnRoadPrice.text = [TSLanguageManager localizedString:@"CHECK ON-ROAD PRICE"];
    lblCheckOnRoadPrice.font = [UIFont boldSystemFontOfSize:18];
    [newCarImgView addSubview:lblCheckOnRoadPrice];
    
    yy=yy+20+16;
    if(IS_IPAD)
    {
        txtCheckOnRoadPrice = [[UITextField alloc] initWithFrame:CGRectMake(191,yy ,DEVICE_WIDTH-382 ,38)];
    }
    else
    {
     txtCheckOnRoadPrice = [[UITextField alloc] initWithFrame:CGRectMake(14,yy ,DEVICE_WIDTH-28 ,38 )];
    }
    txtCheckOnRoadPrice.delegate=self;
    txtCheckOnRoadPrice.backgroundColor = [UIColor whiteColor];
    txtCheckOnRoadPrice.placeholder =[TSLanguageManager localizedString:@" Type to select car name  "];
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            txtCheckOnRoadPrice.textAlignment =NSTextAlignmentLeft;
        }else{
        txtCheckOnRoadPrice.textAlignment =NSTextAlignmentRight;
        }
    txtCheckOnRoadPrice.layer.cornerRadius=2.0;
    txtCheckOnRoadPrice.layer.borderColor = [UIColor colorWithRed:183.0/265.0 green:183.0/265.0 blue:183.0/265.0 alpha:1.0].CGColor;
    txtCheckOnRoadPrice.layer.borderWidth = 1.0;
    [newCarImgView addSubview:txtCheckOnRoadPrice];
    
     yy=yy+38+10;
    
    btnCheckOnRoadPrice = [[UIButton alloc] init];
    if(IS_IPAD)
    {
        btnCheckOnRoadPrice.frame  = CGRectMake(191,yy ,DEVICE_WIDTH-382 ,38);
    }
    else
    {
        btnCheckOnRoadPrice.frame  = CGRectMake(14,yy,DEVICE_WIDTH-28 ,38);
    }
//    [btnCheckOnRoadPrice setImage:[UIImage imageNamed:@"Check_Now_Btn"] forState:UIControlStateNormal];
    [btnCheckOnRoadPrice setTitle:[TSLanguageManager localizedString:@"CHECK NOW" ] forState:UIControlStateNormal];
    btnCheckOnRoadPrice.backgroundColor = APP_BUTTON_COLOR;
    btnCheckOnRoadPrice.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    btnCheckOnRoadPrice.layer.cornerRadius=2.0;
    [btnCheckOnRoadPrice addTarget:self action:@selector(btnViewCheckOnRoadPrice:) forControlEvents:UIControlEventTouchUpInside];
   
    [newCarImgView addSubview:btnCheckOnRoadPrice];

    yy=yy+38+14;
    
    UILabel * lblCheckOnRoadPriceQuote =[[UILabel alloc]init];
    if(IS_IPAD)
    {
        lblCheckOnRoadPriceQuote.frame = CGRectMake(0,yy, DEVICE_WIDTH,35);
    }
    else
    {
        lblCheckOnRoadPriceQuote.frame = CGRectMake(0,yy, DEVICE_WIDTH,35);
    }
    lblCheckOnRoadPriceQuote.textColor= [UIColor whiteColor];
    lblCheckOnRoadPriceQuote.backgroundColor=[UIColor clearColor];
    lblCheckOnRoadPriceQuote.numberOfLines=0;
    lblCheckOnRoadPriceQuote.textAlignment=NSTextAlignmentCenter;
    lblCheckOnRoadPriceQuote.text = [TSLanguageManager localizedString:@"Contact details are not needed to get the price"];
    lblCheckOnRoadPriceQuote.font = [UIFont systemFontOfSize:12.0];
    [newCarImgView addSubview:lblCheckOnRoadPriceQuote];
    
    //================== News =============================//
    
    yy1=yy1+230+24;
    UILabel * lblNewsCarLbl =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblNewsCarLbl.textColor= [UIColor blackColor];
    lblNewsCarLbl.backgroundColor=[UIColor clearColor];
    lblNewsCarLbl.textAlignment=NSTextAlignmentCenter;
    lblNewsCarLbl.text = [TSLanguageManager localizedString:@"NEWS"];
    
    lblNewsCarLbl.font = [UIFont boldSystemFontOfSize:18];
    [scrollContent addSubview:lblNewsCarLbl];
    
    UILabel * lblNewsCarLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+18+8, 60,1)];
    lblNewsCarLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblNewsCarLine];
      yy1=yy1+18+8+21;
    
    self.NewsCar=[[iCarousel alloc]initWithFrame:CGRectMake(0,yy1 , DEVICE_WIDTH-90, 220)];
    
    //=============== News Collectionview =============================//
    
    self.NewsCarFlow=[[NewsCarFlowLayout alloc] init];
    newsCollectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 235) collectionViewLayout:self.NewsCarFlow];
    [self.NewsCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [newsCollectionview setDataSource:self];
    [newsCollectionview setDelegate:self];
    newsCollectionview.showsVerticalScrollIndicator= NO;
    newsCollectionview.showsHorizontalScrollIndicator = NO;
    [newsCollectionview registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [newsCollectionview setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:newsCollectionview];
    
    lblNewCarsError= [[UILabel alloc] initWithFrame:CGRectMake(0, yy1+110, DEVICE_WIDTH, 20)];
    lblNewCarsError.text  = @"No new cars found";
    lblNewCarsError.textColor =[UIColor blackColor];
    lblNewCarsError.textAlignment =NSTextAlignmentCenter;
    lblNewCarsError.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [scrollContent addSubview:lblNewCarsError];
    lblNewCarsError.hidden=YES;
    
    yy1=yy1+235+16;
    btnViewallNews = [[UIButton alloc] init];
    btnViewallNews.frame  = CGRectMake(DEVICE_WIDTH/2-30,yy1 ,70,40 );
    [btnViewallNews addTarget:self action:@selector(btnViewAllUpcomingCarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnViewallNews setTitle:[TSLanguageManager localizedString:@"View all"] forState:UIControlStateNormal];
    [btnViewallNews setTitleColor:[UIColor colorWithRed:3.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [scrollContent addSubview:btnViewallNews];
    //=============== Photo =============================//
    
    yy1=yy1+40+24;
    UILabel * lblPhotosTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblPhotosTitle.textColor= [UIColor blackColor];
    lblPhotosTitle.backgroundColor=[UIColor clearColor];
    lblPhotosTitle.textAlignment=NSTextAlignmentCenter;
    lblPhotosTitle.text = [TSLanguageManager localizedString:@"PHOTOS"];
    
    lblPhotosTitle.font = [UIFont boldSystemFontOfSize:16];
    [scrollContent addSubview:lblPhotosTitle];
    
    UILabel * lblPhotoLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+18+8, 60,1)];
    lblPhotoLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblPhotoLine];
    
      yy1=yy1+18+8+21;
    
    self.photosCar=[[iCarousel alloc]initWithFrame:CGRectMake(0,yy1 , DEVICE_WIDTH-90, 210)];
    self.PhotoCarFlow=[[PhotoCarFlowLayout alloc] init];
    photoCarCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 160) collectionViewLayout:self.PhotoCarFlow];
    [self.PhotoCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [photoCarCollectionView setDataSource:self];
    [photoCarCollectionView setDelegate:self];
    photoCarCollectionView.showsVerticalScrollIndicator= NO;
    photoCarCollectionView.showsHorizontalScrollIndicator = NO;
    [photoCarCollectionView registerClass:[PhotoCarCollectionCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [photoCarCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:photoCarCollectionView];
    
    //=============== Video=============================//
    
    yy1=yy1+160+24;
    UILabel * lblVideosTitle =[[UILabel alloc]initWithFrame:CGRectMake(0,yy1, DEVICE_WIDTH,18)];
    lblVideosTitle.textColor= [UIColor blackColor];
    lblVideosTitle.backgroundColor=[UIColor clearColor];
    lblVideosTitle.textAlignment=NSTextAlignmentCenter;
    lblVideosTitle.text = [TSLanguageManager localizedString:@"Videos"];
    lblVideosTitle.font = [UIFont boldSystemFontOfSize:16];
    [scrollContent addSubview:lblVideosTitle];
    
    UILabel * lblvideoLine =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-30,yy1+18+8, 60,1)];
    lblvideoLine.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblvideoLine];
    
    //=============== Video Collectionview =============================//
    
    yy1=yy1+18+8+21;
    self.videoCar=[[iCarousel alloc]initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 210)];
    
    self.VideoCarFlow=[[VideoCarFlowLayout alloc] init];
    VideoCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy1 , DEVICE_WIDTH-20, 230) collectionViewLayout:self.VideoCarFlow];
    [self.VideoCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [VideoCollectionView setDataSource:self];
    [VideoCollectionView setDelegate:self];
    VideoCollectionView.showsVerticalScrollIndicator= NO;
    VideoCollectionView.showsHorizontalScrollIndicator = NO;
    [VideoCollectionView registerClass:[VideoCarCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [VideoCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:VideoCollectionView];
    
    lblVideosError= [[UILabel alloc] initWithFrame:CGRectMake(0, yy1+90, DEVICE_WIDTH, 20)];
    lblVideosError.text  = @"No car videos found";
    lblVideosError.textColor =[UIColor blackColor];
    lblVideosError.textAlignment =NSTextAlignmentCenter;
    lblVideosError.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [scrollContent addSubview:lblVideosError];
    lblVideosError.hidden=YES;
    
    yy1=yy1+230;
    [scrollContent setContentSize:CGSizeMake(DEVICE_WIDTH, yy1+60)];

 
}

-(void)locationViewFrame
{
    BackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    BackView.backgroundColor=[UIColor blackColor];
    BackView.alpha = 0.5;
    BackView.hidden=YES;
    [self.view addSubview:BackView];
    
    if(IS_IPAD){
        LocationView= [[UIView alloc]initWithFrame:CGRectMake(160, DEVICE_HEIGHT/2-140,DEVICE_WIDTH-320, 280)];
        LocationView.backgroundColor = [UIColor whiteColor];
        LocationView.hidden=YES;
        [self.view addSubview:LocationView];
    }else{
        LocationView= [[UIView alloc]initWithFrame:CGRectMake(20, DEVICE_HEIGHT/2-140,DEVICE_WIDTH-40, 280)];
        LocationView.backgroundColor = [UIColor whiteColor];
        LocationView.hidden=YES;
        [self.view addSubview:LocationView];
    }
    
    UIButton *cancleBtn = [[UIButton alloc]init];
    cancleBtn.frame = CGRectMake(LocationView.frame.size.width-32,12,20, 20);
    [cancleBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    //cancleBtn.backgroundColor = [UIColor blackColor];
    [cancleBtn addTarget:self action:@selector(btnHideLocationView:) forControlEvents:UIControlEventTouchUpInside];
    [LocationView addSubview:cancleBtn];
    
    UIImageView *LocatioLogoImg = [[UIImageView alloc] init];
    LocatioLogoImg.frame = CGRectMake(LocationView.frame.size.width/2-20,20 , 50, 50);
    LocatioLogoImg.image = [UIImage imageNamed:@"map_icon"];
   // LocatioLogoImg.backgroundColor = [UIColor grayColor];
    [LocationView addSubview:LocatioLogoImg];
    
    UILabel *yourCityLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,80,LocationView.frame.size.width,30)];
    yourCityLbl.text=[TSLanguageManager localizedString:@"Please Tell Us Your City"];
    yourCityLbl.textColor = [UIColor lightGrayColor];
    yourCityLbl.textAlignment=NSTextAlignmentCenter;
    [yourCityLbl setFont:[UIFont systemFontOfSize:16.0 weight:UIFontWeightLight]];
    [LocationView addSubview:yourCityLbl];
    
    UILabel *yourCityDescripctionLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,110,LocationView.frame.size.width,30)];
    yourCityDescripctionLbl.text=[TSLanguageManager localizedString:@"Knowing Your city helps us provides relevant content for\n you"];
    yourCityDescripctionLbl.textColor = [UIColor lightGrayColor];
    yourCityDescripctionLbl.numberOfLines = 2;
    yourCityDescripctionLbl.textAlignment=NSTextAlignmentCenter;
    [yourCityDescripctionLbl setFont:[UIFont systemFontOfSize:10.0 weight:UIFontWeightLight]];
    [LocationView addSubview:yourCityDescripctionLbl];
    
    UIView *selectCityView = [[UIView alloc] initWithFrame:CGRectMake(30, 160, LocationView.frame.size.width-60, 40)];
    selectCityView.backgroundColor = [UIColor clearColor];
    selectCityView.layer.cornerRadius = 0.5f;
    selectCityView.layer.borderWidth = 0.5f;
    selectCityView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [LocationView addSubview:selectCityView];
    
    
    UITextField *txtLocation=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, selectCityView.frame.size.width-50, 39)];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:kLMArabic]) {
        [txtLocation setFrame:CGRectMake(50, 0,selectCityView.frame.size.width-50, 39)];
        txtLocation.textAlignment = NSTextAlignmentRight;
        txtLocation.layer.sublayerTransform = CATransform3DMakeTranslation(-10, 0, 0);
    }else{
        txtLocation.textAlignment = NSTextAlignmentLeft;
        txtLocation.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    }
    txtLocation.backgroundColor = [UIColor whiteColor];
    txtLocation.delegate=self;
    txtLocation.placeholder=[TSLanguageManager localizedString:@"Select Location"];
    txtLocation.secureTextEntry = YES;
   
    txtLocation.font = [UIFont fontWithName:@"FiraSans-Regular" size:15];
    txtLocation.textColor=[UIColor blackColor];
    txtLocation.keyboardType=UIKeyboardTypeEmailAddress;
    txtLocation.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [selectCityView addSubview:txtLocation];
    
    UIButton * btnPasswordVisibility = [[UIButton alloc] init];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:kLMArabic]) {
        [btnPasswordVisibility setFrame:CGRectMake(0, 0, 50, 40)];
    }else{
        [btnPasswordVisibility setFrame:CGRectMake((txtLocation.frame.size.width)+(txtLocation.frame.origin.x), 0, 50, 40)];
    }
    [btnPasswordVisibility setImage:[UIImage imageNamed:@"current_place_icon"] forState:UIControlStateNormal];
    [btnPasswordVisibility addTarget:self action:@selector(btnGetCurrentLocation:) forControlEvents:UIControlEventTouchUpInside];
    [btnPasswordVisibility setTag:1];
    [selectCityView addSubview:btnPasswordVisibility];
    
    UIButton *ConfirmCityButton = [[UIButton alloc]init];
    ConfirmCityButton.frame = CGRectMake(30,210,LocationView.frame.size.width-60, 30);
    ConfirmCityButton.backgroundColor = APP_BUTTON_COLOR;
    ConfirmCityButton.layer.cornerRadius=2.0;
    [ConfirmCityButton setTitle:[TSLanguageManager localizedString:@"CONFIRM CITY"] forState:UIControlStateNormal];
    ConfirmCityButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    [ConfirmCityButton addTarget:self action:@selector(btnConfirmCityClick:) forControlEvents:UIControlEventTouchUpInside];
    [LocationView addSubview:ConfirmCityButton];
    
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
    NSLog(@"Click Confirm city");

}
//Disha Code
- (void)btnMakeViewAction:(id)sender{
    if (sender == btnMake){
        FilterCarVC *VC = [FilterCarVC new];
        VC.strSelectedTypeName = @"1";
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (sender == btnEmi){
        FilterCarVC *VC = [FilterCarVC new];
        VC.strSelectedTypeName = @"0";
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (sender == btnBodyType){
        FilterCarVC *VC = [FilterCarVC new];
        VC.strSelectedTypeName = @"4";
        [self.navigationController pushViewController:VC animated:YES];
    }
    else{
        FilterCarVC *VC = [FilterCarVC new];
        VC.strSelectedTypeName = @"2";
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark -Hide Location View
-(void)hideView
{
    presentView.hidden=YES;
    BackView.hidden=YES;
    LocationView.hidden=YES;
}
#pragma mark -Reverse
- (void)scrollToBottomAnimated:(BOOL)animated
{
    if(popularCarCollectionView)
    {
        if ([GetCarModelArray count]>0)
        {
            [popularCarCollectionView reloadData];
            NSInteger section = [popularCarCollectionView numberOfSections] - 1;
            NSInteger item = [popularCarCollectionView numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [popularCarCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
         }
    }
    if(compareCarCollectionview)
    {
    if ([CompareCarArry count]>0) {
    
        [compareCarCollectionview reloadData];
        NSInteger section = [compareCarCollectionview numberOfSections] - 1;
        NSInteger item = [compareCarCollectionview numberOfItemsInSection:section] - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
        [compareCarCollectionview scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }
    if(upcomingCarCollectionview)
    {
     if([arrUpcomingCars count]>0)
     {
         [upcomingCarCollectionview reloadData];
         NSInteger section = [upcomingCarCollectionview numberOfSections] - 1;
         NSInteger item = [upcomingCarCollectionview numberOfItemsInSection:section] - 1;
         NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
         [upcomingCarCollectionview scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
     }
    }
    if(justLaunchedCollectionView)
    {
        if([arrLaunchedCars count]>0)
        {
            [justLaunchedCollectionView reloadData];
            NSInteger section = [justLaunchedCollectionView numberOfSections] - 1;
            NSInteger item = [justLaunchedCollectionView numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [justLaunchedCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
            
        }
    }
    if(newsCollectionview)
    {
        if([GetNewsArray count]>0)
        {
            [newsCollectionview reloadData];
            NSInteger section = [newsCollectionview numberOfSections] - 1;
            NSInteger item = [newsCollectionview numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [newsCollectionview scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }
    if(photoCarCollectionView)
    {
        if([GetNewsArray count]>0)
        {
            [photoCarCollectionView reloadData];
            NSInteger section = [photoCarCollectionView numberOfSections] - 1;
            NSInteger item = [photoCarCollectionView numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [photoCarCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }
    if (VideoCollectionView) {
        if([GetNewsArray count]>0)
        {
            [VideoCollectionView reloadData];
            NSInteger section = [VideoCollectionView numberOfSections] - 1;
            NSInteger item = [VideoCollectionView numberOfItemsInSection:section] - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            [VideoCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }
    
}
#pragma mark - Webservice
-(void)compareCarWebServices
{
        BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    if (isNetAvaliable == NO)
    {
    }else
    {
        NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc] init];
        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        NSString * webServiceName = @"getModalComparison";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getModalComparison";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
    
}
#pragma mark - Get Popular cars
-(void)GetPopularcarModels
{
   
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
        
        [parameter_dict setObject:@"1" forKey:@"popular"];
        [parameter_dict setObject:@"0" forKey:@"upcoming"];
        [parameter_dict setObject:@"0" forKey:@"launched"];
        [parameter_dict setObject:@"0" forKey:@"offset"];
        [parameter_dict setObject:@"20" forKey:@"limit"];
        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        NSString * webServiceName = @"getModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getPopularCarsModels";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}
#pragma mark - Get Popular cars
-(void)getUpcomingcarModels
{
    
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
        [parameter_dict setObject:@"0" forKey:@"popular"];
        [parameter_dict setObject:@"1" forKey:@"upcoming"];
        [parameter_dict setObject:@"0" forKey:@"launched"];
        [parameter_dict setObject:@"0" forKey:@"offset"];
        [parameter_dict setObject:@"20" forKey:@"limit"];
        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        NSString * webServiceName = @"getModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getUpcomingCarsModels";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}
#pragma mark - Get Popular cars
-(void)getLaunchedCars
{
    
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
        
        [parameter_dict setObject:@"0" forKey:@"popular"];
        [parameter_dict setObject:@"0" forKey:@"upcoming"];
        [parameter_dict setObject:@"1" forKey:@"launched"];
        [parameter_dict setObject:@"0" forKey:@"offset"];
        [parameter_dict setObject:@"20" forKey:@"limit"];
        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        NSString * webServiceName = @"getModels";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getLaunchedCarsModels";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}
-(void)GetNews
{
    
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
        [parameter_dict setObject:[TSLanguageManager selectedLanguage] forKey:@"language_type"];
        NSString * webServiceName = @"getNews";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getNews";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_NEWS,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}

#pragma mark - WebServices Delegate


-(void)onResult:(NSDictionary *)result
{
    NSLog(@"%@response",result);

  if([[result valueForKey:@"commandName"] isEqualToString:@"getModalComparison"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            CompareCarArry = [[result valueForKey:@"result"] valueForKey:@"comparison_list"];
            NSLog(@"Compare Car Array:%@",CompareCarArry);
            if ([CompareCarArry count]==0)
            {
                lblCompareError.hidden=NO;
            }else
            {
                lblCompareError.hidden=YES;
                [self.compareCars reloadData];
                [compareCarCollectionview reloadData];
            }
        }else
        {
            lblCompareError.hidden=NO;
        }
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"getPopularCarsModels"])
    {
        
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            GetCarModelArray = [[result valueForKey:@"result"] valueForKey:@"car_model"];

            if ([GetCarModelArray count]==0)
            {
                lblPopulerError.hidden=NO;
            }else
            {
                lblPopulerError.hidden=YES;
                [popularCarCollectionView reloadData];
            }
        }else
        {
            lblPopulerError.hidden=NO;
        }
    }else if ([[result valueForKey:@"commandName"] isEqualToString:@"getUpcomingCarsModels"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            arrUpcomingCars =[[[result valueForKey:@"result"] valueForKey:@"car_model"] mutableCopy];
            
            if ([arrUpcomingCars count]==0)
            {
                lblUpcomingCarError.hidden=NO;
            }else
            {
                lblUpcomingCarError.hidden=YES;
                [self.upcomingCar reloadData];
                [upcomingCarCollectionview reloadData];
            }
        }else
        {
            lblUpcomingCarError.hidden=NO;
        }
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"getLaunchedCarsModels"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            arrLaunchedCars =[[[result valueForKey:@"result"] valueForKey:@"car_model"] mutableCopy];
            
            if ([arrLaunchedCars count]==0)
            {
                lblLauncgedError.hidden=NO;
            }else
            {
                lblLauncgedError.hidden=YES;
                [self.launchedCars reloadData];
                [justLaunchedCollectionView reloadData];
            }
        }else
        {
            lblLauncgedError.hidden=NO;
        }
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"getNews"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            GetNewsArray = [[result valueForKey:@"result"] valueForKey:@"news"];
            
            if ([GetNewsArray count]==0)
            {
                lblNewCarsError.hidden=NO;
            }else
            {
                lblNewCarsError.hidden=YES;
                [self.NewsCar reloadData];
                [newsCollectionview reloadData];
                [photoCarCollectionView reloadData];
                [VideoCollectionView reloadData];
            }
        }else
        {
            lblNewCarsError.hidden=NO;
        }
    }
    if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        
    }
    else
    {
        GetCarModelArray = (NSMutableArray*) [[GetCarModelArray reverseObjectEnumerator]allObjects];
        CompareCarArry = (NSMutableArray*) [[CompareCarArry reverseObjectEnumerator]allObjects];
        arrLaunchedCars =(NSMutableArray*) [[arrLaunchedCars reverseObjectEnumerator]allObjects];
        arrUpcomingCars =(NSMutableArray*) [[arrUpcomingCars reverseObjectEnumerator]allObjects];
        GetNewsArray = (NSMutableArray*) [[GetNewsArray reverseObjectEnumerator]allObjects];
        arrUpcomingCars=(NSMutableArray*) [[arrUpcomingCars reverseObjectEnumerator]allObjects];
        [self scrollToBottomAnimated:YES];
    }
}
- (void)onError:(NSError *)error
{
    NSLog(@"The error is...%@", error);
}

#pragma mark - UItextfield Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
   
}


#pragma mark Uiserchbar Delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

     searchBar.showsCancelButton = YES;
}
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  [searchBar resignFirstResponder];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

#pragma mark - Collectionview Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView==popularCarCollectionView)
    {
        return [GetCarModelArray count];
    }
    if(collectionView == compareCarCollectionview)
    {
        return [CompareCarArry count];
    }
    if(collectionView == upcomingCarCollectionview)
    {
        return [arrUpcomingCars count];
    }
    if(collectionView == justLaunchedCollectionView)
    {
        return [arrLaunchedCars count];
    }
    if(collectionView == newsCollectionview)
    {
        return [GetNewsArray count];
    }
    
    if(collectionView == photoCarCollectionView)
    {
        return [GetNewsArray count];
    }
    else
    {
        return [GetNewsArray count];
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(collectionView == popularCarCollectionView)
    {
        popularCarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"model_image"]];
        cell.imgCar1.imageURL=url;
    
        cell.lblCarName1.text=[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"car_model_name"];;

       NSString *getPrice = [NSString stringWithFormat:@"%@",[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"price"]];

        NSString *finalString = [APP_DELEGATE datafromServer:getPrice] ;

        NSString *strigPrice = [NSString stringWithFormat:@"%@%@ onwords",[[GetCarModelArray objectAtIndex:indexPath.row]valueForKey:@"currency_symbol"],finalString];

        cell.lblCarPrice.text=strigPrice ;
        return cell;
    }
    if(collectionView == compareCarCollectionview)
    {
        compareCarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[CompareCarArry objectAtIndex:indexPath.row]valueForKey:@"image"]];
        cell.imgCar1.imageURL = url;
        
        cell.lblCarName1.text=[[CompareCarArry objectAtIndex:indexPath.row]valueForKey:@"first_model_name"];
        
        cell.lblCarName2.text=[[CompareCarArry objectAtIndex:indexPath.row]valueForKey:@"second_model_name"];
        
        return cell;
    
    }
    if(collectionView == upcomingCarCollectionview)
    {
        upcomingCarCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[arrUpcomingCars objectAtIndex:indexPath.row]valueForKey:@"model_image"]];
        cell.imgCar1.imageURL=url;
        
        cell.lblCarName1.text=[[arrUpcomingCars objectAtIndex:indexPath.row]valueForKey:@"car_model_name"];;

        NSString *getPrice = [NSString stringWithFormat:@"%@",[[arrUpcomingCars objectAtIndex:indexPath.row]valueForKey:@"price"]];
        NSString *finalString = [APP_DELEGATE datafromServer:getPrice] ;
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@ onwords",[[arrUpcomingCars objectAtIndex:indexPath.row]valueForKey:@"currency_symbol"],finalString];
        cell.lblCarPrice.text=strigPrice ;
        cell.lblCarLauchDate.text =[[arrUpcomingCars objectAtIndex:indexPath.row]valueForKey:@"launching_date"];
        return cell;

    }
    if(collectionView == justLaunchedCollectionView)
    {
        justLaunchCarCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[arrLaunchedCars objectAtIndex:indexPath.row]valueForKey:@"model_image"]];
        cell.imgCar1.imageURL = url;
        
        cell.lblCarName1.text=[[arrLaunchedCars objectAtIndex:indexPath.row]valueForKey:@"car_model_name"];;
        
        NSString *getPrice = [NSString stringWithFormat:@"%@",[[arrLaunchedCars objectAtIndex:indexPath.row]valueForKey:@"price"]];
        NSString *finalString = [APP_DELEGATE datafromServer:getPrice] ;
        NSString *strigPrice = [NSString stringWithFormat:@"%@%@ onwords",[[arrLaunchedCars objectAtIndex:indexPath.row]valueForKey:@"currency_symbol"],finalString];

        cell.lblCarPrice.text=strigPrice ;
        cell.lblCarLauchDate.text =[[arrLaunchedCars objectAtIndex:indexPath.row]valueForKey:@"launching_date"];
        return cell;
        
    }
    if(collectionView == newsCollectionview)
    {
        NewsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[GetNewsArray objectAtIndex:indexPath.row
                                            ]valueForKey:@"cover_image"]];
        cell.imgCar1.imageURL = url;
        cell.lblCarPrice.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"news_tag"];
        
        cell.lblCarName1.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        cell.lblEstimetedPrice.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"news_writer"];
        return cell;
    
    }
    if(collectionView == photoCarCollectionView)
    {
        PhotoCarCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[GetNewsArray objectAtIndex:indexPath.row
                                            ]valueForKey:@"cover_image"]];
        cell.imgCar1.imageURL = url;
        cell.lblCarPrice.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"news_tag"];
        
        cell.lblCarName1.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        cell.lblEstimetedPrice.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"news_writer"];
        return cell;
    
    }
    if(collectionView == VideoCollectionView)
    {
    
        VideoCarCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[GetNewsArray objectAtIndex:indexPath.row
                                            ]valueForKey:@"cover_image"]];
        cell.imgCar1.imageURL = url;
        cell.lblCarPrice.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"news_tag"];
        
        cell.lblCarName1.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        cell.lblEstimetedPrice.text=[[GetNewsArray objectAtIndex:indexPath.row]valueForKey:@"news_writer"];
        return cell;
    
    }
    
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    if(collectionView == popularCarCollectionView)
    {
        if ([GetCarModelArray count]>0)
        {
            CarDetailVC * car = [[CarDetailVC alloc] init];
            car.hidesBottomBarWhenPushed = YES;
            car.dictCar = [GetCarModelArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:car animated:YES];
       }
    }
    if(collectionView == justLaunchedCollectionView)
    {
        if([arrLaunchedCars count]>0)
        {
            CarDetailVC * car = [[CarDetailVC alloc] init];
            car.hidesBottomBarWhenPushed = YES;
            car.dictCar = [arrLaunchedCars objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:car animated:YES];
        }
    }

}
#pragma mark - Button Action
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
-(void)btnAllCompareCarsClicked:(id)sender
{


}
-(void)btnViewAllUpcomingCarClicked:(id)sender
{

}
-(void)btnAdvanceSerchClicked:(id)sender
{
    FilterCarVC * filter = [[FilterCarVC alloc] init];
    [self.navigationController pushViewController:filter animated:YES];
}
-(void)btnViewAllUpcomingCar:(id)sender
{
}
-(void)btnViewPopularCarClicked:(id)sender
{
    NSLog(@"View PopularCar Car");
}
-(void)btnViewCheckOnRoadPrice:(id)sender
{
    NSLog(@"View Upcoming Car");
}
-(void)BtnShowSearchCar:(id)sender
{
    SerchCarVC *vc = [[SerchCarVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)btnGetCurrentLocation:(id)sender
{
    
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
