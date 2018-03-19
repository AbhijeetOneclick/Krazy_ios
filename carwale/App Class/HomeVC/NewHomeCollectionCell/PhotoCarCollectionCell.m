//
//  PhotoCarCollectionCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "PhotoCarCollectionCell.h"

@implementation PhotoCarCollectionCell
@synthesize imgCar1,lblCarName1,lblCarPrice,lblCarLauchDate,lblEstimetedPrice;

-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
       UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 244,155)];
        view.layer.shadowColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.21].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 2.0;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 116)];
      //  NSURL *url = [NSURL URLWithString:[[GetNewsArray objectAtIndex:index]valueForKey:@"cover_image"]];
       // imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        
        int y=116+12;
        lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 22);
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarName1.textAlignment = NSTextAlignmentLeft;
        }else{
            lblCarName1.textAlignment = NSTextAlignmentRight;
        }
        lblCarName1.font=[UIFont boldSystemFontOfSize:14.0];
        lblCarName1.textColor=Label_title_color;
        //lblCarName1.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"title"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        UIImageView *NewsImg = [[UIImageView alloc] init];
        
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
           NewsImg.frame = CGRectMake(view.frame.size.width-60, y, 14, 14);
        }else{
            NewsImg.frame = CGRectMake(40, y, 14, 14);
        }
        NewsImg.image = [UIImage imageNamed:@"image"];
        NewsImg.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:NewsImg];
        
        UILabel * lblNumberOfImage=[[UILabel alloc] init];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblNumberOfImage.frame=CGRectMake(view.frame.size.width-40, y, 30, 14);
        }else{
           lblNumberOfImage.frame=CGRectMake(10, y, 30, 14);
        }
        
        lblNumberOfImage.font=[UIFont boldSystemFontOfSize:15.0];
        lblNumberOfImage.textColor=Label_sub_title_color;
        lblNumberOfImage.text=@"12";
        lblNumberOfImage.clipsToBounds=YES;
        [view addSubview:lblNumberOfImage];
        
        
        
    }
    return self;
}
@end
