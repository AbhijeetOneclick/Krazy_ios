//
//  CarImagesFlowLayout.m
//  carwale
//
//  Created by One Click IT Consultancy  on 12/1/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "CarImagesFlowLayout.h"

@implementation CarImagesFlowLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(DEVICE_WIDTH,240);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    
    return self;
}


@end
