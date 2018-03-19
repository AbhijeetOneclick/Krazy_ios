//
//  usedCarListVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 14/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface usedCarListVC : UIViewController<UITableViewDataSource,UITableViewDelegate,URLManagerDelegate>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnSideMenu,*btnChangeView;
    UICollectionView *brandNameCollectionView;
    NSMutableDictionary *dictCar1,*dictCar2;
    NSMutableArray *usedCarArr;
    UITableView *listCarviewTbl,*detailcarViewTbl;
    CGRect floatFrame;
    UIButton * FilterBtn;
}
@property (nonatomic, assign) BOOL isSelectChangeTblView;
@property (nonatomic, assign) BOOL isShowFilter;
@end
