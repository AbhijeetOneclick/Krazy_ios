//
//  CarDetailVC.h
//  carwale
//
//  Created by i-MaC on 14/08/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "RateView.h"
#import "Constant.h"
#import "FavCarFlowLayout.h"
#import "FavCarCell.h"
#import "CarImageCell.h"
#import "CarImagesFlowLayout.h"
#import "NAUIViewWithBorders.h"
#import "iCarousel.h"
#import "URLManager.h"
#import "NSDate+TimeAgo.h"
#import "NIDropDown.h"
#import "DropDownListView.h"
#import "FualTransmissionCell.h"
#import "galleryVC.h"



@interface CarDetailVC : UIViewController<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource,URLManagerDelegate,NIDropDownDelegate,UIGestureRecognizerDelegate,kDropDownListViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnBack;
    UIImageView * imgHeaderLogo;
    
    
    ////**** Scrolview ****////
    UIScrollView * scrolContent;
    BOOL isShowTab;

    UIButton *btnShowGallery;
    ///***** Car detail view ***///
    UIView * viewCarDetail;
    UIImageView * imgFav;
    UIImageView * imgShare;
    UIImageView * imgbackImge;
    UILabel * lblCountImages;
    UIButton * btnShare;
    AsyncImageView * imgCar;
    
    //***** car details ****////
    RateView * carRating;
    int a;
    
    UIImageView *imgSelectVersion;
    UIButton *selectVersionCar;
    UIButton *selectVersion;
    
    UILabel * lblPrice;
    UILabel * lblOnwords;
    UILabel * lblReviewCount;
    UILabel * lblAddress;
    UIButton * btnOnRoadPrice;
    UIButton * btnEMIPrice;
    
    RateView * carReview;
    
    ////**** GetEMI Assistance UI ****////
    UIView * emiView;
    UILabel * lblGetEMItext;
    UILabel * lblCarName;
    UILabel * lblDealerName;
    UIButton * btnBestDeal;
    UIButton * btnGetLoan;
    
    
    ////**** CarDetail ****////
    
    UIView * carDetailView;
    UIButton * btnVersion;
    UIButton * btnMileage;
    UIButton * btnColor;
    
    
    UIScrollView * scrollAccessories;
    
    UILabel * lblVersionCount;
    
    UILabel * lblFuelType;
    UILabel * lblTransmission;
    
    
    
    UILabel * lblMileage;
    
    
    /*---Colors---*/
    
    UILabel * lblColor;
    
    UIView * viewColors;
    UIScrollView * scrolColors;
    
    /*---Car Images----*/
    UILabel * lblImages;
    UIView * viweImages;
    
    /*---CarVideos----*/
    
    UILabel * lblVideos;
    
    /*---Car Reviews---*/
    
    UILabel * lblReviews;
    
    /*----Alternatives---*/
    
    UILabel * lblAlternatives;
    UIView * viewAlternatives;
    
    NSMutableDictionary * dictModelDetail;
    
    
    /*----Show Tabbar View------*/
    UIView *showTabbar;
    UIScrollView *scrolltabBar;
    UIButton *BtnCategory;
    UILabel *showBoder;

    NSMutableArray *sizeOfx;
    /*UIButton *btnTabVersion,*btnTabMileage,*btnTabColors,*btnTabImages,*btnTabAlternatives;*/
    CGFloat versionY,mileageY,colorsY,imagesY,videoY,alternativeY;
    NSMutableArray  *optionsAry;
    int showTabY;
    NSUInteger buttonId;
    CGFloat offsetY;
    
    UIView * viewCarImages;
    UIView * viewModelDetails;
    
    UIView * viewVersion;
    NAUIViewWithBorders * carAccessories;
    UIView * viewCarModelTypes;
    UIView * viewMileage;
    UIView * viewImages;
    UIView * viewVideos;
    UIView * viewExpertReviews;
    UIView * viewAlternative;
    
    NSMutableArray * arrCarImages;
    NSMutableArray * arrCarVideos;
    NSMutableArray * arrFual, * arrTransmission;
    UIButton * btnFuel;
    UIButton * btnTransmission;
    
    NIDropDown * dropDownFuel;
    NIDropDown * dropDownTransmission;

    NSArray *arryList;
    DropDownListView * Dropobj;
    
    UIView * viewFuel;
    UITableView * tblFualTrans;
    
    BOOL isFualClick;
    NSMutableArray * arrVerionList;
    
    BOOL isVersionLess;
    UIView * viewVersionSize;
    UIButton * btnVersionSize;
    
    BOOL isColorLess;
    UIButton * btnColorSize;
    UIView * viewColorSize;
    UIView * viewBackgroundColor;
    
    UIActivityIndicatorView *spinner;
    



}
@property (nonatomic, strong) UICollectionView *collectionviewCars;
@property (nonatomic, strong) CarImagesFlowLayout * carFlowLayout;
@property (nonatomic, strong) iCarousel * carsList;
@property (nonatomic, strong) UIPageControl *videoPageController;
@property (nonatomic, strong) iCarousel * carsAlternative;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableDictionary * dictCar;



@end
