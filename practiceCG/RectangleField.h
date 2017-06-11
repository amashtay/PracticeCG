//
//  RectangleField.h
//  practiceCG
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RectangleField : NSObject

@property (nonatomic) double x0;
@property (nonatomic) double x1;
@property (nonatomic) double y0;
@property (nonatomic) double y1;
@property (nonatomic) NSInteger nx;
@property (nonatomic) NSInteger ny;

- (instancetype)init;
- (instancetype)initWithX0:(double)x0
                        Y0:(double)y0
                        X1:(double)x1
                        Y1:(double)y1
                        Nx:(NSInteger)nx
                        Ny:(NSInteger)ny;

- (void)drawFieldWithScale:(double)scale
                         U:(double(^)(double x, double y))uFuncBlock
              PolygonBlock:(void(^)(double x, double y, double x1, double y1, NSArray<NSNumber *> *u, double scale))drawColorBlock
                EdgesBLock:(void(^)(double x, double y, double x1, double y1, double scale))drawEdgesBlock;


@end
