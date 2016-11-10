//
//  XLFFormTextField.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-9-29.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "XLFFormTextField.h"

NSInteger KDefualtWidth = 100;
@interface XLFFormTextField ()
@property (strong , nonatomic) UILabel *evlbTitle ;
@property (strong , nonatomic) UILabel *evlbDetail ;
@property (strong , nonatomic) UIImageView *evvUnderline ;
@property (assign , nonatomic) XLFFormTextFieldStyle evStyle ;

@property (strong , nonatomic) NSLayoutConstraint *evlcLineLeft;
@property (strong , nonatomic) NSLayoutConstraint *evlcLineRight;
@property (strong , nonatomic) NSLayoutConstraint *evlcLineHeight;
@property (strong , nonatomic) NSLayoutConstraint *evlcLineBottom;

@end
@implementation XLFFormTextField
- (void)dealloc{
    
    [self setEvlbTitle:nil];
    [self setEvlbDetail:nil];
    [self setEvvUnderline:nil];
}

- (id)initWithFrame:(CGRect)frame style:(XLFFormTextFieldStyle)style;{
    
    self = [super initWithFrame:frame];
    if (self) {
    
        // Initialization code

        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor blackColor]];
        [self setFont:[UIFont systemFontOfSize:13]];
        [self setEvLineColor:[UIColor grayColor]];

        [self setEvStyle:style];

        [self setEvTitleWidth:KDefualtWidth];
        [self setEvDetailWidth:KDefualtWidth];

//        [self setFrame:frame];
    }
    return self;
}

- (void)setEvLineStyle:(XLFLineStyle)evLineStyle{

    if (!([self evStyle] & XLFFormTextFieldStyleUnderline)) {

        return;
    }
    
    _evLineStyle = evLineStyle;
    
    switch (evLineStyle) {
    
            
        case XLFLineStyleNone:
            [[self evvUnderline] setImage:nil];
            break;
            
        case XLFLineStyleDot:
            [[self evvUnderline] setImage:[UIImage imageNamed:@"line_dot"]];
            break;
            
        case XLFLineStyleSolid:
            [[self evvUnderline] setImage:[UIImage imageNamed:@"line_solid"]];
            break;
            
        default:
            break;
    }
}

//- (void)setFrame:(CGRect)frame{
//
//    [super setFrame:frame];
//    
//    [self relayout];
//}

- (void)relayout{

    [[self evlbTitle] setFrame:CGRectMake(0, 0, [self evTitleWidth] , CGRectGetHeight([self frame]))];
    [[self evlbDetail] setFrame:CGRectMake(0, 0, [self evDetailWidth], CGRectGetHeight([self frame]))];

    if ([self evLineMode] == XLFLineModeScaleToFillAll) {

        if ([self evvUnderline]) {

            [[self evlcLineLeft] setConstant:0];
            [[self evlcLineRight] setConstant:0];
        }

//        [[self evvUnderline] setFrame:CGRectMake(0, CGRectGetHeight([self frame]) - 1, CGRectGetWidth([self frame]), 1)];
    }
    else if ([self evLineMode] == XLFLineModeScaleToFillContent){

        if ([self evvUnderline]) {

            [[self evlcLineLeft] setConstant:-[self evTitleWidth]];
            [[self evlcLineRight] setConstant:[self evDetailWidth]];
        }

//        [[self evvUnderline] setFrame:CGRectMake(0, CGRectGetHeight([self frame]) - 1 - [self evTitleWidth] - [self evDetailWidth], CGRectGetWidth([self frame]), 1)];
    }
}

- (void)updateConstraints{
    [super updateConstraints];

    [self relayout];
}

- (void)setEvStyle:(XLFFormTextFieldStyle)evStyle{

    if (!(evStyle & XLFFormTextFieldStyleTitle)) {

        [self removeTitle];
    }
    if (!(evStyle & XLFFormTextFieldStyleDetail)) {

        [self removeDetail];
    }
    if (!(evStyle & XLFFormTextFieldStyleUnderline)) {

        [self removeUnderline];
    }
    
    if ((evStyle & XLFFormTextFieldStyleTitle) && !(_evStyle & XLFFormTextFieldStyleTitle) ) {

        [self setEvlbTitle:[self createTitle]];
        [self setLeftView:[self evlbTitle]];
        [self setLeftViewMode:UITextFieldViewModeAlways];
    }
    
    if ((evStyle & XLFFormTextFieldStyleDetail) && !(_evStyle & XLFFormTextFieldStyleDetail) ) {

        [self setEvlbDetail:[self createDetail]];
        [self setRightView:[self evlbDetail]];
        [self setRightViewMode:UITextFieldViewModeAlways];
    }
    
    if ((evStyle & XLFFormTextFieldStyleUnderline) && !(_evStyle & XLFFormTextFieldStyleUnderline) ) {

        [self setEvvUnderline:[self createUnderline]];
        [self addSubview:[self evvUnderline]];

        [[self evvUnderline] addConstraint:[self evlcLineHeight]];
        [self addConstraints:[self evUnderlineLayoutContraints]];
    }

    _evStyle = evStyle;
    
    [self relayout];
}

- (void)setEvTitleWidth:(CGFloat)evTitleWidth{

    _evTitleWidth = evTitleWidth;
    
    [self relayout];
}

- (void)setEvTitle:(NSString *)evTitle{

    [[self evlbTitle] setText:evTitle];
}

- (NSString*)evTitle{

    return [[self evlbTitle] text];
}

- (void)setEvTitleFont:(UIFont *)evTitleFont{

    [[self evlbTitle] setFont:evTitleFont];
}

- (UIFont*)evTitleFont{

    return [[self evlbTitle] font];
}

- (void)setEvTitleColor:(UIColor *)evTitleColor{

    [[self evlbTitle] setTextColor:evTitleColor];
}

- (UIColor*)evTitleColor{

    return [[self evlbTitle] textColor];
}

- (void)setEvTitleAlignment:(NSTextAlignment)evTitleAlignment{

    [[self evlbTitle] setTextAlignment:evTitleAlignment];
}

- (NSTextAlignment)evTitleAlignmen{

    return [[self evlbTitle] textAlignment];
}

- (void)setEvDetailWidth:(CGFloat)evDetailWidth{

    _evDetailWidth = evDetailWidth;
    
    [self relayout];
}

- (void)setEvDetail:(NSString *)evDetail{

    [[self evlbDetail] setText:evDetail];
}

- (NSString*)evDetail{

    return [[self evlbDetail] text];
}

- (void)setEvDetailFont:(UIFont *)evDetailFont{

    [[self evlbDetail] setFont:evDetailFont];
}

- (UIFont*)evDetailFont{

    return [[self evlbDetail] font];
}

- (void)setEvDetailColor:(UIColor *)evDetailColor{

    [[self evlbDetail] setTextColor:evDetailColor];
}

- (UIColor*)evDetailColor{

    return [[self evlbDetail] textColor];
}

- (void)setEvDetailAlignment:(NSTextAlignment)evDetailAlignment{

    [[self evlbDetail] setTextAlignment:evDetailAlignment];
}

- (NSTextAlignment)evDetailAlignmen{

    return [[self evlbDetail] textAlignment];
}

- (void)setEvLineColor:(UIColor *)evLineColor{

    if (_evLineColor != evLineColor) {

        _evLineColor = evLineColor;

        if (![self evLineImage]) {

            [[self evvUnderline] setBackgroundColor:evLineColor];
        }
    }
}

- (void)setEvLineImage:(UIImage *)evLineImage{

    if (_evLineImage != evLineImage) {

        _evLineImage = evLineImage;

        [[self evvUnderline] setImage:evLineImage];
        if (!evLineImage) {

            [[self evvUnderline] setBackgroundColor:[self evLineColor]];
        }
    }
}

- (void)removeSubViews{

    [self removeTitle];
    [self removeDetail];
    [self removeUnderline];
}

- (void)removeTitle{

    [self setLeftView:nil];
    [self setEvlbTitle:nil];
}

- (void)removeDetail{

    [self setRightView:nil];
    [self setEvlbDetail:nil];
}

- (void)removeUnderline{

    [[self evvUnderline] removeConstraints:[self evUnderlineLayoutContraints]];
    [[self evvUnderline] removeFromSuperview];
    [self setEvvUnderline:nil];
}

- (UILabel*)createTitle{

    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self evTitleWidth], CGRectGetHeight([self frame]))];
    
    [lbTitle setBackgroundColor:[UIColor clearColor]];
    [lbTitle setTextColor:[UIColor blackColor]];
    [lbTitle setFont:[UIFont systemFontOfSize:13]];
    
    return lbTitle;
}

- (UILabel*)createDetail{

    UILabel *lbDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self evDetailWidth], CGRectGetHeight([self frame]))];
    
    [lbDetail setBackgroundColor:[UIColor clearColor]];
    [lbDetail setTextColor:[UIColor blackColor]];
    [lbDetail setFont:[UIFont systemFontOfSize:13]];
    
    return lbDetail;
}

- (UIImageView*)createUnderline{

    UIImageView *underline = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([self frame]) - 1, [self evDetailWidth],1) ];
    
    [underline setBackgroundColor:[self evLineColor]];
    [underline setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return underline;
}

- (NSLayoutConstraint*)evlcLineLeft{
    if (!_evlcLineLeft) {

        _evlcLineLeft = [NSLayoutConstraint constraintWithItem:[self evvUnderline] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    }
    return _evlcLineLeft;
}

- (NSLayoutConstraint *)evlcLineRight{

    if (!_evlcLineRight) {

        _evlcLineRight = [NSLayoutConstraint constraintWithItem:[self evvUnderline] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    }
    return _evlcLineRight;
}

- (NSLayoutConstraint *)evlcLineHeight{

    if (!_evlcLineHeight) {

        _evlcLineHeight = [NSLayoutConstraint constraintWithItem:[self evvUnderline] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1];
    }
    return _evlcLineHeight;
}

- (NSLayoutConstraint *)evlcLineBottom{

    if (!_evlcLineBottom) {

        _evlcLineBottom = [NSLayoutConstraint constraintWithItem:[self evvUnderline] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-1];
    }
    return _evlcLineBottom;
}

- (NSArray*)evUnderlineLayoutContraints;{

    return @[[self evlcLineLeft], [self evlcLineRight], [self evlcLineBottom]];
}

@end
