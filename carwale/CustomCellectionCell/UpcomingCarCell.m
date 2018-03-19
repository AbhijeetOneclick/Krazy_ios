//
//  UpcomingCarCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 02/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "UpcomingCarCell.h"

@implementation UpcomingCarCell
@synthesize carImg,carNameLbl,carPriceLbl,estimatedPriceLbl,expectedDateLbl,estimatedPriceDataLbl,expectedDateDataLbl;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *Backview = [[ UIView alloc]initWithFrame:CGRectMake(10, 10, DEVICE_WIDTH-20, 250)];
        Backview.layer.shadowColor = [UIColor blackColor].CGColor;
        Backview.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        Backview.layer.shadowOpacity = 0.2;
        Backview.layer.shadowRadius = 4;
        Backview.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:Backview];
        
        carImg = [[AsyncImageView alloc] init];
        carImg.frame= CGRectMake(0,0,Backview.frame.size.width,180);
        carImg.contentMode=UIViewContentModeScaleAspectFit;
        [Backview addSubview:carImg];
        
        carNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10,185,Backview.frame.size.width,20)];
        carNameLbl.textColor=[UIColor blackColor];
        [carNameLbl setTextAlignment:NSTextAlignmentLeft];
        [carNameLbl setFont:[UIFont systemFontOfSize:16.0]];
        [Backview addSubview:carNameLbl];

        estimatedPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(10,210,100,15)];
        estimatedPriceLbl.textColor=[UIColor grayColor];
        estimatedPriceLbl.text=@"Estimated Price:";
        [estimatedPriceLbl setTextAlignment:NSTextAlignmentLeft];
        [estimatedPriceLbl setFont:[UIFont systemFontOfSize:12.0]];
        [Backview addSubview:estimatedPriceLbl];
        
        estimatedPriceDataLbl = [[UILabel alloc]initWithFrame:CGRectMake(estimatedPriceLbl.frame.size.width+5,210,Backview.frame.size.width/2-10,15)];
        estimatedPriceDataLbl.textColor=[UIColor grayColor];
        estimatedPriceDataLbl.text=@"8L-3L ";
        [estimatedPriceDataLbl setTextAlignment:NSTextAlignmentLeft];
        [estimatedPriceDataLbl setFont:[UIFont systemFontOfSize:12.0]];
        [Backview addSubview:estimatedPriceDataLbl];
        
        expectedDateLbl = [[UILabel alloc]initWithFrame:CGRectMake(10,225,90,15)];
        expectedDateLbl.textColor=[UIColor grayColor];
        expectedDateLbl.text=@"Expected Date:";
        [expectedDateLbl setTextAlignment:NSTextAlignmentLeft];
        [expectedDateLbl setFont:[UIFont systemFontOfSize:12.0]];
        [Backview addSubview:expectedDateLbl];
 
        expectedDateDataLbl = [[UILabel alloc]initWithFrame:CGRectMake(expectedDateLbl.frame.size.width+10,225,Backview.frame.size.width/2-10,15)];
        expectedDateDataLbl.textColor=[UIColor grayColor];
        expectedDateDataLbl.text=@"09-Noember-2017 ";
        [expectedDateDataLbl setTextAlignment:NSTextAlignmentLeft];
        [expectedDateDataLbl setFont:[UIFont systemFontOfSize:12.0]];
        [Backview addSubview:expectedDateDataLbl];
//        carPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 100, 30)];
//        carPriceLbl.textColor=[UIColor blackColor];
//        [carPriceLbl setTextAlignment:NSTextAlignmentLeft];
//        [carPriceLbl setFont:[UIFont systemFontOfSize:12.0]];
//        [Backview addSubview:carPriceLbl];
    }
    return self;
}
@end
