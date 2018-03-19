//
//  SelectCityVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 04/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityVC : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton *btnSideMenu;
    UISearchBar *SearchField;
    UITableView *CityTbl;
    NSMutableArray *cityNameArr;
    NSArray *searchResults;
    BOOL isSearching;
}
@end
