//
//  CompareCarsFlowLayout.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/5/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CompareCarsFlowLayout.h"

@implementation CompareCarsFlowLayout
-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(DEVICE_WIDTH-30,100);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    return self;
}

@end
