//
//  LoacalDealarVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoacalDealarVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnSideMenu,*locationBtn;
    UICollectionView *brandNameCollectionView;
    NSMutableDictionary *dictCar1,*dictCar2;
    NSMutableArray *arrCar;
}
@end
