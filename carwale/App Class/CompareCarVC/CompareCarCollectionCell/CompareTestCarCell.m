//
//  CompareTestCarCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 12/27/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CompareTestCarCell.h"

@implementation CompareTestCarCell
@synthesize imgCar1,lblCarName1,lblCarLauchDate,lblByWriter;

-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
        UIView *view =[[UIView alloc] init];
        if (IS_IPAD) {
            view.frame = CGRectMake(0, 0, DEVICE_WIDTH-60,300);
        }else{
            view.frame = CGRectMake(0, 0, DEVICE_WIDTH-60,200);
        }
        view.layer.shadowColor = [UIColor grayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 1.0;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        //
        imgCar1 = [[AsyncImageView alloc] init];
        if (IS_IPAD) {
            imgCar1.frame = CGRectMake(0, 0, view.frame.size.width, 200);
        }else{
            imgCar1.frame = CGRectMake(0, 0, view.frame.size.width, 100);
        }
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        int y;
        if (IS_IPAD) {
            y=215;
        }
        else
        {
            y=115;
        }
        lblCarName1=[[UILabel alloc] init];
        if (IS_IPAD) {
            lblCarName1.frame=CGRectMake(10, y , view.frame.size.width/2-15, 30);
        }else{
            lblCarName1.frame=CGRectMake(10, y, view.frame.size.width/2-15, 20);
        }
        lblCarName1.font=[UIFont boldSystemFontOfSize:20.0];
        lblCarName1.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
        // lblCarName1.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"title"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        //
        
        if (IS_IPAD) {
            y=y+40;
        }
        else
        {
            y=y+30;
        }
        lblCarLauchDate=[[UILabel alloc] init];
        if (IS_IPAD) {
            lblCarLauchDate.frame=CGRectMake(10, y, view.frame.size.width/2-15, 20);
        }else{
            lblCarLauchDate.frame=CGRectMake(10, y, view.frame.size.width/2-15, 10);
        }
        lblCarLauchDate.font=[UIFont boldSystemFontOfSize:12.0];
        lblCarLauchDate.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
        //lblCarPrice.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"news_tag"];
        lblCarLauchDate.clipsToBounds=YES;
        [view addSubview:lblCarLauchDate];
        
        //
        if (IS_IPAD) {
            y=y+30;
        }
        else
        {
            y=y+20;
        }
        lblByWriter=[[UILabel alloc] init];
        if (IS_IPAD) {
            lblByWriter.frame=CGRectMake(10, y, view.frame.size.width/2-15, 20);
        }else{
            lblByWriter.frame=CGRectMake(10, y, view.frame.size.width/2-15, 10);
        }
        lblByWriter.font=[UIFont boldSystemFontOfSize:11.0];
        lblByWriter.textColor=[APP_DELEGATE colorWithHexString:AppHeaderColor];
        // lblEstimetedPrice.text=[[GetNewsArray objectAtIndex:index]valueForKey:@"news_writer"];
        lblByWriter.clipsToBounds=YES;
        [view addSubview:lblByWriter];
        
    }
    return self;
}

@end
