//
//  UsedCarFilterVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 18/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsedCarFilterVC.h"
#import "HMSegmentedControl.h"
#import "TTRangeSlider.h"
#import "Constant.h"

@interface UsedCarFilterVC : UIViewController<UITableViewDelegate,UITableViewDataSource,TTRangeSliderDelegate,UISearchBarDelegate>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton *btnSideMenu;
    
    UISegmentedControl *filterSegment;
    UIView *selectFilterTypeView;
    
    NSMutableArray *filterArr,*sortByArr;
    UITableView *tblFilter;
    
    UILabel *lblFilterType;
    
     UILabel *lblrangeShow3,*lblrangeShow6,*lblrangeShow7;
    
    HMSegmentedControl *segmentedControlFilter;
    UIButton *btnSelectFilterType;
    UIButton *btnUnselectCity;
    UIImageView *imageShow,*imageShow3,*imageShow6,*imageShow7;
    
    //===========Select Loaction=============//
    UIView *selectLocatioView;
    UITableView *tblLocation;
    UISearchBar *searchCity;
    UIImageView *imageArrow;
    NSMutableArray *cityNameArr;
    NSArray *searchResults;
    BOOL isSearching,ismainTable;
    
    NSString *getCitYString;
    
    //===========select Transmission Type================//
    NSMutableArray *transCarTypeArr;
    
    //===========select Fuel Type================//
    
    NSMutableArray*fuelTypeArr;
    
    //===========select OwnerShip========//
    NSMutableArray *ownerShipArr;
    
    //===========select OwnerShip========//
    NSMutableArray *transMissionArr;
    
    //===========select BodyType========//
    NSMutableArray *bodyTypeArr;
    
    
    
    
}
@property (nonatomic, strong) TTRangeSlider * rangeSlider3,* rangeSlider6,* rangeSlider7;
@end
