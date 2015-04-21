//
//  ZXY_UserCommentBase.m
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserCommentBase.h"
#import "ZXY_UserCommentData.h"


NSString *const kZXY_UserCommentBaseResult = @"result";
NSString *const kZXY_UserCommentBaseData = @"data";


@interface ZXY_UserCommentBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserCommentBase

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
            self.result = [[self objectOrNilForKey:kZXY_UserCommentBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXY_UserCommentData = [dict objectForKey:kZXY_UserCommentBaseData];
    NSMutableArray *parsedZXY_UserCommentData = [NSMutableArray array];
    if ([receivedZXY_UserCommentData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXY_UserCommentData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXY_UserCommentData addObject:[ZXY_UserCommentData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXY_UserCommentData isKindOfClass:[NSDictionary class]]) {
       [parsedZXY_UserCommentData addObject:[ZXY_UserCommentData modelObjectWithDictionary:(NSDictionary *)receivedZXY_UserCommentData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXY_UserCommentData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_UserCommentBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXY_UserCommentBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_UserCommentBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_UserCommentBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_UserCommentBaseResult];
    [aCoder encodeObject:_data forKey:kZXY_UserCommentBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserCommentBase *copy = [[ZXY_UserCommentBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
