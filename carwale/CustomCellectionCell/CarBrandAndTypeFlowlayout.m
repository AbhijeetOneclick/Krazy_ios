//
//  CarBrandAndTypeFlowlayout.m
//  carwale
//
//  Created by Lubhna Shirvastava on 07/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CarBrandAndTypeFlowlayout.h"

@implementation CarBrandAndTypeFlowlayout
-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(DEVICE_WIDTH/3-30,30);
   //  layout.itemSize = CGSizeMake(self.view.frame.size.width/3-30,30)
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumLineSpacing = 10.0;
    self.minimumInteritemSpacing = 0.0;
    self.headerReferenceSize = CGSizeMake(0.0,5.0);
    
    return self;
}
@end
