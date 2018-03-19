//
//  FilterCarVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 05/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLManager.h"
#import "TTRangeSlider.h"
#import "DVSwitch.h"
#import "NewCarOfferVC.h"

@interface FilterCarVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,TTRangeSliderDelegate,URLManagerDelegate>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnSideMenu;
    UIImageView * imgHeaderLogo;
    UITableView *tblFilter;
    UIView * viewTableHeader;
    UIPickerView *priceLevelPicker;
    UILabel *lblPricelevel ;
    UIView *showPickerView;
    UIImageView *imageArrow;
    UIButton * btn;
    UILabel *lblRange;
    UILabel *lblSortBy;
    UIImageView *upselectedDown;
    UIImageView *DownselectedUp;
    
    BOOL isSectedPrice;
    
    NSMutableArray *sectionArray;
    NSMutableArray *priceLevelArray;
    NSMutableArray *brandNameArr;
    NSMutableArray *CarTypeArr;
    NSMutableArray *transCarTypeArr;
    NSMutableArray *fuelTypeArr;
    NSString * strBrand;
    NSString * strFuel ;
    NSString * strBodyType;
    NSString * strTransmisooinType;
    
    NSArray *arrCar;
    UIView *lineBottom;
    
    NSMutableDictionary *dicCategory;
}
@property (nonatomic, strong) TTRangeSlider * rangeSlider;
@property (nonatomic, strong) NSString *strSelectedTypeName;
@property (nonatomic, assign) BOOL* isSected;
@property (nonatomic, assign) BOOL isSectedPrice;
@end
