//
//  SerchCarVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 15/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLManager.h"

@interface SerchCarVC : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,URLManagerDelegate>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton *btnSideMenu;
    UISearchBar *SearchField;
    UITableView *CityTbl;
    NSMutableArray *searchCarArr;
    NSArray *searchResults;
    BOOL isSearching;
}
@end
