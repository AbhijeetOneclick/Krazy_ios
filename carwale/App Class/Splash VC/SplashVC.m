//
//  SplashVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 7/31/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "SplashVC.h"
#import "Constant.h"
#import "AppDelegate.h"

@interface SplashVC ()

@end

@implementation SplashVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setContentViewFrames];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
    self.view.backgroundColor = [UIColor orangeColor];
}

#pragma mark - setFrames
-(void)setContentViewFrames
{
    UIImageView *imgBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    imgBackground.image=[UIImage imageNamed:@"splash"];
    imgBackground.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:imgBackground];
    
    UIImageView *icon = [[UIImageView alloc]init];
    icon.image=[UIImage imageNamed:@"splash_icon"];
    if(IS_IPAD)
    {
        icon.frame = CGRectMake((DEVICE_WIDTH/2)-(128/2), (DEVICE_HEIGHT/2)-(59/2), 128, 59);
    }else{
        icon.frame = CGRectMake((DEVICE_WIDTH/2)-(216/2), (DEVICE_HEIGHT/2)-(100/2), 216, 100);
    }
    icon.contentMode=UIViewContentModeScaleAspectFill;
    [imgBackground addSubview:icon];
     
}
/*-(void)setUpTabBarController
{
    AppDelegate * ap=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    HomeVC *home=[[HomeVC alloc]init];
    tabbarcontroller = [[UITabBarController alloc] init];
    tabbarcontroller.tabBar.tintColor=[UIColor blackColor];
    tabbarcontroller.tabBar.backgroundColor=[UIColor blackColor];
    tabbarcontroller.delegate = self;
    tabbarcontroller.tabBar.backgroundImage=[UIImage imageNamed:@"footer"];
    // tabBarController.tabBar.backgroundColor = globelColor;
    
    //Home Tab Bar Item And Icon
    UIImage *HomeIcon = [UIImage imageNamed:@"book-selected"];
    UIImage *HomeIconUnselected = [UIImage imageNamed:@"book"];
    UITabBarItem *HomeItem = [[UITabBarItem alloc] initWithTitle:@"" image:HomeIconUnselected selectedImage:HomeIcon];
    //    HomeItem.imageInsets = UIEdgeInsetsMake(5, 0, -6, 0);
    UINavigationController *Home = [[UINavigationController alloc] initWithRootViewController:home];
    [Home.navigationBar setTranslucent:NO];
    Home.tabBarItem = HomeItem;
    
    Home.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);;
    HomeItem.selectedImage = [HomeIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    HomeItem.image =[HomeIconUnselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    // Set bar button tint color to app theme color
    [[UIBarButtonItem appearance] setTintColor:[UIColor clearColor]];
    // Set Tab Bar Items Selected Tint color to App Theme Color
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:12.0/255.0 green:12.0/255.0 blue:37.0/255.0 alpha:1.0]];
    
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    
    NSArray* controllers = [NSArray arrayWithObjects: Home, nil];
    
    //      NSArray* controllers = [NSArray arrayWithObjects: Home,bokkingNav, ProfileNav, nil];
    [tabbarcontroller setViewControllers: controllers animated:NO];
    [ap.window addSubview:tabbarcontroller.view];
}*/
#pragma mark CleanUp
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
