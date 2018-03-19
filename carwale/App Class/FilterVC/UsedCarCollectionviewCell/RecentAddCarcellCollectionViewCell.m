//
//  RecentAddCarcellCollectionViewCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 22/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "RecentAddCarcellCollectionViewCell.h"

@implementation RecentAddCarcellCollectionViewCell
@synthesize imgCar1,lblCarName1,lblCarPrice,lblCarLauchDate,lblEstimetedPrice,totalDrivenLbl,fuelTypeLbl,yearlbl,citylbl;


-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 226,245)];
        view.layer.shadowColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.21].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 2.0;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(1, 1, view.frame.size.width-2, 126)];
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        int y=126+19;
        
        lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 22);
        lblCarName1.font=[UIFont boldSystemFontOfSize:14];
        lblCarName1.textColor=Label_title_color;
        lblCarName1.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarName1.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarName1.textAlignment =NSTextAlignmentRight;
        }
        [view addSubview:lblCarName1];
        
        y=y+16+16;
        lblCarPrice=[[UILabel alloc] init];
        lblCarPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 18);
        lblCarPrice.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarPrice.textColor=[UIColor blackColor];
        lblCarPrice.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarPrice.textAlignment =NSTextAlignmentLeft;
        }
        else{
            lblCarPrice.textAlignment =NSTextAlignmentRight;
        }
        [view addSubview:lblCarPrice];
        
        y=y+18+6;
        //=====Show year===//
        
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            yearlbl = [[UILabel alloc] initWithFrame:CGRectMake(10,y,30,13)];
            
        }else{
            yearlbl = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-40,y,30,13)];
        }
        [yearlbl setTextAlignment:NSTextAlignmentCenter];
        yearlbl.textColor = [UIColor lightGrayColor];
        [yearlbl setFont:[UIFont systemFontOfSize:11]];
        [view addSubview:yearlbl];
        
        //=====Show Toatl Dervien===//
        UIView *lineView2 = [[UIView alloc] init];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lineView2.frame =CGRectMake(45, y,1, 15);
        }else{
            lineView2.frame =CGRectMake(view.frame.size.width-48, y,1, 15);
        }
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView2];
        
        totalDrivenLbl = [[UILabel alloc] init];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            totalDrivenLbl.frame =CGRectMake(50,y,50 ,13);
        }else{
            totalDrivenLbl.frame =CGRectMake(view.frame.size.width-100, y,50, 15);
        }
        [totalDrivenLbl setTextAlignment:NSTextAlignmentCenter];
        totalDrivenLbl.textColor = [UIColor lightGrayColor];
        [totalDrivenLbl setFont:[UIFont systemFontOfSize:11]];
        [view addSubview:totalDrivenLbl];
        
        //=====Fuel Type ===//
        UIView *lineView3 = [[UIView alloc] init];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lineView3.frame =CGRectMake(100, y,1, 15);
        }else{
            lineView3.frame =CGRectMake(view.frame.size.width-105, y,1, 15);
        }
        lineView3.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView3];
        
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            fuelTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(105, y,40 ,13 )];
        }else{
            fuelTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-145, y,40 ,13 )];
        }
        [fuelTypeLbl setTextAlignment:NSTextAlignmentCenter];
        fuelTypeLbl.textColor = [UIColor lightGrayColor];
        [fuelTypeLbl setFont:[UIFont fontWithName:FONT size:11]];
        [view addSubview:fuelTypeLbl];
        
        y=y+25;
        
        lblEstimetedPrice=[[UILabel alloc] init];
        lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 13);
        lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:11];
        lblEstimetedPrice.textColor=Label_sub_title_color;
        lblEstimetedPrice.text=[TSLanguageManager localizedString: @"Navarangpura,Ahmedabad"];
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
