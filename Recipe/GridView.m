//
//  GridView.h
//
//  Created by Nick Keroulis on 1/19/12.
//  Copyright (c) 2012 keroulisnikos@gmail.com. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (id)init
{
    self = [super init];
    
    if (self) {
        
        // Initialization code
    }
    return self;
}

- (void)reloadData:(NSInteger)state
{
    for (UIView *subview in self.subviews) {
        
        [subview removeFromSuperview];
    }
    
    m_state = state;
    
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInGridView:self searchState:m_state];
    NSUInteger numberOfColumns = [self.dataSource numberOfColumnsInGridView:self];
    NSUInteger numberOfRows = (numberOfCells - (numberOfCells % numberOfColumns)) / numberOfColumns;
    
    if (numberOfCells % numberOfColumns != 0)
        numberOfRows = numberOfRows + 1;
    
    CGSize cellSize = [self cellSize];
    
    if (numberOfCells > 0 && numberOfColumns > 0 && self.cellSize.height > 0)
    {
        for(UIView *subview in [self subviews])
        {
            [subview removeFromSuperview];
        }
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        scrollView.contentSize = CGSizeMake(self.frame.size.width, numberOfRows * cellSize.height);
        
        [self addSubview:scrollView];
        
        for (int row = 0; row < numberOfRows; ++row)
        {
            for (int column = 0; column < numberOfColumns; ++column)
            {
                NSUInteger index = row * numberOfColumns + column;
                
                if (index < numberOfCells)
                {
                    UIView *cellView = [self.dataSource gridView:self viewForCellAtIndex:index searchState:m_state];
                    
                    cellView.frame = CGRectMake(column * cellSize.width, row * cellSize.height, cellSize.width, cellSize.height);
                    
                    [scrollView addSubview:cellView];
                    
                    UIButton *cellButton = [[UIButton alloc] initWithFrame:CGRectMake(cellView.frame.origin.x,cellView.frame.origin.y, cellView.frame.size.width, cellView.frame.size.height)];
                    
                    cellButton.tag = index;
                    
                    [cellButton addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [scrollView addSubview:cellButton];
                }
            }
        }
    }
}

- (void)selectCell:(id)sender
{
    [self.delegate gridView:self userDidSelectCellAtIndex:[sender tag] searchState:m_state];
}

- (CGSize)cellSize
{
    return CGSizeMake(self.frame.size.width / [self.dataSource numberOfColumnsInGridView:self], [self.dataSource heightOfCellsInGridView:self]);
}

@end
