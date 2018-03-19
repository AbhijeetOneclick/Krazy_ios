//
//  TransmissionViewCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 1/5/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import "TransmissionViewCell.h"

@implementation TransmissionViewCell
@synthesize transImg,viewData,translbl;
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
        self.contentView.frame = CGRectMake(0,0 , DEVICE_WIDTH, 50);
        self.contentView.backgroundColor = [UIColor colorWithRed:223.0/265.0 green:224.0/265.0 blue:224.0/265.0 alpha:0.5];
        
        viewData = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width-20,self.contentView.frame.size.height-10 )];
        viewData.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:viewData];
        
        transImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.contentView.frame.size.height/2-11, 44, 22)];
        transImg.backgroundColor = [UIColor clearColor];
        transImg.clipsToBounds=YES;
        transImg.contentMode = UIViewContentModeScaleAspectFit;
        [viewData addSubview:transImg];
        
        translbl = [[UILabel alloc] initWithFrame:CGRectMake(70, self.contentView.frame.size.height/2-10,self.contentView.frame.size.width, 20)];
        translbl.textAlignment = NSTextAlignmentLeft;
        translbl.font = [UIFont systemFontOfSize:15.0f];
        [viewData addSubview:translbl];
    }
    return self;
}
@end
