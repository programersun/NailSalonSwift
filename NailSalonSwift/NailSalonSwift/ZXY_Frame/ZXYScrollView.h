//
//  ZXYScrollView.h
//  GasStations
//
//  Created by zhouxiaoyu on 14-2-14.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZXYScrollDelegate <NSObject>

@required
-(BOOL)shouldTurnAutoWithTime                      ;//定时滚动
-(NSTimeInterval)turnTimeInterVal                  ;//滚动间隔
-(BOOL)shouldClickAtIndex:(NSInteger)index;         //是否可以进行点击事件
-(void)afterClickAtIndex:(NSInteger)index;          //点击事件

@end

@protocol ZXYScrollDataSource <NSObject>

@required
- (NSInteger)numberOfPages;                         //页数
- (UIView *)viewAtIndexPage:(NSInteger)index;       //定制view

@end

@interface ZXYScrollView : UIView<UIScrollViewDelegate>
{
    id <ZXYScrollDataSource> dataSource2;
    id <ZXYScrollDelegate>   delegate2;
    UIScrollView  *_scrollV;
    UIPageControl *_pageV;
    NSMutableArray *_viewS;
}
@property (nonatomic,assign,setter = setDataSource:)IBOutlet id <ZXYScrollDataSource> dataSource;
@property (nonatomic,assign,setter = setDelegate:)IBOutlet id <ZXYScrollDelegate>   delegate;
@property (nonatomic,readonly) UIScrollView *scrollV;
@property (nonatomic,readonly) UIPageControl *pageV;
@property (nonatomic,readonly) NSMutableArray *viewS;
- (void)reloadDataImage;
@end
