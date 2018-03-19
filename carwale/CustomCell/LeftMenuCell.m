//
//  LeftMenuCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/4/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "LeftMenuCell.h"
#import "AppDelegate.h"
#import "Constant.h"

@implementation LeftMenuCell
@synthesize lblTitle,imgCellBG,lblLine,lblSeprator,lblSeprator1,imgOptionn;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        imgCellBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 44)];
        [imgCellBG setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:imgCellBG];
        
        imgOptionn = [[UIImageView alloc] initWithFrame:CGRectMake(20, 9.5, 25, 25)];
        imgOptionn.contentMode-=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imgOptionn];
        
         if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
        lblTitle =[[UILabel alloc]initWithFrame:CGRectMake(70, 0, self.contentView.frame.size.width-60, 44)];
                lblTitle.textAlignment=NSTextAlignmentLeft;
        }
        else
        {
            if(IS_IPAD)
            {
                lblTitle =[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-200, 0, 200, 44)];

            }
            else
            {
                lblTitle =[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-260, 0, 200, 44)];
            }
                lblTitle.textAlignment=NSTextAlignmentRight;
        }
        lblTitle.text=@"Details";
        lblTitle.textColor=[UIColor grayColor];
        lblTitle.backgroundColor=[UIColor clearColor];
        lblTitle.font=[UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:lblTitle];
        
        lblLine =[[UILabel alloc]initWithFrame:CGRectMake(0, 43, self.contentView.frame.size.width, 1)];
        lblLine.backgroundColor=[APP_DELEGATE colorWithHexString:@"e1e1e1"];
       // [self.contentView addSubview:lblLine];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
