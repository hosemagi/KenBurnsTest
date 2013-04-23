//
//  KenBurnsViewController.m
//  KenBurns
//
//  Created by Preston Lewis on 4/22/13.
//  Copyright (c) 2013 Preston Lewis. All rights reserved.
//

#import "KenBurnsViewController.h"

@interface KenBurnsViewController ()
-(void)setupViews;
-(void)applyStyle;
-(void)layoutSubviews;
-(void)unregisterObservers;
-(void)destroyViews;
@end

@interface KenBurnsViewController (Private)
//Declare any private methods (helpers, UI event handlers, etc)
@end

@implementation KenBurnsViewController

#pragma mark - Initialization
-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

-(void)setupViews
{
    //Called from viewDidLoad
    _imageView = [[HUKenBurnsImageView alloc] initWithFrame:self.view.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [_imageView setImage:[UIImage imageNamed:@"coffee.jpg"] animated:YES];
    [self.view addSubview:_imageView];
    
    UITextView* textView = [[[UITextView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:textView];
    textView.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:24.0f];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.textColor = [UIColor whiteColor];
    textView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    textView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textView];
    
    textView.text = @"This is a delicious turkish latte from Kean Coffee in Tustin. Kean Coffee is the best coffee joint in Orange County.";
    
}

-(void)applyStyle
{
    //Called from viewDidLoad
    
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set up the controller's views
    [self setupViews];
    
    //Apply style
    [self applyStyle];
    
    [self updateView];
}

#pragma mark - Layout
-(void)layoutSubviews
{
}

-(void)viewWillLayoutSubviews
{
    //UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    //Layout views
    [self layoutSubviews];
    
}

#pragma mark - View Updating
-(void)updateView
{
    //Update content views to reflect current state of data model
}

#pragma mark - Rotation
-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Cleanup
-(void)unregisterObservers
{
    
}

-(void)destroyViews
{
    
}

-(void)dealloc
{
    [self unregisterObservers];
    [self destroyViews];
    
    //Release any other retained objects here
    
    [super dealloc];
}

@end

#pragma mark - KenBurnsViewController (Private)
@implementation KenBurnsViewController (Private)
#pragma mark - Key Value Observing
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //Observe changes to data model here and call updateView
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

//Implement any private methods (helpers, UI event handlers, etc)

@end