//
//  popularCarCell.h
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface popularCarCell : UICollectionViewCell

-(void) setGalleryDetail:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath imagePath:(NSString *) imagePath;

@property (nonatomic, strong) AsyncImageView * imgCar1;
@property (nonatomic, strong) AsyncImageView * imgCar2;

@property (nonatomic, strong) UILabel * lblCarName1;
@property (nonatomic, strong) UILabel * lblCarLauchDate;
@property (nonatomic, strong) UILabel * lblCarPrice;
@property (nonatomic, strong) UILabel * lblEstimetedPrice;

@end
