//
//  ZXY_AlbumDetailUser.m
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumDetailUser.h"


NSString *const kZXY_AlbumDetailUserNickName = @"nick_name";
NSString *const kZXY_AlbumDetailUserAttention = @"attention";
NSString *const kZXY_AlbumDetailUserScore = @"score";
NSString *const kZXY_AlbumDetailUserHeadImage = @"head_image";
NSString *const kZXY_AlbumDetailUserRole = @"role";
NSString *const kZXY_AlbumDetailUserUserId = @"user_id";
NSString *const kZXY_AlbumDetailUserByAttention = @"by_attention";
NSString *const kZXY_AlbumDetailUserAlbumCount = @"album_count";
NSString *const kZXY_AlbumDetailUserAddTime = @"add_time";


@interface ZXY_AlbumDetailUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumDetailUser

@synthesize nickName = _nickName;
@synthesize attention = _attention;
@synthesize score = _score;
@synthesize headImage = _headImage;
@synthesize role = _role;
@synthesize userId = _userId;
@synthesize byAttention = _byAttention;
@synthesize albumCount = _albumCount;
@synthesize addTime = _addTime;


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
            self.nickName = [self objectOrNilForKey:kZXY_AlbumDetailUserNickName fromDictionary:dict];
            self.attention = [self objectOrNilForKey:kZXY_AlbumDetailUserAttention fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXY_AlbumDetailUserScore fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXY_AlbumDetailUserHeadImage fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXY_AlbumDetailUserRole fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXY_AlbumDetailUserUserId fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kZXY_AlbumDetailUserByAttention fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kZXY_AlbumDetailUserAlbumCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_AlbumDetailUserAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXY_AlbumDetailUserNickName];
    [mutableDict setValue:self.attention forKey:kZXY_AlbumDetailUserAttention];
    [mutableDict setValue:self.score forKey:kZXY_AlbumDetailUserScore];
    [mutableDict setValue:self.headImage forKey:kZXY_AlbumDetailUserHeadImage];
    [mutableDict setValue:self.role forKey:kZXY_AlbumDetailUserRole];
    [mutableDict setValue:self.userId forKey:kZXY_AlbumDetailUserUserId];
    [mutableDict setValue:self.byAttention forKey:kZXY_AlbumDetailUserByAttention];
    [mutableDict setValue:self.albumCount forKey:kZXY_AlbumDetailUserAlbumCount];
    [mutableDict setValue:self.addTime forKey:kZXY_AlbumDetailUserAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserNickName];
    self.attention = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserAttention];
    self.score = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserScore];
    self.headImage = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserHeadImage];
    self.role = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserRole];
    self.userId = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserUserId];
    self.byAttention = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserByAttention];
    self.albumCount = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserAlbumCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_AlbumDetailUserAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXY_AlbumDetailUserNickName];
    [aCoder encodeObject:_attention forKey:kZXY_AlbumDetailUserAttention];
    [aCoder encodeObject:_score forKey:kZXY_AlbumDetailUserScore];
    [aCoder encodeObject:_headImage forKey:kZXY_AlbumDetailUserHeadImage];
    [aCoder encodeObject:_role forKey:kZXY_AlbumDetailUserRole];
    [aCoder encodeObject:_userId forKey:kZXY_AlbumDetailUserUserId];
    [aCoder encodeObject:_byAttention forKey:kZXY_AlbumDetailUserByAttention];
    [aCoder encodeObject:_albumCount forKey:kZXY_AlbumDetailUserAlbumCount];
    [aCoder encodeObject:_addTime forKey:kZXY_AlbumDetailUserAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumDetailUser *copy = [[ZXY_AlbumDetailUser alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.attention = [self.attention copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
