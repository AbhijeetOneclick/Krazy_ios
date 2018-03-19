//
//  Constant.h
//  ibeacon stores
//
//  Created by One Click IT Consultancy  on 5/14/14.
//  Copyright (c) 2014 One Click IT Consultancy . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Constant <NSObject>

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6plus (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height ==  812.0f)
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication]delegate]


#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]



#define iPhone6 1.17
#define iPhone6Plus 1.29

#define customErrorCodeForMessage 123456

#define kEmptyString @""

#define Alert_Animation_Type URBAlertAnimationTopToBottom


//#define WEB_SERVICE_URL @"http://192.168.0.122:3000/"
//#define WEB_SERVICE_URL @"http://192.168.0.153:3000/"
#define WEB_SERVICE_URL @"http://oneclickitmarketing.co.in/subdomain/krazy/users/"
#define WEB_SERVICE_URL_BRAND @"http://oneclickitmarketing.co.in/subdomain/krazy/brands/"
#define WEB_SIGNIN_URL @"oneclickitmarketing.co.in/subdomain/krazy/users/normalSignup/"
#define WEB_SERVICE_URL_MODEL @"http://oneclickitmarketing.co.in/subdomain/krazy/models/"
#define WEB_SERVICE_NEWS @"http://oneclickitmarketing.co.in/subdomain/krazy/news/"
#define WEB_SERVICE_USEDCAR @"http://oneclickitmarketing.co.in/subdomain/krazy/usedcar/"
#define WEB_APIKEY @"ad9126a546854f9cae115a039209d849"


#define ALERT_TITLE [TSLanguageManager localizedString:@"Krazy"] //Kalpesh 29-10-2016
#define OK_BTN [TSLanguageManager localizedString:@"OK"]
#define ALERT_CANCEL [TSLanguageManager localizedString:@"Cancel"]
#define FONT @"Roboto-Regular"

#define ACTION_TAKE_PHOTO [TSLanguageManager localizedString:@"Take Photo"]
#define ACTION_LIBRARY_PHOTO [TSLanguageManager localizedString:@"Photo From Library"]
#define CONNECTION_FAILED [TSLanguageManager localizedString:@"Please check internet connection"] 


#pragma mark User Credential-----------------------------------------
#define CURRENT_TV_USER_CAN_ACCESS_ALL_LISTING [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_CAN_ACCESS_ALL_LISTING"]



#define CURRENT_TV_USER_CONTACT_NAME [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_CONTACT_NAME"]
#define CURRENT_TV_USER_CONTACT_EMAIL [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_CONTACT_EMAIL"]
#define CURRENT_TV_USER_CONTACT_NUMBER [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_CONTACT_NUMBER"]
#define CURRENT_TV_LOGIN_ID [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_LOGIN_ID"]
#define CURRENT_TV_IS_FROM_ANONYMOUS [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_IS_FROM_ANONYMOUS"]
#define CURRENT_TV_LOGIN_TYPE [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_LOGIN_TYPE"]


#define CURRENT_USER_SKIPBUTTON_CLICKED [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_USER_SKIPBUTTON_CLICKED"]

#define CURRENT_TV_USER_REQUESTED_PROPERTIES [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_REQUESTED_PROPERTIES"]

#define CURRENT_TV_USER_SELECTED_BEDROOM_PREFERENCE [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_SELECTED_BEDROOM_PREFERENCE"]
#define CURRENT_TV_USER_SELECTED_BATHROOM_PREFERENCE [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_SELECTED_BATHROOM_PREFERENCE"]
#define CURRENT_TV_USER_SELECTED_MIN_PRICE_PREFERENCE [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_SELECTED_MIN_PRICE_PREFERENCE"]
#define CURRENT_TV_USER_SELECTED_MAX_PRICE_PREFERENCE [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_SELECTED_MAX_PRICE_PREFERENCE"]
//#define jesh [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_SELECTED_PROPERTY_TYPES_PREFERENCE"]
#define CURRENT_TV_USER_SELECTED_KEYWORDS_PREFERENCE [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_TV_USER_SELECTED_KEYWORDS_PREFERENCE"]
#define CURRENT_TV_USER_SELECTED_COMMUNITY_PREFERENCE [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_SELECTED_COMMUNITY_PREFERENCE"]
#define CURRENT_TV_USER_SELECTED_PROPERTY_TYPES_PREFERENCE [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_SELECTED_PROPERTY_TYPES_PREFERENCE"]


#define CURRENT_TV_USER_NAME [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_NAME"]
#define CURRENT_TV_USER_EMAIL [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_EMAIL"]
#define CURRENT_TV_USER_IMAGE [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_IMAGE"]
#define CURRENT_TV_USER_NUMBER [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_NUMBER"]
#define AUGUSTS_ACCOUNT_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"AUGUSTS_ACCOUNT_ID"]
#define AUGUSTS_LOGIN_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"AUGUSTS_LOGIN_ID"]
#define AUGUSTS_LOGIN_TYPE [[NSUserDefaults standardUserDefaults] objectForKey:@"AUGUSTS_LOGIN_TYPE"]

#define CURRENT_TV_USER_JWT_TOKEN [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_JWT_TOKEN"]//JSON WEB TOKEN


#define CURRENT_TV_USER_LOGIN_TYPE [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_TV_USER_LOGIN_TYPE"]

#define CURRENT_USER_ID [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_ID"]
#define CURRENT_USER_ACCESS_TOKEN [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_ACCESS_TOKEN"]
#define CURRENT_USER_USER_NAME [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_USER_NAME"]


#define CURRENT_USER_EMAIL [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_EMAIL"]
#define CURRENT_USER_FIRST_NAME [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_FIRST_NAME"]
#define CURRENT_USER_LAST_NAME [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_LAST_NAME"]
#define CURRENT_USER_IMAGE [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_IMAGE"]
#define CURRENT_USER_GENDER [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_GENDER"]
#define CURRENT_USER_BIRTHDATE [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_BIRTHDATE"]
#define CURRENT_USER_PHONE_NUMBER [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_PHONE_NUMBER"]
#define CURRENT_USER_LANGUAGE [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_LANGUAGE"]
#define COME_FROM_SETTING_SCREEN_TO_LANGUAGE [[NSUserDefaults standardUserDefaults] valueForKey:@"COME_FROM_SETTING_SCREEN_TO_LANGUAGE"]
#define COME_FIRST_TIME [[NSUserDefaults standardUserDefaults] valueForKey:@"COME_FIRST_TIME"]



#pragma mark - Color Codes-----------------------------------------

#define dark_gray_color @"4d4d4d"
#define light_gray_bg_color @"e4e4e4"

//#define dark_red_color @"ff3b30"
#define dark_red_color @"ae0125"


#define dark_blue_color @"175181"
#define AppNavHeader_white_color @"FFFFFF"
#define APP_THEAM_COLOR [UIColor colorWithRed:41.0/255.0 green:164.0/255.0 blue:158.0/255.0 alpha:1.0]
#define APP_BUTTON_COLOR [UIColor colorWithRed:219.0/255.0 green:11.0/255.0 blue:11.0/255.0 alpha:1.0]
#define APP_HEADER_COLOR [UIColor colorWithRed:7/255.0 green:99.0/255.0 blue:150.0/255.0 alpha:1.0]


#define AppHeaderColor @"026a5f"

//#define skyblue_color_code @"34bba0"

#define skyblue_color_code @"5BAFE2"
#define Label_title_color [UIColor colorWithRed:103/255.0 green:107.0/255.0 blue:109.0/255.0 alpha:1.0]
#define Label_sub_title_color [UIColor colorWithRed:136/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0]

#define light_gray_color @"e4e3e3"


#define dark_green_color @"3C905A"
#define light_green_color @"2dce28"
#define App_green_color @"00c9a6"

#define App_Background_color @"D8D9D8"

#define color_search_bar_textfield_bg @"4a5473"

#pragma mark - Images 
#define Icon_Menu @"icon_menu.png"
//#define Image_App_Background @"bg.png"
#define Image_App_Background @"i5_bg.png"


@end
