//
//  AppDelegate.h
//  carwale
//
//  Created by One Click IT Consultancy  on 7/31/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import "UIViewController+Alerts.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

BOOL isFirstLocationPopUp;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate,UITabBarControllerDelegate>
{
    BOOL isFirstTimePOPUp;
    CLLocationManager * locationManager;
    UITabBarController * tabBarController;
}

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) NSString * appLatitude;
@property(strong,nonatomic) NSString * appLongitude;
@property(nonatomic,strong) NSString * deviceTokenStr;

-(void)rootViewController;
-(UIColor *)colorWithHexString:(NSString *)stringToConvert;
-(BOOL)getInternetStatus;
-(void)showProcessHud;
-(void)hideProcessHud;
-(void)setUpTabBarController;
-(BOOL)validateEmail:(NSString*)email;
- (void)drawLineDivider:(UITextField *)Textfield;
- (void)HideLineDivider:(UITextField *)Textfield;
-(void)loginMethod;
-(void)logoutMethod;
-(void)LanguageSelection;
-(NSString*)datafromServer:(NSString*)actualAmount;
- (UIStatusBarStyle)preferredStatusBarStyle;
@end

