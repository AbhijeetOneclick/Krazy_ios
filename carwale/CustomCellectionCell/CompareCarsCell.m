//
//  CompareCarsCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/5/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CompareCarsCell.h"

@implementation CompareCarsCell
-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.PlaceHolderImage = [UIImageView new];
    [self.contentView addSubview:self.PlaceHolderImage];
    [self.contentView sendSubviewToBack:self.PlaceHolderImage];
    self.PlaceHolderImage.backgroundColor = [UIColor clearColor];
    self.PlaceHolderImage.contentMode = UIViewContentModeScaleAspectFill;
    self.PlaceHolderImage.image=[UIImage imageNamed:@"place_holder_full_screen"];
    self.clipsToBounds = YES;
    
    self.PlaceHolderImage1 = [UIImageView new];
    [self.contentView addSubview:self.PlaceHolderImage1];
    [self.contentView sendSubviewToBack:self.PlaceHolderImage1];
    self.PlaceHolderImage1.backgroundColor = [UIColor clearColor];
    self.PlaceHolderImage1.contentMode = UIViewContentModeScaleAspectFill;
    self.PlaceHolderImage1.image=[UIImage imageNamed:@"place_holder_full_screen"];
    
    
    self.imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 0, DEVICE_WIDTH/2-30, 100)];
    self.imgCar1.clipsToBounds=YES;
    self.imgCar1.image=[UIImage imageNamed:@"demo4.jpg"];
    [self.contentView addSubview:self.imgCar1];
    self.imgCar1.layer.borderColor = [APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    self.imgCar1.layer.borderWidth=2;
    
    self.lblCompare=[[UILabel alloc] init];
    self.lblCompare.frame=CGRectMake(DEVICE_WIDTH/2-20, 40, 20, 20);
    self.lblCompare.font=[UIFont boldSystemFontOfSize:12.0];
    self.lblCompare.textAlignment=NSTextAlignmentCenter;
    self.lblCompare.textColor=[UIColor whiteColor];
    self.lblCompare.backgroundColor = [APP_DELEGATE colorWithHexString:AppHeaderColor];
    self.lblCompare.layer.cornerRadius=10;
    self.lblCompare.text=@"VS";
    self.lblCompare.clipsToBounds=YES;
    [self.contentView addSubview:self.lblCompare];

    
    self.imgCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 0, DEVICE_WIDTH/2-30, 100)];
    self.imgCar2.clipsToBounds=YES;
    self.imgCar2.image=[UIImage imageNamed:@"demo1.jpg"];
    [self.contentView addSubview:self.imgCar2];
    self.imgCar2.layer.borderColor = [APP_DELEGATE colorWithHexString:App_Background_color].CGColor;
    self.imgCar2.layer.borderWidth=2;
    

    
    return self;
}

@end
