//
//  BodyTypeViewCell.h
//  carwale
//
//  Created by One Click IT Consultancy  on 1/5/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyTypeViewCell : UITableViewCell
{
    AppDelegate *appDelegate;
    UILabel *lblName;
}
@property (nonatomic, strong) id    eventHandler;
-(void) setGalleryDetail:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath imagePath:(NSString *) imagePath;
@end
