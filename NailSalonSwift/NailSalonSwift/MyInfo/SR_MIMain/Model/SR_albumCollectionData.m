//
//  SR_albumCollectionData.m
//
//  Created by sun  on 15/4/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_albumCollectionData.h"


NSString *const kSR_albumCollectionDataNickName = @"nick_name";
NSString *const kSR_albumCollectionDataAlbumId = @"album_id";
NSString *const kSR_albumCollectionDataHeadImage = @"head_image";
NSString *const kSR_albumCollectionDataAddTime = @"add_time";
NSString *const kSR_albumCollectionDataCutPath = @"cut_path";
NSString *const kSR_albumCollectionDataUserId = @"user_id";
NSString *const kSR_albumCollectionDataDescription = @"description";
NSString *const kSR_albumCollectionDataCutWidth = @"cut_width";
NSString *const kSR_albumCollectionDataAgreeCount = @"agree_count";
NSString *const kSR_albumCollectionDataCutHeight = @"cut_height";


@interface SR_albumCollectionData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_albumCollectionData

@synthesize nickName = _nickName;
@synthesize albumId = _albumId;
@synthesize headImage = _headImage;
@synthesize addTime = _addTime;
@synthesize cutPath = _cutPath;
@synthesize userId = _userId;
@synthesize dataDescription = _dataDescription;
@synthesize cutWidth = _cutWidth;
@synthesize agreeCount = _agreeCount;
@synthesize cutHeight = _cutHeight;


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
            self.nickName = [self objectOrNilForKey:kSR_albumCollectionDataNickName fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kSR_albumCollectionDataAlbumId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_albumCollectionDataHeadImage fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kSR_albumCollectionDataAddTime fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kSR_albumCollectionDataCutPath fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_albumCollectionDataUserId fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kSR_albumCollectionDataDescription fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kSR_albumCollectionDataCutWidth fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kSR_albumCollectionDataAgreeCount fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kSR_albumCollectionDataCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kSR_albumCollectionDataNickName];
    [mutableDict setValue:self.albumId forKey:kSR_albumCollectionDataAlbumId];
    [mutableDict setValue:self.headImage forKey:kSR_albumCollectionDataHeadImage];
    [mutableDict setValue:self.addTime forKey:kSR_albumCollectionDataAddTime];
    [mutableDict setValue:self.cutPath forKey:kSR_albumCollectionDataCutPath];
    [mutableDict setValue:self.userId forKey:kSR_albumCollectionDataUserId];
    [mutableDict setValue:self.dataDescription forKey:kSR_albumCollectionDataDescription];
    [mutableDict setValue:self.cutWidth forKey:kSR_albumCollectionDataCutWidth];
    [mutableDict setValue:self.agreeCount forKey:kSR_albumCollectionDataAgreeCount];
    [mutableDict setValue:self.cutHeight forKey:kSR_albumCollectionDataCutHeight];

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

    self.nickName = [aDecoder decodeObjectForKey:kSR_albumCollectionDataNickName];
    self.albumId = [aDecoder decodeObjectForKey:kSR_albumCollectionDataAlbumId];
    self.headImage = [aDecoder decodeObjectForKey:kSR_albumCollectionDataHeadImage];
    self.addTime = [aDecoder decodeObjectForKey:kSR_albumCollectionDataAddTime];
    self.cutPath = [aDecoder decodeObjectForKey:kSR_albumCollectionDataCutPath];
    self.userId = [aDecoder decodeObjectForKey:kSR_albumCollectionDataUserId];
    self.dataDescription = [aDecoder decodeObjectForKey:kSR_albumCollectionDataDescription];
    self.cutWidth = [aDecoder decodeObjectForKey:kSR_albumCollectionDataCutWidth];
    self.agreeCount = [aDecoder decodeObjectForKey:kSR_albumCollectionDataAgreeCount];
    self.cutHeight = [aDecoder decodeObjectForKey:kSR_albumCollectionDataCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kSR_albumCollectionDataNickName];
    [aCoder encodeObject:_albumId forKey:kSR_albumCollectionDataAlbumId];
    [aCoder encodeObject:_headImage forKey:kSR_albumCollectionDataHeadImage];
    [aCoder encodeObject:_addTime forKey:kSR_albumCollectionDataAddTime];
    [aCoder encodeObject:_cutPath forKey:kSR_albumCollectionDataCutPath];
    [aCoder encodeObject:_userId forKey:kSR_albumCollectionDataUserId];
    [aCoder encodeObject:_dataDescription forKey:kSR_albumCollectionDataDescription];
    [aCoder encodeObject:_cutWidth forKey:kSR_albumCollectionDataCutWidth];
    [aCoder encodeObject:_agreeCount forKey:kSR_albumCollectionDataAgreeCount];
    [aCoder encodeObject:_cutHeight forKey:kSR_albumCollectionDataCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_albumCollectionData *copy = [[SR_albumCollectionData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
