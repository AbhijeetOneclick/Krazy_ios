//
//  RecentSerchCarFlowLayout.m
//  carwale
//
//  Created by Lubhna Shirvastava on 22/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "RecentSerchCarFlowLayout.h"

@implementation RecentSerchCarFlowLayout
-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(226,245);
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.minimumInteritemSpacing = 0.0f;
    self.minimumLineSpacing = 10.0f;
    return self;
}
@end
