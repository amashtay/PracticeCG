//
//  RectangleField.m
//  practiceCG
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "RectangleField.h"
#import "BiliniarRectangleElement.h"

@implementation RectangleField

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.x0 = 0.0;
        self.x1 = 0.0;
        self.y0 = 0.0;
        self.y1 = 0.0;
        self.nx = 1;
        self.ny = 1;
    }
    return self;
}
- (instancetype)initWithX0:(double)x0
                        Y0:(double)y0
                        X1:(double)x1
                        Y1:(double)y1
                        Nx:(NSInteger)nx
                        Ny:(NSInteger)ny
{
    self = [super init];
    if (self)
    {
        self.x0 = x0;
        self.x1 = x1;
        self.y0 = y0;
        self.y1 = y1;
        self.nx = nx;
        self.ny = ny;
    }
    return self;
}

- (void)drawFieldWithScale:(double)scale
                         U:(double(^)(double x, double y))uFuncBlock
              PolygonBlock:(void(^)(double x, double y, double x1, double y1, NSArray<NSNumber *> *u, double scale))drawColorBlock
                EdgesBLock:(void(^)(double x, double y, double x1, double y1, double scale))drawEdgesBlock
{
    double x, y;
    double hx = (self.x1 - self.x0)/ (self.ny - 1);
    double hy = (self.y1 - self.y0) /(self.nx - 1);
    
    double n = (self.nx - 1) * (self.ny - 1);
    
    NSMutableArray<BiliniarRectangleElement *> *elements = [NSMutableArray arrayWithCapacity:n];
    
    NSInteger k = 0;
    for (NSInteger i = 0; i < self.nx - 1; i++)
    {
        y = self.y0 + i * hy;
        for (NSInteger j = 0; j < self.ny - 1; j++)
        {
            x = self.x0 + j * hx;
            
            elements[k] = [[BiliniarRectangleElement alloc] init];
            elements[k].x0 = x;
            elements[k].y0 = y;
            elements[k].hx = hx;
            elements[k].hy = hy;
            
            elements[k].nx = 8;
            elements[k].ny = 4;
            
            NSArray<NSNumber *> *uArray = @[@(uFuncBlock(x, y)),
                                            @(uFuncBlock(x + hx, y)),
                                            @(uFuncBlock(x, y + hy)),
                                            @(uFuncBlock(x + hx, y + hy))
                                            ];
            [elements[k] setU:uArray];

            
            
            [elements[k] drawColorElementWithScale:scale block:drawColorBlock];
            [elements[k] drawEdgesOfElementWithScale:scale block:drawEdgesBlock];
            
            k++;
        }
    }
}

@end
