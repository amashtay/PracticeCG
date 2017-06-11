//
//  RectangleElementCGView.m
//  practiceCG
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "RectangleElementCGView.h"
#import "BiliniarRectangleElement.h"
#import "Color.h"
#import "RectangleField.h"

static const double kScale = 70.0;
static const NSInteger kCountOfColorAreas = 7;


@interface RectangleElementCGView ()

@property (nonatomic, strong) BiliniarRectangleElement *linElement;
@property (nonatomic) CGContextRef context;
@property (nonatomic, strong) NSMutableArray<Color *> *rainbow;

@end

@implementation RectangleElementCGView


- (void)generateColorsWithMin: (double)minValue
                       andMax: (double)maxValue
{
    self.rainbow = [NSMutableArray arrayWithCapacity:kCountOfColorAreas];
    double hValues = (maxValue - minValue) / (kCountOfColorAreas- 1);
    for (size_t i = 0; i < kCountOfColorAreas; i++)
    {
        self.rainbow[i] = [[Color alloc] init];
        self.rainbow[i].value = minValue + i*hValues;
    }
    
    int colorRedMin = 0, colorGreenMin = 5, colorBlueMin = 255;
    int colorRedMax = 0, colorGreenMax = 255, colorBlueMax = 25;
    
    self.rainbow[0].red = colorRedMin;
    self.rainbow[0].green = colorGreenMin;
    self.rainbow[0].blue = colorBlueMin;
    
    self.rainbow[kCountOfColorAreas - 1].red = colorRedMax;
    self.rainbow[kCountOfColorAreas - 1].green = colorGreenMax;
    self.rainbow[kCountOfColorAreas - 1].blue = colorBlueMax;
    
    int colorRedH = (colorRedMax - colorRedMin) / (kCountOfColorAreas - 1);
    int colorGreenH = (colorGreenMax - colorGreenMin) / (kCountOfColorAreas - 1);
    int colorBlueH = (colorBlueMax - colorBlueMin) / (kCountOfColorAreas- 1);
    
    for (size_t i = 0; i < kCountOfColorAreas; i++)
    {
        self.rainbow[i].red = colorRedMin + i*colorRedH;
        self.rainbow[i].green = colorGreenMin + i*colorGreenH;
        self.rainbow[i].blue = colorBlueMin + i*colorBlueH;
    }
}

- (void)drawLineLoopWithX:(double)x
                        Y:(double)y
                       X1:(double)x1
                       Y1:(double)y1
                    Scale:(double)scale
{
    CGContextSetRGBStrokeColor(self.context, 0, 0, 0, 1);
    //CGContextFillRect(context, CGRectMake(scale*x, scale*y, scale*x1, scale*y1));
    //CGContextAddLineToPoint(context, x1, y1);
    CGPoint points[8] = {
        CGPointMake(x * scale, y * scale), CGPointMake(x * scale, y1 *scale),
        CGPointMake(x * scale, y1 * scale), CGPointMake(x1 * scale, y1 *scale),
        CGPointMake(x1 * scale, y1 *scale), CGPointMake(x1 * scale, y *scale),
        CGPointMake(x1 * scale, y *scale), CGPointMake(x * scale, y *scale),
    };
    CGContextStrokeLineSegments(self.context, points, 8);
}

- (void)drawPolygonWithX:(double)x
                       Y:(double)y
                      X1:(double)x1
                      Y1:(double)y1
                   Scale:(double)scale
{
    CGContextSetRGBFillColor(self.context, 255, 255, 0, 1);
    
    CGContextFillRect(self.context, CGRectMake(x*scale, y*scale, (x1 - x)*scale, (y1 - y)*scale));
}


- (double)uFuncWithX:(double)x andY:(double)y
{
    return x*x+y*y;
}
- (void)drawRect:(CGRect)rect
{
    self.context = UIGraphicsGetCurrentContext();
    CGContextClearRect(self.context, rect);
    
    // зададим белый фон
    CGContextSetRGBFillColor(self.context, 255, 255, 255, 1);
    CGContextFillRect(self.context, self.bounds);
    
    // сгенерируем цвета
    [self generateColorsWithMin:[self uFuncWithX:0.0 andY:0.0] andMax:[self uFuncWithX:13.0 andY:8.0]];
    
//    self.linElement = [[BiliniarRectangleElement alloc] initWithX:0.0 andY:0.0];
//    self.linElement.nx = 9;
//    self.linElement.ny = 5;
//    
//    self.linElement.hx = 8.0;
//    self.linElement.hy = 4.0;
//    
//    self.linElement.u = @[@11.0, @7.0, @23.0, @9.0];
//
//    
//    typeof(self) __weak wself = self;
//    
//    [self.linElement drawColorElementWithScale:kScale block:^(double x, double y, double x1, double y1, NSArray<NSNumber *> *u, double scale) {
//        [wself  drawPolygonWithX:x Y:y X1:x1 Y1:y1 Scale:scale];
//    }];
//    
//    [self.linElement drawEdgesOfElementWithScale:kScale block:^(double x, double y, double x1, double y1, double scale) {
//        [wself drawLineLoopWithX:x Y:y X1:x1 Y1:y1 Scale:scale];
//    }];
    
    RectangleField *rectangleField = [[RectangleField alloc] initWithX0:0.0
                                                                     Y0:0.0
                                                                     X1:13.0
                                                                     Y1:8.0
                                                                     Nx:9
                                                                     Ny:14];
    typeof(self) __weak wself = self;
    
    [rectangleField drawFieldWithScale:kScale
                                     U:^double(double x, double y) {
                                                return 1;
                                     }
                          PolygonBlock:^(double x, double y, double x1, double y1, NSArray<NSNumber *> *u, double scale) {
                                        [wself  drawPolygonWithX:x Y:y X1:x1 Y1:y1 Scale:scale];
                                      }
                            EdgesBLock:^(double x, double y, double x1, double y1, double scale) {
                                         [wself drawLineLoopWithX:x Y:y X1:x1 Y1:y1 Scale:scale];
                                      }];
    
}
@end
