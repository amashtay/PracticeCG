//
//  BiliniarRectangleElement.m
//  practiceCG
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "BiliniarRectangleElement.h"
@interface BiliniarRectangleElement ()
@property (nonatomic, strong) NSMutableArray<NSNumber *> *mutableU;
@end

@implementation BiliniarRectangleElement

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hx = 1.0;
        _hy = 1.0;
        
        _x0 = 0.0;
        _y0 = 0.0;
        
        _nx = 2;
        _ny = 2;
        
        _mutableU = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
           [_mutableU addObject:[NSNumber numberWithDouble:0.0]];
        }
        _u = [_mutableU copy];
    }
    return self;
}

- (instancetype)initWithX:(double)x0 andY:(double)y0
{
    self = [super init];
    if (self) {
        _hx = 1.0;
        _hy = 1.0;
        
        _x0 = x0;
        _y0 = y0;
        
        _nx = 2;
        _ny = 2;
        
        _mutableU = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            [_mutableU addObject:[NSNumber numberWithDouble:0.0]];
        }
        _u = [_mutableU copy];
    }
    return self;
}

- (double)getXp
{
    return _x0 + _hx;
}

- (double)getYs
{
    return _y0 + _hy;
}

- (double)valueAtPointWithX:(double)x andY:(double)y
{
    double res = 0.0;
    double x1 = (self.xp - x)/self.hx;
    double x2 = (x - self.x0)/self.hx;
    double y1 = (self.ys - y)/self.hy;
    double y2 = (y - self.y0)/self.hy;
    
    res = [self.u[0] doubleValue] * x1 * y1 + [self.u[1] doubleValue] * x2 * y1 +
        [self.u[2] doubleValue] * x1 * y2 + [self.u[3] doubleValue] * x2 * y2;
    return res;
}

- (void)drawColorElementWithScale:(double)scale
                            block:(void(^)(double x, double y, double x1, double y1, NSArray<NSNumber *> *u, double scale))drawBlock
{
    double nnx = self.nx - 1;
    double nny = self.ny - 1;
    
    double xStep = self.hx / (nnx);
    double yStep = self.hy / (nny);
    
    for (int i = nny; i >= 1; i--)
    {
        for (int j = 0; j < nnx; j++)
        {
            double x = self.x0 + j * xStep;
            double y = self.y0 + (i - 1) * yStep;
            
            double x1 = self.x0 + (j + 1) * xStep;
            double y1 = self.y0 + i * yStep;
            
            
            NSMutableArray<NSNumber *> *uValue = [NSMutableArray array];

            [uValue addObject: [NSNumber numberWithDouble:[self valueAtPointWithX:x andY:y]]];
            [uValue addObject: [NSNumber numberWithDouble:[self valueAtPointWithX:x andY:y1]]];
            [uValue addObject: [NSNumber numberWithDouble:[self valueAtPointWithX:x1 andY:y1]]];
            [uValue addObject: [NSNumber numberWithDouble:[self valueAtPointWithX:x1 andY:y]]];
            
          
            drawBlock(x,y, x1, y1, [uValue copy], scale);
        }
    }
}


- (void)drawEdgesOfElementWithScale: (double)scale
                              block: (void (^)(double x, double y, double x1, double y1, double scale))drawBlock
{
    if (drawBlock != nil)
    drawBlock(self.x0, self.y0, self.xp, self.ys, scale);
}

@end
