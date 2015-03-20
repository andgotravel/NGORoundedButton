//
//  NGORoundedButton.m
//
//
//  Created by Stanislav Zhukovskiy on 18.03.15.
//  Copyright (c) 2015 Ampersand. All rights reserved.
//

#import "NGORoundedButton.h"

@implementation NGORoundedButton

#pragma mark - Init

- (instancetype)init {
    
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithSize:(CGFloat)size {
    
    self = [self initWithFrame:CGRectMake(0, 0, size, size)];
    return self;
}

- (instancetype)initWithDefaultSize {
    
    CGFloat defaultSize = 44.f;
    self = [self initWithFrame:CGRectMake(0, 0, defaultSize, defaultSize)];
    return self;
}

- (instancetype)initWithButtonType:(NGORoundedButtonType)type {
    
    self.type   = type;
    self        = [self initWithDefaultSize];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    [self setupCornerRadius];
    [self setupShadow];

    switch (self.type) {
        case NGORoundedButtonTypeSave:      [self setupSaveButton];     break;
        case NGORoundedButtonTypeCancel:    [self setupCancelButton];   break;
        case NGORoundedButtonTypeBack:      [self setupBackButton];     break;
        case NGORoundedButtonTypeFilter:    [self setupFilterButton];   break;
        case NGORoundedButtonTypeShare:     [self setupShareButton];    break;
    }
    
    [self setupTargets];
}

- (void)setType:(NGORoundedButtonType)newType {
    
    _type = newType;
    [self setup];
}

#pragma mark - Buttons

- (void)setupSaveButton {
    
    UIColor *backColor      = [UIColor colorWithRed:34/255.0 green:226/255.0 blue:157/255.0 alpha:1];
    self.backgroundColor    = backColor;
    
    CAShapeLayer *checkmarkShape    = [CAShapeLayer layer];
    checkmarkShape.lineWidth        = 3 / [UIScreen mainScreen].scale;
    checkmarkShape.masksToBounds    = NO;
    checkmarkShape.lineCap          = kCALineCapRound;
    checkmarkShape.strokeColor      = [UIColor whiteColor].CGColor;
    checkmarkShape.fillColor        = backColor.CGColor;
    
    CGRect fr       = self.bounds;
    CGFloat width   = CGRectGetWidth(fr);
    CGFloat height  = CGRectGetHeight(fr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) - (width / 4), CGRectGetMidY(fr) + (height / 16));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 12), CGRectGetMidY(fr) + (height / 5));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 5), CGRectGetMidY(fr) - (height / 8));
    
    checkmarkShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:checkmarkShape];
}

- (void)setupCancelButton {
    
    UIColor *backgroundColor    = [UIColor whiteColor];
    UIColor *borderColor        = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:236/255.0 alpha:0.9];
    UIColor *strokeColor        = [UIColor colorWithRed:73/255.0 green:78/255.0 blue:91/255.0 alpha:1.0];
    
    self.backgroundColor                = backgroundColor;
    self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
    self.layer.borderWidth              = 1 / [UIScreen mainScreen].scale;
    self.layer.borderColor              = borderColor.CGColor;
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *crossShape    = [CAShapeLayer layer];
    crossShape.lineWidth        = 3 / [UIScreen mainScreen].scale;
    crossShape.masksToBounds    = NO;
    crossShape.lineCap          = kCALineCapRound;
    crossShape.strokeColor      = strokeColor.CGColor;
    
    CGRect fr       = self.bounds;
    CGFloat ofSize  = CGRectGetWidth(fr) / 2.8;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, ofSize, ofSize);
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(fr) - ofSize, CGRectGetMaxY(fr) - ofSize);
    CGPathMoveToPoint(path, NULL, CGRectGetMaxX(fr) - ofSize, CGRectGetMinY(fr) + ofSize);
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(fr) + ofSize, CGRectGetMaxY(fr) - ofSize);
    
    crossShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:crossShape];
}

- (void)setupBackButton {
    
    UIColor *backgroundColor    = [UIColor whiteColor];
    UIColor *borderColor        = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:236/255.0 alpha:0.9];
    UIColor *strokeColor        = [UIColor colorWithRed:73/255.0 green:78/255.0 blue:91/255.0 alpha:1.0];
    
    self.backgroundColor                = backgroundColor;
    self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
    self.layer.borderWidth              = 1 / [UIScreen mainScreen].scale;
    self.layer.borderColor              = borderColor.CGColor;
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *leftArrowShape    = [CAShapeLayer layer];
    leftArrowShape.lineWidth        = 3 / [UIScreen mainScreen].scale;
    leftArrowShape.masksToBounds    = NO;
    leftArrowShape.lineCap          = kCALineCapRound;
    leftArrowShape.strokeColor      = strokeColor.CGColor;
    leftArrowShape.fillColor        = backgroundColor.CGColor;
    
    CGRect fr       = self.bounds;
    CGFloat width   = CGRectGetWidth(fr);
    CGFloat height  = CGRectGetHeight(fr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) + (width / 20), CGRectGetMidY(fr) - (height / 6));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 8), CGRectGetMidY(fr));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 20), CGRectGetMidY(fr) + (height / 6));
    
    leftArrowShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:leftArrowShape];
}

- (void)setupFilterButton {
    
    UIColor *backgroundColor    = [UIColor whiteColor];
    UIColor *borderColor        = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:236/255.0 alpha:0.9];
    UIColor *strokeColor        = [UIColor colorWithRed:73/255.0 green:78/255.0 blue:91/255.0 alpha:1.0];
    
    self.backgroundColor                = backgroundColor;
    self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
    self.layer.borderWidth              = 1 / [UIScreen mainScreen].scale;
    self.layer.borderColor              = borderColor.CGColor;
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *funnelShape    = [CAShapeLayer layer];
    funnelShape.lineWidth        = 3 / [UIScreen mainScreen].scale;
    funnelShape.masksToBounds    = NO;
    funnelShape.lineCap          = kCALineCapRound;
    funnelShape.strokeColor      = strokeColor.CGColor;
    funnelShape.fillColor        = backgroundColor.CGColor;
    
    CGRect fr               = self.bounds;
    CGFloat width           = CGRectGetWidth(fr);
    CGFloat height          = CGRectGetHeight(fr);
    CGMutablePathRef path   = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) - (width / 4.5), CGRectGetMidY(fr) - (height / 6.76));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 4.5), CGRectGetMidY(fr) - (height / 6.76));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 24), CGRectGetMidY(fr) + (height / 11));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 24), CGRectGetMidY(fr) + (height / 4.88));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 24), CGRectGetMidY(fr) + (height / 4.19));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 24), CGRectGetMidY(fr) + (height / 11));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 4.5), CGRectGetMidY(fr) - (height / 6.76));
    
    funnelShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:funnelShape];
}

- (void)setupShareButton {
    
    UIColor *backgroundColor    = [UIColor whiteColor];
    UIColor *borderColor        = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:236/255.0 alpha:0.9];
    UIColor *strokeColor        = [UIColor colorWithRed:73/255.0 green:78/255.0 blue:91/255.0 alpha:1.0];
    
    self.backgroundColor                = backgroundColor;
    self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
    self.layer.borderWidth              = 1 / [UIScreen mainScreen].scale;
    self.layer.borderColor              = borderColor.CGColor;
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *squareAndArrowShape   = [CAShapeLayer layer];
    squareAndArrowShape.lineWidth       = 3 / [UIScreen mainScreen].scale;
    squareAndArrowShape.masksToBounds   = NO;
    squareAndArrowShape.lineCap         = kCALineCapRound;
    squareAndArrowShape.strokeColor     = strokeColor.CGColor;
    squareAndArrowShape.fillColor       = backgroundColor.CGColor;
    
    CGRect fr               = self.bounds;
    CGFloat width           = CGRectGetWidth(fr);
    CGFloat height          = CGRectGetHeight(fr);
    CGMutablePathRef path   = CGPathCreateMutable();
    //square
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) - (width / 6.76), CGRectGetMidY(fr) - (height / 9.77));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 14.6), CGRectGetMidY(fr) - (height / 9.77));
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) + (width / 14.6), CGRectGetMidY(fr) - (height / 9.77));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 6.76), CGRectGetMidY(fr) - (height / 9.77));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 6.76), CGRectGetMidY(fr) + (height / 4.88));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 6.76), CGRectGetMidY(fr) + (height / 4.88));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 6.76), CGRectGetMidY(fr) - (height / 9.77));
    //arrow
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) + (height / 22));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) - (height / 4.4));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - (width / 14.6), CGRectGetMidY(fr) - (height / 5.5));
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) - (height / 4.4));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + (width / 14.6), CGRectGetMidY(fr) - (height / 5.5));
    
    squareAndArrowShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:squareAndArrowShape];
}

#pragma mark - Common UI setup

- (void)setupCornerRadius {
    
    self.layer.cornerRadius             = CGRectGetWidth(self.bounds) / 2;
    self.layer.masksToBounds            = NO;
    self.layer.allowsEdgeAntialiasing   = YES;
}

- (void)setupShadow {
    
    self.layer.shadowColor      = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity    = 0.15;
    self.layer.shadowRadius     = 3;
    self.layer.shadowOffset     = CGSizeMake(0.0f, 3.0f);
}

- (void)setupTargets {
    
    [self addTarget:self action:@selector(normalState)      forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(normalState)      forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(highlitedState)   forControlEvents:UIControlEventTouchDown];
}

#pragma mark - Button State Animation

- (void)normalState {
    
    self.transform  = CGAffineTransformMakeScale(1, 1);
    self.alpha      = 1;
}

- (void)highlitedState {
    
    self.transform  = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha      = 0.75;
}

@end

