//
//  UpcomingCarCell.h
//  carwale
//
//  Created by Lubhna Shirvastava on 02/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingCarCell : UITableViewCell
@property(nonatomic,strong) AsyncImageView *carImg;
@property (nonatomic, strong) UILabel * carNameLbl,*estimatedPriceLbl,*expectedDateLbl,*estimatedPriceDataLbl,*expectedDateDataLbl;
@property(nonatomic,strong) UILabel *carPriceLbl;
@end
