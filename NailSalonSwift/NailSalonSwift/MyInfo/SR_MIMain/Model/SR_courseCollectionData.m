//
//  SR_courseCollectionData.m
//
//  Created by sun  on 15/4/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_courseCollectionData.h"


NSString *const kSR_courseCollectionDataImgPath = @"img_path";
NSString *const kSR_courseCollectionDataId = @"id";
NSString *const kSR_courseCollectionDataTitle = @"title";
NSString *const kSR_courseCollectionDataStarNum = @"star_num";
NSString *const kSR_courseCollectionDataDesc = @"desc";
NSString *const kSR_courseCollectionDataCollectNum = @"collect_num";


@interface SR_courseCollectionData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_courseCollectionData

@synthesize imgPath = _imgPath;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize title = _title;
@synthesize starNum = _starNum;
@synthesize desc = _desc;
@synthesize collectNum = _collectNum;


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
            self.imgPath = [self objectOrNilForKey:kSR_courseCollectionDataImgPath fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kSR_courseCollectionDataId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kSR_courseCollectionDataTitle fromDictionary:dict];
            self.starNum = [self objectOrNilForKey:kSR_courseCollectionDataStarNum fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kSR_courseCollectionDataDesc fromDictionary:dict];
            self.collectNum = [self objectOrNilForKey:kSR_courseCollectionDataCollectNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imgPath forKey:kSR_courseCollectionDataImgPath];
    [mutableDict setValue:self.dataIdentifier forKey:kSR_courseCollectionDataId];
    [mutableDict setValue:self.title forKey:kSR_courseCollectionDataTitle];
    [mutableDict setValue:self.starNum forKey:kSR_courseCollectionDataStarNum];
    [mutableDict setValue:self.desc forKey:kSR_courseCollectionDataDesc];
    [mutableDict setValue:self.collectNum forKey:kSR_courseCollectionDataCollectNum];

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

    self.imgPath = [aDecoder decodeObjectForKey:kSR_courseCollectionDataImgPath];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kSR_courseCollectionDataId];
    self.title = [aDecoder decodeObjectForKey:kSR_courseCollectionDataTitle];
    self.starNum = [aDecoder decodeObjectForKey:kSR_courseCollectionDataStarNum];
    self.desc = [aDecoder decodeObjectForKey:kSR_courseCollectionDataDesc];
    self.collectNum = [aDecoder decodeObjectForKey:kSR_courseCollectionDataCollectNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imgPath forKey:kSR_courseCollectionDataImgPath];
    [aCoder encodeObject:_dataIdentifier forKey:kSR_courseCollectionDataId];
    [aCoder encodeObject:_title forKey:kSR_courseCollectionDataTitle];
    [aCoder encodeObject:_starNum forKey:kSR_courseCollectionDataStarNum];
    [aCoder encodeObject:_desc forKey:kSR_courseCollectionDataDesc];
    [aCoder encodeObject:_collectNum forKey:kSR_courseCollectionDataCollectNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_courseCollectionData *copy = [[SR_courseCollectionData alloc] init];
    
    if (copy) {

        copy.imgPath = [self.imgPath copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.starNum = [self.starNum copyWithZone:zone];
        copy.desc = [self.desc copyWithZone:zone];
        copy.collectNum = [self.collectNum copyWithZone:zone];
    }
    
    return copy;
}


@end
