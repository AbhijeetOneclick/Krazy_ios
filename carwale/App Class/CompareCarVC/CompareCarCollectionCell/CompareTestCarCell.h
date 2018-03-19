//
//  CompareTestCarCell.h
//  carwale
//
//  Created by One Click IT Consultancy  on 12/27/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareTestCarCell : UICollectionViewCell
@property (nonatomic, strong) AsyncImageView * imgCar1;
@property (nonatomic, strong) AsyncImageView * imgCar2;

@property (nonatomic, strong) UILabel * lblCarName1;
@property (nonatomic, strong) UILabel * lblCarLauchDate;
@property (nonatomic, strong) UILabel * lblByWriter;

@end
