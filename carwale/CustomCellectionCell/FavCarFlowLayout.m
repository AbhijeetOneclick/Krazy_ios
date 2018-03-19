//
//  FavCarFlowLayout.m
//  carwale
//
//  Created by i-MaC on 14/08/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "FavCarFlowLayout.h"

@implementation FavCarFlowLayout
-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(DEVICE_WIDTH,120);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    
    return self;
}


@end
