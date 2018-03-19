//
//  contentCellVC.h
//  carwale
//
//  Created by i-MaC on 11/10/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *kCellIdentifier = @"storyCellId";
static CGFloat kTableViewWidth = -1;
@interface contentCellVC : UITableViewCell
{
  
}
+ (void)setTableViewWidth:(CGFloat)tableWidth;
+ (id)storyCommentCellForTableWidth:(CGFloat)width;
+ (CGFloat)cellHeightForComment:(NSString *)comment;
- (void)configureCommentCellForComment:(NSDictionary *)comment;
@end
