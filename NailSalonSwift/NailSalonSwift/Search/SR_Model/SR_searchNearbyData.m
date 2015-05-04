//
//  SR_searchNearbyData.m
//
//  Created by sun  on 15/4/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchNearbyData.h"
#import "SR_searchNearbyImage.h"


NSString *const kSR_searchNearbyDataP = @"p";
NSString *const kSR_searchNearbyDataHeadImage = @"head_image";
NSString *const kSR_searchNearbyDataLongitude = @"longitude";
NSString *const kSR_searchNearbyDataNickName = @"nick_name";
NSString *const kSR_searchNearbyDataLatitude = @"latitude";
NSString *const kSR_searchNearbyDataUserId = @"user_id";
NSString *const kSR_searchNearbyDataAlbumCount = @"album_count";
NSString *const kSR_searchNearbyDataImage = @"image";
NSString *const kSR_searchNearbyDataRole = @"role";
NSString *const kSR_searchNearbyDataScore = @"score";
NSString *const kSR_searchNearbyDataIsPass = @"is_pass";
NSString *const kSR_searchNearbyDataIsAttention = @"is_attention";


@interface SR_searchNearbyData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchNearbyData

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
            self.p = [self objectOrNilForKey:kSR_searchNearbyDataP fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_searchNearbyDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kSR_searchNearbyDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kSR_searchNearbyDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kSR_searchNearbyDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_searchNearbyDataUserId fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kSR_searchNearbyDataAlbumCount fromDictionary:dict];
    NSObject *receivedSR_searchNearbyImage = [dict objectForKey:kSR_searchNearbyDataImage];
    NSMutableArray *parsedSR_searchNearbyImage = [NSMutableArray array];
    if ([receivedSR_searchNearbyImage isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_searchNearbyImage) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_searchNearbyImage addObject:[SR_searchNearbyImage modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_searchNearbyImage isKindOfClass:[NSDictionary class]]) {
       [parsedSR_searchNearbyImage addObject:[SR_searchNearbyImage modelObjectWithDictionary:(NSDictionary *)receivedSR_searchNearbyImage]];
    }

    self.image = [NSArray arrayWithArray:parsedSR_searchNearbyImage];
            self.role = [self objectOrNilForKey:kSR_searchNearbyDataRole fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_searchNearbyDataScore fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kSR_searchNearbyDataIsPass fromDictionary:dict];
            self.isAttention = [[self objectOrNilForKey:kSR_searchNearbyDataIsAttention fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.p forKey:kSR_searchNearbyDataP];
    [mutableDict setValue:self.headImage forKey:kSR_searchNearbyDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kSR_searchNearbyDataLongitude];
    [mutableDict setValue:self.nickName forKey:kSR_searchNearbyDataNickName];
    [mutableDict setValue:self.latitude forKey:kSR_searchNearbyDataLatitude];
    [mutableDict setValue:self.userId forKey:kSR_searchNearbyDataUserId];
    [mutableDict setValue:self.albumCount forKey:kSR_searchNearbyDataAlbumCount];
    NSMutableArray *tempArrayForImage = [NSMutableArray array];
    for (NSObject *subArrayObject in self.image) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImage addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImage addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImage] forKey:kSR_searchNearbyDataImage];
    [mutableDict setValue:self.role forKey:kSR_searchNearbyDataRole];
    [mutableDict setValue:self.score forKey:kSR_searchNearbyDataScore];
    [mutableDict setValue:self.isPass forKey:kSR_searchNearbyDataIsPass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAttention] forKey:kSR_searchNearbyDataIsAttention];

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

    self.p = [aDecoder decodeObjectForKey:kSR_searchNearbyDataP];
    self.headImage = [aDecoder decodeObjectForKey:kSR_searchNearbyDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kSR_searchNearbyDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kSR_searchNearbyDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kSR_searchNearbyDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kSR_searchNearbyDataUserId];
    self.albumCount = [aDecoder decodeObjectForKey:kSR_searchNearbyDataAlbumCount];
    self.image = [aDecoder decodeObjectForKey:kSR_searchNearbyDataImage];
    self.role = [aDecoder decodeObjectForKey:kSR_searchNearbyDataRole];
    self.score = [aDecoder decodeObjectForKey:kSR_searchNearbyDataScore];
    self.isPass = [aDecoder decodeObjectForKey:kSR_searchNearbyDataIsPass];
    self.isAttention = [aDecoder decodeDoubleForKey:kSR_searchNearbyDataIsAttention];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_p forKey:kSR_searchNearbyDataP];
    [aCoder encodeObject:_headImage forKey:kSR_searchNearbyDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kSR_searchNearbyDataLongitude];
    [aCoder encodeObject:_nickName forKey:kSR_searchNearbyDataNickName];
    [aCoder encodeObject:_latitude forKey:kSR_searchNearbyDataLatitude];
    [aCoder encodeObject:_userId forKey:kSR_searchNearbyDataUserId];
    [aCoder encodeObject:_albumCount forKey:kSR_searchNearbyDataAlbumCount];
    [aCoder encodeObject:_image forKey:kSR_searchNearbyDataImage];
    [aCoder encodeObject:_role forKey:kSR_searchNearbyDataRole];
    [aCoder encodeObject:_score forKey:kSR_searchNearbyDataScore];
    [aCoder encodeObject:_isPass forKey:kSR_searchNearbyDataIsPass];
    [aCoder encodeDouble:_isAttention forKey:kSR_searchNearbyDataIsAttention];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchNearbyData *copy = [[SR_searchNearbyData alloc] init];
    
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
