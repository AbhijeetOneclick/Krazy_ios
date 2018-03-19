//
//  DetailCarTblViewCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 14/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "DetailCarTblViewCell.h"

@implementation DetailCarTblViewCell

@synthesize carImg,carNameLbl,carPricelbl,carEMIlbl,totalDrivenLbl,fuelTypeLbl,yearlbl,citylbl,checkrightPriceBtn,loanBtn,getSellerBtn;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *Backview = [[ UIView alloc]initWithFrame:CGRectMake(10, 10, DEVICE_WIDTH-20, 280)];
        Backview.layer.shadowColor = [UIColor blackColor].CGColor;
        Backview.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        Backview.layer.shadowOpacity = 0.2;
        Backview.layer.shadowRadius = 4;
        Backview.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:Backview];
        
        int y = 0 ;
        
        carImg = [[AsyncImageView alloc] init];
        carImg.frame= CGRectMake(0,y,Backview.frame.size.width,120);
        carImg.contentMode=UIViewContentModeScaleAspectFill;
        carImg.layer.masksToBounds =YES;
        [Backview addSubview:carImg];
        
        y=y+120+10;
        
        carNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10,y,Backview.frame.size.width,20)];
        carNameLbl.textColor=[UIColor blackColor];
        [carNameLbl setTextAlignment:NSTextAlignmentLeft];
        [carNameLbl setFont:[UIFont fontWithName:FONT size:18]];
        [Backview addSubview:carNameLbl];
        
        y=y+25;
        
        carPricelbl = [[UILabel alloc]initWithFrame:CGRectMake(10,y,100,15)];
        carPricelbl.textColor=[UIColor blackColor];
        [carPricelbl setTextAlignment:NSTextAlignmentLeft];
        [carPricelbl setFont:[UIFont fontWithName:FONT size:16]];
        [Backview addSubview:carPricelbl];
        
        carEMIlbl = [[UILabel alloc] initWithFrame:CGRectMake(150,y ,100 ,15 )];
        carEMIlbl.textColor=[UIColor blackColor];
        [carEMIlbl setTextAlignment:NSTextAlignmentLeft];
        carEMIlbl.text = @"Rs.100000";
        [carEMIlbl setFont:[UIFont fontWithName:FONT size:16]];
        [Backview addSubview:carEMIlbl];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(140, y,1, 30)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [Backview addSubview:lineView];
        
        y=y+15+5;
        
        checkrightPriceBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, y, 130, 15)];
        checkrightPriceBtn.backgroundColor = [UIColor clearColor];
        [checkrightPriceBtn setTitle:@"Check Right Price" forState:UIControlStateNormal];
        [checkrightPriceBtn setTitleColor:APP_HEADER_COLOR forState:UIControlStateNormal];
        checkrightPriceBtn.titleLabel.font = [UIFont fontWithName:FONT size:14];
        checkrightPriceBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        checkrightPriceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [Backview addSubview:checkrightPriceBtn];

        loanBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, y, 180, 15)];
        loanBtn.backgroundColor = [UIColor clearColor];
        [loanBtn setTitle:@"Get Instant Loan Approval" forState:UIControlStateNormal];
        loanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [loanBtn setTitleColor:APP_HEADER_COLOR forState:UIControlStateNormal];
        loanBtn.titleLabel.font = [UIFont fontWithName:FONT size:14];
        [Backview addSubview:loanBtn];
        
        
        y=y+15+5;
        
        totalDrivenLbl = [[UILabel alloc] initWithFrame:CGRectMake(10,y ,100 ,15)];
        totalDrivenLbl.textColor = [UIColor lightGrayColor];
        [totalDrivenLbl setTextAlignment:NSTextAlignmentLeft];
        [totalDrivenLbl setFont:[UIFont fontWithName:FONT size:14]];
        [Backview addSubview:totalDrivenLbl];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(105, y,1, 15)];
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [Backview addSubview:lineView2];
        
        fuelTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(120, y,40 ,15)];
        fuelTypeLbl.textColor = [UIColor lightGrayColor];
        [fuelTypeLbl setTextAlignment:NSTextAlignmentLeft];
        [fuelTypeLbl setFont:[UIFont fontWithName:FONT size:14]];
        [Backview addSubview:fuelTypeLbl];
        
        UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(165, y,1, 15)];
        lineView3.backgroundColor = [UIColor lightGrayColor];
        [Backview addSubview:lineView3];
        
        yearlbl = [[UILabel alloc] initWithFrame:CGRectMake(175, y,100 ,15 )];
        yearlbl.textColor = [UIColor lightGrayColor];
        [yearlbl setTextAlignment:NSTextAlignmentLeft];
        [yearlbl setFont:[UIFont fontWithName:FONT size:14]];
        [Backview addSubview:yearlbl];
        
        y=y+15+10;
        
        citylbl = [[UILabel alloc] initWithFrame:CGRectMake(10, y,DEVICE_WIDTH/2 ,15 )];
        citylbl.textColor = [UIColor lightGrayColor];
        [citylbl setTextAlignment:NSTextAlignmentLeft];
        [citylbl setFont:[UIFont fontWithName:FONT size:14]];
        [Backview addSubview:citylbl];
      
        y=y+20;
        
        getSellerBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, y, DEVICE_WIDTH/2, 30)];
        getSellerBtn.backgroundColor = APP_BUTTON_COLOR;
        [getSellerBtn setTitle:@"GET SELLER DETAILS" forState:UIControlStateNormal];
        [getSellerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        getSellerBtn.titleLabel.font = [UIFont fontWithName:FONT size:15];
        [Backview addSubview:getSellerBtn];
        
        UIButton *btnfavSelect = [[UIButton alloc] initWithFrame:CGRectMake(Backview.frame.size.width-26,10, 16, 16)];
        btnfavSelect.backgroundColor = [UIColor clearColor];
        [btnfavSelect setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        [Backview addSubview:btnfavSelect];

 
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
