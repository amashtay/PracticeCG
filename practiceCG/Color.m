//
//  Color.m
//  practiceCG
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "Color.h"

@implementation Color

- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = 0.0;
        _red = 0;
        _green = 0;
        _blue = 0;
    }
    return self;
}

@end
