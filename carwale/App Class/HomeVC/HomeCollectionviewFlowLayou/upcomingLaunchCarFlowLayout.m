//
//  upcomingLaunchCarFlowLayout.m
//  carwale
//
//  Created by One Click IT Consultancy  on 1/1/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import "upcomingLaunchCarFlowLayout.h"

@implementation upcomingLaunchCarFlowLayout
-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(244,208);
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.minimumInteritemSpacing = 0.0f;
    self.minimumLineSpacing = 10.0f;
    return self;
}
@end
