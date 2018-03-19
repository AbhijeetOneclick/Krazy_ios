//
//  CarImageCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 12/2/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CarImageCell.h"

@implementation CarImageCell

-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width,self.contentView.frame.size.height)];
    self.viewBackground .backgroundColor = [UIColor whiteColor];
    self.viewBackground .layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewBackground .layer.shadowOffset = CGSizeMake(0, 1);
    self.viewBackground .layer.shadowOpacity = 1;
    self.viewBackground .layer.shadowRadius = 1;
    self.viewBackground .layer.cornerRadius=5;
    [self.contentView sendSubviewToBack:self.viewBackground];
    
    
    self.imgCar = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0,self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.imgCar.clipsToBounds=YES;
    self.imgCar.image=[UIImage imageNamed:@"demo4.jpg"];
    self.imgCar.contentMode = UIViewContentModeScaleToFill;
    self.imgCar.clipsToBounds=YES;
    [self.contentView addSubview:self.imgCar];
    

    
    return self;
}


@end
