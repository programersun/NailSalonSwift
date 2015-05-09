//
//  ZXY_NotiForAttensionBaseModel.m
//
//  Created by   on 15/5/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_NotiForAttensionBaseModel.h"
#import "ZXY_NotiForAttensionContent.h"


NSString *const kZXY_NotiForAttensionBaseModelContent = @"content";


@interface ZXY_NotiForAttensionBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_NotiForAttensionBaseModel

@synthesize content = _content;


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
            self.content = [ZXY_NotiForAttensionContent modelObjectWithDictionary:[dict objectForKey:kZXY_NotiForAttensionBaseModelContent]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.content dictionaryRepresentation] forKey:kZXY_NotiForAttensionBaseModelContent];

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

    self.content = [aDecoder decodeObjectForKey:kZXY_NotiForAttensionBaseModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:kZXY_NotiForAttensionBaseModelContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_NotiForAttensionBaseModel *copy = [[ZXY_NotiForAttensionBaseModel alloc] init];
    
    if (copy) {

        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
