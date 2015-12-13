//
//  NGORoundedButton.m
//
//
//  Created by Stanislav Zhukovskiy on 18.03.15.
//  Copyright (c) 2015 Ampersand. All rights reserved.
//

#import "NGORoundedButton.h"

#define SHAPE_TAG @"CustomShapeTag"

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
    
    CGFloat defaultSize = 50.f;
    switch (self.shape) {
        case NGORoundedButtonShapeCircle: self = [self initWithFrame:CGRectMake(0, 0, defaultSize, defaultSize)];       break;
        case NGORoundedButtonShapeSausage: self = [self initWithFrame:CGRectMake(0, 0, defaultSize * 2, defaultSize)];  break;
    }
    return self;
}

- (instancetype)initWithButtonType:(NGORoundedButtonType)type {
    
    self.type   = type;
    self        = [self initWithDefaultSize];
    return self;
}

- (instancetype)initWithButtonType:(NGORoundedButtonType)type andShape:(NGORoundedButtonShape)shape {

    self.type   = type;
    self.shape  = shape;
    self        = [self initWithDefaultSize];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setup];
}

- (void)setup {

    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:SHAPE_TAG]) {
            [layer removeFromSuperlayer];
        }
    }

    [self setupCornerRadius];
    [self setupShadow];
    [self setupTargets];

    switch (self.type) {
        case NGORoundedButtonTypeSave:      [self setupSaveButton];     break;
        case NGORoundedButtonTypeOK:        [self setupOKButton];       break;
        case NGORoundedButtonTypeCancel:    [self setupCancelButton];   break;
        case NGORoundedButtonTypeBack:      [self setupBackButton];     break;
        case NGORoundedButtonTypeFilter:    [self setupFilterButton];   break;
        case NGORoundedButtonTypeShare:     [self setupShareButton];    break;
    }
}

- (void)setType:(NGORoundedButtonType)newType {
    
    if (_type != newType) {
        _type = newType;
        [self setup];
    }
}

- (void)setShape:(NGORoundedButtonShape)newShape {
    
    if (_shape != newShape) {
        _shape = newShape;
        [self setup];
    }
}

#pragma mark - Buttons

- (void)setupSaveButton {
    
    self.accessibilityLabel     = @"Save";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.backgroundColor = [UIColor colorWithRed:105/255.0 green:204/255.0 blue:57/255.0 alpha:1];;
    
    CAShapeLayer *checkmarkShape    = [CAShapeLayer layer];
    checkmarkShape.name             = SHAPE_TAG;
    checkmarkShape.lineWidth        = 2;
    checkmarkShape.masksToBounds    = NO;
    checkmarkShape.lineCap          = kCALineCapRound;
    checkmarkShape.strokeColor      = [UIColor whiteColor].CGColor;
    checkmarkShape.fillColor        = self.backgroundColor.CGColor;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(self.bounds) - 10, CGRectGetMidY(self.bounds) + 3);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(self.bounds) - 2, CGRectGetMidY(self.bounds) + 10);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(self.bounds) + 10, CGRectGetMidY(self.bounds) - 4);
    
    checkmarkShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:checkmarkShape];
}

- (void)setupOKButton {
    
    self.accessibilityLabel     = @"Ok";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.backgroundColor        = [UIColor colorWithRed:105/255.0 green:204/255.0 blue:57/255.0 alpha:1];
    NSDictionary *dict          = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18] };
    NSAttributedString *attr    = [[NSAttributedString alloc] initWithString:@"Ok" attributes:dict];
    [self setAttributedTitle:attr forState:UIControlStateNormal];
}

- (void)setupCancelButton {
    
    self.accessibilityLabel     = @"Cancel";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.backgroundColor                = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:255/255.0 alpha:1.0];
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *crossShape    = [CAShapeLayer layer];
    crossShape.name             = SHAPE_TAG;
    crossShape.lineWidth        = 2;
    crossShape.masksToBounds    = NO;
    crossShape.lineCap          = kCALineCapRound;
    crossShape.strokeColor      = [UIColor whiteColor].CGColor;
    
    CGRect fr       = self.bounds;
    CGFloat ofSize  = 6;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(self.bounds) - ofSize, CGRectGetMidY(self.bounds) - ofSize);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + ofSize, CGRectGetMidY(fr) + ofSize);
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) + ofSize, CGRectGetMidY(fr) - ofSize);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - ofSize, CGRectGetMidY(fr) + ofSize);
    
    crossShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:crossShape];
}

- (void)setupBackButton {
    
    self.accessibilityLabel     = @"Back";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.backgroundColor                = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:255/255.0 alpha:1.0];
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *leftArrowShape    = [CAShapeLayer layer];
    leftArrowShape.name             = SHAPE_TAG;
    leftArrowShape.lineWidth        = 2;
    leftArrowShape.masksToBounds    = NO;
    leftArrowShape.lineCap          = kCALineCapRound;
    leftArrowShape.strokeColor      = [UIColor whiteColor].CGColor;
    leftArrowShape.fillColor        = self.backgroundColor.CGColor;
    
    CGRect fr = self.bounds;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) + 3, CGRectGetMidY(fr) - 7);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - 4, CGRectGetMidY(fr));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 3, CGRectGetMidY(fr) + 7);
    
    leftArrowShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:leftArrowShape];
}

- (void)setupFilterButton {
    
    self.accessibilityLabel     = @"Filter";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.backgroundColor                = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:255/255.0 alpha:1.0];
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *funnelShape   = [CAShapeLayer layer];
    funnelShape.name            = SHAPE_TAG;
    funnelShape.lineWidth       = 2;
    funnelShape.masksToBounds   = NO;
    funnelShape.lineCap         = kCALineCapRound;
    funnelShape.lineJoin        = kCALineJoinRound;
    funnelShape.strokeColor     = [UIColor whiteColor].CGColor;
    funnelShape.fillColor       = self.backgroundColor.CGColor;
    
    CGRect fr               = self.bounds;
    CGMutablePathRef path   = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) - 9.7, CGRectGetMidY(fr) - 6.5);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 9.7, CGRectGetMidY(fr) - 6.5);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 1.83, CGRectGetMidY(fr) + 4);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 1.83, CGRectGetMidY(fr) + 9.016);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - 1.83, CGRectGetMidY(fr) + 10.50);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - 1.83, CGRectGetMidY(fr) + 4);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - 9.6, CGRectGetMidY(fr) - 6.4);
    
    funnelShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:funnelShape];
}

- (void)setupShareButton {
    
    self.accessibilityLabel     = @"Share";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.backgroundColor                = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:255/255.0 alpha:1.0];
    self.layer.allowsEdgeAntialiasing   = YES;
    
    CAShapeLayer *squareAndArrowShape   = [CAShapeLayer layer];
    squareAndArrowShape.name            = SHAPE_TAG;
    squareAndArrowShape.lineWidth       = 2;
    squareAndArrowShape.masksToBounds   = NO;
    squareAndArrowShape.lineCap         = kCALineCapRound;
    squareAndArrowShape.lineJoin        = kCALineJoinRound;
    squareAndArrowShape.strokeColor     = [UIColor whiteColor].CGColor;
    squareAndArrowShape.fillColor       = self.backgroundColor.CGColor;
    
    CGRect fr               = self.bounds;
    CGMutablePathRef path   = CGPathCreateMutable();
    //square
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) - 3.01, CGRectGetMidY(fr) - 4.5);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - 6.5, CGRectGetMidY(fr) - 4.5);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - 6.5, CGRectGetMidY(fr) + 9.016);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 6.5, CGRectGetMidY(fr) + 9.016);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 6.5, CGRectGetMidY(fr) - 4.5);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 3.01, CGRectGetMidY(fr) - 4.5);
    //arrow
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) + 2);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) - 10);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) - 3.013, CGRectGetMidY(fr) - 8);
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) - 10);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + 3.013, CGRectGetMidY(fr) - 8);
    
    squareAndArrowShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:squareAndArrowShape];
}

#pragma mark - Common UI setup

- (void)setupCornerRadius {
    
    self.layer.cornerRadius             = CGRectGetHeight(self.bounds) / 2;
    self.layer.masksToBounds            = NO;
    self.layer.allowsEdgeAntialiasing   = YES;
}

- (void)setupShadow {
    
    self.layer.shadowColor      = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity    = 0.3;
    self.layer.shadowRadius     = 2;
    self.layer.shadowOffset     = CGSizeMake(0.0f, 2.0f);
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
