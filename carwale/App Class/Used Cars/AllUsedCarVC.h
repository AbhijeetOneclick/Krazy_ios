//
//  AllUsedCarVC.h
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllUsedCarVC : UIViewController
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton   *btnSideMenu,*locationBtn;
   
    NSMutableArray *carIamgeArray;
}
@end
