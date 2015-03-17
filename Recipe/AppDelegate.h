//
//  AppDelegate.h
//  Recipe
//
//  Created by Mobile on 2/26/15.
//  Copyright (c) 2015 Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlipsideViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) FlipsideViewController *flipsideViewController;


@end

