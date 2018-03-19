//
//  FualTransmissionCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 12/8/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "FualTransmissionCell.h"

@implementation FualTransmissionCell
@synthesize lblTitle,imgOption;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView * viewBackground = [[UIView alloc] initWithFrame:CGRectMake(5, 5, DEVICE_WIDTH-10, 44)];
        viewBackground.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:viewBackground];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, DEVICE_WIDTH-80, 20)];
        lblTitle.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        lblTitle.textAlignment = NSTextAlignmentLeft;
        lblTitle.textColor = [UIColor blackColor];
        [self.contentView addSubview:lblTitle];
        
        imgOption = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-60, 12, 20, 20)];
        imgOption.contentMode = UIViewContentModeScaleAspectFit;
        imgOption.clipsToBounds=YES;
        [self.contentView addSubview:imgOption];
        
        UILabel * lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, DEVICE_WIDTH, 0.5)];
        lblSep.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lblSep];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
