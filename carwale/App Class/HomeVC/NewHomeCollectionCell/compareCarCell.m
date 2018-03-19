//
//  compareCarCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "compareCarCell.h"

@implementation compareCarCell
@synthesize imgCar1,lblCarName1,lblCarName2;
-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;
    {
        
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0,226,135)];
        view.layer.shadowColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.21].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 2.0;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        imgCar1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 80)];
       // NSURL *url = [NSURL URLWithString:[[CompareCarArry objectAtIndex:index]valueForKey:@"image"]];
        //imgCar1.imageURL = url;
        imgCar1.clipsToBounds=YES;
        imgCar1.userInteractionEnabled=YES;
        imgCar1.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgCar1];
        
        lblCarName1=[[UILabel alloc] init];
        lblCarName1.frame=CGRectMake(0, 90, view.frame.size.width/2-15, 16);
        lblCarName1.font=[UIFont boldSystemFontOfSize:12.0];
        lblCarName1.textAlignment=NSTextAlignmentCenter;
        lblCarName1.textColor=Label_title_color;
       // lblCarName1.text=[[CompareCarArry objectAtIndex:index]valueForKey:@"first_model_name"];
        lblCarName1.clipsToBounds=YES;
        [view addSubview:lblCarName1];
        
        
       lblCarName2=[[UILabel alloc] init];
        lblCarName2.frame=CGRectMake(view.frame.size.width/2+15, 90, view.frame.size.width/2-15, 16);
        lblCarName2.font=[UIFont boldSystemFontOfSize:12];
        lblCarName2.textAlignment=NSTextAlignmentCenter;
        lblCarName2.textColor=Label_title_color;
       // lblCarName2.text=[[CompareCarArry objectAtIndex:index]valueForKey:@"second_model_name"];
        lblCarName2.clipsToBounds=YES;
        [view addSubview:lblCarName2];
        
    }
    return self;
}
@end
