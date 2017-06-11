//
//  BiliniarRectangleElement.h
//  practiceCG
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiliniarRectangleElement : NSObject

@property (nonatomic) NSInteger nx;
@property (nonatomic) NSInteger ny;

@property (nonatomic) double hx;
@property (nonatomic) double hy;
@property (nonatomic) double x0;
@property (nonatomic) double y0;
@property (nonatomic, strong) NSArray<NSNumber *> *u;
@property (nonatomic, readonly, getter=getXp) double xp;
@property (nonatomic, readonly, getter=getYs) double ys;


- (instancetype)init;
- (instancetype)initWithX:(double)x0 andY:(double)y0;

- (double)valueAtPointWithX:(double)x andY:(double)y;

- (void)drawColorElementWithScale:(double)scale
                            block:(void(^)(double x, double y, double x1, double y1, NSArray<NSNumber *> *u, double scale))drawBlock;

- (void)drawEdgesOfElementWithScale:(double)scale
                              block:(void(^)(double x, double y, double x1, double y1, double scale))drawBlock;

@end
