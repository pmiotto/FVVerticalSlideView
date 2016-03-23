//
//  HalfViewSlideViewController.m
//  FVVerticalSlideViewExample
//
//  Created by Fernando on 23/3/16.
//  Copyright © 2016 tato469. All rights reserved.
//

#import "HalfViewSlideViewController.h"
#import "FVVerticalSlideView.h"
#import "FVAwesomeLabel.h"

@interface HalfViewSlideViewController () <FVVerticalSliderViewDelegate>

@end

@implementation HalfViewSlideViewController
{
    FVAwesomeLabel *header;
    FVVerticalSlideView *slider;
    NSString *headerTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat top = self.view.frame.size.height/2-10;
    CGFloat bottom = 50;
    
    slider = [[FVVerticalSlideView alloc] initWithTop:top
                                               bottom:bottom
                                      translationView:self.view];
    
    [slider setBackgroundColor:[UIColor colorWithRed:66.0/255.0 green:165.0/255.0 blue:245.0/255.0 alpha:1]];
    [slider setTopY:top];
    
    slider.delegate = self;
    
    [self.view addSubview:slider];
    
    headerTitle = @"Slider";
    
    header = [[FVAwesomeLabel alloc] initWithFrame:CGRectMake(0, 5, slider.frame.size.width, 40)];
    [header setTextAlignment:NSTextAlignmentCenter];
    [header setTextColor:[UIColor whiteColor]];
    [header setAwesomeIcon:FAArrowUp andText:[NSString stringWithFormat:@" %@",headerTitle] withFotSize:14.0f];
    [slider addSubview:header];
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap)];
    tapGesture.numberOfTapsRequired = 1;
    header.userInteractionEnabled = YES;
    [header addGestureRecognizer:tapGesture];
    
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) headerTap
{
    if([slider slideViewStatus] == FVStatusTop)
    {
        [slider slideToBottom];
    }
    else{
        [slider slideToTop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FVVerticalSliderViewDelegate

-(void) startMovingSliderView
{
    NSLog(@"Start moving SliderView");
}

-(void) movingSliderView:(float)calculatedPosition
{
    NSLog(@"calculatedPosition %f",calculatedPosition);
    
}

-(void) stopMovingSliderView:(float)calculatedPosition
{
    NSLog(@"stopMovingSliderView %f",calculatedPosition);
    
}


-(void) closeTopPositionSliderView:(float)calculatedPosition
{
    //NSLog(@"calculatedPosition %f",calculatedPosition);
    [header setAwesomeIcon:FAArrowDown andText:[NSString stringWithFormat:@" %@",headerTitle] withFotSize:14.0f];
}


-(void) closeBottomPositionSliderView:(float)calculatedPosition
{
    //NSLog(@"closeBottomPositionSliderView %f",calculatedPosition);
    [header setAwesomeIcon:FAArrowUp andText:[NSString stringWithFormat:@" %@",headerTitle] withFotSize:14.0f];
}


@end
