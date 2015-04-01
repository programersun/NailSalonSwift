//
//  ZXYOriginAlbumUser.m
//
//  Created by   on 15/3/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOriginAlbumUser.h"


NSString *const kZXYOriginAlbumUserNickName = @"nick_name";
NSString *const kZXYOriginAlbumUserRole = @"role";
NSString *const kZXYOriginAlbumUserHeadImage = @"head_image";


@interface ZXYOriginAlbumUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOriginAlbumUser

@synthesize nickName = _nickName;
@synthesize role = _role;
@synthesize headImage = _headImage;


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
            self.nickName = [self objectOrNilForKey:kZXYOriginAlbumUserNickName fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXYOriginAlbumUserRole fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXYOriginAlbumUserHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXYOriginAlbumUserNickName];
    [mutableDict setValue:self.role forKey:kZXYOriginAlbumUserRole];
    [mutableDict setValue:self.headImage forKey:kZXYOriginAlbumUserHeadImage];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXYOriginAlbumUserNickName];
    self.role = [aDecoder decodeObjectForKey:kZXYOriginAlbumUserRole];
    self.headImage = [aDecoder decodeObjectForKey:kZXYOriginAlbumUserHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXYOriginAlbumUserNickName];
    [aCoder encodeObject:_role forKey:kZXYOriginAlbumUserRole];
    [aCoder encodeObject:_headImage forKey:kZXYOriginAlbumUserHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOriginAlbumUser *copy = [[ZXYOriginAlbumUser alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
