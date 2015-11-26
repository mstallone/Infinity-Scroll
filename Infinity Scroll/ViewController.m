//
//  ViewController.m
//  Infinity Scroll
//
//  Created by Matthew Stallone on 11/25/15.
//  Copyright © 2015 Matthew Stallone. All rights reserved.
//

#import "ViewController.h"

#pragma clang diagnostic ignored "-Wshadow-ivar"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    date = [NSDate date];
    
    contentView = [[UIView alloc] init];
    [contentView setFrame:self.view.frame];
    [self.view addSubview:contentView];
    
    navigationBar = [[UINavigationBar alloc] init];
    [navigationBar setFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    [navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [navigationBar setBarTintColor:[UIColor colorWithRed:0.3 green:0.5 blue:1 alpha:1]];
    [navigationBar setDelegate:self];
    navigationItem = [[UINavigationItem alloc] init];
    navigationItem.title = @"Your Title";
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    [self.view addSubview:navigationBar];
    
    pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [pageViewController setDataSource:self];
    [pageViewController setDelegate:self];
    pageViewController.view.backgroundColor = [UIColor clearColor];
    [pageViewController.view setFrame:CGRectMake(0, navigationBar.frame.size.height, contentView.frame.size.width, contentView.frame.size.height - navigationBar.frame.size.height)];
    [pageViewController setViewControllers:@[[self createDetailedViewControllerWithIndex:1 direction:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:pageViewController];
    [contentView addSubview:pageViewController.view];
    [pageViewController didMoveToParentViewController:self];
    
    todayBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleDone target:self action:@selector(todayPressed:)];
}

- (DetailedViewController *)createDetailedViewControllerWithIndex:(NSUInteger)index direction:(long)direction {
    DetailedViewController *detailedViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detailedViewController"];
    detailedViewController.index = index;
    detailedViewController.delegate = self;
    
    if (direction > 0) detailedViewController.date = [date dateByAddingTimeInterval:60*60*24];
    else if (direction < 0) detailedViewController.date = [date dateByAddingTimeInterval:-60*60*24];
    else detailedViewController.date = [NSDate date];
    
    return detailedViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(DetailedViewController *)viewController index] + 1;
    
    if (index == 2) return [self createDetailedViewControllerWithIndex:0 direction:1];
    return [self createDetailedViewControllerWithIndex:index direction:1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(DetailedViewController *)viewController index] - 1;
    
    if (index == -1) return [self createDetailedViewControllerWithIndex:1 direction:-1];
    return [self createDetailedViewControllerWithIndex:index direction:-1];
}

- (void)setDate:(NSDate *)date {
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eeee, MMMM d, yyyy"];
    
    self->date = date;
    navigationItem.title = [dateFormatter stringFromDate:self->date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger calendarComponents = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);
    NSDateComponents *today = [calendar components:calendarComponents fromDate:[NSDate date]], *currentDate = [calendar components:calendarComponents fromDate: self->date];
    
    if ([[calendar dateFromComponents:today] compare:[calendar dateFromComponents:currentDate]] != NSOrderedSame) [navigationItem setRightBarButtonItem:todayBarButtonItem animated:YES];
    else [navigationItem setRightBarButtonItem:nil animated:YES];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (void)todayPressed:(id)sender {
    if([date compare:[NSDate date]] == NSOrderedAscending) [pageViewController setViewControllers:@[[self createDetailedViewControllerWithIndex:1 direction:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    else [pageViewController setViewControllers:@[[self createDetailedViewControllerWithIndex:1 direction:0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
