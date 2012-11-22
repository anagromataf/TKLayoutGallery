//
//  TKViewController.m
//  TKLayoutGallery
//
//  Created by Tobias Kräntzer on 23.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "TKViewController.h"

@interface TKViewController ()
@property (nonatomic, readwrite) NSMutableArray *sections;
@end

@implementation TKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    
    self.sections = [[NSMutableArray alloc] init];
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.collectionView performBatchUpdates:^{
            [self.sections addObject:@(14)];
            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:0]];
        } completion:^(BOOL finished){
            int64_t delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.collectionView performBatchUpdates:^{
                    [self.sections addObject:@(7)];
                    [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:1]];
                } completion:^(BOOL finished){
                    int64_t delayInSeconds = 2.0;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self.collectionView performBatchUpdates:^{
                            [self.sections addObject:@(17)];
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:2]];
                        } completion:nil];
                    });
                }];
            });
        }];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section;
{
    return [[self.sections objectAtIndex:section] unsignedIntegerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    CGFloat hue = (CGFloat)indexPath.row / (CGFloat)[self collectionView:cv numberOfItemsInSection:indexPath.section];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = [UIColor colorWithHue:hue
                                                     saturation:(1 - indexPath.section * 0.4)
                                                     brightness:1
                                                          alpha:1];
    return cell;
}

@end
