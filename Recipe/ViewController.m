//
//  ViewController.m
//  Recipe
//
//  Created by Mobile on 2/26/15.
//  Copyright (c) 2015 Mobile. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.logoBackgroundView.layer.cornerRadius = 5.0f;
    
    self.logoView.layer.shadowOffset = CGSizeMake(0, 1);
    self.logoView.layer.shadowOpacity = 1.0f;
    self.logoView.layer.shadowRadius = 1.0f;
    
    self.startButton.layer.cornerRadius = 10.0f;
    
    self.infoBackgroundView.layer.cornerRadius = 5.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [UIView transitionFromView:self.view toView:appDelegate.flipsideViewController.view duration:2 * 0.3 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
}

@end
