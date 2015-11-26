//
//  DetailedViewController.h
//  Infinity Scroll
//
//  Created by Matthew Stallone on 11/25/15.
//  Copyright © 2015 Matthew Stallone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailedDelegate <NSObject>

- (void)setDate:(NSDate *)date;

@end

@interface DetailedViewController : UIViewController

@property (assign, nonatomic) NSUInteger index;
@property (retain, nonatomic) NSDate *date;
@property (assign, nonatomic) id<DetailedDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;

@end
