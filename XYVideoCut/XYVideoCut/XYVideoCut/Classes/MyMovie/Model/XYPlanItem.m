//
//  XYPlanItem.m
//  XYRrearrangeCell
//
//  Created by xiaoyuan on 16/11/6.
//  Copyright © 2016年 alpface. All rights reserved.
//

#import "XYPlanItem.h"

@implementation XYPlanItem

+ (instancetype)planItemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
