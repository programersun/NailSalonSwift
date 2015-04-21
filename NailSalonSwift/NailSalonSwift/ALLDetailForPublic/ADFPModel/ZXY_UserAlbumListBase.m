//
//  ZXY_UserAlbumListBase.m
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserAlbumListBase.h"
#import "ZXY_UserAlbumListData.h"


NSString *const kZXY_UserAlbumListBaseResult = @"result";
NSString *const kZXY_UserAlbumListBaseData = @"data";


@interface ZXY_UserAlbumListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserAlbumListBase

@synthesize result = _result;
@synthesize data = _data;


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
            self.result = [[self objectOrNilForKey:kZXY_UserAlbumListBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXY_UserAlbumListData = [dict objectForKey:kZXY_UserAlbumListBaseData];
    NSMutableArray *parsedZXY_UserAlbumListData = [NSMutableArray array];
    if ([receivedZXY_UserAlbumListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXY_UserAlbumListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXY_UserAlbumListData addObject:[ZXY_UserAlbumListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXY_UserAlbumListData isKindOfClass:[NSDictionary class]]) {
       [parsedZXY_UserAlbumListData addObject:[ZXY_UserAlbumListData modelObjectWithDictionary:(NSDictionary *)receivedZXY_UserAlbumListData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXY_UserAlbumListData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_UserAlbumListBaseResult];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXY_UserAlbumListBaseData];

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
    return [object isEqual:[NSNull null]] ? @"" : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.result = [aDecoder decodeDoubleForKey:kZXY_UserAlbumListBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_UserAlbumListBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_UserAlbumListBaseResult];
    [aCoder encodeObject:_data forKey:kZXY_UserAlbumListBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserAlbumListBase *copy = [[ZXY_UserAlbumListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
