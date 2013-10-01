//
//  AppDelegate.m
//  ITPullToRefreshScrollView
//
//  Created by Ilija Tovilo on 9/25/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "AppDelegate.h"
#import "ITPullToRefreshScrollView.h"


@interface AppDelegate () {
    NSMutableArray *data;
}
@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    data = [@[  ] mutableCopy];
    self.scrollView.refreshableEdges = ITPullToRefreshEdgeTop | ITPullToRefreshEdgeBottom;
    [self.tableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return data.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"default" owner:self];
    cellView.textField.stringValue = data[row];
    
    return cellView;
}

- (void)pullToRefreshView:(ITPullToRefreshScrollView *)scrollView didStartRefreshingEdge:(ITPullToRefreshEdge)edge {
    double delayInSeconds = ((arc4random() % 10) / 10.0) * 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void){
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (edge & ITPullToRefreshEdgeTop) {
                [data insertObject:@"Test 1" atIndex:0];
                [data insertObject:@"Test 2" atIndex:0];
            } else if (edge & ITPullToRefreshEdgeBottom) {
                for (int i = 0; i < 50; i++) {
                    [data addObject:[NSString stringWithFormat:@"Test %d", i]];
                }
            }
            
            [scrollView stopRefreshingEdge:edge];
        });
    });
}

- (void)pullToRefreshView:(ITPullToRefreshScrollView *)scrollView didStopRefreshingEdge:(ITPullToRefreshEdge)edge {
    NSRange range;
    
    if (edge & ITPullToRefreshEdgeTop) {
        range = NSMakeRange(0, 2);
    }
    else if (edge & ITPullToRefreshEdgeBottom) range = NSMakeRange(data.count - 50, 50);
        
    [self.tableView beginUpdates];
    {
        [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]
                              withAnimation:NSTableViewAnimationSlideDown];
    }
    [self.tableView endUpdates];
}

@end
