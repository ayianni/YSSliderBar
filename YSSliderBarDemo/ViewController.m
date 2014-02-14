//
//  ViewController.m
//  YSSliderBarDemo
//
//  Created by Alexander Yianni on 14/02/2014.
//  Copyright (c) 2014 Yianni Software Pty Ltd. All rights reserved.
//

#import "ViewController.h"
#import "YSSliderBar.h"

@interface ViewController () <YSSliderBarDelegate>
@property (nonatomic, retain) YSSliderBar *SliderBar;
@property (nonatomic, retain) UILabel *feedback;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect frame = [self.view bounds];
    
    CGFloat margin = 10;
    
    YSSliderBar *ab = [[YSSliderBar alloc] initWithFrame:CGRectMake(10, 20, 250, 50)];
    self.sliderBar = ab;
#ifdef TRACE
    [ab setBackgroundColor:[UIColor orangeColor]];
#endif
    [ab setIndicatorPlacement:IndicatorPlacementBottom]; // test after setting items
    [ab setItems:@[@"test1", @"test2", @"test3", @"testing one two", @"alex was here", @"'sup", @"dudes"]];
    [ab setIndicatorColor:[UIColor grayColor]];
    [ab setDelegate:self];
    [self.view addSubview:ab];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(margin, 100, frame.size.width-(margin*2), 100)];
    [l setTextAlignment:NSTextAlignmentCenter];
    [l setFont:[UIFont systemFontOfSize:32.0f]];
    self.feedback = l;
    [self.view addSubview:self.feedback];
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"Top", @"Bottom", @"Left", @"Right", @"Behind"]];
    [sc addTarget:self action:@selector(changedSegment:) forControlEvents:UIControlEventValueChanged];
    [sc setFrame:CGRectMake(margin, margin+self.SliderBar.frame.size.height+self.SliderBar.frame.origin.y, sc.frame.size.width, sc.frame.size.height)];
    [sc setSelectedSegmentIndex:1];
    [self.view addSubview:sc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Seg
- (void) changedSegment:(id) sender {
    NSLog(@"sender is %@", sender);
    UISegmentedControl *sc = (UISegmentedControl *) sender;
    switch (sc.selectedSegmentIndex) {
        case 0:
            [self.SliderBar setIndicatorPlacement:IndicatorPlacementTop];
            break;
        case 1:
            [self.SliderBar setIndicatorPlacement:IndicatorPlacementBottom];
            break;
        case 2:
            [self.SliderBar setIndicatorPlacement:IndicatorPlacementLeft];
            break;
        case 3:
            [self.SliderBar setIndicatorPlacement:IndicatorPlacementRight];
            break;
        case 4:
            [self.SliderBar setIndicatorPlacement:IndicatorPlacementBehind];
            break;
        default:
            break;
    }
    
}

#pragma mark - SliderBarDelegate
- (void) sliderBarDidChangeSelectedItem:(int)index {
    NSLog(@"SliderBarDidChangeSelectedItem: SliderBarIndex is %d", index);
    [self.feedback setText:[NSString stringWithFormat:@"%d", index]];
}

- (void) sliderBarWillChangeSelectedItem:(int)index {
    NSLog(@"SliderBarWillChangeSelectedItem: SliderBarIndex is %d", index);
}
@end
