//
//  ZXY_AlbumDetailBaseAlbum.m
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumDetailBaseAlbum.h"
#import "ZXY_AlbumDetailData.h"


NSString *const kZXY_AlbumDetailBaseAlbumResult = @"result";
NSString *const kZXY_AlbumDetailBaseAlbumData = @"data";


@interface ZXY_AlbumDetailBaseAlbum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumDetailBaseAlbum

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
            self.result = [[self objectOrNilForKey:kZXY_AlbumDetailBaseAlbumResult fromDictionary:dict] doubleValue];
            self.data = [ZXY_AlbumDetailData modelObjectWithDictionary:[dict objectForKey:kZXY_AlbumDetailBaseAlbumData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_AlbumDetailBaseAlbumResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXY_AlbumDetailBaseAlbumData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_AlbumDetailBaseAlbumResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_AlbumDetailBaseAlbumData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_AlbumDetailBaseAlbumResult];
    [aCoder encodeObject:_data forKey:kZXY_AlbumDetailBaseAlbumData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumDetailBaseAlbum *copy = [[ZXY_AlbumDetailBaseAlbum alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
