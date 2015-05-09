//
//  ZXY_NotiForAttensionContent.m
//
//  Created by   on 15/5/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_NotiForAttensionContent.h"
#import "ZXY_NotiForAttensionData.h"


NSString *const kZXY_NotiForAttensionContentType = @"type";
NSString *const kZXY_NotiForAttensionContentData = @"data";


@interface ZXY_NotiForAttensionContent ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_NotiForAttensionContent

@synthesize type = _type;
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
            self.type = [self objectOrNilForKey:kZXY_NotiForAttensionContentType fromDictionary:dict];
            self.data = [ZXY_NotiForAttensionData modelObjectWithDictionary:[dict objectForKey:kZXY_NotiForAttensionContentData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kZXY_NotiForAttensionContentType];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXY_NotiForAttensionContentData];

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

    self.type = [aDecoder decodeObjectForKey:kZXY_NotiForAttensionContentType];
    self.data = [aDecoder decodeObjectForKey:kZXY_NotiForAttensionContentData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kZXY_NotiForAttensionContentType];
    [aCoder encodeObject:_data forKey:kZXY_NotiForAttensionContentData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_NotiForAttensionContent *copy = [[ZXY_NotiForAttensionContent alloc] init];
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
