//
//  ZXYOfferData.m
//
//  Created by   on 15/3/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOfferData.h"
#import "ZXYOfferRecommendAlbum.h"
#import "ZXYOfferLastAlbum.h"


NSString *const kZXYOfferDataRecommendAlbum = @"recommend_album";
NSString *const kZXYOfferDataLastAlbum = @"last_album";


@interface ZXYOfferData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOfferData

@synthesize recommendAlbum = _recommendAlbum;
@synthesize lastAlbum = _lastAlbum;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedZXYOfferRecommendAlbum = [dict objectForKey:kZXYOfferDataRecommendAlbum];
    NSMutableArray *parsedZXYOfferRecommendAlbum = [NSMutableArray array];
    if ([receivedZXYOfferRecommendAlbum isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYOfferRecommendAlbum) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYOfferRecommendAlbum addObject:[ZXYOfferRecommendAlbum modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYOfferRecommendAlbum isKindOfClass:[NSDictionary class]]) {
       [parsedZXYOfferRecommendAlbum addObject:[ZXYOfferRecommendAlbum modelObjectWithDictionary:(NSDictionary *)receivedZXYOfferRecommendAlbum]];
    }

    self.recommendAlbum = [NSArray arrayWithArray:parsedZXYOfferRecommendAlbum];
    NSObject *receivedZXYOfferLastAlbum = [dict objectForKey:kZXYOfferDataLastAlbum];
    NSMutableArray *parsedZXYOfferLastAlbum = [NSMutableArray array];
    if ([receivedZXYOfferLastAlbum isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYOfferLastAlbum) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYOfferLastAlbum addObject:[ZXYOfferLastAlbum modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYOfferLastAlbum isKindOfClass:[NSDictionary class]]) {
       [parsedZXYOfferLastAlbum addObject:[ZXYOfferLastAlbum modelObjectWithDictionary:(NSDictionary *)receivedZXYOfferLastAlbum]];
    }

    self.lastAlbum = [NSArray arrayWithArray:parsedZXYOfferLastAlbum];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRecommendAlbum = [NSMutableArray array];
    for (NSObject *subArrayObject in self.recommendAlbum) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRecommendAlbum addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRecommendAlbum addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRecommendAlbum] forKey:kZXYOfferDataRecommendAlbum];
    NSMutableArray *tempArrayForLastAlbum = [NSMutableArray array];
    for (NSObject *subArrayObject in self.lastAlbum) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLastAlbum addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLastAlbum addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLastAlbum] forKey:kZXYOfferDataLastAlbum];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.recommendAlbum = [aDecoder decodeObjectForKey:kZXYOfferDataRecommendAlbum];
    self.lastAlbum = [aDecoder decodeObjectForKey:kZXYOfferDataLastAlbum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recommendAlbum forKey:kZXYOfferDataRecommendAlbum];
    [aCoder encodeObject:_lastAlbum forKey:kZXYOfferDataLastAlbum];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOfferData *copy = [[ZXYOfferData alloc] init];
    
    if (copy) {

        copy.recommendAlbum = [self.recommendAlbum copyWithZone:zone];
        copy.lastAlbum = [self.lastAlbum copyWithZone:zone];
    }
    
    return copy;
}


@end
