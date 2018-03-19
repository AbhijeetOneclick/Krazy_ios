//
//  NewCarOfferVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLManager.h"
@interface NewCarOfferVC : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,URLManagerDelegate>
{
    UIView * navView,*carDetials;
    UITableView *newCarOfferInfoTbl;
    UIScrollView *scrlMain;
    NSMutableDictionary *dictCar1,*dictCar2,*dictCar3;
    UILabel * lblHeader,*carName;
    UIButton   *btnSideMenu,*locationBtn;
    NSArray *arrCarImg,*arrCarName,*arrCarPrice,*arrArea;
    NSMutableArray *arrCar;
    
}
@property (nonatomic,strong) NSString *strBrandGet;
@property (nonatomic,strong) NSString *strFuelTypeGet;
@property (nonatomic,strong) NSString *strTrasmissionTypeGet;
@property (nonatomic,strong) NSString *strBodyTypeGet;

@end
