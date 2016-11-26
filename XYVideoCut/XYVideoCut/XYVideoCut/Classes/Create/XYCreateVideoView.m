//
//  XYCreateVideoView.m
//  XYVideoCut
//
//  Created by mofeini on 16/11/14.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

#import "XYCreateVideoView.h"

@interface XYCreateVideoView ()

@property (nonatomic, weak) UIImageView *backgroundView;
@property (nonatomic, weak) UIButton *createButton;
@property (nonatomic, weak) UILabel *label;
@end

@implementation XYCreateVideoView

- (instancetype)initWithCreateButtun:(void(^)(UIButton *btn))createButton {
    
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupSubViews];
        if (createButton) {
            createButton(self.createButton);
        }
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(NO, nil);
    @throw nil;
}

- (void)setupSubViews {
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed:@"onBoardingBackgrounsImage4"];
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;

    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:createButton];
    [createButton setBackgroundImage:[UIImage imageNamed:@"kColorBluePressed"] forState:UIControlStateNormal];
    [createButton setTitle:@"制作影片" forState:UIControlStateNormal];
    self.createButton = createButton;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"让精彩重现";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25 weight:1.0];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    self.label = label;
    
    createButton.translatesAutoresizingMaskIntoConstraints = NO;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat createButtonH = 40;
//    CGFloat createButtonMarginV = (CGRectGetHeight([UIScreen mainScreen].bounds) - createButtonH) * 0.5;
    CGFloat createButtonMarginV = 180;
    NSDictionary *views = NSDictionaryOfVariableBindings(_createButton, _label, _backgroundView);
    NSDictionary *metrics = @{@"createButtonMarginH": @80, @"labelMarginH": @120, @"createButtonH": @(createButtonH), @"createButtonMarginV": @(createButtonMarginV), @"labelMarginV": @50};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-labelMarginH-[_label]-labelMarginH-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-createButtonMarginH-[_createButton]-createButtonMarginH-|" options:kNilOptions metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label]-labelMarginV-[_createButton(createButtonH)]-<=createButtonMarginV@700-|" options:kNilOptions metrics:metrics views:views]];
    
    [self layoutIfNeeded];
    
}
@end
