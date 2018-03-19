//
//  CompareCarVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "compareCarFlowlayout.h"
#import "PopularComapreCarCell.h"
#import "CompareTestCarCell.h"

@interface CompareCarVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,URLManagerDelegate>
{
    UIView * navView;
    UILabel * lblHeader, *lblPopulerError,*lblCompareTestError;
    UIButton   *btnSideMenu,*locationBtn;
    UIScrollView *scrollContent;
}
@property (nonatomic, strong) UICollectionView *CompareCarCollectionView , *CompareTestCollectionView;
@property (nonatomic, strong) compareCarFlowlayout * popularCompareCarFlow,*compareTestCarFlow;
@property (nonatomic, strong) NSMutableArray *CompareCarArry,*CompareCarTestArry;
@end
