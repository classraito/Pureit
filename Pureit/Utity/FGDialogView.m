//
//  FGDialogView.m
//  MCDonald
//
//  Created by luyang on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FGDialogView.h"
BOOL lock;
static CGFloat kRenrenBlue[4] = {0.42578125, 0.515625, 0.703125, 1.0};
static CGFloat kBorderGray[4] = {0.3, 0.3, 0.3, 0.8};
static CGFloat kBorderBlack[4] = {0.3, 0.3, 0.3, 1};
static CGFloat kBorderBlue[4] = {0.23, 0.35, 0.6, 1.0};
static CGFloat kTransitionDuration = 0.3;
static CGFloat kPadding = 10;
static CGFloat kBorderWidth = 10;

    ///////////////////////////////////////////////////////////////////////////////////////////////////

BOOL IsDeviceIPad() {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
#endif
    return NO;
}

    ///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FGDialogView
@synthesize delegate_dialog;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    if (self = [super initWithFrame:CGRectZero]) {
        _orientation = UIDeviceOrientationUnknown;
        
        self.backgroundColor = [UIColor clearColor];
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}



- (void)dialogWillAppear {
    lock = YES;
    [self calContentRect];
    btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_close.frame = CGRectMake(self.frame.size.width-30, 0, 30, 30);
    [btn_close setImage:[UIImage imageNamed:@"close1.png"] forState:UIControlStateNormal];
    [btn_close setImage:[UIImage imageNamed:@"close2.png"] forState:UIControlStateHighlighted];
    [btn_close addTarget:self  action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_close];
    [self bringSubviewToFront:btn_close];
}

-(void)closeAction:(UIButton *)_btn
{
    [self dismiss:YES];
    if(delegate_dialog && [(NSObject *)delegate_dialog respondsToSelector:@selector(dialogDidClose:)])
    {
        [delegate_dialog dialogDidClose:self];
    }
}

- (void)dialogWillDisappear {
}

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
    CGContextBeginPath(context);
    CGContextSaveGState(context);
    
    if (radius == 0) {
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddRect(context, rect);
    } else {
        rect = CGRectOffset(CGRectInset(rect, 0.5, 0.5), 0.5, 0.5);
        CGContextTranslateCTM(context, CGRectGetMinX(rect)-0.5, CGRectGetMinY(rect)-0.5);
        CGContextScaleCTM(context, radius, radius);
        float fw = CGRectGetWidth(rect) / radius;
        float fh = CGRectGetHeight(rect) / radius;
        
        CGContextMoveToPoint(context, fw, fh/2);
        CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
        CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    }
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect fill:(const CGFloat*)fillColors radius:(CGFloat)radius {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    if (fillColors) {
        CGContextSaveGState(context);
        CGContextSetFillColor(context, fillColors);
        if (radius) {
            [self addRoundedRectToPath:context rect:rect radius:radius];
            CGContextFillPath(context);
        } else {
            CGContextFillRect(context, rect);
        }
        CGContextRestoreGState(context);
    }
    
    CGColorSpaceRelease(space);
    
}

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    // UIView

- (void)drawRect:(CGRect)rect {
    NSLog(@"rect=%@",NSStringFromCGRect(rect));
    CGRect grayRect = CGRectOffset(rect, -0.5, -0.5);
    [self drawRect:grayRect fill:kBorderGray radius:10];
    
    CGRect headerRect = CGRectMake(
                                   ceil(rect.origin.x + kBorderWidth), ceil(rect.origin.y + kBorderWidth),
                                   rect.size.width - kBorderWidth*2,0);
    [self drawRect:headerRect fill:kRenrenBlue radius:0];
    [self strokeLines:headerRect stroke:kBorderBlue];
    
    contentRect = CGRectMake(
                                ceil(rect.origin.x + kBorderWidth), 
                                headerRect.origin.y + headerRect.size.height,
                                rect.size.width - kBorderWidth*2,
                                rect.size.height - (1 + kBorderWidth*2)+1);
    NSLog(@"contentRect.frame= %@",NSStringFromCGRect(contentRect));
    [self strokeLines:contentRect stroke:kBorderBlack];
}

    ///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)strokeLines:(CGRect)rect stroke:(const CGFloat*)strokeColor {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorSpace(context, space);
    CGContextSetStrokeColor(context, strokeColor);
    CGContextSetLineWidth(context, 1.0);
    
    {
        CGPoint points[] = {{rect.origin.x+0.5, rect.origin.y-0.5},
            {rect.origin.x+rect.size.width, rect.origin.y-0.5}};
        CGContextStrokeLineSegments(context, points, 2);
    }
    {
        CGPoint points[] = {{rect.origin.x+0.5, rect.origin.y+rect.size.height-0.5},
            {rect.origin.x+rect.size.width-0.5, rect.origin.y+rect.size.height-0.5}};
        CGContextStrokeLineSegments(context, points, 2);
    }
    {
        CGPoint points[] = {{rect.origin.x+rect.size.width-0.5, rect.origin.y},
            {rect.origin.x+rect.size.width-0.5, rect.origin.y+rect.size.height}};
        CGContextStrokeLineSegments(context, points, 2);
    }
    {
        CGPoint points[] = {{rect.origin.x+0.5, rect.origin.y},
            {rect.origin.x+0.5, rect.origin.y+rect.size.height}};
        CGContextStrokeLineSegments(context, points, 2);
    }
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(space);
}

- (BOOL)shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    if (orientation == _orientation) {
        return NO;
    } else {
        return orientation == UIDeviceOrientationLandscapeLeft
        || orientation == UIDeviceOrientationLandscapeRight
        || orientation == UIDeviceOrientationPortrait
        || orientation == UIDeviceOrientationPortraitUpsideDown;
    }
}

- (CGAffineTransform)transformForOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

- (void)sizeToFitOrientation:(BOOL)transform {
    if (transform) {
        self.transform = CGAffineTransformIdentity;
    }
    CGRect frame = self.frame;
    CGPoint center = CGPointMake(
                                 frame.origin.x + ceil(frame.size.width/2),
                                 frame.origin.y + ceil(frame.size.height/2));
    
    CGFloat scale_factor = 1.0f;
    if (IsDeviceIPad()) {
            // On the iPad the dialog's dimensions should only be 60% of the screen's
        scale_factor = 0.6f;
    }
    
    CGFloat width = floor(scale_factor * frame.size.width) - kPadding * 2;
    CGFloat height = floor(scale_factor * frame.size.height) - kPadding * 2;
    
    _orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(_orientation)) {
        self.frame = CGRectMake(kPadding, kPadding, height, width);
    } else {
        self.frame = CGRectMake(kPadding, kPadding, width, height);
    }
    self.center = center;
    
    if (transform) {
        self.transform = [self transformForOrientation];
    }
}

- (void)bounce1AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = [self transformForOrientation];
    [UIView commitAnimations];
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChange:)
                                                 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"UIKeyboardWillHideNotification" object:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIDeviceOrientationDidChangeNotification
- (void)deviceOrientationDidChange:(void*)object {
    UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if ([self shouldRotateToOrientation:orientation]) {
        CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];
        [self sizeToFitOrientation:YES];
        [UIView commitAnimations];
    }
}

- (void)postDismissCleanup {
    [self removeObservers];
    [self removeFromSuperview];
}

- (void)dismiss:(BOOL)animated {
    lock = NO;
    [self dialogWillDisappear];
    
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(postDismissCleanup)];
        self.alpha = 0;
        [UIView commitAnimations];
    } else {
        [self postDismissCleanup];
    }
}

-(void)calContentRect
{
    CGRect headerRect = CGRectMake(
                                   ceil(self.bounds.origin.x + kBorderWidth), ceil(self.bounds.origin.y + kBorderWidth),
                                   self.frame.size.width - kBorderWidth*2,0);
    contentRect = CGRectMake(
                             ceil(self.bounds.origin.x + kBorderWidth), 
                             headerRect.origin.y + headerRect.size.height,
                             self.bounds.size.width - kBorderWidth*2,
                             self.bounds.size.height - (1 + kBorderWidth*2)+1);
    NSLog(@"contentRect.frame= %@",NSStringFromCGRect(contentRect));
}

- (void)showFromView:(UIView *)_view {
   
    [self sizeToFitOrientation:NO];
    self.frame = _view.frame;
    NSLog(@"self.frame = %@",NSStringFromCGRect(self.frame));
    [_view addSubview:self];
    
    [self dialogWillAppear];
    
    self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
    [UIView commitAnimations];
    
    [self addObservers];
    
}

- (void)showInFrame:(CGRect )_frame
{
     UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [self showInFrame:_frame fromView:window];
}

- (void)showInFrame:(CGRect )_frame fromView:(UIView *)_view{
    
    [self sizeToFitOrientation:NO];
    self.frame = _frame;
    [_view addSubview:self];
    
    [_view bringSubviewToFront:self];
    
    
    [self dialogWillAppear];
    
    self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
    [UIView commitAnimations];
    
    [self addObservers];
}

- (void)show {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [self showInFrame:window.frame];
    
}

-(void)addContentView:(UIView *)_view
{
    [self addContentView:_view isBackgroundFitContent:NO];
}

-(void)addContentView:(UIView *)_view isBackgroundFitContent:(BOOL)_isBackgroundFitContent
{
    [self calContentRect];
    [self insertSubview:_view belowSubview:btn_close];
    
    if(_isBackgroundFitContent)
    {
         CGRect _frame = self.frame;
        _frame.size.height = _view.frame.size.height+(1 + kBorderWidth*2)*2;
        self.frame = _frame;
        
        [self calContentRect];
        
        _frame = contentRect;
        _frame.size.height = _view.frame.size.height;
        _view.frame = _frame;
    }
    else {
        _view.frame = contentRect;
        NSLog(@"self.frame=%@",NSStringFromCGRect(self.frame));
    }
}

-(void)fitHeightByContentView:(UIView *)_view
{
    
    CGRect _frame = self.frame;
    _frame.size.height = _view.frame.size.height+((1 + kBorderWidth*2)-1)*2;
    self.frame = _frame;
    
    [self calContentRect];
    
    _frame = contentRect;
    _frame.size.height = _view.frame.size.height;
    _view.frame = _frame;
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc FGDialogView");
    [self removeObservers];
    lock = NO;
    delegate_dialog = nil;
    [super dealloc];
}
@end
