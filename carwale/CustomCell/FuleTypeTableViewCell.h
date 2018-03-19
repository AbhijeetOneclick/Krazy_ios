//
//  FuleTypeTableViewCell.h
//  carwale
//
//  Created by Lubhna Shirvastava on 08/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"

@interface FuleTypeTableViewCell : UITableViewCell

{
    AppDelegate *appDelegate;
    UILabel *lblName;
    
}

@property (nonatomic, strong) id    eventHandler;
-(void) setGalleryDetail:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath imagePath:(NSString *) imagePath;
@end
