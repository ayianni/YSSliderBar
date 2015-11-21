//
//  YSViewController.m
//  YSSliderBar
//
//  Created by Alexander Yianni on 11/21/2015.
//  Copyright (c) 2015 Alexander Yianni. All rights reserved.
//

#import "YSViewController.h"
#import "YSSliderBar.h"
#define TAG_SEGMENTPLACEMENT 1
#define TAG_SEGMENTSTYLE 2
#define TAG_SEGMENTALIGNMENT 3
#define MARGIN 10

@interface YSViewController ()
@property (nonatomic, retain) YSSliderBar *sliderBar;
@property (nonatomic, retain) YSSliderBar *sliderBarSmall;
@property (nonatomic, retain) UILabel *feedback;

@end

@implementation YSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = [self.view bounds];
    
    CGFloat margin = 10.f;
    
    YSSliderBar *ab = [[YSSliderBar alloc] initWithFrame:CGRectMake(margin, 20, 250, 40)];
    self.sliderBar = ab;
    [ab enablePanForView:self.view];
    [ab setBackgroundColor:[UIColor orangeColor]];
    
    CGFloat top = ab.frame.size.height+ab.frame.origin.y;
    YSSliderBar *abs = [[YSSliderBar alloc] initWithFrame:CGRectMake(margin, top+10, frame.size.width-(margin*2), 40)];
    self.sliderBarSmall = abs;
    //    [abs enablePanForView:self.view];
    [abs setBackgroundColor:[UIColor brownColor]];
    
#ifdef TRACE
#endif
    [ab setItems:@[@"test1", @"test2", @"test3", @"testing one two", @"alex was here", @"'sup", @"dudes"]];
    [ab setTextColor:[UIColor darkGrayColor]];
    [ab setIndicatorColor:[UIColor grayColor]];
    [ab setDelegate:self];
    [self.view addSubview:ab];
    
    [abs setDelegate:self];
    [abs setIndicatorColor:[UIColor orangeColor]];
    //    [abs setIndicatorAlignment:IndicatorAlignmentToFit];
    [abs setIndicatorAlignment:IndicatorAlignmentFollow];
    [abs setTextColor:[UIColor whiteColor]];
    [abs setItemSizing:ItemSizingFixed];
    [abs setItems:@[@"item 1", @"item 2"]];
    [self.view addSubview:abs];
    
    [abs setSelectedIndex:1];
    
    [abs addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 250.f, frame.size.width-(MARGIN*2), 100)];
    [l setTextAlignment:NSTextAlignmentCenter];
    [l setFont:[UIFont systemFontOfSize:32.0f]];
    self.feedback = l;
    [self.view addSubview:self.feedback];
    
    top = abs.frame.size.height+abs.frame.origin.y + 10;
    
    [self addSegmentControlWithElements:@[@"Default", @"^", @"v", @"<", @">", @"Behind"] atTop:top withTag:TAG_SEGMENTPLACEMENT];
    [self addSegmentControlWithElements:@[@"Default", @"Bar", @"Spot"] atTop:top+50 withTag:TAG_SEGMENTSTYLE];
    [self addSegmentControlWithElements:@[@"Default", @"Follow", @"Centered"] atTop:top+100 withTag:TAG_SEGMENTALIGNMENT];
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

#pragma mark -
- (void) sliderChanged:(id) sender {
    NSLog(@"selected Index %d", self.sliderBarSmall.selectedIndex);
}

@end
