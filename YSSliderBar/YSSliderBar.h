//
//  YSSliderBar.h
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

#import <UIKit/UIKit.h>

typedef enum {
    IndicatorPlacementDefault,
    IndicatorPlacementTop,
    IndicatorPlacementBottom,
    IndicatorPlacementLeft,
    IndicatorPlacementRight,
    IndicatorPlacementBehind
} IndicatorPlacement;

typedef enum {
    IndicatorStyleDefault,
    IndicatorStyleBar,
    IndicatorStyleSpot
} IndicatorStyle;

typedef enum {
    IndicatorAlignmentDefault,
    IndicatorAlignmentFollow,
    IndicatorAlignmentCentered
} IndicatorAlignment;

typedef  enum {
    ItemSizingDefault,
    ItemSizingToFit,
    ItemSizingFixed
} ItemSizing;

@protocol YSSliderBarDelegate <NSObject>

@optional
- (void) sliderBarDidChangeSelectedItem:(int) index;
- (void) sliderBarWillChangeSelectedItem:(int) index;

@end

@interface YSSliderBar : UIControl {
    IndicatorPlacement indicatorPlacement;
    IndicatorStyle indicatorStyle;
    IndicatorAlignment indicatorAlignment;
    ItemSizing itemSizing;
//    int selectedIndex;
    int itemCount;
    CGPoint startPoint;
    UIColor *tColor;
    UIColor *htColor;
}
@property (nonatomic, assign) id <YSSliderBarDelegate> delegate;
@property (nonatomic, readonly) UIColor *indicatorColor;
@property (nonatomic) int selectedIndex;
- (void) setItems:(NSArray *) items;
- (void) setTextColor:(UIColor *) color;
- (void) setHighlightedTextColor:(UIColor *) color;
- (void) setIndicatorColor:(UIColor *) color;
- (void) setIndicatorPlacement:(IndicatorPlacement) placement;
- (void) setIndicatorStyle:(IndicatorStyle) style;
- (void) setIndicatorAlignment:(IndicatorAlignment) alignment;
- (void) setItemSizing:(ItemSizing) sizing;
- (void) enablePanForView:(UIView *) view;
@end
