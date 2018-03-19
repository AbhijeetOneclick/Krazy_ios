//
//  HomeVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/4/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompareCarsCell.h"
#import "CompareCarsFlowLayout.h"
#import "iCarousel.h"
#import "TTRangeSlider.h"
#import "RangeSlider.h"
#import "MBProgressHUD.h"



@interface HomeVC : UIViewController<UIScrollViewDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource,TTRangeSliderDelegate,URLManagerDelegate>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnSideMenu,*locationBtn;
    UIImageView * imgHeaderLogo;
    
    UIButton * btnNewCars, * btnUsedCars;
    UILabel * lblSelerator;
    
    UIScrollView * scrolContent, * scrolMain, * scrolUsedCar,* newCarOffer;
    
    UISearchBar * searchCars, * searchPrice;
    UIImageView * searchImgGlass;
    UILabel * lblBackground;
    
    UITableView * tblSearchCar;
    NSMutableArray * arraySearchCars;
    
    UIButton * btnFindCar;
    
    UIView * viewCars,*BackView,*presentView;
    
    UICollectionView *_cCompareCars;
    
    UILabel * sepFeatureCar, * sepLatestCars;
    UIView * viewUpcomingCars, * viewJustLaunchedCars , * viewCarNews, * viewVideos;
    
    UIScrollView * scrolFeatures, * scrolCarUpdates;
    
    MBProgressHUD *ProgressHUD;
    
    //###### User Cars UI Objects #####//
    
    UIView * viewRangeCar, * viewLastVisited, * viewPopularCars, * viewBuying;
    UIButton * btnSellCar, * btnCheckValue;
    
    UILabel * lblPriceRange;
    
    NSURL *url;
}

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) CompareCarsFlowLayout * compareFlowLayout;
@property (nonatomic, strong) iCarousel * compareCars;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) TTRangeSlider * rangeSlider;
@property (nonatomic, strong) RangeSlider *slider;
@property (nonatomic, strong) UIView*LocationView;
@property (nonatomic, strong) NSMutableArray *carBrandArray,*carTypeArray,*CompareCarArry,*GetCarModel;




@end
