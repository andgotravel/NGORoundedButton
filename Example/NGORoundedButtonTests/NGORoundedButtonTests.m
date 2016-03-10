//
//  NGORoundedButtonTests.m
//  NGORoundedButtonTests
//
//  Created by Stanislav Zhukovskiy on 18.03.15.
//  Copyright (c) 2015 Stas Zhukovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <NGORoundedButton/NGORoundedButton.h>

@interface NGORoundedButtonTests : XCTestCase

@end

@implementation NGORoundedButtonTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatButtonCanInitWithDefaultSize {
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithDefaultSize];
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height);
}

- (void)testThatButtonCanInitWithType {
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeFilter];
    XCTAssertEqual(button.type, NGORoundedButtonTypeFilter);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height);
}

- (void)testThatButtonCanInitWithTypeAndShape {
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeSave andShape:NGORoundedButtonShapeSausage];
    XCTAssertEqual(button.type, NGORoundedButtonTypeSave);
    XCTAssertEqual(button.shape, NGORoundedButtonShapeSausage);
    XCTAssertEqual(button.color, NGORoundedButtonColorDefault);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height * 2);
}

- (void)testThatButtonCanInitWithTypeShapeAndColor {
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeFilter shape:NGORoundedButtonShapeSausage andColor:NGORoundedButtonColorGreen];
    XCTAssertEqual(button.type, NGORoundedButtonTypeFilter);
    XCTAssertEqual(button.color, NGORoundedButtonColorGreen);
    button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeFilter shape:NGORoundedButtonShapeSausage andColor:NGORoundedButtonColorBlue];
    XCTAssertEqual(button.color, NGORoundedButtonColorBlue);
    button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeFilter shape:NGORoundedButtonShapeSausage andColor:NGORoundedButtonColorPink];
    XCTAssertEqual(button.color, NGORoundedButtonColorPink);
    
    XCTAssertEqual(button.shape, NGORoundedButtonShapeSausage);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height * 2);
    button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeFilter shape:NGORoundedButtonShapeCircle andColor:NGORoundedButtonColorPink];
    XCTAssertEqual(button.shape, NGORoundedButtonShapeCircle);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height);
}

- (void)testThatButtonHasAccessabilityLabel {
    
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithDefaultSize];

    NSArray *types = @[@(NGORoundedButtonTypeBack),
                       @(NGORoundedButtonTypeCancel),
                       @(NGORoundedButtonTypeFilter),
                       @(NGORoundedButtonTypeOK),
                       @(NGORoundedButtonTypeSave),
                       @(NGORoundedButtonTypeShare),
                       @(NGORoundedButtonTypeCustomText)];
    
    [types enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NGORoundedButtonType type = [types[idx] integerValue];
        button.type = type;
        XCTAssertNotNil(button.accessibilityLabel);
        XCTAssertGreaterThan(button.accessibilityLabel.length, 0);
        XCTAssertGreaterThan(button.accessibilityTraits, UIAccessibilityTraitNone);
    }];
}

- (void)testThatButtonCanInitWithTypeOKAndShapeCircle {
    
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeOK andShape:NGORoundedButtonShapeCircle];
    XCTAssertEqual(button.type, NGORoundedButtonTypeOK);
    XCTAssertEqual(button.shape, NGORoundedButtonShapeCircle);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height);
    XCTAssertGreaterThan(button.titleLabel.text.length, 0);
}

- (void)testThatButtonCanInitWithTypeOKAndShapeSausage {
    
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithButtonType:NGORoundedButtonTypeOK andShape:NGORoundedButtonShapeSausage];
    XCTAssertEqual(button.type, NGORoundedButtonTypeOK);
    XCTAssertEqual(button.shape, NGORoundedButtonShapeSausage);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height * 2);
    XCTAssertGreaterThan(button.titleLabel.text.length, 0);
}

- (void)testThatButtonCanInitWithCustomTextAndSausageShape {
    
    NSString *text = @"test text";
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithButtonCustomText:text andShape:NGORoundedButtonShapeSausage];
    XCTAssertEqual(button.type, NGORoundedButtonTypeCustomText);
    XCTAssertEqual(button.shape, NGORoundedButtonShapeSausage);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height * 2);
    XCTAssertTrue([button.titleLabel.text isEqualToString:text]);
}

- (void)testThatButtonCanInitWithCustomTextAndCircle {
    
    NSString *text = @"test text";
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithButtonCustomText:text andShape:NGORoundedButtonShapeCircle];
    XCTAssertEqual(button.type, NGORoundedButtonTypeCustomText);
    XCTAssertEqual(button.shape, NGORoundedButtonShapeCircle);
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height);
    XCTAssertTrue([button.titleLabel.text isEqualToString:text]);
}

@end
