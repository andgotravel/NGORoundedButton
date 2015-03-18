//
//  NGORoundedButton.h
//
//
//  Created by Stanislav Zhukovskiy on 18.03.15.
//  Copyright (c) 2015 Ampersand. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NGORoundedButtonType) {
    NGORoundedButtonTypeSave,
    NGORoundedButtonTypeCancel,
    NGORoundedButtonTypeBack
};

@interface NGORoundedButton : UIButton

@property (nonatomic) NGORoundedButtonType type;

- (instancetype)initWithSize:(CGFloat)size;
- (instancetype)initWithDefaultSize;
- (instancetype)initWithButtonType:(NGORoundedButtonType)type;

@end
