//
//  FIndCarVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/8/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "TTRangeSlider.h"
#import "URLManager.h"
#import "AsyncImageView.h"

@interface FindCarVC : UIViewController <UIScrollViewDelegate,iCarouselDelegate,iCarouselDataSource,TTRangeSliderDelegate,URLManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView * viewHeader;
    UIButton * btnBack, * btnFindCar;
    UILabel * lblHeaderTitle;
    
    UIScrollView * scrolContent, * scrolCarDeatils, * scrolFeatures, * scrolBrand, * scrolBudget, * scrolBodyType;
    
    UIView * viewBrand, * viewBudget, * viewBodyType, * viewPopularCar, * viewJustLaunched, * viewComareCars, * viewBuyingTools, *viewPopular, *viewCarBrands;
    
    UIButton * btnBrands, * btnBudget, * btnBodyType, * btnPopular, * btnJustLaunched, * btnViewAllCars, * btnDetails, * btnSeller, * btnCheckValue, *btnmoreFeatureCars;
    UILabel * lblFeaturedCars, * lblPrice;
    UILabel * sepFeatureCar, * sepCarDetails;
    NSArray * brandNameArr,*CarTypeArr;
    UICollectionView * carBrnadAndTypeCollectionView,*CarTypeCollectionView;
    BOOL isCarBarnd,isCarType;
    
}
@property (nonatomic, strong) TTRangeSlider * rangeSlider;
@property (nonatomic, strong) iCarousel * compareCars;
@property (nonatomic, assign) BOOL wrap;
@end
