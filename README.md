# YSSliderBar

by Alexander Yianni

  * [Visit yianni-software.com.au][1]
  * [Follow @ay23 or @YianniSoftware on Twitter][2]

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

[1]: http://yianni-software.com.au/ "yianni software"
[2]: http://twitter.com/ay23/ "@ay23 on Twitter"
