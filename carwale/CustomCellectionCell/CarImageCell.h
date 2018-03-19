//
//  CarImageCell.h
//  carwale
//
//  Created by One Click IT Consultancy  on 12/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarImageCell : UICollectionViewCell

@property (nonatomic, strong) UIView * viewBackground;
@property (nonatomic, strong) AsyncImageView * imgCar;
@property (nonatomic, strong) AsyncImageView * imgFav;
@end
