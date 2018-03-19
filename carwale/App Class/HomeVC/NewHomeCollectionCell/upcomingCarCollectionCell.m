//
//  upcomingCarCollectionCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "upcomingCarCollectionCell.h"

@implementation upcomingCarCollectionCell
@synthesize imgCar1,lblCarName1,lblCarPrice,lblCarLauchDate,lblEstimetedPrice;

-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 244,208)];
        view.layer.shadowColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.21].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 2.0;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
        //        NSURL *url = [NSURL URLWithString:[[arrUpcomingCars objectAtIndex:index]valueForKey:@"model_image"]];
        //        imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        int y=115;
        lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarName1.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarName1.textColor=[UIColor grayColor];
        //   lblCarName1.text=[[arrUpcomingCars objectAtIndex:index]valueForKey:@"car_model_name"];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarName1.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarName1.textAlignment =NSTextAlignmentRight;
        }
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        // y=y+25;
        
        lblCarLauchDate=[[UILabel alloc] init];
        
        lblCarLauchDate.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarLauchDate.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarLauchDate.textColor=[UIColor grayColor];
        
        // lblCarLauchDate.text=[[arrUpcomingCars objectAtIndex:index]valueForKey:@"launching_date"];
        lblCarName1.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarLauchDate.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarLauchDate.textAlignment =NSTextAlignmentRight;
        }
        // [view addSubview:lblCarLauchDate];
        
        
        y=y+30;
        
        lblCarPrice=[[UILabel alloc] init];
        lblCarPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarPrice.textColor=[UIColor blackColor];
        //        NSString *strigPrice = [NSString stringWithFormat:@"%@ %@ %@",[[arrUpcomingCars objectAtIndex:index]valueForKey:@"currency_symbol"],[[arrUpcomingCars objectAtIndex:index]valueForKey:@"price"],@"onwards"];
        //        lblCarPrice.text=strigPrice;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarPrice.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarPrice.textAlignment =NSTextAlignmentRight;
        }
        lblCarPrice.clipsToBounds=YES;
        [view addSubview:lblCarPrice];
        
        
        
        
        y=y+30;
        
        lblCarLauchDate=[[UILabel alloc] init];
        lblCarLauchDate.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblCarLauchDate.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarLauchDate.textColor=[UIColor grayColor];
        lblCarLauchDate.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarLauchDate.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarLauchDate.textAlignment =NSTextAlignmentRight;
        }
        [view addSubview:lblCarLauchDate];
        
        y=y+30;
        
        lblEstimetedPrice=[[UILabel alloc] init];
        lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblEstimetedPrice.textColor=[UIColor grayColor];
        lblEstimetedPrice.text=[TSLanguageManager localizedString:@"Ex showroom ahmedabad"];
        lblEstimetedPrice.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblEstimetedPrice.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblEstimetedPrice.textAlignment =NSTextAlignmentRight;
        }

        [view addSubview:lblEstimetedPrice];
        
    }
    return self;
}

@end
