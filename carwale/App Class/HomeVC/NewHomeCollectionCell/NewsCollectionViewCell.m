//
//  NewsCollectionViewCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewCell
@synthesize imgCar1,lblCarName1,lblCarPrice,lblCarLauchDate,lblEstimetedPrice;

-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
       UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 244,229)];
        view.layer.shadowColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.21].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 2.0;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
       
            
        imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height/2)];
//        NSURL *url = [NSURL URLWithString:[[GetNewsArray objectAtIndex:index]valueForKey:@"cover_image"]];
//        imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        UIImageView * imgNewsBaner = [[UIImageView alloc] init];
        UIView *newsBanerView = [[UIView alloc]init];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            imgNewsBaner.frame =CGRectMake(0,view.frame.size.height/2-11.5 , 50,23);
            imgNewsBaner.image = [UIImage imageNamed:@"news-button"];
            imgNewsBaner.clipsToBounds=YES;
            imgNewsBaner.userInteractionEnabled=YES;
            imgNewsBaner.contentMode = UIViewContentModeScaleAspectFill;
            [view addSubview:imgNewsBaner];
        }
        else{
            newsBanerView.frame =CGRectMake(view.frame.size.width-50,view.frame.size.height/2-11.5, 50,23);
            newsBanerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:180.0/255.0 blue:196.0/255.0 alpha:1.0];
            newsBanerView.clipsToBounds=YES;
            newsBanerView.userInteractionEnabled=YES;
            [view addSubview:newsBanerView];
            
            UILabel *lblNews = [[UILabel alloc] init];
            lblNews.frame = CGRectMake(newsBanerView.frame.size.width/2-16, newsBanerView.frame.size.height/2-7, 32,14);
            lblNews.font = [UIFont systemFontOfSize:12];
            lblNews.textColor = [UIColor whiteColor];
            lblNews.text = [TSLanguageManager localizedString:@"NEWS"];
            lblNews.textAlignment = NSTextAlignmentCenter;
            [newsBanerView addSubview:lblNews];
        }
   
        
        int y=view.frame.size.height/2+17;
        
        lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 38);
        lblCarName1.font=[UIFont boldSystemFontOfSize:14.0];
        lblCarName1.numberOfLines=2;
        lblCarName1.textColor=Label_title_color;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarName1.textAlignment =NSTextAlignmentLeft;
        }else{
             lblCarName1.textAlignment =NSTextAlignmentRight;
        }
       // lblCarName1.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"title"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        y=y+38+8;
        lblCarPrice=[[UILabel alloc] init];
        lblCarPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 12);
        lblCarPrice.font=[UIFont boldSystemFontOfSize:10.0];
        lblCarPrice.textColor=Label_sub_title_color;
        //lblCarPrice.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"news_tag"];
        lblCarPrice.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarPrice.textAlignment =NSTextAlignmentLeft;
        }else{
            lblCarPrice.textAlignment =NSTextAlignmentRight;
        }
        [view addSubview:lblCarPrice];
        
        
        y=y+12+8;
        lblEstimetedPrice=[[UILabel alloc] init];
        lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 20);
        lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:10.0];
        lblEstimetedPrice.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
       // lblEstimetedPrice.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"news_writer"];
        lblEstimetedPrice.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblEstimetedPrice.textAlignment =NSTextAlignmentLeft;
        }else{
            lblEstimetedPrice.textAlignment =NSTextAlignmentRight;
        }
        [view addSubview:lblEstimetedPrice];
        
        
    }
    return self;
}
@end
