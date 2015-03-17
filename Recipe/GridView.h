//
//  GridView.h
//
//  Created by Nick Keroulis on 1/19/12.
//  Copyright (c) 2012 keroulisnikos@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridView;

@protocol GridViewDataSource <NSObject>
@required
- (NSInteger)numberOfCellsInGridView:(GridView *)gridView searchState:(NSInteger) state;
- (NSInteger)numberOfColumnsInGridView:(GridView *)gridView;
- (float)heightOfCellsInGridView:(GridView *)gridView;
- (UIView *)gridView:(GridView *)gridView viewForCellAtIndex:(NSInteger)index searchState:(NSInteger) state;
@end

@protocol GridViewDelegate <NSObject>
@optional
- (void)gridView:(GridView *)gridView userDidSelectCellAtIndex:(NSInteger)index searchState:(NSInteger) state;
@end

@interface GridView : UIView {
    NSInteger m_state;
}
@property (nonatomic, retain) IBOutlet id <GridViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet id <GridViewDataSource> dataSource;

- (id)init;
- (void)reloadData:(NSInteger) state;
- (void)selectCell:(id)sender;
- (CGSize)cellSize;
@end
