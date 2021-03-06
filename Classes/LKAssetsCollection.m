//
//  LKAssetsCollection.m
//  LKAssetsLibrary
//
//  Created by Hiroshi Hashiguchi on 2014/05/22.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "LKAssetsCollection.h"

@interface LKAssetsCollection()
@property (nonatomic, weak) LKAssetsGroup* group;
@property (nonatomic, strong) id <LKAssetsCollectionGrouping> grouping;

@property (nonatomic, strong) NSArray* entries;         // <LKAssetsCollectionEntry>
@property (nonatomic, strong) NSArray* processedEntries; // <LKAssetsCollectionEntry>

@end

@implementation LKAssetsCollection

+ (instancetype)assetsCollectionWithGroup:(LKAssetsGroup*)group grouping:(id <LKAssetsCollectionGrouping>)grouping
{
    LKAssetsCollection* collection = self.new;
    collection.group = group;
    collection.grouping = grouping;
    collection.entries = [grouping groupedCollectionEntriesWithAssetsGroup:group];
    return collection;
}

- (NSArray*)entries
{
    if (self.filter || self.sorter) {
        return self.processedEntries;
    }
    return _entries;
}

- (NSArray*)processedEntries
{
    if (_processedEntries == nil) {
        NSArray* resultEntries = nil;
        if (self.filter) {
            resultEntries = [self.filter filteredCollectionEntriesWithEntries:_entries];
        } else {
            resultEntries = _entries;
        }
        if (self.sorter) {
            resultEntries = [self.sorter sortedCollectionEntriesWithEntries:resultEntries];
        }        
        _processedEntries = resultEntries;
    }
    return _processedEntries;
}

- (void)setFilter:(id <LKAssetsCollectionFilter>)filter
{
    _filter = filter;
    self.processedEntries = nil;
}

- (void)setSorter:(id <LKAssetsCollectionSorter>)sorter
{
    _sorter = sorter;
    self.processedEntries = nil;
}

@end


@implementation  LKAssetsCollection (NSIndexPath)

- (LKAsset*)assetForIndexPath:(NSIndexPath*)indexPath
{
    LKAssetsCollectionEntry* entry = self.entries[indexPath.section];
    return entry.assets[indexPath.row];
}

@end
