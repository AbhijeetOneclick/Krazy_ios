//
//  popularCarFlowLayout.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "popularCarFlowLayout.h"

@implementation popularCarFlowLayout
-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(226,217);
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.minimumInteritemSpacing = 0.0f;
    self.minimumLineSpacing = 10.0f;
    return self;
}
@end
