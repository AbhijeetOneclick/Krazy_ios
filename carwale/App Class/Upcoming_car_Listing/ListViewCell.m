//
//  ListViewCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 14/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

@synthesize carImg,carNameLbl,carPricelbl,carEMIlbl,totalDrivenLbl,fuelTypeLbl,yearlbl,citylbl,checkrightPriceBtn,loanBtn,getSellerBtn;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *Backview = [[ UIView alloc]initWithFrame:CGRectMake(10, 10, DEVICE_WIDTH-20,150)];
        Backview.layer.shadowColor = [UIColor blackColor].CGColor;
        Backview.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        Backview.layer.shadowOpacity = 0.2;
        Backview.layer.shadowRadius = 4;
        Backview.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:Backview];
        
        int y = 5 ;
        
        carImg = [[AsyncImageView alloc] init];
        carImg.frame= CGRectMake(5,y,Backview.frame.size.width/2-10,100);
        carImg.contentMode=UIViewContentModeScaleAspectFill;
        carImg.layer.masksToBounds =YES;
        [Backview addSubview:carImg];
        
        y=y+100+5;
        
        getSellerBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, y,Backview.frame.size.width/2-10, 35)];
        getSellerBtn.backgroundColor = APP_BUTTON_COLOR;
        [getSellerBtn setTitle:@"GET SELLER DETAILS" forState:UIControlStateNormal];
        [getSellerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        getSellerBtn.titleLabel.font = [UIFont fontWithName:FONT size:14];
        [Backview addSubview:getSellerBtn];
        
        int yy=5;
        
        carNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(Backview.frame.size.width/2,yy,Backview.frame.size.width,15)];
        carNameLbl.textColor=[UIColor blackColor];
        [carNameLbl setTextAlignment:NSTextAlignmentLeft];
        [carNameLbl setFont:[UIFont fontWithName:FONT size:15]];
        [Backview addSubview:carNameLbl];
        
        yy=yy+15+5;
        
        carPricelbl = [[UILabel alloc]initWithFrame:CGRectMake(Backview.frame.size.width/2,yy,100,15)];
        carPricelbl.textColor=[UIColor blackColor];
        [carPricelbl setTextAlignment:NSTextAlignmentLeft];
        [carPricelbl setFont:[UIFont fontWithName:FONT size:15]];
        [Backview addSubview:carPricelbl];

        yy=yy+15+5;
        
        checkrightPriceBtn = [[UIButton alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2, yy, 130, 15)];
        checkrightPriceBtn.backgroundColor = [UIColor clearColor];
        [checkrightPriceBtn setTitle:@"Check Right Price" forState:UIControlStateNormal];
        [checkrightPriceBtn setTitleColor:APP_HEADER_COLOR forState:UIControlStateNormal];
        checkrightPriceBtn.titleLabel.font = [UIFont fontWithName:FONT size:12];
        checkrightPriceBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        checkrightPriceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [Backview addSubview:checkrightPriceBtn];
        
        yy=yy+15+5;
        
        carEMIlbl = [[UILabel alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2,yy ,100 ,15 )];
        carEMIlbl.textColor=[UIColor blackColor];
        [carEMIlbl setTextAlignment:NSTextAlignmentLeft];
        carEMIlbl.text = @"Rs.100000";
        [carEMIlbl setFont:[UIFont systemFontOfSize:12]];
        [Backview addSubview:carEMIlbl];
        
        yy=yy+15+5;
        
        loanBtn = [[UIButton alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2, yy, 180, 15)];
        loanBtn.backgroundColor = [UIColor clearColor];
        [loanBtn setTitle:@"Get Instant Loan Approval" forState:UIControlStateNormal];
        loanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [loanBtn setTitleColor:APP_HEADER_COLOR forState:UIControlStateNormal];
        loanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [Backview addSubview:loanBtn];

        yy=yy+15+5;
        
        totalDrivenLbl = [[UILabel alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2,yy ,100 ,15)];
        totalDrivenLbl.textColor = [UIColor lightGrayColor];
        [totalDrivenLbl setTextAlignment:NSTextAlignmentLeft];
        [totalDrivenLbl setFont:[UIFont fontWithName:FONT size:12]];
        [Backview addSubview:totalDrivenLbl];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2+80, yy,1, 15)];
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [Backview addSubview:lineView2];
        
        fuelTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2+90, yy,40 ,15)];
        fuelTypeLbl.textColor = [UIColor lightGrayColor];
        [fuelTypeLbl setTextAlignment:NSTextAlignmentLeft];
        [fuelTypeLbl setFont:[UIFont systemFontOfSize:12]];
        [Backview addSubview:fuelTypeLbl];
        
        UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2+140, yy,1, 15)];
        lineView3.backgroundColor = [UIColor lightGrayColor];
        [Backview addSubview:lineView3];
        
        yearlbl = [[UILabel alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2+145, yy,100 ,15 )];
        yearlbl.textColor = [UIColor lightGrayColor];
        [yearlbl setTextAlignment:NSTextAlignmentLeft];
        [yearlbl setFont:[UIFont fontWithName:FONT size:12]];
        [Backview addSubview:yearlbl];
        
        yy=yy+15+5;
        
        citylbl = [[UILabel alloc] initWithFrame:CGRectMake(Backview.frame.size.width/2, yy,DEVICE_WIDTH/2 ,15 )];
        citylbl.textColor = [UIColor lightGrayColor];
        [citylbl setTextAlignment:NSTextAlignmentLeft];
        [citylbl setFont:[UIFont fontWithName:FONT size:14]];
        [Backview addSubview:citylbl];
        
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
