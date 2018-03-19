//
//  PopularComapreCarCell.m
//  carwale
//
//  Created by Romit Arora on 26/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "PopularComapreCarCell.h"

@implementation PopularComapreCarCell
@synthesize imgCar1,lblCarName1,lblCarName2;
-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
        
        UIView *view =[[UIView alloc] init];
        if (IS_IPAD) {
            view.frame = CGRectMake(0, 0, DEVICE_WIDTH-60,250);
        }else{
            view.frame = CGRectMake(0, 0, DEVICE_WIDTH-60,150);
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
        // NSURL *url = [NSURL URLWithString:[[CompareCarArry objectAtIndex:index]valueForKey:@"image"]];
        //imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        //
        lblCarName1=[[UILabel alloc] init];
        if (IS_IPAD) {
            lblCarName1.frame=CGRectMake(0, 210, view.frame.size.width/2-15, 30);
        }else{
            lblCarName1.frame=CGRectMake(0, 120, view.frame.size.width/2-15, 20);
        }

        lblCarName1.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarName1.textAlignment=NSTextAlignmentCenter;
        lblCarName1.textColor=[UIColor grayColor];
        // lblCarName1.text=[[CompareCarArry objectAtIndex:index]valueForKey:@"first_model_name"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        //
        lblCarName2=[[UILabel alloc] init];
        if (IS_IPAD) {
            lblCarName2.frame=CGRectMake(view.frame.size.width/2+15, 210, view.frame.size.width/2-15, 30);
        }else{
            lblCarName2.frame=CGRectMake(view.frame.size.width/2+15, 120, view.frame.size.width/2-15, 20);
        }
        lblCarName2.font=[UIFont boldSystemFontOfSize:15.0];
        lblCarName2.textAlignment=NSTextAlignmentCenter;
        lblCarName2.textColor=[UIColor grayColor];
        // lblCarName2.text=[[CompareCarArry objectAtIndex:index]valueForKey:@"second_model_name"];
        lblCarName2.clipsToBounds=YES;
        [view addSubview:lblCarName2];
        
    }
    return self;
}

@end
