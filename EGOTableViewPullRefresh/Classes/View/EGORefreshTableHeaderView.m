//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
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

#import "EGORefreshTableHeaderView.h"


#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullRefreshState)aState;
-(CGFloat) contentViewRealHeight;
- (void) handleShowMessage: (NSTimer *) timer;
@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;
@synthesize lastContenView=_tableView;
@synthesize isTopRefresh=_isTopRefresh;
@synthesize hasMoreData=_hasMoreData;
@synthesize hideLoadMoreTip=_hideLoadMoreTip;
@synthesize showMessageAfterRefreshed=_showMessageAfterRefreshed;


- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor tableView:(UITableView *)tableView  {
    if((self = [super initWithFrame:frame])) {
        _hasMoreData=YES;
        _hideLoadMoreTip=NO;
        _showMessageAfterRefreshed=YES;
        _tableView=tableView;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		label=nil;
        
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		label=nil;
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:arrow].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		view=nil;
		
        CGRect footerRect=CGRectMake(0.0f, frame.size.height +[self                                                                contentViewRealHeight], self.frame.size.width,MAX(frame.size.height, 150.0f));
        UIView	*fview = [[UIView alloc] initWithFrame:footerRect];
		fview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		fview.backgroundColor =  [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];		
        [_tableView addSubview:fview];
		_footerView=fview;
		fview=nil;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f, self.frame.size.width, 15.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:11.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[_footerView addSubview:label];    
		_footerStatusLabel=label;
		label=nil;    
        
        
        UIActivityIndicatorView *view2 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view2.frame = CGRectMake(18.0f, 8.0f, 10.0f, 10.0f);
		[_footerView addSubview:view2];
		_footerActivityView = view2;
		view=nil;
        _previousOffSet=[tableView contentOffset];
        [self setState:EGOOPullFooterRefreshNormal];
		[self setState:EGOOPullRefreshNormal];        
		
    }
	
    return self;
	
}

- (id)initWithFrame:(CGRect)frame tableView:(UITableView *)tableView  {
    return [self initWithFrame:frame arrowImageName:@"blueArrow.png" textColor:TEXT_COLOR tableView:tableView];
}

#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
		
		[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
		_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Last Updated: %@", @"") , [dateFormatter stringFromDate:date]];
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
		_lastUpdatedLabel.text = nil;
		
	}
    
}

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			//NSLog(@"%@",NSLocalizedString(@"Release to refresh...", @"Release to refresh status"));
			_statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
            //NSLog(@"%@",_statusLabel.text);
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshNormal:
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
			
			
			_statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
			[_activityView stopAnimating];           
            
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
            [self refreshLastUpdatedDate];	
            if(_hideLoadMoreTip)
                _footerView.hidden=YES;
            else
                _footerView.hidden=!_hasMoreData;
			break;
		case EGOOPullRefreshLoading:			
            
            _isTopRefresh=YES;
            _statusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden=YES;
            _arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];           
			
			break;
        case EGOOPullFooterRefreshNormal:
            
            _footerStatusLabel.text = NSLocalizedString(@"Pull up to load more...", @"Pull up to refresh status");
            [_footerActivityView stopAnimating];
            _footerView.hidden=!_hasMoreData;
            
            break;
        case EGOOPullFooterRefreshPulling:			
            
			_footerStatusLabel.text = NSLocalizedString(@"Release to load more...", @"Release to load more status");
            _footerView.hidden=NO;		
            
			break;  
        case EGOOPullFooterRefreshLoading:
            
            _isTopRefresh=NO;
			_footerStatusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
            _footerView.hidden=NO;
			[_footerActivityView startAnimating];		
			
			break;    
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
    
	BOOL directDown;      
    if (_previousOffSet.y < scrollView.contentOffset.y) {          
        directDown = YES;          
    }      
    else{          
        directDown = NO;          
    }  
    _previousOffSet.y = scrollView.contentOffset.y; 
	if (_state == EGOOPullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);	
	}
    else if(_state==EGOOPullFooterRefreshLoading){
        
    }
    else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
		NSLog(@"offset y:%f,footer frame origin.y:%f,self frame orgin.height:%f,table view height:%f,frame height:%f",scrollView.contentOffset.y,
              _footerView.frame.origin.y,self.frame.size.height,[self contentViewRealHeight],scrollView.frame.size.height);
        NSLog(@"%d%d%d",_state == EGOOPullRefreshNormal,scrollView.contentOffset.y < -65.0f,!_loading);
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
			[self setState:EGOOPullRefreshNormal];
            if (scrollView.contentInset.top != 0) {
                scrollView.contentInset = UIEdgeInsetsZero;
            }
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
			[self setState:EGOOPullRefreshPulling];
            if (scrollView.contentInset.top != 0) {
                scrollView.contentInset = UIEdgeInsetsZero;
            }
		} else if (!directDown && _hasMoreData && _state == EGOOPullFooterRefreshPulling && scrollView.contentOffset.y>0 && scrollView.contentOffset.y +scrollView.frame.size.height> _footerView.frame.origin.y && !_loading) {
            [self setState:EGOOPullFooterRefreshNormal];
        } else if (directDown && _hasMoreData && (_state == EGOOPullFooterRefreshNormal||_state == EGOOPullRefreshNormal) &&scrollView.contentOffset.y>0 && scrollView.contentOffset.y +scrollView.frame.size.height>_footerView.frame.origin.y+65.0f && !_loading) {
            [self setState:EGOOPullFooterRefreshPulling];
        }		
	}
	
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	if ((scrollView.contentOffset.y <= - 65.0f || (_hasMoreData && scrollView.contentOffset.y >_footerView.frame.origin.y-scrollView.frame.size.height+65.0f)) && !_loading) {	
		if(scrollView.contentOffset.y <= - 65.0f){
            [self setState:EGOOPullRefreshLoading];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];
        }    
        else{
            [self setState:EGOOPullFooterRefreshLoading];
		}
        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}        
	}
	
}

- (void)egoInitLoading:(UIScrollView *)scrollView {	
	[self setState:EGOOPullRefreshLoading];
    if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
        [_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
    }   
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];	
    [self setState:EGOOPullRefreshLoading];
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
	if(_state==EGOOPullRefreshLoading){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        
        [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [UIView commitAnimations];
    }
    CGFloat height=[self contentViewRealHeight];
    CGRect footerRect=CGRectMake(0.0f,height,_footerView.frame.size.width,_footerView.frame.size.height);
	[_footerView setFrame:footerRect];
    if(_state==EGOOPullRefreshLoading){
        [self setState:EGOOPullRefreshNormal];
        if(_showMessageAfterRefreshed){
            if(_messageView==nil){
                _messageView=[[UIView alloc] initWithFrame:CGRectMake((scrollView.frame.size.width-140.0f)/2,scrollView.contentOffset.y+(scrollView.frame.size.height-70.0f)/2, 140.0f, 70.0f)];
                _messageView.backgroundColor=[UIColor blackColor];
                UILabel *text= [[UILabel alloc ]initWithFrame:CGRectMake(0.0f,0.0f,_messageView.bounds.size.width,_messageView.bounds.size.height)];
                text.backgroundColor=[UIColor clearColor];
                text.text=NSLocalizedString(@"Result refreshed",@"");  
                text.font = [UIFont boldSystemFontOfSize:18.0f];
                text.textAlignment=UITextAlignmentCenter;
                text.textColor=[UIColor whiteColor];            
                [_messageView addSubview:text];
                _messageView.alpha=1.0f;                 
            }
            else{
                [_messageView setFrame:CGRectMake(_messageView.frame.origin.x, scrollView.contentOffset.y+(scrollView.frame.size.height-70.0f)/2, _messageView.frame.size.width, _messageView.frame.size.height)];
            }
            
            [UIView beginAnimations:@"View Flip" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [scrollView addSubview:_messageView];	
            [UIView commitAnimations];
            NSTimer *timer;        
            timer = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                                     target: self
                                                   selector: @selector(handleShowMessage:)
                                                   userInfo: nil
                                                    repeats: NO];
        }

    }else{
        [self setState:EGOOPullFooterRefreshNormal];
    }
}

- (void) handleShowMessage: (NSTimer *) timer
{
    if(_messageView!=nil){
        [_messageView removeFromSuperview];
    }
} 

-(CGFloat) contentViewRealHeight{
    if ([_delegate respondsToSelector:@selector(egoContentViewHeight:)]) {
       return [_delegate egoContentViewHeight:self];
    }  
    else
        return  0.0f;
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    _footerStatusLabel=nil;
    _footerView=nil;
    _footerActivityView=nil;
}


@end
