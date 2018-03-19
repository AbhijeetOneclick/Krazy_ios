//
//  LocateDealerCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 02/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "LocateDealerCell.h"

@implementation LocateDealerCell
@synthesize brandLogoImg,brandNameLbl;
-(id)initWithFrame:(CGRect)frame
{
    if(!(self =[super initWithFrame:frame])) return nil;

       
        UIView *Backview = [[ UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width,self.contentView.frame.size.height)];
        Backview.layer.shadowColor = [UIColor blackColor].CGColor;
        Backview.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        Backview.layer.shadowOpacity = 0.2;
        Backview.layer.shadowRadius = 4;
        Backview.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:Backview];
        
       brandLogoImg= [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0,self.contentView.frame.size.width,70)];
//       
//       // brandLogoImg.frame = CGRectMake(10,0,self.frame.size.width-20, );
//       brandLogoImg.backgroundColor = [UIColor lightGrayColor];
//        brandLogoImg.layer.masksToBounds = YES;
//        
//        brandLogoImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [Backview addSubview:brandLogoImg];
//        
        brandNameLbl = [[UILabel alloc] init];
        brandNameLbl.frame = CGRectMake(0, 70,self.contentView.frame.size.width , 30);
        brandNameLbl.backgroundColor =[UIColor whiteColor];
        brandNameLbl.textColor = [UIColor blackColor];
        brandNameLbl.textAlignment = NSTextAlignmentCenter;
        [Backview addSubview:brandNameLbl];


    
    
        return self;
}

@end
