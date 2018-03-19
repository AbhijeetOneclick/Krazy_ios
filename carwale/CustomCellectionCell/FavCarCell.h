//
//  FavCarCell.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface FavCarCell : UICollectionViewCell

@property (nonatomic, strong) UIView * viewBackground;
@property (nonatomic, strong) AsyncImageView * imgCar;
@property (nonatomic, strong) AsyncImageView * imgFav;

@property (nonatomic, strong) UILabel * lblName;
@property (nonatomic, strong) UILabel * lblPrice;
@property (nonatomic, strong) UILabel * lblOnwords;

@property (nonatomic, strong) UILabel * lblTpyeAndReviews;
@property (nonatomic, strong) UIButton * btnCheckOnPrice;
@property (nonatomic, strong) RateView * carReview;


@end
