//
//  ZXY_AlbumDetailData.m
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumDetailData.h"
#import "ZXY_AlbumDetailImages.h"
#import "ZXY_AlbumDetailUser.h"


NSString *const kZXY_AlbumDetailDataDescription = @"description";
NSString *const kZXY_AlbumDetailDataIsCollect = @"is_collect";
NSString *const kZXY_AlbumDetailDataCollectCount = @"collect_count";
NSString *const kZXY_AlbumDetailDataImgCount = @"img_count";
NSString *const kZXY_AlbumDetailDataUserId = @"user_id";
NSString *const kZXY_AlbumDetailDataPrice = @"price";
NSString *const kZXY_AlbumDetailDataTag = @"tag";
NSString *const kZXY_AlbumDetailDataIsAtten = @"is_atten";
NSString *const kZXY_AlbumDetailDataAgreeCount = @"agree_count";
NSString *const kZXY_AlbumDetailDataImages = @"images";
NSString *const kZXY_AlbumDetailDataIsAgree = @"is_agree";
NSString *const kZXY_AlbumDetailDataAddTime = @"add_time";
NSString *const kZXY_AlbumDetailDataAlbumId = @"album_id";
NSString *const kZXY_AlbumDetailDataUser = @"user";


@interface ZXY_AlbumDetailData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumDetailData

@synthesize dataDescription = _dataDescription;
@synthesize isCollect = _isCollect;
@synthesize collectCount = _collectCount;
@synthesize imgCount = _imgCount;
@synthesize userId = _userId;
@synthesize price = _price;
@synthesize tag = _tag;
@synthesize isAtten = _isAtten;
@synthesize agreeCount = _agreeCount;
@synthesize images = _images;
@synthesize isAgree = _isAgree;
@synthesize addTime = _addTime;
@synthesize albumId = _albumId;
@synthesize user = _user;


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
            self.dataDescription = [self objectOrNilForKey:kZXY_AlbumDetailDataDescription fromDictionary:dict];
            self.isCollect = [[self objectOrNilForKey:kZXY_AlbumDetailDataIsCollect fromDictionary:dict] doubleValue];
            self.collectCount = [self objectOrNilForKey:kZXY_AlbumDetailDataCollectCount fromDictionary:dict];
            self.imgCount = [self objectOrNilForKey:kZXY_AlbumDetailDataImgCount fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXY_AlbumDetailDataUserId fromDictionary:dict];
            self.price = [self objectOrNilForKey:kZXY_AlbumDetailDataPrice fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kZXY_AlbumDetailDataTag fromDictionary:dict];
            self.isAtten = [[self objectOrNilForKey:kZXY_AlbumDetailDataIsAtten fromDictionary:dict] doubleValue];
            self.agreeCount = [self objectOrNilForKey:kZXY_AlbumDetailDataAgreeCount fromDictionary:dict];
    NSObject *receivedZXY_AlbumDetailImages = [dict objectForKey:kZXY_AlbumDetailDataImages];
    NSMutableArray *parsedZXY_AlbumDetailImages = [NSMutableArray array];
    if ([receivedZXY_AlbumDetailImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXY_AlbumDetailImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXY_AlbumDetailImages addObject:[ZXY_AlbumDetailImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXY_AlbumDetailImages isKindOfClass:[NSDictionary class]]) {
       [parsedZXY_AlbumDetailImages addObject:[ZXY_AlbumDetailImages modelObjectWithDictionary:(NSDictionary *)receivedZXY_AlbumDetailImages]];
    }

    self.images = [NSArray arrayWithArray:parsedZXY_AlbumDetailImages];
            self.isAgree = [[self objectOrNilForKey:kZXY_AlbumDetailDataIsAgree fromDictionary:dict] doubleValue];
            self.addTime = [self objectOrNilForKey:kZXY_AlbumDetailDataAddTime fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXY_AlbumDetailDataAlbumId fromDictionary:dict];
            self.user = [ZXY_AlbumDetailUser modelObjectWithDictionary:[dict objectForKey:kZXY_AlbumDetailDataUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataDescription forKey:kZXY_AlbumDetailDataDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCollect] forKey:kZXY_AlbumDetailDataIsCollect];
    [mutableDict setValue:self.collectCount forKey:kZXY_AlbumDetailDataCollectCount];
    [mutableDict setValue:self.imgCount forKey:kZXY_AlbumDetailDataImgCount];
    [mutableDict setValue:self.userId forKey:kZXY_AlbumDetailDataUserId];
    [mutableDict setValue:self.price forKey:kZXY_AlbumDetailDataPrice];
    [mutableDict setValue:self.tag forKey:kZXY_AlbumDetailDataTag];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAtten] forKey:kZXY_AlbumDetailDataIsAtten];
    [mutableDict setValue:self.agreeCount forKey:kZXY_AlbumDetailDataAgreeCount];
    NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kZXY_AlbumDetailDataImages];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAgree] forKey:kZXY_AlbumDetailDataIsAgree];
    [mutableDict setValue:self.addTime forKey:kZXY_AlbumDetailDataAddTime];
    [mutableDict setValue:self.albumId forKey:kZXY_AlbumDetailDataAlbumId];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kZXY_AlbumDetailDataUser];

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

    self.dataDescription = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataDescription];
    self.isCollect = [aDecoder decodeDoubleForKey:kZXY_AlbumDetailDataIsCollect];
    self.collectCount = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataCollectCount];
    self.imgCount = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataImgCount];
    self.userId = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataUserId];
    self.price = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataPrice];
    self.tag = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataTag];
    self.isAtten = [aDecoder decodeDoubleForKey:kZXY_AlbumDetailDataIsAtten];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataAgreeCount];
    self.images = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataImages];
    self.isAgree = [aDecoder decodeDoubleForKey:kZXY_AlbumDetailDataIsAgree];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataAddTime];
    self.albumId = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataAlbumId];
    self.user = [aDecoder decodeObjectForKey:kZXY_AlbumDetailDataUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dataDescription forKey:kZXY_AlbumDetailDataDescription];
    [aCoder encodeDouble:_isCollect forKey:kZXY_AlbumDetailDataIsCollect];
    [aCoder encodeObject:_collectCount forKey:kZXY_AlbumDetailDataCollectCount];
    [aCoder encodeObject:_imgCount forKey:kZXY_AlbumDetailDataImgCount];
    [aCoder encodeObject:_userId forKey:kZXY_AlbumDetailDataUserId];
    [aCoder encodeObject:_price forKey:kZXY_AlbumDetailDataPrice];
    [aCoder encodeObject:_tag forKey:kZXY_AlbumDetailDataTag];
    [aCoder encodeDouble:_isAtten forKey:kZXY_AlbumDetailDataIsAtten];
    [aCoder encodeObject:_agreeCount forKey:kZXY_AlbumDetailDataAgreeCount];
    [aCoder encodeObject:_images forKey:kZXY_AlbumDetailDataImages];
    [aCoder encodeDouble:_isAgree forKey:kZXY_AlbumDetailDataIsAgree];
    [aCoder encodeObject:_addTime forKey:kZXY_AlbumDetailDataAddTime];
    [aCoder encodeObject:_albumId forKey:kZXY_AlbumDetailDataAlbumId];
    [aCoder encodeObject:_user forKey:kZXY_AlbumDetailDataUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumDetailData *copy = [[ZXY_AlbumDetailData alloc] init];
    
    if (copy) {

        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.isCollect = self.isCollect;
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.imgCount = [self.imgCount copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
        copy.isAtten = self.isAtten;
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.isAgree = self.isAgree;
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
