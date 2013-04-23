//
//  HUKenBurnsImageView.m
//  KenBurns
//
//  Created by Preston Lewis on 4/22/13.
//  Copyright (c) 2013 Preston Lewis. All rights reserved.
//

#import "HUKenBurnsImageView.h"
#define ARC4RANDOM_MAX      0x100000000

static const CGFloat kMinScale = 0.75f;
static const CGFloat kMaxScale = 1.5f;
static const CGFloat kMinDuration = 1.0f;
static const CGFloat kMaxDuration = 2.0f;

@interface HUKenBurnsImageView ()
-(void)setupViews;
-(void)registerObservers;
-(void)applyStyle;
-(void)unregisterObservers;
-(void)destroyViews;
@end

@interface HUKenBurnsImageView (Private)
-(CGRect)getNewRect;
@end

#pragma mark - HUKenBurnsImageView
@implementation HUKenBurnsImageView

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /* Perform default setup */
        [self setupViews];
        [self registerObservers];
        [self applyStyle];
        [self setNeedsLayout];
        
        /* Perform any additional setup here */
    }
    return self;
}

-(void)setupViews
{
    /* 
     This function is responsible for creating this components subviews
     and adding them to the view hierarchy and initializing all attributes that
     are not related to positioning/layout or styling. For positioning/layout, use
     layoutSubviews and for styling, use applyStyle.
     */
    [self destroyViews];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_imageView];
}

-(void)layoutSubviews
{
    /*
     This function is responsible for laying out this view's subviews. It is triggered
     automatically by the application after setNeedsLayout is called on this object. Do
     not call this function directly, instead use setNeedsLayout.
     */

}

-(void)applyStyle
{
    /*
     This function is responsible for setting styling on this view and its subviews.
     */
    
    _imageView.contentMode = UIViewContentModeScaleToFill;
    
    self.clipsToBounds = YES;
}

-(void)registerObservers
{
    /*
     This function sets up Key-Value observing on any properties this view should subscribe to
     for the duration of its lifecycle. See observeValue:forKeyPath: for handling of KVO events.
     */
}

-(void)setImage:(UIImage *)image animated:(BOOL)animated
{
    [_image release], _image = nil;
    _image = [image retain];
    _imageView.image = image;
    [self calculateBaseDimensions];
    if(animated)
    {
        [self beginAnimating];
        _imageView.alpha = 0.0f;
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _imageView.alpha = 1.0f;
                         }
                         completion:^(BOOL finished){
                             
                         }];
    }
    else
    {
        _imageView.alpha = 1.0f;
    }
    _aspect = image.size.height/image.size.width;
    [self setNeedsLayout];
    
}

-(void)calculateBaseDimensions
{
    CGFloat wScale = CGRectGetWidth(self.bounds)/_image.size.width;
    CGFloat hScale = CGRectGetHeight(self.bounds)/_image.size.height;
    CGFloat scaleFactor = MAX(wScale, hScale);
    
    _baseWidth = round(scaleFactor * _image.size.width);
    _baseHeight = round(scaleFactor * _image.size.height);
    
    _imageView.frame = CGRectIntegral(CGRectMake((CGRectGetWidth(self.bounds) - _baseWidth)/2,
                                                  (CGRectGetHeight(self.bounds) - _baseHeight)/2,
                                                 _baseWidth,
                                                 _baseHeight));
}

#pragma mark - Public Methods
-(void)beginAnimating
{
    _animating = YES;
    [self doKenBurnsAnimation];
}

-(void)stopAnimating
{
    _animating = NO;
}

-(void)doKenBurnsAnimation
{
    CGRect rect = [self getNewRect];
    CGFloat r = (CGFloat)arc4random()/ARC4RANDOM_MAX;
    CGFloat duration = kMinDuration + r*(kMaxDuration - kMinDuration);
    
    
    NSLog(@"rect: %@ duration: %f", [NSValue valueWithCGRect:rect], duration);
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _imageView.frame = rect;
                     }
                     completion:^(BOOL finished){
                        if(_animating)
                            [self doKenBurnsAnimation];
                     }];
}

#pragma mark - Cleanup
-(void)unregisterObservers
{
    /*
     This function removes all key-value observers prior to deallocation. It should be the inverse
     of registerObservers.
     */
}

-(void)destroyViews
{
    /*
     This function is responsible for removing and releasing all existing subviews. It should be the inverse
     of setupViews.
     */
    [_imageView removeFromSuperview], [_imageView release], _imageView = nil;
}

-(void)dealloc
{
    [self unregisterObservers];
    [self destroyViews];
    
    /*
     Additional cleanup of resource here
     */
    [_image release], _image = nil;
    [super dealloc];
}

@end

#pragma mark - HUKenBurnsImageView (Private)
@implementation HUKenBurnsImageView (Private)
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
}

-(CGRect)getNewRect
{
    CGFloat minScale = MAX(kMinScale, MAX(CGRectGetWidth(self.bounds)/_baseWidth, CGRectGetHeight(self.bounds)/_baseWidth));
    CGFloat maxScale = kMaxScale;
    
    //pick a scale
    CGFloat r = (CGFloat)arc4random() / ARC4RANDOM_MAX;
    CGFloat scale = minScale + (maxScale - minScale)*r;
    
    //Generate rectangle
    CGFloat x,y,w,h;
    
    w = round(scale * _baseWidth);
    h = round(scale * _baseHeight);
    
    NSInteger minX = (NSInteger)CGRectGetWidth(self.bounds) - w;
    NSInteger minY = (NSInteger)CGRectGetHeight(self.bounds) - h;
    NSInteger maxX = 0;
    NSInteger maxY = 0;
    NSInteger dx = maxX - minX;
    NSInteger dy = maxY - minY;
    NSInteger zx = arc4random() % dx;
    NSInteger zy = arc4random() % dy;
    
    x = minX + zx;
    y = minY + zy;
    
    NSLog(@"zx: %d", zx);
    NSLog(@"dx: %d", dx);
    
    NSAssert(x >= minX, @"x (%f) must be higher than %d", x, minX);
    
    
    //int corner = arc4random() % 4;
    //NSLog(@"image: %@  w: %f h %f", [NSValue valueWithCGSize:_image.size], w, h);
    //x = (corner % 2 == 0.0f) ? 0.0f : CGRectGetWidth(self.bounds) - _baseWidth*scale;
    //y = (corner < 2) ? 0.0f : CGRectGetHeight(self.bounds) - _baseHeight*scale;
    
    
    return CGRectIntegral(CGRectMake(x, y, w, h));
}

@end