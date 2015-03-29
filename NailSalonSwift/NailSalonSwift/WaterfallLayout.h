//
//  WaterfallLayout.h
//  CollectionViewWaterfallLayoutSample
//
//  Created by MORITA NAOKI on 2014/04/29.
//  Copyright (c) 2014年 molabo. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const CollectionElementKindSectionHeader;
extern NSString *const CollectionElementKindSectionFooter;

#pragma mark - WaterfallLayoutDelegate

@class WaterfallLayout;

@protocol WaterfallLayoutDelegate <UICollectionViewDelegate>
@required
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;
- (UIEdgeInsets) collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout *) collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat) collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout *) collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger) section;

@end

#pragma mark - WaterfallLayout

@interface WaterfallLayout : UICollectionViewLayout

/**
 *  @brief How many columns for this layout.
 *  @discussion Default: 2
 */
@property (nonatomic, assign) NSInteger columnCount;

/**
 *  @brief The minimum spacing to use between successive columns.
 *  @discussion Default: 10.0
 */
@property (nonatomic, assign) CGFloat minimumColumnSpacing;

/**
 *  @brief The minimum spacing to use between items in the same column.
 *  @discussion Default: 10.0
 *  @note This spacing is not applied to the space between header and columns or between columns and footer.
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/**
 *  @brief Height for section header
 *  @discussion
 *    If your collectionView's delegate doesn't implement `collectionView:layout:heightForHeaderInSection:`,
 *    then this value will be used.
 *
 *    Default: 0
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 *  @brief Height for section footer
 *  @discussion
 *    If your collectionView's delegate doesn't implement `collectionView:layout:heightForFooterInSection:`,
 *    then this value will be used.
 *
 *    Default: 0
 */
@property (nonatomic, assign) CGFloat footerHeight;

/**
 *  @brief The margins that are used to lay out content in each section.
 *  @discussion
 *    Section insets are margins applied only to the items in the section.
 *    They represent the distance between the header view and the columns and between the columns and the footer view.
 *    They also indicate the spacing on either side of columns. They do not affect the size of the headers or footers themselves.
 *
 *    Default: UIEdgeInsetsZero
 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/**
 *  @brief The calculated width of an item in the specified section.
 *  @discussion
 *    The width of an item is calculated based on number of columns, the collection view width, and the horizontal insets for that section.
 */
- (CGFloat)itemWidthInSectionAtIndex:(NSInteger) section;
@end