//
//  justLaunchCarCollectionCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "justLaunchCarCollectionCell.h"

@implementation justLaunchCarCollectionCell
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
        
        imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 126)];
     //   NSURL *url = [NSURL URLWithString:[[arrLaunchedCars objectAtIndex:index]valueForKey:@"model_image"]];
       // imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];


        int y=126+6;
         lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 22);
        lblCarName1.font=[UIFont boldSystemFontOfSize:14.0];
        lblCarName1.textColor=Label_title_color;
       // lblCarName1.text=[[arrLaunchedCars objectAtIndex:index]valueForKey:@"car_model_name"];
        lblCarName1.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarName1.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarName1.textAlignment =NSTextAlignmentRight;
        }
        [view addSubview:lblCarName1];


        y=y+12+10;

         lblCarPrice=[[UILabel alloc] init];
        lblCarPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 18);
        lblCarPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarPrice.textColor=[UIColor blackColor];
       // NSString *strigPrice = [NSString stringWithFormat:@"%@%@",[[arrLaunchedCars objectAtIndex:index]valueForKey:@"currency_symbol"],[[arrLaunchedCars objectAtIndex:index]valueForKey:@"price"]];
       // lblCarPrice.text=strigPrice;
        lblCarPrice.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarPrice.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarPrice.textAlignment =NSTextAlignmentRight;
        }
        [view addSubview:lblCarPrice];

        y=y+18+6;

        lblEstimetedPrice=[[UILabel alloc] init];
        lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblEstimetedPrice.textColor=Label_sub_title_color;
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
