//
//  UpcomingCarVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UpcomingCarVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnSideMenu,*locationBtn;
    UITableView *UpcomingCarDataTbl;
    NSMutableDictionary *dictCar1,*dictCar2,*dictCar3;
    NSMutableArray *arrCar;
}
@end
