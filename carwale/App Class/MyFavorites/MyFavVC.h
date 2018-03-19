//
//  MyFavVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/4/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavCarFlowLayout.h"
#import "FavCarCell.h"


@interface MyFavVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnSideMenu, *bntFilter;
    UIImageView * imgHeaderLogo;
    
    NSMutableArray * arrFavCars;
}

@property (nonatomic, strong) UICollectionView *collectionviewCars;
@property (nonatomic, strong) FavCarFlowLayout * carFlowLayout;

@end
