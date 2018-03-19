//
//  CheckValuationVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "SelectCityVC.h"
@interface CheckValuationVC : UIViewController<UITextFieldDelegate>
{
    UIScrollView *scrlContent;
    UIView * navView;
    UILabel * lblHeader;
    UILabel *LineSelectcityLbl,*LineManufacturingLbl,*LineSelectMakeLbl,*LineSelectModelLbl,*LineSelectVersionLbl,*LineNumberOfOwnersLbl;
    UIButton   *btnSideMenu,*locationBtn,*btncheckValuation;
    JVFloatLabeledTextField *txtSelectcity,*txtManufacturingYear,*txtSelectMake,*txtSelectModel,*txtSelectVersion,*txtNumberOfOwners;
}
@end
