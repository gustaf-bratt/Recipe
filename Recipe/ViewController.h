//
//  ViewController.h
//  Recipe
//
//  Created by Mobile on 2/26/15.
//  Copyright (c) 2015 Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *logoBackgroundView;
@property (retain, nonatomic) IBOutlet UIImageView *logoView;
@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIImageView *infoBackgroundView;
- (IBAction)start:(id)sender;


@end

