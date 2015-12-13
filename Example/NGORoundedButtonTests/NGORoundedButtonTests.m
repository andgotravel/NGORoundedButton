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
    XCTAssertGreaterThan(button.frame.size.width, 0);
    XCTAssertGreaterThan(button.frame.size.height, 0);
    XCTAssertEqual(button.frame.size.width, button.frame.size.height * 2);
}

- (void)testThatButtonHasAccessabilityLabel {
    
    NGORoundedButton *button = [[NGORoundedButton alloc] initWithDefaultSize];

    NSArray *types = @[@(NGORoundedButtonTypeBack),
                       @(NGORoundedButtonTypeCancel),
                       @(NGORoundedButtonTypeFilter),
                       @(NGORoundedButtonTypeOK),
                       @(NGORoundedButtonTypeSave),
                       @(NGORoundedButtonTypeShare)];
    
    [types enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NGORoundedButtonType type = [types[idx] integerValue];
        button.type = type;
        XCTAssertNotNil(button.accessibilityLabel);
        XCTAssertGreaterThan(button.accessibilityLabel.length, 0);
        XCTAssertGreaterThan(button.accessibilityTraits, UIAccessibilityTraitNone);
    }];
}

@end
