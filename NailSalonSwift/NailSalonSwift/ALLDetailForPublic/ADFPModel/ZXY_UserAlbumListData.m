//
//  ZXY_UserAlbumListData.m
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserAlbumListData.h"


NSString *const kZXY_UserAlbumListDataDescription = @"description";
NSString *const kZXY_UserAlbumListDataIsWarn = @"is_warn";
NSString *const kZXY_UserAlbumListDataCollectCount = @"collect_count";
NSString *const kZXY_UserAlbumListDataCutPath = @"cut_path";
NSString *const kZXY_UserAlbumListDataWidth = @"width";
NSString *const kZXY_UserAlbumListDataImgCount = @"img_count";
NSString *const kZXY_UserAlbumListDataUserId = @"user_id";
NSString *const kZXY_UserAlbumListDataCutHeight = @"cut_height";
NSString *const kZXY_UserAlbumListDataIsFirst = @"is_first";
NSString *const kZXY_UserAlbumListDataImageId = @"image_id";
NSString *const kZXY_UserAlbumListDataCutWidth = @"cut_width";
NSString *const kZXY_UserAlbumListDataAgreeCount = @"agree_count";
NSString *const kZXY_UserAlbumListDataHeight = @"height";
NSString *const kZXY_UserAlbumListDataImagePath = @"image_path";
NSString *const kZXY_UserAlbumListDataAddTime = @"add_time";
NSString *const kZXY_UserAlbumListDataAlbumId = @"album_id";
NSString *const kZXY_UserAlbumListDataIsRecommend = @"is_recommend";


@interface ZXY_UserAlbumListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserAlbumListData

@synthesize dataDescription = _dataDescription;
@synthesize isWarn = _isWarn;
@synthesize collectCount = _collectCount;
@synthesize cutPath = _cutPath;
@synthesize width = _width;
@synthesize imgCount = _imgCount;
@synthesize userId = _userId;
@synthesize cutHeight = _cutHeight;
@synthesize isFirst = _isFirst;
@synthesize imageId = _imageId;
@synthesize cutWidth = _cutWidth;
@synthesize agreeCount = _agreeCount;
@synthesize height = _height;
@synthesize imagePath = _imagePath;
@synthesize addTime = _addTime;
@synthesize albumId = _albumId;
@synthesize isRecommend = _isRecommend;


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
            self.dataDescription = [self objectOrNilForKey:kZXY_UserAlbumListDataDescription fromDictionary:dict];
            self.isWarn = [self objectOrNilForKey:kZXY_UserAlbumListDataIsWarn fromDictionary:dict];
            self.collectCount = [self objectOrNilForKey:kZXY_UserAlbumListDataCollectCount fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXY_UserAlbumListDataCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kZXY_UserAlbumListDataWidth fromDictionary:dict];
            self.imgCount = [self objectOrNilForKey:kZXY_UserAlbumListDataImgCount fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXY_UserAlbumListDataUserId fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXY_UserAlbumListDataCutHeight fromDictionary:dict];
            self.isFirst = [self objectOrNilForKey:kZXY_UserAlbumListDataIsFirst fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kZXY_UserAlbumListDataImageId fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kZXY_UserAlbumListDataCutWidth fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kZXY_UserAlbumListDataAgreeCount fromDictionary:dict];
            self.height = [self objectOrNilForKey:kZXY_UserAlbumListDataHeight fromDictionary:dict];
            self.imagePath = [self objectOrNilForKey:kZXY_UserAlbumListDataImagePath fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_UserAlbumListDataAddTime fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXY_UserAlbumListDataAlbumId fromDictionary:dict];
            self.isRecommend = [self objectOrNilForKey:kZXY_UserAlbumListDataIsRecommend fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataDescription forKey:kZXY_UserAlbumListDataDescription];
    [mutableDict setValue:self.isWarn forKey:kZXY_UserAlbumListDataIsWarn];
    [mutableDict setValue:self.collectCount forKey:kZXY_UserAlbumListDataCollectCount];
    [mutableDict setValue:self.cutPath forKey:kZXY_UserAlbumListDataCutPath];
    [mutableDict setValue:self.width forKey:kZXY_UserAlbumListDataWidth];
    [mutableDict setValue:self.imgCount forKey:kZXY_UserAlbumListDataImgCount];
    [mutableDict setValue:self.userId forKey:kZXY_UserAlbumListDataUserId];
    [mutableDict setValue:self.cutHeight forKey:kZXY_UserAlbumListDataCutHeight];
    [mutableDict setValue:self.isFirst forKey:kZXY_UserAlbumListDataIsFirst];
    [mutableDict setValue:self.imageId forKey:kZXY_UserAlbumListDataImageId];
    [mutableDict setValue:self.cutWidth forKey:kZXY_UserAlbumListDataCutWidth];
    [mutableDict setValue:self.agreeCount forKey:kZXY_UserAlbumListDataAgreeCount];
    [mutableDict setValue:self.height forKey:kZXY_UserAlbumListDataHeight];
    [mutableDict setValue:self.imagePath forKey:kZXY_UserAlbumListDataImagePath];
    [mutableDict setValue:self.addTime forKey:kZXY_UserAlbumListDataAddTime];
    [mutableDict setValue:self.albumId forKey:kZXY_UserAlbumListDataAlbumId];
    [mutableDict setValue:self.isRecommend forKey:kZXY_UserAlbumListDataIsRecommend];

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
    return [object isEqual:[NSNull null]] ? @"" : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.dataDescription = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataDescription];
    self.isWarn = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataIsWarn];
    self.collectCount = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataCollectCount];
    self.cutPath = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataCutPath];
    self.width = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataWidth];
    self.imgCount = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataImgCount];
    self.userId = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataUserId];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataCutHeight];
    self.isFirst = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataIsFirst];
    self.imageId = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataImageId];
    self.cutWidth = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataCutWidth];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataAgreeCount];
    self.height = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataHeight];
    self.imagePath = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataImagePath];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataAddTime];
    self.albumId = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataAlbumId];
    self.isRecommend = [aDecoder decodeObjectForKey:kZXY_UserAlbumListDataIsRecommend];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dataDescription forKey:kZXY_UserAlbumListDataDescription];
    [aCoder encodeObject:_isWarn forKey:kZXY_UserAlbumListDataIsWarn];
    [aCoder encodeObject:_collectCount forKey:kZXY_UserAlbumListDataCollectCount];
    [aCoder encodeObject:_cutPath forKey:kZXY_UserAlbumListDataCutPath];
    [aCoder encodeObject:_width forKey:kZXY_UserAlbumListDataWidth];
    [aCoder encodeObject:_imgCount forKey:kZXY_UserAlbumListDataImgCount];
    [aCoder encodeObject:_userId forKey:kZXY_UserAlbumListDataUserId];
    [aCoder encodeObject:_cutHeight forKey:kZXY_UserAlbumListDataCutHeight];
    [aCoder encodeObject:_isFirst forKey:kZXY_UserAlbumListDataIsFirst];
    [aCoder encodeObject:_imageId forKey:kZXY_UserAlbumListDataImageId];
    [aCoder encodeObject:_cutWidth forKey:kZXY_UserAlbumListDataCutWidth];
    [aCoder encodeObject:_agreeCount forKey:kZXY_UserAlbumListDataAgreeCount];
    [aCoder encodeObject:_height forKey:kZXY_UserAlbumListDataHeight];
    [aCoder encodeObject:_imagePath forKey:kZXY_UserAlbumListDataImagePath];
    [aCoder encodeObject:_addTime forKey:kZXY_UserAlbumListDataAddTime];
    [aCoder encodeObject:_albumId forKey:kZXY_UserAlbumListDataAlbumId];
    [aCoder encodeObject:_isRecommend forKey:kZXY_UserAlbumListDataIsRecommend];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserAlbumListData *copy = [[ZXY_UserAlbumListData alloc] init];
    
    if (copy) {

        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.isWarn = [self.isWarn copyWithZone:zone];
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.imgCount = [self.imgCount copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.isFirst = [self.isFirst copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.isRecommend = [self.isRecommend copyWithZone:zone];
    }
    
    return copy;
}


@end
