//
//  contentCellVC.m
//  carwale
//
//  Created by i-MaC on 11/10/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "contentCellVC.h"
@implementation contentCellVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (void)setTableViewWidth:(CGFloat)tableWidth
{
    kTableViewWidth = tableWidth;
}

+ (id)storyCommentCellForTableWidth:(CGFloat)width
{
    contentCellVC *cell = [[contentCellVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    
    CGRect cellFrame = cell.frame;
    cellFrame.size.width = width;
    cell.frame = cellFrame;
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
