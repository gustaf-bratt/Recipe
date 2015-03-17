//
//  FlipsideViewController.h
//  Recipe
//
//  Created by Mobile on 2/26/15.
//  Copyright (c) 2015 Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridView.h"

@interface FlipsideViewController : UIViewController<GridViewDataSource, GridViewDelegate, UISearchBarDelegate, UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet GridView *gridView;
@property (retain, nonatomic) NSArray *recipes;
@property (retain, nonatomic) NSMutableArray *contentItems;
@property (retain, nonatomic) IBOutlet UIView *popupView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UITextView *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (retain, nonatomic) IBOutlet UITextView *stepsTextView;
@property (retain, nonatomic) NSArray *results;

- (void)showPopupView;
- (IBAction)hidePopupView:(id)sender;


@end
