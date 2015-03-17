//
//  FlipsideViewController.m
//  Recipe
//
//  Created by Mobile on 2/26/15.
//  Copyright (c) 2015 Mobile. All rights reserved.
//

#define MARGIN 10.0f

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [[UIScreen mainScreen] bounds];

    // Do any additional setup after loading the view from its nib.
    
    self.recipes = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Recipes" ofType:@"plist"]];
    

    [self.gridView reloadData:0];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPopupView
{
    self.popupView.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:self.popupView];
    
    self.popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.popupView.alpha = 1.0f;
    }];
}

- (IBAction)hidePopupView:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.popupView.alpha = 0.0f;
    } completion:^(BOOL finished){
        
        [self.popupView removeFromSuperview];
    }];
}

#pragma mark - GridViewDataSource

- (NSInteger)numberOfCellsInGridView:(GridView *)gridView searchState:(NSInteger)state
{
    NSInteger cellCount = self.recipes.count;
    
    for (int i = 0 ; i < self.recipes.count ; i++) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        [array addObjectsFromArray:[[self.recipes objectAtIndex:i] objectForKey:@"Receipe"]];
        cellCount += [array count];
    }
    if (state == 1) {
        return self.recipes.count;
    }else
        return cellCount;
}

- (NSInteger)numberOfColumnsInGridView:(GridView *)gridView
{
    return 1;
}

- (float)heightOfCellsInGridView:(GridView *)gridView
{
    return 64;
}

- (UIView *)gridView:(GridView *)gridView viewForCellAtIndex:(NSInteger)index searchState:(NSInteger)state
{
    UIView *cellView = [[UIView alloc] init];
    cellView.frame = CGRectMake(0, 0, self.gridView.cellSize.width, self.gridView.cellSize.height);
    if (state == 1) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(MARGIN, MARGIN, 44, 44);
        imageView.image = [UIImage imageNamed:[[self.recipes objectAtIndex:index] objectForKey:@"Dish Image"]];
        [cellView addSubview:imageView];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(2 * MARGIN + 44, MARGIN, cellView.frame.size.width - (2 * MARGIN + 44), 21);
        nameLabel.text = [[self.recipes objectAtIndex:index] objectForKey:@"Dish name"];
        
        [cellView addSubview:nameLabel];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.frame = CGRectMake(2 * MARGIN + 44, MARGIN + 21, cellView.frame.size.width - (2 * MARGIN + 44), 21);
        timeLabel.text = [[self.recipes objectAtIndex:index] objectForKey:@"Time"];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        [cellView addSubview:timeLabel];
        
    }else{
        NSInteger dictIndex = 0;
        NSInteger totalItemCount = 0;
        
        while (1) {
            totalItemCount += [[[self.recipes objectAtIndex:dictIndex] objectForKey:@"Receipe"] count] + 1;
            NSInteger difference = (index + 1) - totalItemCount;
            if (difference > 0) {
                dictIndex++;
            }else{
                break;
            }
        }
        
        NSInteger itemIndex = 0;
        
        if (dictIndex <= 0) {
            itemIndex = index;
        }else{
            totalItemCount = 0;
            for (int i = 0 ; i < dictIndex ; i++) {
                totalItemCount += [[[self.recipes objectAtIndex:i] objectForKey:@"Receipe"] count] + 1;
            }
            itemIndex = index - totalItemCount;
        }
        
        if (itemIndex == 0) {
            UILabel *catagoryLabel = [[UILabel alloc] init];
            catagoryLabel.frame = CGRectMake(MARGIN, MARGIN, cellView.frame.size.width - (2 * MARGIN), 44);
            catagoryLabel.text = [[self.recipes objectAtIndex:dictIndex] objectForKey:@"Catagory"];
            catagoryLabel.backgroundColor = [UIColor darkGrayColor];
            catagoryLabel.textAlignment = NSTextAlignmentCenter;
            [cellView addSubview:catagoryLabel];
        }else{
            NSArray *itemArray = [[NSArray alloc] init];
            itemArray = [[self.recipes objectAtIndex:dictIndex] objectForKey:@"Receipe"];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(MARGIN, MARGIN, 44, 44);
            imageView.image = [UIImage imageNamed:[[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"Dish Image"]];
            
            [cellView addSubview:imageView];
            
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.frame = CGRectMake(2 * MARGIN + 44, MARGIN, cellView.frame.size.width - (2 * MARGIN + 44), 21);
            nameLabel.text = [[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"Dish name"];
            
            [cellView addSubview:nameLabel];
            
            UILabel *timeLabel = [[UILabel alloc] init];
            timeLabel.frame = CGRectMake(2 * MARGIN + 44, MARGIN + 21, cellView.frame.size.width - (2 * MARGIN + 44), 21);
            timeLabel.text = [[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"Time"];
            timeLabel.textColor = [UIColor lightGrayColor];
            timeLabel.font = [UIFont boldSystemFontOfSize:13.0f];
            [cellView addSubview:timeLabel];
            
        }
    }
    
    return cellView;
}

#pragma mark - GridViewDelegate

- (void)gridView:(GridView *)gridView userDidSelectCellAtIndex:(NSInteger)index searchState:(NSInteger)state
{
    
    if (state == 1) {
        self.imageView.image = [UIImage imageNamed:[[self.recipes objectAtIndex:index] objectForKey:@"Dish Image"]];
        self.nameLabel.text = [[self.recipes objectAtIndex:index] objectForKey:@"Dish name"];
        self.timeLabel.text = [[self.recipes objectAtIndex:index] objectForKey:@"Time"];
        self.ingredientsTextView.text = [[self.recipes objectAtIndex:index] objectForKey:@"ingredients"];
        self.stepsTextView.text = [[self.recipes objectAtIndex:index] objectForKey:@"Steps"];
    }else{
        NSInteger dictIndex = 0;
        NSInteger totalItemCount = 0;
        
        while (1) {
            totalItemCount += [[[self.recipes objectAtIndex:dictIndex] objectForKey:@"Receipe"] count] + 1;
            NSInteger difference = (index + 1) - totalItemCount;
            if (difference > 0) {
                dictIndex++;
            }else{
                break;
            }
        }
        
        NSInteger itemIndex = 0;
        
        if (dictIndex <= 0) {
            itemIndex = index;
        }else{
            totalItemCount = 0;
            for (int i = 0 ; i < dictIndex ; i++) {
                totalItemCount += [[[self.recipes objectAtIndex:i] objectForKey:@"Receipe"] count] + 1;
            }
            itemIndex = index - totalItemCount;
        }
        
        if (itemIndex == 0) {
            return;
        }
        NSArray *itemArray = [[NSArray alloc] init];
        itemArray = [[self.recipes objectAtIndex:dictIndex] objectForKey:@"Receipe"];
        
        
        self.imageView.image = [UIImage imageNamed:[[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"Dish Image"]];
        self.nameLabel.text = [[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"Dish name"];
        self.timeLabel.text = [[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"Time"];
        self.ingredientsTextView.text = [[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"ingredients"];
        self.stepsTextView.text = [[itemArray objectAtIndex:itemIndex - 1] objectForKey:@"Steps"];
    }
    
    
    
    [self showPopupView];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *allRecipes = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Recipes" ofType:@"plist"]];
    
    NSMutableArray *searchRecipes = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < [allRecipes count]; i++) {
        NSArray *itemsArray = [[NSArray alloc] init];
        itemsArray = [[allRecipes objectAtIndex:i] objectForKey:@"Receipe"];
        for (int j = 0 ; j < [itemsArray count] ; j++) {
            [searchRecipes addObject:[itemsArray objectAtIndex:j]];
        }
    }    
    
    for (int i = 0; i < searchRecipes.count; ++i) {
        
        NSDictionary *recipe = [searchRecipes objectAtIndex:i];
        
        NSString *name = [recipe objectForKey:@"Dish name"];
        
        if ([name.lowercaseString rangeOfString:searchBar.text.lowercaseString].location != NSNotFound) {
            
            [results addObject:recipe];
        }
    }
    
    self.recipes = results;
    
    [self.gridView reloadData:1];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
    
    self.recipes = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Recipes" ofType:@"plist"]];
    
    
    [self.gridView reloadData:0];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    
    return YES;
}

@end

