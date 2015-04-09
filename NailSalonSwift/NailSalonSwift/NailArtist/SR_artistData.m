//
//  SR_artistData.m
//
//  Created by sun  on 15/4/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_artistData.h"


NSString *const kSR_artistDataNickName = @"nick_name";
NSString *const kSR_artistDataScore = @"score";
NSString *const kSR_artistDataP = @"p";
NSString *const kSR_artistDataHeadImage = @"head_image";
NSString *const kSR_artistDataLongitude = @"longitude";
NSString *const kSR_artistDataLatitude = @"latitude";
NSString *const kSR_artistDataUserId = @"user_id";
NSString *const kSR_artistDataByAttention = @"by_attention";
NSString *const kSR_artistDataAlbumCount = @"album_count";
NSString *const kSR_artistDataIsPass = @"is_pass";


@interface SR_artistData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_artistData

@synthesize nickName = _nickName;
@synthesize score = _score;
@synthesize p = _p;
@synthesize headImage = _headImage;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize userId = _userId;
@synthesize byAttention = _byAttention;
@synthesize albumCount = _albumCount;
@synthesize isPass = _isPass;


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
            self.nickName = [self objectOrNilForKey:kSR_artistDataNickName fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_artistDataScore fromDictionary:dict];
            self.p = [self objectOrNilForKey:kSR_artistDataP fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_artistDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kSR_artistDataLongitude fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kSR_artistDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_artistDataUserId fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kSR_artistDataByAttention fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kSR_artistDataAlbumCount fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kSR_artistDataIsPass fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kSR_artistDataNickName];
    [mutableDict setValue:self.score forKey:kSR_artistDataScore];
    [mutableDict setValue:self.p forKey:kSR_artistDataP];
    [mutableDict setValue:self.headImage forKey:kSR_artistDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kSR_artistDataLongitude];
    [mutableDict setValue:self.latitude forKey:kSR_artistDataLatitude];
    [mutableDict setValue:self.userId forKey:kSR_artistDataUserId];
    [mutableDict setValue:self.byAttention forKey:kSR_artistDataByAttention];
    [mutableDict setValue:self.albumCount forKey:kSR_artistDataAlbumCount];
    [mutableDict setValue:self.isPass forKey:kSR_artistDataIsPass];

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

    self.nickName = [aDecoder decodeObjectForKey:kSR_artistDataNickName];
    self.score = [aDecoder decodeObjectForKey:kSR_artistDataScore];
    self.p = [aDecoder decodeObjectForKey:kSR_artistDataP];
    self.headImage = [aDecoder decodeObjectForKey:kSR_artistDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kSR_artistDataLongitude];
    self.latitude = [aDecoder decodeObjectForKey:kSR_artistDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kSR_artistDataUserId];
    self.byAttention = [aDecoder decodeObjectForKey:kSR_artistDataByAttention];
    self.albumCount = [aDecoder decodeObjectForKey:kSR_artistDataAlbumCount];
    self.isPass = [aDecoder decodeObjectForKey:kSR_artistDataIsPass];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kSR_artistDataNickName];
    [aCoder encodeObject:_score forKey:kSR_artistDataScore];
    [aCoder encodeObject:_p forKey:kSR_artistDataP];
    [aCoder encodeObject:_headImage forKey:kSR_artistDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kSR_artistDataLongitude];
    [aCoder encodeObject:_latitude forKey:kSR_artistDataLatitude];
    [aCoder encodeObject:_userId forKey:kSR_artistDataUserId];
    [aCoder encodeObject:_byAttention forKey:kSR_artistDataByAttention];
    [aCoder encodeObject:_albumCount forKey:kSR_artistDataAlbumCount];
    [aCoder encodeObject:_isPass forKey:kSR_artistDataIsPass];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_artistData *copy = [[SR_artistData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.p = [self.p copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.isPass = [self.isPass copyWithZone:zone];
    }
    
    return copy;
}


@end
