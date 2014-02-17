//
//  YSSliderBar.m
//
//  Created by Alexander Yianni on 14/02/2014.
//  Copyright (c) 2014 Yianni Software Pty Ltd. All rights reserved.
//
//  * Redistribution and use in source and binary forms, with or without
//   modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright
//   notice, this list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright
//   notice, this list of conditions and the following disclaimer in the
//   documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
//

#import "YSSliderBar.h"
#import <QuartzCore/QuartzCore.h>
#define GAP 0
#define TAG 10
#define SPOTSIZE 6
@interface YSSliderBar() {
}
@property (nonatomic, retain) UIView *indicator;
@property (nonatomic, retain) UIColor *color;
@end

@implementation YSSliderBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:YES];
        indicatorStyle = IndicatorStyleDefault;
        indicatorPlacement = IndicatorPlacementDefault;

        self.color = [UIColor blackColor]; // default colour
        tColor = [UIColor blackColor];
        htColor = [UIColor redColor];
        // Initialization code
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [v setBackgroundColor:self.color];
        self.indicator = v;

        [self setIndicatorPlacement:indicatorPlacement];
        [self setIndicatorStyle:indicatorStyle];
        [self setIndicatorAlignment:IndicatorAlignmentDefault];
        [self addSubview:self.indicator];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    //
}

#pragma mark - private
- (CGFloat) indicatorHeight {
    return SPOTSIZE;
}

- (void) moveToItem {
    CGRect frame = [self bounds];
    
    UIView *item = [self viewWithTag:TAG+selectedIndex];
    
    if (indicatorAlignment == IndicatorAlignmentFollow) {
        if (item.frame.origin.x + item.frame.size.width > frame.size.width) {
            //NSLog(@"OFF TO RIGHT");
            // Off screen so move it on
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat left = frame.size.width;
                
            for (int i = selectedIndex; i >= 0; i--) {
                UIView *s = [self viewWithTag:TAG+i];
                left -= s.frame.size.width + (i!=selectedIndex ? GAP : 0);
                [s setFrame:CGRectMake(left, s.frame.origin.y, s.frame.size.width, s.frame.size.height)];
            }
            }];

        }
        else if (item.frame.origin.x <  0) {
            // NSLog(@"OFF TO LEFT");
            // off screen to left
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat left = 0;
                
                for (int i = selectedIndex; i <= [self items] - 1; i++) {
                    UIView *s = [self viewWithTag:TAG+i];
                    [s setFrame:CGRectMake(left, s.frame.origin.y, s.frame.size.width, s.frame.size.height)];
                    left += s.frame.size.width + GAP;
                }
            }];
        }
    }
    else {
//        item.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat left = frame.size.width/2 - item.frame.size.width/2;
            
            for (int i = selectedIndex; i <= [self items] - 1; i++) {
                UIView *s = [self viewWithTag:TAG+i];
                [s setFrame:CGRectMake(left, s.frame.origin.y, s.frame.size.width, s.frame.size.height)];
                left += s.frame.size.width + (i!=selectedIndex ? GAP : 0);
            }
            left = frame.size.width/2 - item.frame.size.width/2;
            for (int i = selectedIndex-1; i >=0; i--) {
                UIView *s = [self viewWithTag:TAG+i];
                left -= s.frame.size.width + (i!=selectedIndex ? GAP : 0);
                [s setFrame:CGRectMake(left, s.frame.origin.y, s.frame.size.width, s.frame.size.height)];
            }
        }];

    }
    
    [self updateIndicator];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderBarDidChangeSelectedItem:)]) {
          [self.delegate sliderBarDidChangeSelectedItem:selectedIndex];
    }
}

- (void) updateIndicator {
    CGRect frame = [self bounds];

    UILabel *view = (UILabel *)[self viewWithTag:TAG+selectedIndex];
    CGSize size = CGSizeZero;
    CGPoint point = CGPointZero;
    switch (indicatorPlacement) {
        case IndicatorPlacementLeft:
        case IndicatorPlacementRight:
            size = CGSizeMake([self indicatorHeight], frame.size.height);
            point = CGPointMake(indicatorPlacement == IndicatorPlacementLeft ? view.frame.origin.x + [self indicatorHeight] / 2 : view.frame.size.width+view.frame.origin.x - [self indicatorHeight]/2,
                                 view.frame.size.height / 2);
            NSLog(@"width is %f, %@", view.frame.size.width, NSStringFromCGPoint(point));
            break;
        case IndicatorPlacementBottom:
        case IndicatorPlacementTop:
            size = CGSizeMake(view.frame.size.width, [self indicatorHeight]);
            point = CGPointMake((view.frame.size.width/2)+view.frame.origin.x,
                                indicatorPlacement == IndicatorPlacementTop ? [self indicatorHeight] / 2
                                : frame.size.height - ([self indicatorHeight] / 2));
            break;
        case IndicatorPlacementBehind:
            point = view.center;
            size = CGSizeMake(view.frame.size.width, view.frame.size.height);
            break;
        default:
            break;
    }

    // override the sizing for spot
    switch (indicatorStyle) {
        case IndicatorStyleSpot:
            size = CGSizeMake(SPOTSIZE, SPOTSIZE);
            break;
            
        default:
            break;
    }


    [UIView animateWithDuration:0.1 animations:^{
        CGRect indframe = self.indicator.frame;
        indframe.size = size;
        indframe.origin.x = point.x - size.width/2;
        indframe.origin.y = point.y - size.height/2;
        self.indicator.frame = indframe;
//        [self.indicator setCenter:point];
        //NSLog(@"frame is %@ for selectedIndex=%d", NSStringFromCGRect(self.indicator.frame), selectedIndex);
    }];
//    [view setTextColor:htColor];
}

#pragma mark - Gestures
- (void) tap:(UITapGestureRecognizer *) tapRecognizer {
    //NSLog(@"tap");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderBarWillChangeSelectedItem:)]) {
        [self.delegate sliderBarWillChangeSelectedItem:selectedIndex];
    }
    
    UIView *v = [tapRecognizer view];
    int tag = (int)v.tag - TAG;
    selectedIndex = tag;
    [self moveToItem];
}

- (void) pan:(UIPanGestureRecognizer *) gestureRecognizer {
    UIView *view = [gestureRecognizer view];

    CGPoint translation = [gestureRecognizer translationInView:[view superview]];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        startPoint = translation;
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sliderBarWillChangeSelectedItem:)]) {
            [self.delegate sliderBarWillChangeSelectedItem:selectedIndex];
        }

        // check if we've panned left or right..
        [self incrementSelectedIndex:startPoint.x > translation.x];
        
        [self moveToItem];
    }
}

- (int) items {
    return itemCount;
}

#pragma mark - helper
- (void) incrementSelectedIndex:(BOOL) increase {
    if (increase) {
        if (selectedIndex < [self items] - 1)
            selectedIndex++;
    }
    else {
        if (selectedIndex > 0)
            selectedIndex--;
    }
}

#pragma mark - public 
- (void) setIndicatorPlacement:(IndicatorPlacement) placement {
    indicatorPlacement = placement == IndicatorPlacementDefault ? IndicatorPlacementTop : placement;

    if (indicatorPlacement == IndicatorPlacementTop || indicatorPlacement == IndicatorPlacementBottom) {
        CGFloat top = indicatorPlacement == IndicatorPlacementTop ? [self indicatorHeight] : 0;

        // Just change the top depending on placement.
        for (int i = 0; i < [self items]; i++) {
            UIView *v = [self viewWithTag:TAG+i];
            [v setFrame:CGRectMake(v.frame.origin.x,top, v.frame.size.width, v.frame.size.height)];
        }
    }
    else {
        CGRect frame = [self bounds];
        // Just change the top depending on placement.
        for (int i = 0; i < [self items]; i++) {
            UIView *v = [self viewWithTag:TAG+i];
            [v setFrame:CGRectMake(v.frame.origin.x,0, v.frame.size.width, frame.size.height)];
        }
        
    }
    
    [self updateIndicator];

}

- (void) setIndicatorStyle:(IndicatorStyle) style {
    indicatorStyle = style == IndicatorStyleDefault ? IndicatorStyleBar : style;
 
    switch (indicatorStyle) {
        case IndicatorStyleSpot:
            self.indicator.layer.cornerRadius = SPOTSIZE/2;
            break;
            
        default:
            self.indicator.layer.cornerRadius = 0;
            break;
    }

    [self updateIndicator];
}

- (void) setIndicatorAlignment:(IndicatorAlignment) alignment {
    indicatorAlignment = alignment == IndicatorAlignmentDefault ? IndicatorAlignmentFollow : alignment;
    [self moveToItem];
}

- (void) setTextColor:(UIColor *)color {
    tColor = color;
    for (int i = 0; i < [self items]; i++) {
        UILabel *v = (UILabel *) [self viewWithTag:TAG+i];
        [v setTextColor:tColor];
    }
}

- (void) setHighlightedTextColor:(UIColor *) color {
    htColor = color;
    [self updateIndicator];
//    UILabel *v = (UILabel *) [self viewWithTag:TAG+selectedIndex];
//    if (v) {
//        v setTextColor:<#(UIColor *)#>
//    }
}
- (void) setIndicatorColor:(UIColor *)color {
    self.color = color;
    [self.indicator setBackgroundColor:self.color];
}

- (void) setItems:(NSArray *) items {
    
    CGFloat left = 0;
    CGFloat top = indicatorPlacement == IndicatorPlacementTop ? [self indicatorHeight] : 0;
    int i = 0;
    CGRect frame = [self bounds];
    itemCount = (int)[items count];
    for (NSString *item in items) {
        UILabel *l = [[UILabel alloc] init];
        [l setTag:TAG+i];
        [l setText:item];
        [l setBackgroundColor:[UIColor clearColor]];
        [l sizeToFit];
        [l setTextColor:tColor];
        [l setTextAlignment:NSTextAlignmentCenter];
        [l setUserInteractionEnabled:YES]; // needed for tap gesture
#ifdef TRACE
        [l setBackgroundColor:[UIColor purpleColor]];
#endif
        
        [l setFrame:CGRectMake(left, top, l.frame.size.width+([self indicatorHeight]*2), frame.size.height - [self indicatorHeight])];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [l addGestureRecognizer:tap];
        [self addSubview:l];
        left += l.frame.size.width + GAP;
        i++;
    }
    
    UIPanGestureRecognizer *pg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pg];
    
    [self updateIndicator];
}

- (void) enablePanForView:(UIView *) view {
    UIPanGestureRecognizer *pg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [view addGestureRecognizer:pg];
}

@end