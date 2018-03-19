//
//  DetailCarTblViewCell.h
//  carwale
//
//  Created by Lubhna Shirvastava on 14/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCarTblViewCell : UITableViewCell

@property(nonatomic,strong) AsyncImageView *carImg;
@property (nonatomic, strong) UILabel *carNameLbl,*carPricelbl,*carEMIlbl,*totalDrivenLbl,*fuelTypeLbl,*yearlbl,*citylbl;


@property(nonatomic,strong) UIButton *checkrightPriceBtn,*loanBtn,*getSellerBtn;

@end
