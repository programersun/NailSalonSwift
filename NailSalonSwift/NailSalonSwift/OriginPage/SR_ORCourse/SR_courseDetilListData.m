//
//  SR_courseDetilListData.m
//
//  Created by sun  on 15/4/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_courseDetilListData.h"


NSString *const kSR_courseDetilListDataImgPath = @"img_path";
NSString *const kSR_courseDetilListDataId = @"id";
NSString *const kSR_courseDetilListDataTitle = @"title";
NSString *const kSR_courseDetilListDataStarNum = @"star_num";
NSString *const kSR_courseDetilListDataDesc = @"desc";
NSString *const kSR_courseDetilListDataCollectNum = @"collect_num";


@interface SR_courseDetilListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_courseDetilListData

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
            self.imgPath = [self objectOrNilForKey:kSR_courseDetilListDataImgPath fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kSR_courseDetilListDataId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kSR_courseDetilListDataTitle fromDictionary:dict];
            self.starNum = [self objectOrNilForKey:kSR_courseDetilListDataStarNum fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kSR_courseDetilListDataDesc fromDictionary:dict];
            self.collectNum = [self objectOrNilForKey:kSR_courseDetilListDataCollectNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imgPath forKey:kSR_courseDetilListDataImgPath];
    [mutableDict setValue:self.dataIdentifier forKey:kSR_courseDetilListDataId];
    [mutableDict setValue:self.title forKey:kSR_courseDetilListDataTitle];
    [mutableDict setValue:self.starNum forKey:kSR_courseDetilListDataStarNum];
    [mutableDict setValue:self.desc forKey:kSR_courseDetilListDataDesc];
    [mutableDict setValue:self.collectNum forKey:kSR_courseDetilListDataCollectNum];

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

    self.imgPath = [aDecoder decodeObjectForKey:kSR_courseDetilListDataImgPath];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kSR_courseDetilListDataId];
    self.title = [aDecoder decodeObjectForKey:kSR_courseDetilListDataTitle];
    self.starNum = [aDecoder decodeObjectForKey:kSR_courseDetilListDataStarNum];
    self.desc = [aDecoder decodeObjectForKey:kSR_courseDetilListDataDesc];
    self.collectNum = [aDecoder decodeObjectForKey:kSR_courseDetilListDataCollectNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imgPath forKey:kSR_courseDetilListDataImgPath];
    [aCoder encodeObject:_dataIdentifier forKey:kSR_courseDetilListDataId];
    [aCoder encodeObject:_title forKey:kSR_courseDetilListDataTitle];
    [aCoder encodeObject:_starNum forKey:kSR_courseDetilListDataStarNum];
    [aCoder encodeObject:_desc forKey:kSR_courseDetilListDataDesc];
    [aCoder encodeObject:_collectNum forKey:kSR_courseDetilListDataCollectNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_courseDetilListData *copy = [[SR_courseDetilListData alloc] init];
    
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
