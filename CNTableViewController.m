//
//  Created by Ravel Antunes on 10/31/12.
//  Copyright (c) 2012 Riptide Software. All rights reserved.
//

#import "CNTableViewController.h"
#import "CNTableHeader.h"


@implementation CNTableViewController
@synthesize reloading=_reloading;
@synthesize refreshHeaderView;

#pragma mark -
#pragma mark View lifecycle


#define SENSIBILITY 50.0f

- (void)viewDidLoad {
    [super viewDidLoad];

	 if (refreshHeaderView == nil) {
		 refreshHeaderView = [[CNTableHeader alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 320.0f, self.tableView.bounds.size.height)];
         refreshHeaderView.backgroundColor = [UIColor blackColor];
		 refreshHeaderView.bottomBorderThickness = 1.0;
		 [self.tableView addSubview:refreshHeaderView];
		 self.tableView.showsVerticalScrollIndicator = YES;
         
         [self setupTableViewFooter];
	 }
 
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
}


#pragma mark -
#pragma mark ScrollView Callbacks
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -SENSIBILITY && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -SENSIBILITY && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
    
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        [self loadMore];        
    }
}


#pragma mark Load More Call Back
- (void)loadMore{
    NSLog(@"Please override loadMore.");    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.contentOffset.y <= - SENSIBILITY && !_reloading) {
		_reloading = YES;
		[self reloadTableViewDataSource];
		[refreshHeaderView setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}



#pragma mark -
#pragma mark refreshHeaderView Methods

- (void)dataSourceDidFinishLoadingNewData{	
    [refreshHeaderView setCurrentDate];
    
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
}


- (void) reloadTableViewDataSource
{
	NSLog(@"Please override reloadTableViewDataSource");
}



#pragma mark Footer

- (void)setupTableViewFooter
{
    // set up label
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    footerView.backgroundColor = [UIColor clearColor];
    
    
    footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    footerLabel.font = [UIFont boldSystemFontOfSize:16];
    footerLabel.textColor = [UIColor whiteColor];
    [footerLabel setBackgroundColor:[UIColor clearColor]];
    footerLabel.textAlignment = UITextAlignmentCenter;
    
    
    footerActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    footerActivityIndicator.center = CGPointMake(40, 22);
    footerActivityIndicator.hidesWhenStopped = YES;    
    [footerActivityIndicator setColor:[UIColor whiteColor]];
    
    [footerView addSubview:footerLabel];
    [footerView addSubview:footerActivityIndicator];
    

    self.tableView.tableFooterView = footerView;
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	refreshHeaderView=nil;
}


@end

