//
//  UsedcarNewVC.h
//  carwale
//
//  Created by Oneclick IT Solution on 12/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "TTRangeSlider.h"
#import "URLManager.h"
#import "AsyncImageView.h"
#import "RecentSerchCarFlowLayout.h"
#import "MXParallaxHeader.h"
#import "MXScrollView.h"

@interface UsedcarNewVC : UIViewController <UIScrollViewDelegate,iCarouselDelegate,iCarouselDataSource,TTRangeSliderDelegate,URLManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MXScrollViewDelegate,UIScrollViewDelegate,TTRangeSliderDelegate>
{
    UIScrollView *scrollContent;
    UIImageView *backGroundImg;
    UIView *navView;
    UIButton *btnSideMenu,*btnFindCar;
    UIView * viewCars,*BackView,*presentView;
    UITextField *txtCheckOnRoadPrice;
    UILabel *lblRange;
    NSMutableArray *GetCarModelArray;
    UIButton *btnViewAllUpcomingCar;
}
@property (nonatomic, strong) TTRangeSlider * rangeSlider;
@property (nonatomic, strong) iCarousel *recentLauchedCar,*certifiedCar,*recentSearchCar;
@property (nonatomic, strong) UICollectionView *recentSearchCarCollectionView,*certifiedCarCollectionView,*recentAddCarCollectionview;
@property (nonatomic, strong) RecentSerchCarFlowLayout *recentSerchFlowLayout;
@property (nonatomic, assign) BOOL wrap;
@end
