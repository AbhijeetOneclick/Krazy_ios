//
//  NewCarOfferCellVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCarOfferCellVC : UITableViewCell
{
//    UILabel *carNameLbl,*carPriceLbl,*carLocationLbl;
//    UIImageView *carImg;
}
@property(nonatomic,strong) AsyncImageView *carImg;
@property (nonatomic, strong) UILabel * carNameLbl;
@property(nonatomic,strong) UILabel *carPriceLbl;
@end
