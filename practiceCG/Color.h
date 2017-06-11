//
//  Color.h
//  practiceCG
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Color : NSObject

@property (nonatomic) double value;
@property (nonatomic) NSInteger red;
@property (nonatomic) NSInteger green;
@property (nonatomic) NSInteger blue;

- (instancetype)init;

@end
