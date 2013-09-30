//
//  AppDelegate.h
//  ITPullToRefreshScrollView
//
//  Created by Ilija Tovilo on 9/25/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ITPullToRefreshScrollView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,
                                   NSTableViewDataSource,
                                   NSTableViewDelegate,
                                   ITPullToRefreshScrollViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *tableView;
@property (assign) IBOutlet ITPullToRefreshScrollView *scrollView;

@end
