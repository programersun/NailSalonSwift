//
//  ZXYOriginAlbumList.m
//
//  Created by   on 15/3/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOriginAlbumList.h"
#import "ZXYOriginAlbumData.h"


NSString *const kZXYOriginAlbumListResult = @"result";
NSString *const kZXYOriginAlbumListData = @"data";


@interface ZXYOriginAlbumList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOriginAlbumList

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
            self.result = [[self objectOrNilForKey:kZXYOriginAlbumListResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXYOriginAlbumData = [dict objectForKey:kZXYOriginAlbumListData];
    NSMutableArray *parsedZXYOriginAlbumData = [NSMutableArray array];
    if ([receivedZXYOriginAlbumData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYOriginAlbumData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYOriginAlbumData addObject:[ZXYOriginAlbumData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYOriginAlbumData isKindOfClass:[NSDictionary class]]) {
       [parsedZXYOriginAlbumData addObject:[ZXYOriginAlbumData modelObjectWithDictionary:(NSDictionary *)receivedZXYOriginAlbumData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXYOriginAlbumData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYOriginAlbumListResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXYOriginAlbumListData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYOriginAlbumListResult];
    self.data = [aDecoder decodeObjectForKey:kZXYOriginAlbumListData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYOriginAlbumListResult];
    [aCoder encodeObject:_data forKey:kZXYOriginAlbumListData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOriginAlbumList *copy = [[ZXYOriginAlbumList alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
