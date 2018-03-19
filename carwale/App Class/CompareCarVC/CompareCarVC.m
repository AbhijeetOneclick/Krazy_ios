//
//  CompareCarVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CompareCarVC.h"

@interface CompareCarVC ()

@end

@implementation CompareCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self headerFrame];
    [self setFrame];
    [self GetNews];
   
    _CompareCarArry = [NSMutableArray new];
    _CompareCarTestArry = [NSMutableArray new];
    // Do any additional setup after loading the view.
    [self compareCarWebServices];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor = APP_HEADER_COLOR;
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    
    btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];

    [btnSideMenu addTarget:self action:@selector(btnSideMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btnSideMenu];
    
    lblHeader =[[UILabel alloc]initWithFrame:CGRectMake(60,20,DEVICE_WIDTH-120,44)];
    lblHeader.textColor= [UIColor whiteColor];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textAlignment=NSTextAlignmentCenter;
    lblHeader.text = [TSLanguageManager localizedString:@"Comapare Cars"];
    lblHeader.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblHeader];
}

-(void)setFrame
{
    //==============================Header View=====================================//
    
    scrollContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT)];
    scrollContent.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollContent.bounces = NO;
    scrollContent.contentInset = UIEdgeInsetsMake(0,0,0,0);
    scrollContent.showsVerticalScrollIndicator = NO;
    scrollContent.showsHorizontalScrollIndicator = NO;
    if (IS_IPAD){
        scrollContent.contentSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT*1.2);
    }else{
        scrollContent.contentSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT*2);
    }
    scrollContent.clipsToBounds =YES;
    [self.view addSubview:scrollContent];
    
    int  yy = 5;
    
    UIView * viewMain  = [[UIView alloc ]init];
    if (IS_IPAD){
    viewMain.frame = CGRectMake(0,yy, DEVICE_WIDTH,200);
    }else{
        viewMain.frame = CGRectMake(0,yy, DEVICE_WIDTH,150);
    }
    viewMain.backgroundColor = [UIColor lightGrayColor];
    [scrollContent addSubview:viewMain];

    //
    UIView * viewSelectCar1  = [[UIView alloc]init];
    if (IS_IPAD){
    viewSelectCar1.frame = CGRectMake(0,0, DEVICE_WIDTH/2-1,199);
    }else{
        viewSelectCar1.frame = CGRectMake(0,0, DEVICE_WIDTH/2-1,149);
    }
    viewSelectCar1.backgroundColor = [UIColor whiteColor];
    [viewMain addSubview:viewSelectCar1];
   
    //
    UIButton *btnSelectCar1 = [[UIButton alloc]init];
    if (IS_IPAD){
        btnSelectCar1.frame = CGRectMake(0,0, DEVICE_WIDTH/2,199);
    }else{
        btnSelectCar1.frame = CGRectMake(0,0, DEVICE_WIDTH/2,149);
    }
    [btnSelectCar1 setImage:[UIImage imageNamed:@"car_compare"] forState:UIControlStateNormal];
    //[btnSelectCar1 setBackgroundImage:[UIImage imageNamed:@"car.png"] forState:UIControlStateNormal];
    btnSelectCar1.backgroundColor = [UIColor clearColor];
    [btnSelectCar1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [viewSelectCar1 addSubview:btnSelectCar1];
    
    //
    UILabel * lblAddCar  = [[UILabel alloc ]init];
    if (IS_IPAD){
        lblAddCar.frame = CGRectMake(btnSelectCar1.frame.size.width/2 -50,btnSelectCar1.frame.size.height - 30,100,20);
    }
    else{
        lblAddCar.frame = CGRectMake(btnSelectCar1.frame.size.width/2 -50,btnSelectCar1.frame.size.height - 30,100,20);
    }
    lblAddCar.backgroundColor = [UIColor clearColor];
    lblAddCar.textColor = [UIColor blackColor];
    lblAddCar.textAlignment = NSTextAlignmentCenter;
    lblAddCar.text = @"Add Car";
    [btnSelectCar1 addSubview:lblAddCar];
    
    //
    UIView * viewSelectCar2  = [[UIView alloc ]init];
    if (IS_IPAD){
    viewSelectCar2.frame = CGRectMake(DEVICE_WIDTH/2+1,0, DEVICE_WIDTH/2,199);
    }
    else{
        viewSelectCar2.frame = CGRectMake(DEVICE_WIDTH/2+1,0, DEVICE_WIDTH/2,149);
    }
    viewSelectCar2.backgroundColor = [UIColor whiteColor];
    [viewMain addSubview:viewSelectCar2];
    
    //
    UIButton *btnSelectCar2 = [[UIButton alloc]init];
    if (IS_IPAD){
        btnSelectCar2.frame = CGRectMake(0,0, DEVICE_WIDTH/2,199);
    }else{
        btnSelectCar2.frame = CGRectMake(0,0, DEVICE_WIDTH/2,149);
    }
    [btnSelectCar2 setImage:[UIImage imageNamed:@"car_compare"] forState:UIControlStateNormal];
    [btnSelectCar2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnSelectCar2.backgroundColor = [UIColor clearColor];
    [viewSelectCar2 addSubview:btnSelectCar2];
    
    UILabel * lblAddCar1  = [[UILabel alloc ]init];
    if (IS_IPAD){
        lblAddCar1.frame = CGRectMake(btnSelectCar2.frame.size.width/2 -50,btnSelectCar2.frame.size.height - 30,100,20);
    }
    else{
        lblAddCar1.frame = CGRectMake(btnSelectCar2.frame.size.width/2 -50,btnSelectCar2.frame.size.height - 30,100,20);
    }
    lblAddCar1.backgroundColor = [UIColor clearColor];
    lblAddCar1.textAlignment = NSTextAlignmentCenter;
    lblAddCar1.textColor = [UIColor blackColor];
    lblAddCar1.text = @"Add Car";
    [btnSelectCar2 addSubview:lblAddCar1];

    
    //VsView
    UILabel * lblVs  = [[UILabel alloc ]init];
    if (IS_IPAD){
        lblVs.frame = CGRectMake(DEVICE_WIDTH/2 - 10,viewMain.frame.size.height/2-10,20,20);
    }
    else{
        lblVs.frame = CGRectMake(DEVICE_WIDTH/2 - 10,viewMain.frame.size.height/2-10,20,20);
    }
    lblVs.backgroundColor = [UIColor whiteColor];
    lblVs.textColor = [UIColor lightGrayColor];
    lblVs.layer.cornerRadius = lblVs.frame.size.height/2;
    lblVs.layer.borderWidth = 1;
    lblVs.layer.borderColor = [UIColor lightGrayColor].CGColor;
    lblVs.text = @"Vs";
    [viewMain addSubview:lblVs];
    
    //
    if (IS_IPAD) {
        yy = yy + 200 + 20;
    }else{
        yy = yy + 150 + 20;
    }
    UIButton *btnCompareCar = [[UIButton alloc]init];
    if (IS_IPAD){
        btnCompareCar.frame = CGRectMake(10,yy,DEVICE_WIDTH-20,40);
    }else{
        btnCompareCar.frame = CGRectMake(10,yy,DEVICE_WIDTH-20,30);
    }
    //[btnSelectCar1 setImage:[UIImage imageNamed:@"knowmore.png"] forState:UIControlStateNormal];
    btnCompareCar.backgroundColor = APP_BUTTON_COLOR;
    btnCompareCar.titleLabel.textColor = [UIColor whiteColor];
    [btnCompareCar setTitle:@"COMPARE CARS" forState:UIControlStateNormal];
    [scrollContent addSubview:btnCompareCar];
    
    
    //======================= Popular cars ================================//
    if (IS_IPAD) {
        yy = yy + 40 + 30;
    }else{
        yy = yy + 30 + 30;
    }

    UILabel * lblPopularCarHeader =[[UILabel alloc]init];
    if (IS_IPAD) {
        lblPopularCarHeader.frame = CGRectMake(0,yy, DEVICE_WIDTH,30);
    }else{
        lblPopularCarHeader.frame = CGRectMake(0,yy, DEVICE_WIDTH,20);
    }
    lblPopularCarHeader.textColor= [UIColor blackColor];
    lblPopularCarHeader.backgroundColor=[UIColor clearColor];
    lblPopularCarHeader.textAlignment=NSTextAlignmentCenter;
    lblPopularCarHeader.text = @"POPULAR CARS";
    lblPopularCarHeader.font = [UIFont boldSystemFontOfSize:16];
    [scrollContent addSubview:lblPopularCarHeader];
    
    //
    UILabel * lblSepPopularCar =[[UILabel alloc]init];
    if (IS_IPAD) {
        lblSepPopularCar.frame = CGRectMake(DEVICE_WIDTH/2-30,yy+31, 80,1);
    }else{
        lblSepPopularCar.frame = CGRectMake(DEVICE_WIDTH/2-30,yy+21, 60,1);
    }
    lblSepPopularCar.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblSepPopularCar];
    
   
    if (IS_IPAD) {
        yy = yy + 40 ;
    }else{
        yy = yy + 20 ;
    }

    //======popular Car Collection view========//
    self.popularCompareCarFlow = [[compareCarFlowlayout alloc] init];

    if (IS_IPAD) {
        _CompareCarCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy,DEVICE_WIDTH-20, 340) collectionViewLayout:self.popularCompareCarFlow];
    }else{
        _CompareCarCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy,DEVICE_WIDTH-20, 260) collectionViewLayout:self.popularCompareCarFlow];
    }
    [self.popularCompareCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_CompareCarCollectionView setDataSource:self];
    [_CompareCarCollectionView setDelegate:self];
    _CompareCarCollectionView.showsVerticalScrollIndicator= NO;
    _CompareCarCollectionView.showsHorizontalScrollIndicator = NO;
    [_CompareCarCollectionView registerClass:[PopularComapreCarCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_CompareCarCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:_CompareCarCollectionView];

    //
    lblPopulerError = [[UILabel alloc] init];
    if (IS_IPAD) {
        lblPopulerError.frame = CGRectMake(0,yy+155,DEVICE_WIDTH, 30);
    }else{
        lblPopulerError.frame = CGRectMake(0,yy+120,DEVICE_WIDTH, 20);
    }
    lblPopulerError.text  = @"No Popular cars found";
    lblPopulerError.textColor =[UIColor blackColor];
    lblPopulerError.textAlignment =NSTextAlignmentCenter;
    lblPopulerError.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [scrollContent addSubview:lblPopulerError];
    lblPopulerError.hidden=YES;
    
    //
    if (IS_IPAD) {
        yy = yy + 320;
    }else{
        yy = yy + 240;
    }
    UIButton *btnViewAll = [[UIButton alloc]init];
    if (IS_IPAD){
        btnViewAll.frame = CGRectMake(DEVICE_WIDTH/2-75,yy,150,25);
    }else{
        btnViewAll.frame = CGRectMake(DEVICE_WIDTH/2-75,yy,150,15);
    }
    [btnViewAll setTitle:@"View all" forState:UIControlStateNormal];
    [btnViewAll setTitleColor:[UIColor colorWithRed:3.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnViewAll setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [scrollContent addSubview:btnViewAll];

    //======================= CompareTest cars ================================//
    
    if (IS_IPAD) {
        yy = yy + 25 + 20;
    }else{
        yy = yy + 15 + 20;
    }
    UILabel * lblCompareTestHeader =[[UILabel alloc]init];
    if (IS_IPAD) {
        lblCompareTestHeader.frame = CGRectMake(0,yy, DEVICE_WIDTH,30);
    }else{
        lblCompareTestHeader.frame = CGRectMake(0,yy, DEVICE_WIDTH,20);
    }
    lblCompareTestHeader.textColor= [UIColor blackColor];
    lblCompareTestHeader.backgroundColor=[UIColor clearColor];
    lblCompareTestHeader.textAlignment=NSTextAlignmentCenter;
    lblCompareTestHeader.text = @"COMPARE TEST CARS";
    lblCompareTestHeader.font = [UIFont boldSystemFontOfSize:16];
    [scrollContent addSubview:lblCompareTestHeader];
    
    //
    UILabel * lblSepCompareTest =[[UILabel alloc]init];
    if (IS_IPAD) {
        lblSepCompareTest.frame = CGRectMake(DEVICE_WIDTH/2-30,yy+31, 80,1);
    }else{
        lblSepCompareTest.frame = CGRectMake(DEVICE_WIDTH/2-30,yy+21, 60,1);
    }
    lblSepCompareTest.backgroundColor=[[UIColor colorWithRed:4.0/255.0 green:187.0/255.0 blue:203.0/255.0 alpha:1.0]colorWithAlphaComponent:0.6];
    [scrollContent addSubview:lblSepCompareTest];
    
    //======CompareTest Car Collection view========//

    if (IS_IPAD) {
        yy = yy + 30 ;
    }else{
        yy = yy + 20 ;
    }

    self.compareTestCarFlow = [[compareCarFlowlayout alloc] init];
    
    if (IS_IPAD) {
        _CompareTestCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy,DEVICE_WIDTH-20, 340) collectionViewLayout:self.compareTestCarFlow];
    }else{
        _CompareTestCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10,yy,DEVICE_WIDTH-20, 260) collectionViewLayout:self.compareTestCarFlow];
    }
    [self.compareTestCarFlow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_CompareTestCollectionView setDataSource:self];
    [_CompareTestCollectionView setDelegate:self];
    _CompareTestCollectionView.showsVerticalScrollIndicator= NO;
    _CompareTestCollectionView.showsHorizontalScrollIndicator = NO;
    [_CompareTestCollectionView registerClass:[CompareTestCarCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_CompareTestCollectionView setBackgroundColor:[UIColor clearColor]];
    [scrollContent addSubview:_CompareTestCollectionView];
    
    if (IS_IPAD) {
        yy = yy + 360 ;
    }else{
        yy = yy + 280 ;
    }
    

        [scrollContent setContentSize:CGSizeMake(DEVICE_WIDTH, yy*1.2)];
    
    
    //
    lblCompareTestError = [[UILabel alloc] init];
    if (IS_IPAD) {
        lblCompareTestError.frame = CGRectMake(0, yy+155, DEVICE_WIDTH, 30);
    }else{
        lblCompareTestError.frame = CGRectMake(0, yy+120, DEVICE_WIDTH, 20);
    }
    lblCompareTestError.text  = @"No Popular cars found";
    lblCompareTestError.textColor =[UIColor blackColor];
    lblCompareTestError.textAlignment =NSTextAlignmentCenter;
    lblCompareTestError.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [scrollContent addSubview:lblCompareTestError];
    lblCompareTestError.hidden=YES;

}

#pragma mark - Button Action

-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}

#pragma mark - Collectionview Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == _CompareCarCollectionView)
    {
        if ([_CompareCarArry count] >0) {
            return [_CompareCarArry count];
        }else{
            return 0;
        }
    }
    else if(collectionView == _CompareTestCollectionView)
    {
        if ([_CompareCarTestArry count] >0) {
            return [_CompareCarTestArry count];
        }else{
            return 0;
        }
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == _CompareCarCollectionView)
    {
        PopularComapreCarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[_CompareCarArry objectAtIndex:indexPath.row]valueForKey:@"image"]];
        cell.imgCar1.imageURL = url;
        cell.lblCarName1.text=[[_CompareCarArry objectAtIndex:indexPath.row]valueForKey:@"first_model_name"];
        cell.lblCarName2.text=[[_CompareCarArry objectAtIndex:indexPath.row]valueForKey:@"second_model_name"];
        return cell;
    }
    else if(collectionView == _CompareTestCollectionView)
    {
        CompareTestCarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[[_CompareCarTestArry objectAtIndex:indexPath.row
                                            ]valueForKey:@"cover_image"]];
        cell.imgCar1.imageURL = url;
        cell.lblCarName1.text=[[_CompareCarTestArry objectAtIndex:indexPath.row]valueForKey:@"news_tag"];
        cell.lblCarLauchDate.text=[[_CompareCarTestArry objectAtIndex:indexPath.row]valueForKey:@"time_diff"];
        cell.lblByWriter.text= [NSString stringWithFormat:@"by%@ ",[[_CompareCarTestArry objectAtIndex:indexPath.row]valueForKey:@"news_writer"]];
        return cell;
    }

    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
//    if(collectionView == _popularCarCollectionView)
//    {
//        if ([GetCarModelArray count]>0)
//        {
//            CarDetailVC * car = [[CarDetailVC alloc] init];
//            car.hidesBottomBarWhenPushed = YES;
//            car.dictCar = [GetCarModelArray objectAtIndex:indexPath.row];
//            [self.navigationController pushViewController:car animated:YES];
//        }
//    }
    
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
        NSString * webServiceName = @"getModalComparison";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getModalComparison";
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
        
        NSString * webServiceName = @"getNews";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"getNews";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_NEWS,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}

-(void)onResult:(NSDictionary *)result
{
    NSLog(@"%@response",result);
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getModalComparison"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            _CompareCarArry = [[result valueForKey:@"result"] valueForKey:@"comparison_list"];
            NSLog(@"Compare Car Array:%@",_CompareCarArry);
            if ([_CompareCarArry count]==0)
            {
                lblPopulerError.hidden=NO;
            }else
            {
                lblPopulerError.hidden=YES;
                [_CompareCarCollectionView reloadData];
            }
        }else
        {
            lblPopulerError.hidden=NO;
        }
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"getNews"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            _CompareCarTestArry = [[result valueForKey:@"result"] valueForKey:@"news"];
            
            if ([_CompareCarTestArry count]==0)
            {
                lblCompareTestError.hidden=NO;
            }else
            {
                lblCompareTestError.hidden=YES;
                [_CompareTestCollectionView reloadData];
            }
        }else
        {
            lblCompareTestError.hidden=NO;
        }
    }
}

- (void)onError:(NSError *)error
{
    NSLog(@"The error is...%@", error);
}

@end
