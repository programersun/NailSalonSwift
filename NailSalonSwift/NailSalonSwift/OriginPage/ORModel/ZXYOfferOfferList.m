//
//  ZXYOfferOfferList.m
//
//  Created by   on 15/3/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOfferOfferList.h"
#import "ZXYOfferData.h"


NSString *const kZXYOfferOfferListResult = @"result";
NSString *const kZXYOfferOfferListData = @"data";


@interface ZXYOfferOfferList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOfferOfferList

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
            self.result = [[self objectOrNilForKey:kZXYOfferOfferListResult fromDictionary:dict] doubleValue];
            self.data = [ZXYOfferData modelObjectWithDictionary:[dict objectForKey:kZXYOfferOfferListData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYOfferOfferListResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXYOfferOfferListData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYOfferOfferListResult];
    self.data = [aDecoder decodeObjectForKey:kZXYOfferOfferListData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYOfferOfferListResult];
    [aCoder encodeObject:_data forKey:kZXYOfferOfferListData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOfferOfferList *copy = [[ZXYOfferOfferList alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
