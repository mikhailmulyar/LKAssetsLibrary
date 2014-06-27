//
//  AssetsGroup.h
//  SlideshowFun
//
//  Created by Hiroshi Hashiguchi on 2013/07/27.
//  Copyright (c) 2013年 Lakesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class LKAsset;

// Notifications
extern NSString * const LKAssetsGroupDidReloadNotification;

@interface LKAssetsGroup : NSObject

// Properties (Attribute)
// Note: below properties can be used before calling -reloadAssets
@property (strong, nonatomic, readonly) NSString*   name;
@property (strong, nonatomic, readonly) UIImage*    posterImage;
@property (weak  , nonatomic, readonly) NSURL*      url;
@property (assign, nonatomic, readonly) NSUInteger  type;               // ALAssetsGroupType
@property (assign, nonatomic, readonly) NSInteger   numberOfAssets;
@property (nonatomic, assign, readonly) NSString *persistentId;
@property (nonatomic, assign) BOOL isLoaded;

// Properties (Asset)
@property (strong, nonatomic, readonly) NSArray* assets;    // should call -reloadAssets before accessing it

// Factories
+ (LKAssetsGroup*)assetsGroupFrom:(ALAssetsGroup*)assetsGroup;

// Operations
- (void)reloadAssets;   // should be called before accessing assets
- (void)unloadAssets;

- (BOOL) addAsset:(LKAsset *)asset sendNotification:(BOOL)shouldSendNotification;

// Etc
- (NSComparisonResult)compare:(LKAssetsGroup*)assetsGroup;


// [Advanced] Custom Asset
// default: LKAsset.class
@property (strong, nonatomic) Class assetClass;

@end
