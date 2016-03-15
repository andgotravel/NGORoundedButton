//
//  NGOViewController.m
//  NGORoundedButton
//
//  Created by Stas Zhukovskiy on 03/18/2015.
//  Copyright (c) 2014 Stas Zhukovskiy. All rights reserved.
//

#import "NGOViewController.h"
#import <NGORoundedButton/NGORoundedButton.h>

@interface NGOViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) NSMutableArray *buttons;

@end

@implementation NGOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttons = [NSMutableArray array];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupBackGradient];
        [self setupButtons];
        [self setupScrollView];
    });
}

- (void)setupBackGradient {
    
    UIImageView *gradient   = [[UIImageView alloc] initWithFrame:self.view.frame];
    gradient.image          = [UIImage imageNamed:@"Gradient"];
    [self.view addSubview:gradient];
    [self.view sendSubviewToBack:gradient];
}

- (void)setupButtons {
    
    NGORoundedButton *saveButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeSave];
    [self.buttons addObject:saveButton];
    
    NGORoundedButton *saveButtonLong = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeSave andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:saveButtonLong];
    
    NGORoundedButton *OKButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeOK];
    [self.buttons addObject:OKButton];
    
    NGORoundedButton *OKButtonLong = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeOK andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:OKButtonLong];
    
    NGORoundedButton *cancelButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeCancel];
    [self.buttons addObject:cancelButton];
    
    NGORoundedButton *cancelButtonLong = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeCancel andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:cancelButtonLong];
    
    NGORoundedButton *backButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeBack];
    [self.buttons addObject:backButton];
    
    NGORoundedButton *backButtonLong = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeBack andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:backButtonLong];
    
    NGORoundedButton *filterButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeFilter];
    [self.buttons addObject:filterButton];
    
    NGORoundedButton *filterButtonLong = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeFilter andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:filterButtonLong];
    
    NGORoundedButton *shareButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeShare];
    [self.buttons addObject:shareButton];
    
    NGORoundedButton *shareButtonLong = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeShare andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:shareButtonLong];
    
    NGORoundedButton *customTextButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeCustomText];
    [self.buttons addObject:customTextButton];
    
    NGORoundedButton *customTextButtonLong = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeCustomText andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:customTextButtonLong];
    
    NGORoundedButton *customImageButton = [[NGORoundedButton alloc] initWithButtonCustomImage:[UIImage imageNamed:@"github"] andShape:NGORoundedButtonShapeCircle];
    [self.buttons addObject:customImageButton];
    
    NGORoundedButton *customImageButtonLong = [[NGORoundedButton alloc] initWithButtonCustomImage:[UIImage imageNamed:@"github"] andShape:NGORoundedButtonShapeSausage];
    [self.buttons addObject:customImageButtonLong];
}

- (void)setupScrollView {
    
    CGFloat viewHeight                          = 80.f;
    self.mainScrollView.delaysContentTouches    = NO;
    self.mainScrollView.contentSize             = CGSizeMake(CGRectGetWidth(self.mainScrollView.bounds),
                                                             viewHeight * self.buttons.count);
    
    [self.buttons enumerateObjectsUsingBlock:^(NGORoundedButton *button, NSUInteger idx, BOOL *stop) {
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             idx * viewHeight,
                                                             CGRectGetWidth(self.mainScrollView.frame),
                                                             viewHeight)];
        v.backgroundColor = [UIColor clearColor];
        [self.mainScrollView addSubview:v];
        
        CGRect frame;
        frame.origin.x  = CGRectGetMaxX(v.bounds) - (CGRectGetWidth(button.frame) + 20);
        frame.origin.y  = CGRectGetMidY(v.bounds) - (CGRectGetHeight(button.frame) / 2);
        frame.size      = button.bounds.size;
        button.frame    = frame;
        [v addSubview:button];
        
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(v.bounds) + 20,
                                                                    CGRectGetMinY(v.bounds),
                                                                    CGRectGetWidth(v.bounds) - (CGRectGetWidth(button.bounds) + 20),
                                                                    CGRectGetHeight(v.bounds))];
        label.text      = [self buttonTypeNameForType:button.type];
        label.textColor = [UIColor whiteColor];
        [v addSubview:label];
    }];
}

- (NSString *)buttonTypeNameForType:(NGORoundedButtonType)type {
    
    NSString *result = @"";
    
    switch (type) {
        case NGORoundedButtonTypeSave:      result = @"ButtonTypeSave";     break;
        case NGORoundedButtonTypeOK:        result = @"ButtonTypeOK";       break;
        case NGORoundedButtonTypeCancel:    result = @"ButtonTypeCancel";   break;
        case NGORoundedButtonTypeBack:      result = @"ButtonTypeBack";     break;
        case NGORoundedButtonTypeFilter:    result = @"ButtonTypeFilter";   break;
        case NGORoundedButtonTypeShare:     result = @"ButtonTypeShare";    break;
        case NGORoundedButtonTypeCustomText:    result = @"ButtonTypeCustomText";   break;
        case NGORoundedButtonTypeCustomImage:   result = @"ButtonTypeCustomImage";  break;
    }
    return result;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
