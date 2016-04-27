//
//  NGORoundedButton.m
//
//
//  Created by Stanislav Zhukovskiy on 18.03.15.
//  Copyright (c) 2015 Ampersand. All rights reserved.
//

#import "NGORoundedButton.h"

#define SHAPE_TAG @"CustomShapeTag"
#define DEFAULT_SIZE 50.f

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
    
    switch (self.shape) {
        case NGORoundedButtonShapeCircle: self = [self initWithFrame:CGRectMake(0, 0, DEFAULT_SIZE, DEFAULT_SIZE)];       break;
        case NGORoundedButtonShapeSausage: self = [self initWithFrame:CGRectMake(0, 0, DEFAULT_SIZE * 2, DEFAULT_SIZE)];  break;
    }
    return self;
}

- (instancetype)initWithButtonType:(NGORoundedButtonType)type {
    
    _type   = type;
    self    = [self initWithDefaultSize];
    return self;
}

- (instancetype)initWithButtonType:(NGORoundedButtonType)type andShape:(NGORoundedButtonShape)shape {
    
    _type   = type;
    _shape  = shape;
    self    = [self initWithDefaultSize];
    return self;
}

- (instancetype)initWithButtonType:(NGORoundedButtonType)type shape:(NGORoundedButtonShape)shape andColor:(NGORoundedButtonColor)color {
    
    _type   = type;
    _shape  = shape;
    _color  = color;
    self    = [self initWithDefaultSize];
    return self;
}

- (instancetype)initWithButtonCustomText:(NSString *)string andShape:(NGORoundedButtonShape)shape {
    
    _type       = NGORoundedButtonTypeCustomText;
    _shape      = shape;
    _customText = string;
    self        = [self initWithDefaultSize];
    return self;
}

- (instancetype)initWithButtonCustomImage:(UIImage *)image andShape:(NGORoundedButtonShape)shape {
    
    _type           = NGORoundedButtonTypeCustomImage;
    _shape          = shape;
    _customImage    = image;
    self            = [self initWithDefaultSize];
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
    [self setupColor];
    
    switch (self.type) {
        case NGORoundedButtonTypeSave:      [self setupSaveButton];     break;
        case NGORoundedButtonTypeOK:        [self setupOKButton];       break;
        case NGORoundedButtonTypeCancel:    [self setupCancelButton];   break;
        case NGORoundedButtonTypeBack:      [self setupBackButton];     break;
        case NGORoundedButtonTypeFilter:    [self setupFilterButton];   break;
        case NGORoundedButtonTypeShare:     [self setupShareButton];    break;
        case NGORoundedButtonTypeAdd:       [self setupAddButton];      break;
        case NGORoundedButtonTypeCustomText:    [self setupCustomTextButton];   break;
        case NGORoundedButtonTypeCustomImage:   [self setupCustomImageButton];  break;
    }
}

- (void)setType:(NGORoundedButtonType)newType {
    
    if (_type != newType) {
        _type = newType;
        
        if (_type != NGORoundedButtonTypeCustomText) {
            _customText = @"";
            [self setAttributedTitle:[[NSAttributedString alloc] initWithString:@""] forState:UIControlStateNormal];
            [self setAttributedTitle:[[NSAttributedString alloc] initWithString:@""] forState:UIControlStateHighlighted];
        }
        
        if (_type != NGORoundedButtonTypeCustomImage) {
            _customImage = nil;
            [self setImage:nil forState:UIControlStateNormal];
            [self setImage:nil forState:UIControlStateHighlighted];
        }
        [self setup];
    }
}

- (void)setShape:(NGORoundedButtonShape)newShape {
    
    if (_shape != newShape) {
        _shape = newShape;
        [self setup];
    }
}

- (void)setColor:(NGORoundedButtonColor)newColor {
    
    if (_color != newColor) {
        _color = newColor;
        [self setup];
    }
}

- (void)setCustomText:(NSString *)newCustomText {
    
    if (_customText != newCustomText) {
        _customText = newCustomText;
        [self setup];
    }
}

- (void)setCustomImage:(UIImage *)newCustomImage {
    
    if (_customImage != newCustomImage) {
        _customImage = newCustomImage;
        [self setup];
    }
}

#pragma mark - Buttons

- (void)setupSaveButton {
    
    self.accessibilityLabel     = @"Save";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    
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
    NSDictionary *dict          = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18] };
    NSAttributedString *attr    = [[NSAttributedString alloc] initWithString:@"Ok" attributes:dict];
    [self setAttributedTitle:attr forState:UIControlStateNormal];
}

- (void)setupCancelButton {
    
    self.accessibilityLabel     = @"Cancel";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.layer.allowsEdgeAntialiasing = YES;
    
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
    self.layer.allowsEdgeAntialiasing = YES;
    
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
    self.layer.allowsEdgeAntialiasing = YES;
    
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
    self.layer.allowsEdgeAntialiasing = YES;
    
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

- (void)setupCustomTextButton {
    
    self.accessibilityLabel     = @"Custom Text";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    
    NSString *result = self.customText;
    if (!result) {
        NSLog(@"NGORoundedButton Warning! You forgot to set the customText property");
        return;
    }
    
    NSDictionary *dict          = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18] };
    NSAttributedString *attr    = [[NSAttributedString alloc] initWithString:self.customText attributes:dict];
    [self setAttributedTitle:attr forState:UIControlStateNormal];
    [self setAttributedTitle:attr forState:UIControlStateHighlighted];
}

- (void)setupCustomImageButton {
    
    self.accessibilityLabel     = @"Custom Image";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    [self setImage:self.customImage forState:UIControlStateNormal];
    [self setImage:self.customImage forState:UIControlStateHighlighted];
}

- (void)setupAddButton {
    
    self.accessibilityLabel     = @"Add";
    self.accessibilityTraits    = UIAccessibilityTraitButton;
    self.layer.allowsEdgeAntialiasing = YES;
    
    CAShapeLayer *plusShape = [CAShapeLayer layer];
    plusShape.name          = SHAPE_TAG;
    plusShape.lineWidth     = 2;
    plusShape.masksToBounds = NO;
    plusShape.lineCap       = kCALineCapRound;
    plusShape.strokeColor   = [UIColor whiteColor].CGColor;
    
    CGRect fr       = self.bounds;
    CGFloat ofSize  = 7;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) - ofSize);
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr), CGRectGetMidY(fr) + ofSize);
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(fr) - ofSize, CGRectGetMidY(fr));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(fr) + ofSize, CGRectGetMidY(fr));
    
    plusShape.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:plusShape];
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

- (void)setupColor {
    
    UIColor *greenColor = [UIColor colorWithRed:105/255.0 green:204/255.0 blue:57/255.0 alpha:1];
    UIColor *blueColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:255/255.0 alpha:1];
    UIColor *pinkColor = [UIColor colorWithRed:243/255.0 green:122/255.0 blue:183/255.0 alpha:1];
    
    switch (self.color) {
        case NGORoundedButtonColorBlue: self.backgroundColor = blueColor; break;
        case NGORoundedButtonColorGreen: self.backgroundColor = greenColor; break;
        case NGORoundedButtonColorPink: self.backgroundColor = pinkColor; break;
        case NGORoundedButtonColorDefault: {
            switch (self.type) {
                case NGORoundedButtonTypeSave:
                case NGORoundedButtonTypeAdd:
                case NGORoundedButtonTypeOK: self.backgroundColor = greenColor; break;
                case NGORoundedButtonTypeBack:
                case NGORoundedButtonTypeCancel:
                case NGORoundedButtonTypeCustomText:
                case NGORoundedButtonTypeCustomImage:
                case NGORoundedButtonTypeFilter:
                case NGORoundedButtonTypeShare: self.backgroundColor = blueColor; break;
            }
        }
    }
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
