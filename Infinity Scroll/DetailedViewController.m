//
//  DetailedViewController.m
//  Infinity Scroll
//
//  Created by Matthew Stallone on 11/25/15.
//  Copyright © 2015 Matthew Stallone. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eeee, MMMM d, yyyy"];
    
    [_helloLabel setText:[NSString stringWithFormat:@"Hello from a DetailedViewController\n\n%@", [dateFormatter stringFromDate:_date]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_delegate setDate:_date];
}

@end
