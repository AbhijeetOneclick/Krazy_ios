//
//  compareCarFlowlayout.m
//  carwale
//
//  Created by Lubhna Shirvastava on 21/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "compareCarFlowlayout.h"

@implementation compareCarFlowlayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
//    if (IS_IPAD) {
        self.itemSize = CGSizeMake(226,135);
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.minimumInteritemSpacing = 0.0f;
        self.minimumLineSpacing = 10.0f;
//    }else{
//    self.itemSize = CGSizeMake((DEVICE_WIDTH-50),160);
//    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//    self.minimumInteritemSpacing = 0.0f;
//    self.minimumLineSpacing = 10.0f;
//    }
    return self;
}

@end
