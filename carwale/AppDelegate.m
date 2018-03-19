//
//  AppDelegate.m
//  carwale
//
//  Created by One Click IT Consultancy  on 7/31/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "AppDelegate.h"
#import "SplashVC.h"
#import "SocialLoginVC.h"
#import "NewAppInfoVC.h"
#import "Reachability.h"
#import "URBAlertView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LeftMenuVC.h"
#import "HomeVC.h"
#import "FindCarVC.h"
#import "CompareCarVC.h"
#import "NewsVC.h"
#import "CheckOnRoadPriceVC.h"
#import "RegisterVC.h"
#import "NewsVC.h"
#import "NewHomeVC.h"
#import "UsedcarNewVC.h"
#import "LanguageSelectionVC.h"
#import "MyFavVC.h"
#import "TSLanguageManager.h"

@interface AppDelegate ()
{
    SplashVC * appSplash;
    MFSideMenuContainerViewController * container;
    
}

@end

@implementation AppDelegate
@synthesize window;
@synthesize appLatitude,appLongitude,deviceTokenStr;


#pragma mark - Application Life Cycle

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions NS_AVAILABLE_IOS(6_0)
{
   
    [application setStatusBarHidden:YES];
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self preferredStatusBarStyle];
    CGFloat screenSize = [[UIScreen mainScreen] bounds].size.height;
    NSLog(@"Davice Widt%f@",screenSize);
    [Fabric with:@[[Crashlytics class]]];
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    NSLog(@"%s",__FUNCTION__);
    window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    isFirstTimePOPUp=YES;//For Checking InterNET
    
    /*-----track User location----*/
    appLatitude=@"";
    appLongitude=@"";
    deviceTokenStr=@"123";
    
    [self trackUserLocation];
    
    NSLog(@"Device Width======>%.0f",[[UIScreen mainScreen] bounds].size.width);
    NSLog(@"Device Height======>%.0f",[[UIScreen mainScreen] bounds].size.height);
    /*----PushNotification Method*/
    if( SYSTEM_VERSION_LESS_THAN( @"10.0" ) )
    {
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
            [application registerForRemoteNotifications];
        }
        else
        {
            // Register for Push Notifications before iOS 8
            [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
            [application enabledRemoteNotificationTypes];
        }
    }
    else
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
             if( !error )
             {
                 [[UIApplication sharedApplication] registerForRemoteNotifications];  // required to get the app to do anything at all about push notifications
                 NSLog( @"Push registration success." );
             }
             else
             {
                 NSLog( @"Push registration FAILED" );
                 NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                 NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );  
             }  
         }];  
    }
    
    /*----App Splash screen*/
    [self splashOn];
    
    /*--------------Facebook Login----------*/
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
  /*-------------- BTab Bar ----------*/
  
    return YES;
    
}

#pragma mark - App Splash
-(void)splashOn
{
    [UIApplication sharedApplication].statusBarHidden = YES;
    appSplash = [[SplashVC alloc] init];
    [window addSubview:appSplash.view];
    window.rootViewController = appSplash;
    [window makeKeyAndVisible];
    
      [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(cancelsplash) userInfo:nil repeats:NO];

}

#pragma mark - Cancel Splash
-(void)cancelsplash
{
    if(appSplash)
    {
        [appSplash.view removeFromSuperview];
        self->appSplash = nil;
    }
    /*Splash Screen*/
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
    [window addSubview:appSplash.view];
    [UIView commitAnimations];
    [UIApplication sharedApplication].statusBarHidden = NO;
    window.rootViewController = nil;
    
    [self infoMethod];

}
#pragma  mark -Setup Tab bar
-(void)infoMethod
{
    
    NSLog(@"%@", CURRENT_USER_ID);
    
        if([CURRENT_USER_SKIPBUTTON_CLICKED isEqual:[NSNull null]] || [CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@""] || CURRENT_USER_SKIPBUTTON_CLICKED == nil || CURRENT_USER_SKIPBUTTON_CLICKED == NULL || [CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"(null)"])
        {
            if([CURRENT_USER_SKIPBUTTON_CLICKED isEqualToString:@"1"])
            {
                [self setUpTabBarController];
            }
            else
            {
                if([CURRENT_USER_ID isEqual:[NSNull null]] || [CURRENT_USER_ID isEqualToString:@""] || CURRENT_USER_ID == nil || CURRENT_USER_ID == NULL || [CURRENT_USER_ID isEqualToString:@"(null)"]){
            
                if([CURRENT_USER_LANGUAGE isEqual:[NSNull null]] || [CURRENT_USER_LANGUAGE isEqualToString:@""] || CURRENT_USER_LANGUAGE == nil || CURRENT_USER_LANGUAGE == NULL || [CURRENT_USER_LANGUAGE isEqualToString:@"(null)"]){
                    if(COME_FROM_SETTING_SCREEN_TO_LANGUAGE)
                    {
                        if([COME_FROM_SETTING_SCREEN_TO_LANGUAGE isEqualToString:@"1"])
                        {
                            NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
                            [user setValue:@"0" forKey:@"COME_FROM_SETTING_SCREEN_TO_LANGUAGE"];
                        }
                        
                    }
                    LanguageSelectionVC * infoScreen = [[LanguageSelectionVC alloc] init];
                    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:infoScreen];
                    window.rootViewController=nav;
                    [window makeKeyAndVisible];
                }
                else
                {
                    [self loginMethod];
                }

            }
                else{
                    [self setUpTabBarController];
                }
        }
           
        }
        else{
            [self rootViewController];
           
    }
    
}

#pragma mark - Root view controller
-(void)rootViewController
{
//    LeftMenuVC * leftVc = [[LeftMenuVC alloc] init];
//    UINavigationController * leftNav = [[UINavigationController alloc] initWithRootViewController:leftVc];
//    NSUserDefaults *pre = [NSUserDefaults standardUserDefaults];
//    if([pre valueForKey:@"CURRENT_USER_ID"]==nil)
//    {
//    NewHomeVC *homeVC = [[NewHomeVC alloc] init];
//        UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
//        container = [MFSideMenuContainerViewController containerWithCenterViewController:homeNav leftMenuViewController:leftNav rightMenuViewController:nil];
//        container.panMode=MFSideMenuPanModeNone;
    
//        self.window.rootViewController = container;
//        [window makeKeyAndVisible];
//    }
//    else{
//        CompareCarVC * homeVC = [[CompareCarVC alloc] init];
//        UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
//        container = [MFSideMenuContainerViewController containerWithCenterViewController:homeNav leftMenuViewController:leftNav rightMenuViewController:nil];
//        container.panMode=MFSideMenuPanModeNone;
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        self.window.rootViewController = container;
//        [window makeKeyAndVisible];
//
//  
//    }
    [self setUpTabBarController];
    
    
  }

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)loginMethod
{
    NewAppInfoVC * infoScreen = [[NewAppInfoVC alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:infoScreen];
    window.rootViewController=nav;
    [window makeKeyAndVisible];

}
-(void)LanguageSelection
{
    LanguageSelectionVC * infoScreen = [[LanguageSelectionVC alloc] init];
     infoScreen.strComeFromSettings = @"1";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:infoScreen];
    window.rootViewController=nav;
    [window makeKeyAndVisible];

}
-(void)logoutMethod
{
 
    NSUserDefaults *pre = [NSUserDefaults standardUserDefaults];
    [pre removeObjectForKey:@"CURRENT_USER_ID"];
    [pre removeObjectForKey:@"CURRENT_USER_EMAIL"];
    [pre removeObjectForKey:@"CURRENT_USER_FIRST_NAME"];
    [pre removeObjectForKey:@"CURRENT_USER_IMAGE"];
    [pre removeObjectForKey:@"CURRENT_USER_LAST_NAME"];
    [pre removeObjectForKey:@"CURRENT_USER_PHONE_NUMBER"];
    [self loginMethod];
}
#pragma mark- Set-Up Tatbar
-(void)setUpTabBarController
{
     tabBarController = [[UITabBarController alloc] init];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
    //------Home View Controller--------//
    NewHomeVC * firstViewController = [[NewHomeVC alloc] init];
    firstViewController.title =@"New Cars";
    firstViewController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"New" image:[[UIImage imageNamed:@"car new.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"car new_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    UINavigationController *firstNavigation = [[UINavigationController alloc]initWithRootViewController:firstViewController];
    
    //------Used Car View Controller--------//
    UsedcarNewVC * secondViewController = [[UsedcarNewVC alloc]init];
    secondViewController.title=@"Used";
    secondViewController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Used" image:[[UIImage imageNamed:@"car used.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"car used_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    UINavigationController *secondNavigation = [[UINavigationController alloc]initWithRootViewController:secondViewController];
    
    //------Compare Car View Controller--------//

    CompareCarVC *thirdViewController = [[CompareCarVC alloc] init];
    thirdViewController.title = @"Comapre";
    thirdViewController.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"Compare" image:[[UIImage imageNamed:@"compare_tab.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"compare_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *thirdNavigation = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
    
    //--------News View Controller---//
    NewsVC *fourthViewController = [[NewsVC alloc] init];
    fourthViewController.title = @"News";
    fourthViewController.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"News" image:[[UIImage imageNamed:@"news_tab.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"news_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *fourthNavigation = [[UINavigationController alloc] initWithRootViewController:fourthViewController];
   
    //---------Check On road Price---//
    
    MyFavVC *fifthViewController = [[MyFavVC alloc] init];
    fifthViewController.title = @"Price";
    fifthViewController.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"Price" image:[[UIImage imageNamed:@"price_2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"price_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *fifthNavigation = [[UINavigationController alloc] initWithRootViewController:fifthViewController];
        
        tabBarController.viewControllers = [[NSArray alloc] initWithObjects:firstNavigation,secondNavigation,thirdNavigation,fourthNavigation,fifthNavigation,nil];
    }
    else
    {
        
        //---------Check On road Price---//
        
        MyFavVC *fifthViewController = [[MyFavVC alloc] init];
        fifthViewController.title = [TSLanguageManager localizedString:@"Price"];
        fifthViewController.tabBarItem =[[UITabBarItem alloc]initWithTitle:[TSLanguageManager localizedString:@"Price"] image:[[UIImage imageNamed:@"price_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"price_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *fifthNavigation = [[UINavigationController alloc] initWithRootViewController:fifthViewController];
        //--------News View Controller---//
        NewsVC *fourthViewController = [[NewsVC alloc] init];
        fourthViewController.title = [TSLanguageManager localizedString:@"NEWS"] ;
        fourthViewController.tabBarItem =[[UITabBarItem alloc]initWithTitle:[TSLanguageManager localizedString:@"NEWS"] image:[[UIImage imageNamed:@"news_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"news_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *fourthNavigation = [[UINavigationController alloc] initWithRootViewController:fourthViewController];
        
        
        //------Compare Car View Controller--------//
        
        CompareCarVC *thirdViewController = [[CompareCarVC alloc] init];
        thirdViewController.title = [TSLanguageManager localizedString:@"Compare"];
        thirdViewController.tabBarItem =[[UITabBarItem alloc]initWithTitle:[TSLanguageManager localizedString:@"Compare"] image:[[UIImage imageNamed:@"compare_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"compare_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *thirdNavigation = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
        
        //------Used Car View Controller--------//
        UsedcarNewVC * secondViewController = [[UsedcarNewVC alloc]init];
        secondViewController.title=[TSLanguageManager localizedString:@"Used"];
        secondViewController.tabBarItem=[[UITabBarItem alloc] initWithTitle:[TSLanguageManager localizedString:@"Used"] image:[[UIImage imageNamed:@"car used"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"car used_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        UINavigationController *secondNavigation = [[UINavigationController alloc]initWithRootViewController:secondViewController];
        
        //------Home View Controller--------//
        NewHomeVC * firstViewController = [[NewHomeVC alloc] init];
        firstViewController.title =[TSLanguageManager localizedString:@"New"];
        firstViewController.tabBarItem=[[UITabBarItem alloc] initWithTitle:[TSLanguageManager localizedString:@"New"] image:[[UIImage imageNamed:@"car new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"car new_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        UINavigationController *firstNavigation = [[UINavigationController alloc]initWithRootViewController:firstViewController];
      
        tabBarController.viewControllers = [[NSArray alloc] initWithObjects:fifthNavigation,fourthNavigation,thirdNavigation,secondNavigation,firstNavigation,nil];
    
    }
   
    tabBarController.tabBar.tintColor = APP_BUTTON_COLOR;
    tabBarController.delegate = self;
    tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    LeftMenuVC * sideMenuViewController = [[LeftMenuVC alloc] init];
    UINavigationController * leftNav = [[UINavigationController alloc] initWithRootViewController:sideMenuViewController];
    
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        tabBarController.selectedIndex=0;
        container = [MFSideMenuContainerViewController containerWithCenterViewController:tabBarController leftMenuViewController:leftNav rightMenuViewController:nil];

    }else
    {
        tabBarController.selectedIndex=4;
        container = [MFSideMenuContainerViewController containerWithCenterViewController:tabBarController leftMenuViewController:nil rightMenuViewController:leftNav];

    }
   
    container.panMode=MFSideMenuPanModeNone;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController = container;
    [window makeKeyAndVisible];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//#pragma mark - Social login options iOS >8
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    if ([[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation])
//    {
//        return YES;
//    }
//    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url
//            // [START old_options]
//                                                sourceApplication:sourceApplication annotation:annotation];
//}
//#pragma mark - Social login options iOS <9
//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary *)options {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//}

#pragma mark - Open Url
- (BOOL)application:(nonnull UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *, id> *)options
{
    return [self application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([[url scheme] caseInsensitiveCompare:@"fb158864688016605"]==NSOrderedSame){
        return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];}
    
    else{
        return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}

//- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
//{
//    if (error == nil) {
//        GIDAuthentication *authentication = user.authentication;
//        FIRAuthCredential *credential =
//        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
//                                         accessToken:authentication.accessToken];
//        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"Error %@", error.localizedDescription);
//            }
//        }];
//    } else {
//        NSLog(@"Error %@", error.localizedDescription);
//    }
//}

#pragma mark - Color conversion Hexa to String
-(UIColor *) colorWithHexString:(NSString *)stringToConvert
{
    // NSLog(@"ColorCode -- %@",stringToConvert);
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            
                           green:((float) g / 255.0f)
            
                            blue:((float) b / 255.0f)
            
                           alpha:1.0f];
}


-(BOOL)getInternetStatus
{
    BOOL iSNetAvaliable;
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        iSNetAvaliable=NO;
        
        NSLog(@"There IS NO internet connection");
        if (isFirstTimePOPUp == YES)
        {
            isFirstTimePOPUp=NO;
            
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[NSString stringWithFormat:@"Please check internet connection!"] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView setMessageFont:[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{
                    isFirstTimePOPUp=YES;
                    [alertView removeFromSuperview];
                }];
            }];
            [alertView showWithAnimation:URBAlertAnimationTopToBottom];
        }
    }else
    {
        isFirstTimePOPUp=YES;
        iSNetAvaliable=YES;
    }
    
    return iSNetAvaliable;
}
#pragma mark - Location Method
-(void)trackUserLocation
{
    /*-----------Start Location Manager----------*/
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    if(IS_OS_8_OR_LATER)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}

#pragma mark Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //      NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        
        appLatitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
        appLongitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
        //[self trackUserLocation];
    }
}

#pragma mark - Remote notification Delegate Methods
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    deviceTokenStr = [[[[deviceToken description]
                        stringByReplacingOccurrencesOfString: @"<" withString: @""]
                       stringByReplacingOccurrencesOfString: @">" withString: @""]
                      stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"My device token ============================>>>>>>>>>>>%@",deviceTokenStr);
}

#pragma mark - Less then iOS 10
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler
{
    // iOS 10 will handle notifications through other methods
    
    if( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( @"10.0" ) )
    {
        NSLog( @"iOS version >= 10. Let NotificationCenter handle this one." );
        // set a member variable to tell the new delegate that this is background
        return;
    }
    NSLog( @"HANDLE PUSH, didReceiveRemoteNotification: %@", userInfo );
    
    // custom code to handle notification content
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        NSLog( @"INACTIVE" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        NSLog( @"BACKGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
    else
    {
        NSLog( @"FOREGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{  
    [self application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult result) {  
    }];  
}

#pragma mark - iOS 10 On words
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog( @"Handle push from foreground" );
    // custom code to handle push while app is in the foreground
    NSLog(@"%@", notification.request.content.userInfo);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler
{
    NSLog( @"Handle push from background or closed" );
    // if you set a member variable in didReceiveRemoteNotification, you  will know if this is from closed or background
    NSLog(@"%@", response.notification.request.content.userInfo);
}

#pragma mark - Hud methods
-(void)showProcessHud
{
    [self.window.rootViewController showSpinner:nil];
}
-(void)hideProcessHud
{
    [self.window.rootViewController hideSpinner:nil];

}

#pragma mark Email validation
-(BOOL)validateEmail:(NSString*)email
{
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        
        return TRUE;
    }
    else {// no '@' or '.' present
        return FALSE;
    }
}

#pragma mark -->  Drow Line On textField


- (void)drawLineDivider:(UITextField *)Textfield
{
    for (UIView* b in Textfield.subviews)
    {
        [b removeFromSuperview];
    }
    
    UILabel *bottomBorder;
    [bottomBorder removeFromSuperview];
    bottomBorder = [[UILabel alloc]init];
    bottomBorder.frame = CGRectMake(0,0, 0,0);
    bottomBorder.frame = CGRectMake(0.0f, Textfield.frame.size.height - 2.0,0, 1.0f);
    
    CGFloat duration = 0.0;
    bottomBorder.backgroundColor = APP_BUTTON_COLOR;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseInOut animations:^{
        bottomBorder.frame = CGRectMake(0.0f, Textfield.frame.size.height - 0.5, Textfield.frame.size.width, 2.0f);
    } completion:^(BOOL finished) { }];
    bottomBorder.layer.cornerRadius=0.75;
    [Textfield addSubview:bottomBorder];
}

- (void)HideLineDivider:(UITextField *)Textfield
{
    for (UIView* b in Textfield.subviews)
    {
        [b removeFromSuperview];
    }
    UILabel *bottomBorder;
    [bottomBorder removeFromSuperview];
    bottomBorder = [[UILabel alloc]init];
    bottomBorder.frame = CGRectMake(0,0, 0,0);
    bottomBorder.frame = CGRectMake(0.0f, Textfield.frame.size.height - 1.5,Textfield.frame.size.width, 1.0f);
    CGFloat duration = 0.0;
    bottomBorder.backgroundColor = APP_BUTTON_COLOR;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseOut animations:^{
        bottomBorder.frame = CGRectMake(0,0, 0,0);
    } completion:^(BOOL finished)
     {
         bottomBorder.backgroundColor = APP_THEAM_COLOR;
     }];
    bottomBorder.layer.cornerRadius=0.75;
    [Textfield addSubview:bottomBorder];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"dsfs");
    
}
#pragma mark - Currency String
-(NSString*)datafromServer:(NSString*)actualAmount
{
    float shortenedAmount = [actualAmount floatValue];
    NSString *suffix = @"";
    if(shortenedAmount >= 10000000.0f) {
        suffix = @"C";
        shortenedAmount /= 10000000.0f;
    }
    else if(shortenedAmount >= 1000000.0f) {
        suffix = @"M";
        shortenedAmount /= 1000000.0f;
    }
    else if(shortenedAmount >= 100000.0f) {
        suffix = @"L";
        shortenedAmount /= 100000.0f;
    }
    else if(shortenedAmount >= 1000.0f) {
        suffix = @"K";
        shortenedAmount /= 1000.0f;
    }

    //    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:shortenedAmount]];

    NSString *requiredString = [NSString stringWithFormat:@"%@%@", numberAsString, suffix];
    NSLog(@"%@",requiredString);
    return requiredString;
}

@end
