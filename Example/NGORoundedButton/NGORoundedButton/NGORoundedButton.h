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
    NGORoundedButtonTypeOK,
    NGORoundedButtonTypeCancel,
    NGORoundedButtonTypeBack,
    NGORoundedButtonTypeFilter,
    NGORoundedButtonTypeShare
};

typedef NS_ENUM(NSInteger, NGORoundedButtonShape) {
    NGORoundedButtonShapeCircle,
    NGORoundedButtonShapeSausage
};

@interface NGORoundedButton : UIButton

@property (nonatomic) NGORoundedButtonType type;
@property (nonatomic) NGORoundedButtonShape shape;

- (instancetype)initWithSize:(CGFloat)size;
- (instancetype)initWithDefaultSize;
- (instancetype)initWithButtonType:(NGORoundedButtonType)type;
- (instancetype)initWithButtonType:(NGORoundedButtonType)type andShape:(NGORoundedButtonShape)shape;

@end
