//
//  FuleTypeTblCell.h
//  carwale
//
//  Created by Lubhna Shirvastava on 20/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"

@interface FuleTypeTblCell : UITableViewCell
{
    AppDelegate *appDelegate;
    UILabel *lblName;
}
@property (nonatomic, strong) id    eventHandler;
-(void) setGalleryDetail:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath imagePath:(NSString *) imagePath;
@end
