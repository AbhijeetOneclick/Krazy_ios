//
//  CarBarndAndTypeCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 07/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CarBarndAndTypeCell.h"

@implementation CarBarndAndTypeCell
@synthesize imgCar2,CarBrnadNTypeLbl,btnCar;
-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel * lblTmp = [[UILabel alloc] init];
    lblTmp.frame = CGRectMake(10, 0,self.contentView.frame.size.width, self.contentView.frame.size.height);
    lblTmp.backgroundColor = [UIColor clearColor];
    lblTmp.userInteractionEnabled = YES;
    [self.contentView addSubview:lblTmp];
    
     btnCar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, lblTmp.frame.size.width,lblTmp.frame.size.height)];
    [lblTmp addSubview:btnCar];
    
    imgCar2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0,lblTmp.frame.size.width, lblTmp.frame.size.height-20)];
    imgCar2.contentMode=UIViewContentModeScaleAspectFit;
    imgCar2.clipsToBounds=YES;
    [lblTmp addSubview:imgCar2];
    
   CarBrnadNTypeLbl = [[UILabel alloc] init];
    CarBrnadNTypeLbl.frame = CGRectMake(0, 50, lblTmp.frame.size.width,lblTmp.frame.size.height-50);
    CarBrnadNTypeLbl.textAlignment = NSTextAlignmentCenter;
    [CarBrnadNTypeLbl setFont:[UIFont systemFontOfSize:12.0]];
    CarBrnadNTypeLbl.textColor = [self randomColor];
    [lblTmp addSubview:CarBrnadNTypeLbl];
    return self;
}
- (UIColor *)randomColor
{
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    NSLog(@"%@", color);
    return color;
}

@end
