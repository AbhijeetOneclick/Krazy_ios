//
//  NewHomeVC.h
//  carwale
//
//  Created by i-MaC on 11/10/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Constant.h"
#import "URLManager.h"
#import "CarDetailVC.h"
#import "FilterCarVC.h"
#import "popularCarFlowLayout.h"
#import "compareCarFlowlayout.h"
#import "upcomingLaunchCarFlowLayout.h"
#import "VideoCarFlowLayout.h"
#import "PhotoCarFlowLayout.h"
#import "justLauchCarFlowLayout.h"
#import "NewsCarFlowLayout.h"
#import "MXParallaxHeader.h"
#import "MXScrollView.h"

@interface NewHomeVC : UIViewController<iCarouselDelegate,iCarouselDataSource,URLManagerDelegate,UISearchBarDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,MXScrollViewDelegate>
{
    UIScrollView *scrollContent;
    UIImageView *backGroundImg;
    UIButton *btnSideMenu,*btnNavgation,*btnAdvanceSerch,*btnViewAllUpcomingCar,*btnViewPopularCar,*btnCheckOnRoadPrice, * btnAllCompareCars,*btnMake,*btnEmi,*btnBodyType, *btnFuelType,*btnViewallNews;
    UIView *navView;
    UISearchBar *serchCar;
    UIView * viewCars,*BackView,*presentView;
    UITextField *txtCheckOnRoadPrice;
    
    
    
    UILabel * lblPopulerError, * lblCompareError, * lblUpcomingCarError, * lblLauncgedError, *lblImagesError, * lblVideosError, * lblNewCarsError;

}
@property (nonatomic, strong) UIView*LocationView;
@property (nonatomic, strong) UICollectionView *popularCarCollectionView,*compareCarCollectionview,*upcomingCarCollectionview,*justLaunchedCollectionView,*newsCollectionview,*photoCarCollectionView,*VideoCollectionView;
@property (nonatomic, strong) popularCarFlowLayout * popularCarFlow;
@property (nonatomic, strong) compareCarFlowlayout * compareCarFlow;
@property (nonatomic, strong) upcomingLaunchCarFlowLayout * upcomingCarFlow;
@property (nonatomic, strong) justLauchCarFlowLayout * justLauchFlow;
@property (nonatomic, strong) NewsCarFlowLayout * NewsCarFlow;
@property (nonatomic, strong) PhotoCarFlowLayout * PhotoCarFlow;
@property (nonatomic, strong) VideoCarFlowLayout * VideoCarFlow;
@property (nonatomic, strong) iCarousel * compareCars,*popularCar,*upcomingCar,*NewsCar,*photosCar,*videoCar ,* launchedCars;
@property (nonatomic, strong) NSMutableArray *CompareCarArry,*GetCarModelArray,*GetNewsArray, * arrUpcomingCars, * arrLaunchedCars;
@property (nonatomic, assign) BOOL wrap;
@end
