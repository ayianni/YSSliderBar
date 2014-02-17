//
//  ViewController.m
//  YSSliderBarDemo
//
//  Created by Alexander Yianni on 14/02/2014.
//  Copyright (c) 2014 Yianni Software Pty Ltd. All rights reserved.
//

#import "ViewController.h"
#import "YSSliderBar.h"

#define TAG_SEGMENTPLACEMENT 1
#define TAG_SEGMENTSTYLE 2
#define TAG_SEGMENTALIGNMENT 3
#define MARGIN 10
@interface ViewController () <YSSliderBarDelegate>
@property (nonatomic, retain) YSSliderBar *sliderBar;
@property (nonatomic, retain) UILabel *feedback;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect frame = [self.view bounds];
    
    YSSliderBar *ab = [[YSSliderBar alloc] initWithFrame:CGRectMake(10, 20, 250, 40)];
    self.sliderBar = ab;
    [ab enablePanForView:self.view];
    [ab setBackgroundColor:[UIColor orangeColor]];
#ifdef TRACE
#endif
    [ab setItems:@[@"test1", @"test2", @"test3", @"testing one two", @"alex was here", @"'sup", @"dudes"]];
    [ab setTextColor:[UIColor darkGrayColor]];
    [ab setIndicatorColor:[UIColor grayColor]];
    [ab setDelegate:self];
    [self.view addSubview:ab];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 250, frame.size.width-(MARGIN*2), 100)];
    [l setTextAlignment:NSTextAlignmentCenter];
    [l setFont:[UIFont systemFontOfSize:32.0f]];
    self.feedback = l;
    [self.view addSubview:self.feedback];
    
    [self addSegmentControlWithElements:@[@"Default", @"^", @"v", @"<", @">", @"Behind"] atTop:100 withTag:TAG_SEGMENTPLACEMENT];
    [self addSegmentControlWithElements:@[@"Default", @"Bar", @"Spot"] atTop:150 withTag:TAG_SEGMENTSTYLE];
    [self addSegmentControlWithElements:@[@"Default", @"Follow", @"Centered"] atTop:200 withTag:TAG_SEGMENTALIGNMENT];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addSegmentControlWithElements:(NSArray *) array atTop:(int) top withTag:(int) tag {
    CGRect frame = [self.view bounds];

    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:array];
    [sc addTarget:self action:@selector(changedSegment:) forControlEvents:UIControlEventValueChanged];
    [sc setFrame:CGRectMake(MARGIN, top, frame.size.width-(MARGIN*2), sc.frame.size.height)];
    [sc setSelectedSegmentIndex:0];
    [sc setTag:tag];
    [self.view addSubview:sc];
}

#pragma mark - Seg
- (void) changedSegment:(id) sender {
    NSLog(@"sender is %@", sender);
    UISegmentedControl *sc = (UISegmentedControl *) sender;
    if (sc.tag == TAG_SEGMENTPLACEMENT)
        [self.sliderBar setIndicatorPlacement:(int)sc.selectedSegmentIndex];
    if (sc.tag == TAG_SEGMENTSTYLE)
        [self.sliderBar setIndicatorStyle:(int)sc.selectedSegmentIndex];
    if (sc.tag == TAG_SEGMENTALIGNMENT)
        [self.sliderBar setIndicatorAlignment:(int) sc.selectedSegmentIndex];
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
