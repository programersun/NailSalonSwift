//
//  SR_searchUserData.m
//
//  Created by sun  on 15/4/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchUserData.h"


NSString *const kSR_searchUserDataP = @"p";
NSString *const kSR_searchUserDataHeadImage = @"head_image";
NSString *const kSR_searchUserDataLongitude = @"longitude";
NSString *const kSR_searchUserDataNickName = @"nick_name";
NSString *const kSR_searchUserDataLatitude = @"latitude";
NSString *const kSR_searchUserDataUserId = @"user_id";
NSString *const kSR_searchUserDataAlbumCount = @"album_count";
NSString *const kSR_searchUserDataImage = @"image";
NSString *const kSR_searchUserDataRole = @"role";
NSString *const kSR_searchUserDataScore = @"score";
NSString *const kSR_searchUserDataIsPass = @"is_pass";
NSString *const kSR_searchUserDataIsAttention = @"is_attention";


@interface SR_searchUserData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchUserData

@synthesize p = _p;
@synthesize headImage = _headImage;
@synthesize longitude = _longitude;
@synthesize nickName = _nickName;
@synthesize latitude = _latitude;
@synthesize userId = _userId;
@synthesize albumCount = _albumCount;
@synthesize image = _image;
@synthesize role = _role;
@synthesize score = _score;
@synthesize isPass = _isPass;
@synthesize isAttention = _isAttention;


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
            self.p = [self objectOrNilForKey:kSR_searchUserDataP fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_searchUserDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kSR_searchUserDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kSR_searchUserDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kSR_searchUserDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_searchUserDataUserId fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kSR_searchUserDataAlbumCount fromDictionary:dict];
            self.image = [self objectOrNilForKey:kSR_searchUserDataImage fromDictionary:dict];
            self.role = [self objectOrNilForKey:kSR_searchUserDataRole fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_searchUserDataScore fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kSR_searchUserDataIsPass fromDictionary:dict];
            self.isAttention = [[self objectOrNilForKey:kSR_searchUserDataIsAttention fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.p forKey:kSR_searchUserDataP];
    [mutableDict setValue:self.headImage forKey:kSR_searchUserDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kSR_searchUserDataLongitude];
    [mutableDict setValue:self.nickName forKey:kSR_searchUserDataNickName];
    [mutableDict setValue:self.latitude forKey:kSR_searchUserDataLatitude];
    [mutableDict setValue:self.userId forKey:kSR_searchUserDataUserId];
    [mutableDict setValue:self.albumCount forKey:kSR_searchUserDataAlbumCount];
    [mutableDict setValue:self.image forKey:kSR_searchUserDataImage];
    [mutableDict setValue:self.role forKey:kSR_searchUserDataRole];
    [mutableDict setValue:self.score forKey:kSR_searchUserDataScore];
    [mutableDict setValue:self.isPass forKey:kSR_searchUserDataIsPass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAttention] forKey:kSR_searchUserDataIsAttention];

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

    self.p = [aDecoder decodeObjectForKey:kSR_searchUserDataP];
    self.headImage = [aDecoder decodeObjectForKey:kSR_searchUserDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kSR_searchUserDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kSR_searchUserDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kSR_searchUserDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kSR_searchUserDataUserId];
    self.albumCount = [aDecoder decodeObjectForKey:kSR_searchUserDataAlbumCount];
    self.image = [aDecoder decodeObjectForKey:kSR_searchUserDataImage];
    self.role = [aDecoder decodeObjectForKey:kSR_searchUserDataRole];
    self.score = [aDecoder decodeObjectForKey:kSR_searchUserDataScore];
    self.isPass = [aDecoder decodeObjectForKey:kSR_searchUserDataIsPass];
    self.isAttention = [aDecoder decodeDoubleForKey:kSR_searchUserDataIsAttention];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_p forKey:kSR_searchUserDataP];
    [aCoder encodeObject:_headImage forKey:kSR_searchUserDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kSR_searchUserDataLongitude];
    [aCoder encodeObject:_nickName forKey:kSR_searchUserDataNickName];
    [aCoder encodeObject:_latitude forKey:kSR_searchUserDataLatitude];
    [aCoder encodeObject:_userId forKey:kSR_searchUserDataUserId];
    [aCoder encodeObject:_albumCount forKey:kSR_searchUserDataAlbumCount];
    [aCoder encodeObject:_image forKey:kSR_searchUserDataImage];
    [aCoder encodeObject:_role forKey:kSR_searchUserDataRole];
    [aCoder encodeObject:_score forKey:kSR_searchUserDataScore];
    [aCoder encodeObject:_isPass forKey:kSR_searchUserDataIsPass];
    [aCoder encodeDouble:_isAttention forKey:kSR_searchUserDataIsAttention];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchUserData *copy = [[SR_searchUserData alloc] init];
    
    if (copy) {

        copy.p = [self.p copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.isPass = [self.isPass copyWithZone:zone];
        copy.isAttention = self.isAttention;
    }
    
    return copy;
}


@end
