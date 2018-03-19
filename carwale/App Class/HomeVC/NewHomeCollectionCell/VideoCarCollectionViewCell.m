//
//  VideoCarCollectionViewCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "VideoCarCollectionViewCell.h"

@implementation VideoCarCollectionViewCell
@synthesize imgCar1,lblCarName1,lblCarPrice,lblCarLauchDate,lblEstimetedPrice;


-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
       UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 244,219)];
    
        view.layer.shadowColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.21].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 2.0;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 126)];
       // NSURL *url = [NSURL URLWithString:[[GetNewsArray objectAtIndex:index]valueForKey:@"cover_image"]];
       // imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        // test-drive
        UIImageView * imgVideoPlaybtn = [[UIImageView alloc] initWithFrame:CGRectMake((imgCar1.frame.size.width/2)-7.5, (imgCar1.frame.size.height/2)-7.5, 21, 21)];
        imgVideoPlaybtn.image = [UIImage imageNamed:@"play"];
        imgVideoPlaybtn.contentMode = UIViewContentModeScaleAspectFit;
        [imgCar1 addSubview:imgVideoPlaybtn];
        
        UIImageView * imgTestDrive = [[UIImageView alloc] init];
        UIView *showTestDrive = [[UIView alloc] init];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            imgTestDrive.frame = CGRectMake(0, 0, 120,23);
        }else{
            showTestDrive.frame = CGRectMake(view.frame.size.width-120, 0, 120,23);
            showTestDrive.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:180.0/255.0 blue:196.0/255.0 alpha:1.0];
            showTestDrive.clipsToBounds=YES;
            showTestDrive.userInteractionEnabled=YES;
            [view addSubview:showTestDrive];
            
            UILabel *lblNews = [[UILabel alloc] init];
            lblNews.frame = CGRectMake(showTestDrive.frame.size.width/2-50, showTestDrive.frame.size.height/2-6, 100,12);
            lblNews.font = [UIFont systemFontOfSize:10];
            lblNews.textColor = [UIColor whiteColor];
            lblNews.text = [TSLanguageManager localizedString:@"TEST DRIVE REVIEW"];
            lblNews.textAlignment = NSTextAlignmentCenter;
            [showTestDrive addSubview:lblNews];
        }
        imgTestDrive.image = [UIImage imageNamed:@"test-drive"];
        // imgTestDrive.clipsToBounds=YES;
        imgTestDrive.userInteractionEnabled=YES;
        //  imgTestDrive.contentMode = UIViewContentModeScaleAspectFit;
        
        [imgCar1 addSubview:imgTestDrive];
        
        int y=126+12;
        lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(10, y, view.frame.size.width-20, 22);
        lblCarName1.font=[UIFont boldSystemFontOfSize:14.0];
        lblCarName1.textColor=Label_title_color;
       // lblCarName1.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"title"];
        lblCarName1.clipsToBounds=YES;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblCarName1.textAlignment = NSTextAlignmentLeft;
        }else{
            lblCarName1.textAlignment = NSTextAlignmentRight;
        }
        [view addSubview:lblCarName1];
        
        y=y+16+8;
        
        lblEstimetedPrice=[[UILabel alloc] init];
        lblEstimetedPrice.frame=CGRectMake(10, y, view.frame.size.width-20, 12);
        lblEstimetedPrice.font=[UIFont boldSystemFontOfSize:10.0];
        lblEstimetedPrice.textColor=Label_sub_title_color;
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            lblEstimetedPrice.textAlignment = NSTextAlignmentLeft;
        }else{
            lblEstimetedPrice.textAlignment = NSTextAlignmentRight;
        }
       // lblEstimetedPrice.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"news_writer"];
        lblEstimetedPrice.clipsToBounds=YES;
        [view addSubview:lblEstimetedPrice];
        
        y=y+12+8;
        
        int x = 10;
        
        UIImageView *ViewsImg = [[UIImageView alloc] init];
         if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
        ViewsImg.frame = CGRectMake(x, y, 22, 16);
         }else{
        ViewsImg.frame = CGRectMake(view.frame.size.width-32, y, 22, 16);
         }
        ViewsImg.image = [UIImage imageNamed:@"visibility"];
        ViewsImg.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:ViewsImg];
        
        x=x+30;
        UILabel * lblViews=[[UILabel alloc] init];
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
        lblViews.frame=CGRectMake(x, y, 30, 16);
        }else{
        lblViews.frame=CGRectMake(view.frame.size.width-32-30-7, y, 30, 16);
        }
        lblViews.font=[UIFont boldSystemFontOfSize:14.0];
        lblViews.textColor=Label_sub_title_color;
        lblViews.text=@"1.6K";
        lblViews.clipsToBounds=YES;
        [view addSubview:lblViews];
        
        x=x+40;
        UIImageView *LikeImg = [[UIImageView alloc] init];
        
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
            LikeImg.frame = CGRectMake(x, y, 22, 16);
        }else{
           LikeImg.frame = CGRectMake(view.frame.size.width-32-30-7-30-12, y, 22, 16);
        }
        LikeImg.image = [UIImage imageNamed:@"like"];
        LikeImg.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:LikeImg];
        
        x=x+30;
        UILabel * lblLike=[[UILabel alloc] init];
       
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"en"]){
             lblLike.frame=CGRectMake(x, y, 40, 16);
        }else{
            lblLike.frame=CGRectMake(view.frame.size.width-32-30-7-30-12-22-9, y, 40, 16);
        }
        lblLike.font=[UIFont boldSystemFontOfSize:14.0];
        lblLike.textColor=Label_sub_title_color;
        lblLike.text=@"124";
        lblLike.clipsToBounds=YES;
        [view addSubview:lblLike];
    }
    return self;
}
@end
