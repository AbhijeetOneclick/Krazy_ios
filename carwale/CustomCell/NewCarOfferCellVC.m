//
//  NewCarOfferCellVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "NewCarOfferCellVC.h"

@implementation NewCarOfferCellVC
@synthesize carImg,carPriceLbl,carNameLbl;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *Backview = [[ UIView alloc]initWithFrame:CGRectMake(10, 10, DEVICE_WIDTH-20, 100)];
        Backview.layer.shadowColor = [UIColor blackColor].CGColor;
        Backview.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        Backview.layer.shadowOpacity = 0.2;
        Backview.layer.shadowRadius = 4;
        Backview.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:Backview];
        
        carImg = [[AsyncImageView alloc] init];
        carImg.frame= CGRectMake(0, 0,  Backview.frame.size.width/2-10, Backview.frame.size.height);
        
        [Backview addSubview:carImg];
        
        carNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-5,0,150,40)];
        carNameLbl.textColor=[UIColor blackColor];
        [carNameLbl setTextAlignment:NSTextAlignmentLeft];
        [carNameLbl setFont:[UIFont systemFontOfSize:16.0]];
        [Backview addSubview:carNameLbl];
        
        carPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-5, 30, 100, 20)];
        carPriceLbl.textColor=[UIColor lightGrayColor];
        [carPriceLbl setTextAlignment:NSTextAlignmentLeft];
        [carPriceLbl setFont:[UIFont boldSystemFontOfSize:12.0]];
        [Backview addSubview:carPriceLbl];
        
        //UIImageView *rateingShow = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-5,30 , , )]
        
        UIButton *btnChekOnRoadPrice = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-5,70,150 ,20)];
        btnChekOnRoadPrice.backgroundColor = [UIColor clearColor];
        [btnChekOnRoadPrice setTitle:@"Check On Road Price" forState:UIControlStateNormal];
        btnChekOnRoadPrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnChekOnRoadPrice.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        [btnChekOnRoadPrice setTitleColor:[UIColor colorWithRed:151.0/255.0 green:192.0/255.0 blue:230.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [Backview addSubview:btnChekOnRoadPrice];
        
        UIButton *btnfavSelect = [[UIButton alloc] initWithFrame:CGRectMake(Backview.frame.size.width-26,10, 16, 16)];
        btnfavSelect.backgroundColor = [UIColor clearColor];
        [btnfavSelect setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        [Backview addSubview:btnfavSelect];
    
        
    }
    return self;
}


@end
