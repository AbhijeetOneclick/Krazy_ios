//
//  FavCarCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "FavCarCell.h"

@implementation FavCarCell
-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.viewBackground = [[UIView alloc] initWithFrame:CGRectMake(15, 5, self.contentView.frame.size.width-30, self.contentView.frame.size.height-10)];
    self.viewBackground .backgroundColor = [UIColor whiteColor];
    self.viewBackground .layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewBackground .layer.shadowOffset = CGSizeMake(0, 1);
    self.viewBackground .layer.shadowOpacity = 1;
    self.viewBackground .layer.shadowRadius = 1;
    self.viewBackground .layer.cornerRadius=5;
    [self.contentView sendSubviewToBack:self.viewBackground];
    
    
    self.imgCar = [[AsyncImageView alloc] initWithFrame:CGRectMake(15, 10, DEVICE_WIDTH/2-30, self.contentView.frame.size.height-20)];
    self.imgCar.clipsToBounds=YES;
    self.imgCar.image=[UIImage imageNamed:@"demo4.jpg"];
    [self.contentView addSubview:self.imgCar];
    
    self.imgFav = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 20, 31, 31)];
    self.imgFav.clipsToBounds=YES;
    self.imgFav.image=[UIImage imageNamed:@"icon_fav_filled.png"];
    [self.contentView addSubview:self.imgFav];
    
    UILabel * lblSep = [[UILabel alloc] initWithFrame:CGRectMake( DEVICE_WIDTH/2, 10, 1, self.contentView.frame.size.height-20)];
    lblSep.backgroundColor = [APP_DELEGATE colorWithHexString:App_Background_color];
    [self.contentView addSubview:lblSep];

    self.lblName=[[UILabel alloc] init];
    self.lblName.frame=CGRectMake(DEVICE_WIDTH/2+10, 10, DEVICE_WIDTH/2+-20, 20);
    self.lblName.font=[UIFont boldSystemFontOfSize:16.0];
    self.lblName.textAlignment=NSTextAlignmentLeft;
    self.lblName.textColor=[UIColor blackColor];
    self.lblName.text=@"HONDA CITY";
    [self.contentView addSubview:self.lblName];
    
    self.lblPrice=[[UILabel alloc] init];
    self.lblPrice.frame=CGRectMake(DEVICE_WIDTH/2+10, 30, 80, 20);
    self.lblPrice.font=[UIFont boldSystemFontOfSize:14.0];
    self.lblPrice.textAlignment=NSTextAlignmentLeft;
    self.lblPrice.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
    self.lblPrice.text=@"$ 5000";
    [self.contentView addSubview:self.lblPrice];
    
    self.lblOnwords=[[UILabel alloc] init];
    self.lblOnwords.frame=CGRectMake(DEVICE_WIDTH/2+100, 40, 80, 10);
    self.lblOnwords.font=[UIFont boldSystemFontOfSize:8.0];
    self.lblOnwords.textAlignment=NSTextAlignmentLeft;
    self.lblOnwords.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
    self.lblOnwords.text=@"on words";
    [self.contentView addSubview:self.lblOnwords];
    
    self.carReview = [RateView rateViewWithRating:0.0];
    self.carReview.frame = CGRectMake(DEVICE_WIDTH/2+10,50, 95, 10);
//    self.carReview.backgroundColor = [UIColor orangeColor];
    self.carReview.rating = 4.3;
    [self.contentView addSubview:self.carReview];
    
    self.lblTpyeAndReviews=[[UILabel alloc] init];
    self.lblTpyeAndReviews.frame=CGRectMake(DEVICE_WIDTH/2+10,68, DEVICE_WIDTH/2-20, 20);
    self.lblTpyeAndReviews.font=[UIFont boldSystemFontOfSize:12.0];
    self.lblTpyeAndReviews.textAlignment=NSTextAlignmentLeft;
    self.lblTpyeAndReviews.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
    self.lblTpyeAndReviews.text=@"Diesel | 30 reviews";
    [self.contentView addSubview:self.lblTpyeAndReviews];
    
    
    self.btnCheckOnPrice = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnCheckOnPrice.frame = CGRectMake(DEVICE_WIDTH/2+10, 80, 120, 40);
    self.btnCheckOnPrice.backgroundColor =[UIColor clearColor];
    [self.btnCheckOnPrice setTitle:@"Check on -Road Price" forState:UIControlStateNormal];
    [self.btnCheckOnPrice setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnCheckOnPrice.titleLabel setFont:[UIFont systemFontOfSize:10.0]];
    [self.contentView addSubview: self.btnCheckOnPrice];
    
//    self.backgroundColor = [UIColor redColor];
    
    return self;
}

@end
