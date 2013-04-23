//
//  HUKenBurnsImageView.h
//  KenBurns
//
//  Created by Preston Lewis on 4/22/13.
//  Copyright (c) 2013 Preston Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - HUKenBurnsImageView
@interface HUKenBurnsImageView : UIView
{
    //Views
    UIImageView* _imageView;
    UITextView* _textView;
    
    //Data
    UIImage* _image;
    CGFloat _aspect;
    CGFloat _baseWidth;
    CGFloat _baseHeight;
    
    //State
    BOOL _animating;
}

#pragma mark - Properties

#pragma mark - Public Methods
-(void)setImage:(UIImage*)image animated:(BOOL)animated;
-(void)beginAnimating;
-(void)stopAnimating;

@end
