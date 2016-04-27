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
    NGORoundedButtonTypeShare,
    NGORoundedButtonTypeCustomText,
    NGORoundedButtonTypeCustomImage,
    NGORoundedButtonTypeAdd
};

typedef NS_ENUM(NSInteger, NGORoundedButtonShape) {
    NGORoundedButtonShapeCircle,
    NGORoundedButtonShapeSausage
};

typedef NS_ENUM(NSInteger, NGORoundedButtonColor) {
    NGORoundedButtonColorDefault,
    NGORoundedButtonColorBlue,
    NGORoundedButtonColorGreen,
    NGORoundedButtonColorPink
};

@interface NGORoundedButton : UIButton

@property (nonatomic) NGORoundedButtonType type;
@property (nonatomic) NGORoundedButtonShape shape;
@property (nonatomic) NGORoundedButtonColor color;
@property (nonatomic) NSString *customText;
@property (nonatomic) UIImage *customImage;

- (instancetype)initWithSize:(CGFloat)size;
- (instancetype)initWithDefaultSize;
- (instancetype)initWithButtonType:(NGORoundedButtonType)type;
- (instancetype)initWithButtonType:(NGORoundedButtonType)type andShape:(NGORoundedButtonShape)shape;
- (instancetype)initWithButtonType:(NGORoundedButtonType)type shape:(NGORoundedButtonShape)shape andColor:(NGORoundedButtonColor)color;
- (instancetype)initWithButtonCustomText:(NSString *)string andShape:(NGORoundedButtonShape)shape;
- (instancetype)initWithButtonCustomImage:(UIImage *)image andShape:(NGORoundedButtonShape)shape;

@end
