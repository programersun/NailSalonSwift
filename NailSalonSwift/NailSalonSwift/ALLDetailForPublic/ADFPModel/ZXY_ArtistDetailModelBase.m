//
//  ZXY_ArtistDetailModelBase.m
//
//  Created by   on 15/4/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_ArtistDetailModelBase.h"
#import "ZXY_ArtistDetailData.h"


NSString *const kZXY_ArtistDetailModelBaseResult = @"result";
NSString *const kZXY_ArtistDetailModelBaseData = @"data";


@interface ZXY_ArtistDetailModelBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_ArtistDetailModelBase

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
            self.result = [[self objectOrNilForKey:kZXY_ArtistDetailModelBaseResult fromDictionary:dict] doubleValue];
            self.data = [ZXY_ArtistDetailData modelObjectWithDictionary:[dict objectForKey:kZXY_ArtistDetailModelBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_ArtistDetailModelBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXY_ArtistDetailModelBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_ArtistDetailModelBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_ArtistDetailModelBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_ArtistDetailModelBaseResult];
    [aCoder encodeObject:_data forKey:kZXY_ArtistDetailModelBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_ArtistDetailModelBase *copy = [[ZXY_ArtistDetailModelBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
