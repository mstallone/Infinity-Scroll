//
//  ViewController.h
//  Infinity Scroll
//
//  Created by Matthew Stallone on 11/25/15.
//  Copyright © 2015 Matthew Stallone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedViewController.h"

@interface ViewController : UIViewController <UINavigationBarDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, DetailedDelegate> {
    UINavigationBar *navigationBar;
    UINavigationItem *navigationItem;
    UIBarButtonItem *todayBarButtonItem;
    
    UIView *contentView;
    UIPageViewController *pageViewController;
    
    NSDate *date;
}

@end