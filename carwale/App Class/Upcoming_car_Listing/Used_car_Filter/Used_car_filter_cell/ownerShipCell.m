//
//  ownerShipCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 1/3/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import "ownerShipCell.h"

@implementation ownerShipCell
@synthesize ownerImg,ownerlbl,viewData;
- (void)awakeFromNib {
    [super awakeFromNib];
    

    
    
    
    // Initialization code
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
        
        ownerImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.contentView.frame.size.height/2-11, 44, 22)];
        ownerImg.backgroundColor = [UIColor clearColor];
        ownerImg.clipsToBounds=YES;
        ownerImg.contentMode = UIViewContentModeScaleAspectFit;
        [viewData addSubview:ownerImg];
        
        ownerlbl = [[UILabel alloc] initWithFrame:CGRectMake(70, self.contentView.frame.size.height/2-10,self.contentView.frame.size.width, 20)];
        ownerlbl.textAlignment = NSTextAlignmentLeft;
        ownerlbl.font = [UIFont systemFontOfSize:15.0f];
        [viewData addSubview:ownerlbl];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
