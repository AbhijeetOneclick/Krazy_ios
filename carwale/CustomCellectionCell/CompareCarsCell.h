//
//  CompareCarsCell.h
//  carwale
//
//  Created by One Click IT Consultancy  on 8/5/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface CompareCarsCell : UICollectionViewCell

@property (nonatomic, strong) AsyncImageView * imgCar1;
@property (nonatomic, strong) AsyncImageView * imgCar2;
@property (nonatomic, strong) UIImageView *PlaceHolderImage;
@property (nonatomic, strong) UIImageView *PlaceHolderImage1;


@property (nonatomic, strong) UILabel * lblCompare;
@property (nonatomic, strong) UILabel * lblCarName1;
@property (nonatomic, strong) UILabel * lblCarName2;


@end
