//
//  ZXYScrollView.m
//  GasStations
//
//  Created by zhouxiaoyu on 14-2-14.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

#import "ZXYScrollView.h"
@interface ZXYScrollView()
{
    NSInteger numPages;
    BOOL flag;
    NSTimer *_timer;
}
@end
@implementation ZXYScrollView
@synthesize dataSource = _dataSource;
@synthesize delegate   = _delegate;
@synthesize scrollV    = _scrollV;
@synthesize pageV      = _pageV;
@synthesize viewS      = _viewS;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        _pageV   = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 30)];
        _viewS   = [[NSMutableArray alloc] init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)initView
{
    if(_scrollV==nil)
    {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        _pageV   = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 30)];
//        _pageV.pageIndicatorTintColor = [UIColor grayColor];
//        _pageV.currentPageIndicatorTintColor = ;
        _viewS   = [[NSMutableArray alloc] init];
    }
    if(_viewS)
    {
        [_viewS removeAllObjects];
    }
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [_scrollV setBounces:NO];
    _scrollV.delegate = self;
    [self addSubview:_scrollV];
    [self addSubview:_pageV];
    [_pageV setUserInteractionEnabled:NO];
}

- (void)setDataSource:(id<ZXYScrollDataSource>)dataSource
{
    [self initView];
    _dataSource = dataSource;
    if([dataSource respondsToSelector:@selector(numberOfPages)])
    {
        numPages = [dataSource numberOfPages];
        [_scrollV setContentSize:CGSizeMake(self.frame.size.width*numPages,self.frame.size.height)];
        [_pageV setNumberOfPages:numPages];
        for(int i = 0;i<numPages;i++)
        {
            if([dataSource respondsToSelector:@selector(viewAtIndexPage:)])
            {
                UIView *returnView = [dataSource viewAtIndexPage:i];
                returnView.tag     = i;
                [_viewS addObject:returnView];
            }
        }
    }
    [self addsubViewS:_viewS];
}

- (void)setDelegate:(id<ZXYScrollDelegate>)delegate
{
    _delegate = delegate;
    if([delegate respondsToSelector:@selector(shouldTurnAutoWithTime)])
    {
        if([delegate shouldTurnAutoWithTime])
        {
            NSTimeInterval interVal = [delegate turnTimeInterVal];
            if(_timer == nil)
            {
                _timer=[NSTimer timerWithTimeInterval:interVal target:self selector:@selector(changePage) userInfo:nil repeats:YES];
                //必须手动加入到当前循环中去
                NSRunLoop *runloop=[NSRunLoop currentRunLoop];
                [runloop addTimer:_timer forMode:NSDefaultRunLoopMode];
            }
        }
    }
    if([delegate respondsToSelector:@selector(shouldClickAtIndex:)])
    {
        for(int i = 0;i<numPages;i++)
        {
            if([_delegate shouldClickAtIndex:i])
            {
                 UIView *returnView = [_viewS objectAtIndex:i];
                [returnView setUserInteractionEnabled:YES];
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAtIndex:)];
                [returnView addGestureRecognizer:tapGes];
                tapGes = nil;
            }
        }
    }
}

- (void)clickAtIndex:(UITapGestureRecognizer *)tap
{
    [_delegate afterClickAtIndex:_pageV.currentPage];
}

-(void)changePage
{
    if(_pageV.currentPage == 0)
    {
        flag = YES;
    }
    if(_pageV.currentPage == numPages-1)
    {
        flag = NO;
    }

    if(flag)
    {
        long witch = _pageV.currentPage+1;
        [_scrollV setContentOffset:CGPointMake(witch*self.frame.size.width, 0) animated:YES];
    }
    else
    {
        long witch = _pageV.currentPage-1;
        [_scrollV setContentOffset:CGPointMake(witch*self.frame.size.width, 0) animated:YES];
    }
    return;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = floor((scrollView.contentOffset.x - self.frame.size.width / 2) / self.frame.size.width) +1;
    [_pageV setCurrentPage:pageIndex];
    if(_pageV.currentPage == 0)
    {
        flag = YES;
    }
    if(_pageV.currentPage == numPages-1)
    {
        flag = NO;
    }

}


- (void)addsubViewS:(NSArray *)allView
{
    for(int i = 0;i<allView.count;i++)
    {
        UIView *view = [allView objectAtIndex:i];
        view.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        [_scrollV addSubview:view];
    }
}

- (void)reloadDataImage
{
    [self setDataSource:self.dataSource];
    [self setDelegate:self.delegate];
}
@end
