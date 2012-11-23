//
//  TKAppDelegate.m
//  TKLayoutGallery
//
//  Created by Tobias Kräntzer on 23.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import "TKCollectionViewPagingLayout.h"

#import "TKViewController.h"

#import "TKAppDelegate.h"

@implementation TKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UICollectionViewController *collectionViewController = [[TKViewController alloc] initWithCollectionViewLayout:[[TKCollectionViewPagingLayout alloc] init]];
    collectionViewController.collectionView.pagingEnabled = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = collectionViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
