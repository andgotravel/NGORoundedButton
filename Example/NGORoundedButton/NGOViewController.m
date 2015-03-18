//
//  NGOViewController.m
//  NGORoundedButton
//
//  Created by Stas Zhukovskiy on 03/18/2015.
//  Copyright (c) 2014 Stas Zhukovskiy. All rights reserved.
//

#import "NGOViewController.h"
#import "NGORoundedButton.h"

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
    
    [self setupBackGradient];
    [self setupSaveButton];
    [self setupCancelButton];
    [self setupBackButton];
    [self setupScrollView];
}

- (void)setupBackGradient {
    
    UIImageView *gradient   = [[UIImageView alloc] initWithFrame:self.view.frame];
    gradient.image          = [UIImage imageNamed:@"Gradient"];
    [self.view addSubview:gradient];
    [self.view sendSubviewToBack:gradient];
}

- (void)setupSaveButton {
    
    NGORoundedButton *saveButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeSave];
    [self.buttons addObject:saveButton];
}

- (void)setupCancelButton {
    
    NGORoundedButton *cancelButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeCancel];
    [self.buttons addObject:cancelButton];
}

- (void)setupBackButton {
    
    NGORoundedButton *backButton = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeBack];
    [self.buttons addObject:backButton];
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
        case NGORoundedButtonTypeSave:      result = @"ButtonTypeSave";   break;
        case NGORoundedButtonTypeCancel:    result = @"ButtonTypeCancel"; break;
        case NGORoundedButtonTypeBack:      result = @"ButtonTypeBack";   break;
        default: break;
    }
    return result;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
