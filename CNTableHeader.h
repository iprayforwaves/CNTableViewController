//
//  Created by Ravel Antunes on 10/31/12.
//  Copyright (c) 2012 Riptide Software. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,	
	EGOOPullRefreshUpToDate,
} EGOPullRefreshState;

@interface CNTableHeader : UIView {
	
	UILabel *lastUpdatedLabel;
	UILabel *statusLabel;
	CALayer *arrowImage;
	UIActivityIndicatorView *activityView;
	
	EGOPullRefreshState _state;
	UIColor *bottomBorderColor;
	CGFloat bottomBorderThickness;

}

@property(nonatomic,assign) EGOPullRefreshState state;
@property(nonatomic,retain) UIColor *bottomBorderColor;
@property(nonatomic,assign) CGFloat bottomBorderThickness;

- (id)initWithFrameRelativeToFrame:(CGRect)originalFrame;
- (void)setLastRefreshDate:(NSDate*)date;
- (void)setCurrentDate;
- (void)setState:(EGOPullRefreshState)aState;

@end
