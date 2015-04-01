//
//  ZXYCourseBaseList.m
//
//  Created by   on 15/4/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseBaseList.h"
#import "ZXYCourseData.h"


NSString *const kZXYCourseBaseListResult = @"result";
NSString *const kZXYCourseBaseListData = @"data";


@interface ZXYCourseBaseList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseBaseList

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
            self.result = [[self objectOrNilForKey:kZXYCourseBaseListResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXYCourseData = [dict objectForKey:kZXYCourseBaseListData];
    NSMutableArray *parsedZXYCourseData = [NSMutableArray array];
    if ([receivedZXYCourseData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYCourseData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYCourseData addObject:[ZXYCourseData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYCourseData isKindOfClass:[NSDictionary class]]) {
       [parsedZXYCourseData addObject:[ZXYCourseData modelObjectWithDictionary:(NSDictionary *)receivedZXYCourseData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXYCourseData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYCourseBaseListResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXYCourseBaseListData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYCourseBaseListResult];
    self.data = [aDecoder decodeObjectForKey:kZXYCourseBaseListData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYCourseBaseListResult];
    [aCoder encodeObject:_data forKey:kZXYCourseBaseListData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseBaseList *copy = [[ZXYCourseBaseList alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
