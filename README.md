# YSSliderBar

[![CI Status](http://img.shields.io/travis/Alexander Yianni/YSSliderBar.svg?style=flat)](https://travis-ci.org/Alexander Yianni/YSSliderBar)
[![Version](https://img.shields.io/cocoapods/v/YSSliderBar.svg?style=flat)](http://cocoapods.org/pods/YSSliderBar)
[![License](https://img.shields.io/cocoapods/l/YSSliderBar.svg?style=flat)](http://cocoapods.org/pods/YSSliderBar)
[![Platform](https://img.shields.io/cocoapods/p/YSSliderBar.svg?style=flat)](http://cocoapods.org/pods/YSSliderBar)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

##Purpose

YSSliderBar is an iOS component to be used as an alternative to a segmented control or tab.

##ARC Compatibility

If you're using this on an older project, just include the -fobjc-arc compiler flag for the YSSliderBar.m class

##Usage
The component is designed to be used with various styles.
The indicator bar can be configured to be shown at the top, bottom, left/right (if appropriate) and behind to behave like a 
highlighter.

set the placement of the Indicator with the setIndicatorPlacement method, taking one of
* IndicatorPlacementTop,
* IndicatorPlacementBottom,
* IndicatorPlacementLeft,
* IndicatorPlacementRight,
* IndicatorPlacementBehind

Set your items by passing in an array of text items.
[ab setItems:@[@"test1", @"test2", @"test3", @"testing one two", @"alex was here", @"'sup", @"dudes"]];

Set the colour of your indicator with:
setIndicatorColor

##Delegate
By adhering to the YSSliderBarDelegate, you'll get two optional callbacks which the names are hopefully self-explantory:
* sliderBarDidChangeSelectedItem
* sliderBarWillChangeSelectedItem


## Installation

YSSliderBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YSSliderBar"
```

## Author

Alexander Yianni, alex.yianni@yianni-software.com

## License

YSSliderBar is available under the MIT license. See the LICENSE file for more info.
