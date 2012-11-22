//
//  TKCollectionViewPagingLayout.m
//  TKLayoutGallery
//
//  Created by Tobias Kräntzer on 23.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "TKCollectionViewPagingLayout.h"

@interface TKCollectionViewPagingLayout ()
@property (nonatomic, assign) CGSize collectionViewContentSize;
@property (nonatomic, strong) NSDictionary *layoutAttributes;
@end

@implementation TKCollectionViewPagingLayout

- (id)init;
{
    self = [super init];
    if (self) {
        _itemScale = 1;
        _itemSpacing = 15.0;
    }
    return self;
}

#pragma mark UICollectionViewLayout

- (void)prepareLayout;
{
    NSMutableDictionary *layoutAttributes = [[NSMutableDictionary alloc] init];
    NSUInteger totalNumberOfItems = 0;
    
    
    // Calculate the total Number of Items
    // -----------------------------------
    
    NSUInteger numberOfSections = [self.collectionView numberOfSections];
    for (NSUInteger section = 0; section < numberOfSections; section++) {
        totalNumberOfItems += [self.collectionView numberOfItemsInSection:section];
    }
    
    
    // Set the Content Size
    // --------------------
    
    self.collectionViewContentSize = CGSizeMake(self.collectionView.frame.size.width * MAX(1, totalNumberOfItems),
                                  self.collectionView.frame.size.height);
    
    
    // Calculate the scrolling Position
    // --------------------------------
    
    CGFloat position =  self.collectionView.contentOffset.x / self.collectionViewContentSize.width * totalNumberOfItems;
    
    
    // Generate Layout Attributes
    // --------------------------
    
    CGSize itemSize = self.collectionView.frame.size;
    
    NSUInteger totalItemIndex = 0;
    
    // Iterate of all Sections
    
    for (NSUInteger section = 0; section < numberOfSections; section++) {
        
        // Iterate over all Items in the current Section
        
        NSUInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:section];
        for (NSUInteger itemIndex = 0; itemIndex < numberOfItemsInSection; itemIndex++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:section];
            
            CGFloat positionOffset = totalItemIndex - position;
            
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.transform3D = CATransform3DMakeScale(self.itemScale, self.itemScale, 1);
            attributes.size = itemSize;
            attributes.center = CGPointMake(round(itemSize.width / 2 + (itemSize.width * totalItemIndex) - positionOffset * (1 - self.itemScale) * itemSize.width + positionOffset * self.itemSpacing),
                                            round(itemSize.height / 2));
            
            [layoutAttributes setObject:attributes forKey:indexPath];
            
            totalItemIndex++;
        }
    }
    
    self.layoutAttributes = layoutAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
{
    return [[self.layoutAttributes allValues] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *attributes, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, attributes.frame);
    }]];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.layoutAttributes objectForKey:indexPath];
}

@end
