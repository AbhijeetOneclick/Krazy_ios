//
//  LanguageSelectionVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 25/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLanguageManager.h"

@interface LanguageSelectionVC : UIViewController
{
    UIButton * btnEnglish;
    UIButton * btnArebic;
    
    UIView *navView;
    
    UILabel* lblEnglish;
    UILabel* lblArebic;
    
    UIImageView* imgEnglish;
    UIImageView* imgArebic;
    
    NSString * strForIdentifyEnglishLanguageSelection;
    NSString*strForIdentifyArebicLanguageSelection;
    NSString* selected_languaage;
    NSString *strSelect;
    
    UIButton* btnSelect;
}
@property(nonatomic,strong)NSString* strComeFromSettings;

@end
