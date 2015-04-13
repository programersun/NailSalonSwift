//
//  ZXY_AlbumCommentData.m
//
//  Created by   on 15/4/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumCommentData.h"


NSString *const kZXY_AlbumCommentDataNickName = @"nick_name";
NSString *const kZXY_AlbumCommentDataAddTime = @"add_time";
NSString *const kZXY_AlbumCommentDataContent = @"content";
NSString *const kZXY_AlbumCommentDataUserId = @"user_id";
NSString *const kZXY_AlbumCommentDataHeadImage = @"head_image";


@interface ZXY_AlbumCommentData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumCommentData

@synthesize nickName = _nickName;
@synthesize addTime = _addTime;
@synthesize content = _content;
@synthesize userId = _userId;
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
            self.nickName = [self objectOrNilForKey:kZXY_AlbumCommentDataNickName fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_AlbumCommentDataAddTime fromDictionary:dict];
            self.content = [self objectOrNilForKey:kZXY_AlbumCommentDataContent fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXY_AlbumCommentDataUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXY_AlbumCommentDataHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXY_AlbumCommentDataNickName];
    [mutableDict setValue:self.addTime forKey:kZXY_AlbumCommentDataAddTime];
    [mutableDict setValue:self.content forKey:kZXY_AlbumCommentDataContent];
    [mutableDict setValue:self.userId forKey:kZXY_AlbumCommentDataUserId];
    [mutableDict setValue:self.headImage forKey:kZXY_AlbumCommentDataHeadImage];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXY_AlbumCommentDataNickName];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_AlbumCommentDataAddTime];
    self.content = [aDecoder decodeObjectForKey:kZXY_AlbumCommentDataContent];
    self.userId = [aDecoder decodeObjectForKey:kZXY_AlbumCommentDataUserId];
    self.headImage = [aDecoder decodeObjectForKey:kZXY_AlbumCommentDataHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXY_AlbumCommentDataNickName];
    [aCoder encodeObject:_addTime forKey:kZXY_AlbumCommentDataAddTime];
    [aCoder encodeObject:_content forKey:kZXY_AlbumCommentDataContent];
    [aCoder encodeObject:_userId forKey:kZXY_AlbumCommentDataUserId];
    [aCoder encodeObject:_headImage forKey:kZXY_AlbumCommentDataHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumCommentData *copy = [[ZXY_AlbumCommentData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
