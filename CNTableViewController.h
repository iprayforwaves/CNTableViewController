//
//  Created by Ravel Antunes on 10/31/12.
//  Copyright (c) 2012 Riptide Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNTableHeader.h"

@interface CNTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
	CNTableHeader *refreshHeaderView;

    UIActivityIndicatorView *footerActivityIndicator;    
    UILabel *footerLabel;
    
	BOOL _reloading;
}

@property(assign,getter=isReloading) BOOL reloading;

@property(nonatomic,readonly) CNTableHeader *refreshHeaderView;
@property(nonatomic,readonly) CNTableHeader *loadMoreFooterView;

- (void)reloadTableViewDataSource;
- (void)dataSourceDidFinishLoadingNewData;

- (void)loadMore;

- (void)addNewRows:(NSArray*)newRows toCurrentArray:(NSArray*) currentArray;

@end
