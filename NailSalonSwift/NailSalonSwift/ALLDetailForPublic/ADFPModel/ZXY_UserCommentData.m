//
//  testData.m
//
//  Created by   on 15/4/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserCommentData.h"


NSString *const ktestDataHeadImage = @"head_image";
NSString *const ktestDataCutPath = @"cut_path";
NSString *const ktestDataWidth = @"width";
NSString *const ktestDataNickName = @"nick_name";
NSString *const ktestDataUserId = @"user_id";
NSString *const ktestDataComment = @"comment";
NSString *const ktestDataCutHeight = @"cut_height";
NSString *const ktestDataCutWidth = @"cut_width";
NSString *const ktestDataCtime = @"ctime";
NSString *const ktestDataImageId = @"image_id";
NSString *const ktestDataCommentId = @"comment_id";
NSString *const ktestDataHeight = @"height";
NSString *const ktestDataImagePath = @"image_path";
NSString *const ktestDataScore = @"score";
NSString *const ktestDataAddTime = @"add_time";


@interface ZXY_UserCommentData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserCommentData

@synthesize headImage = _headImage;
@synthesize cutPath = _cutPath;
@synthesize width = _width;
@synthesize nickName = _nickName;
@synthesize userId = _userId;
@synthesize comment = _comment;
@synthesize cutHeight = _cutHeight;
@synthesize cutWidth = _cutWidth;
@synthesize ctime = _ctime;
@synthesize imageId = _imageId;
@synthesize commentId = _commentId;
@synthesize height = _height;
@synthesize imagePath = _imagePath;
@synthesize score = _score;
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
        self.headImage = [self objectOrNilForKey:ktestDataHeadImage fromDictionary:dict];
        self.cutPath = [self objectOrNilForKey:ktestDataCutPath fromDictionary:dict];
        self.width = [self objectOrNilForKey:ktestDataWidth fromDictionary:dict];
        self.nickName = [self objectOrNilForKey:ktestDataNickName fromDictionary:dict];
        self.userId = [self objectOrNilForKey:ktestDataUserId fromDictionary:dict];
        self.comment = [self objectOrNilForKey:ktestDataComment fromDictionary:dict];
        self.cutHeight = [self objectOrNilForKey:ktestDataCutHeight fromDictionary:dict];
        self.cutWidth = [self objectOrNilForKey:ktestDataCutWidth fromDictionary:dict];
        self.ctime = [self objectOrNilForKey:ktestDataCtime fromDictionary:dict];
        self.imageId = [self objectOrNilForKey:ktestDataImageId fromDictionary:dict];
        self.commentId = [self objectOrNilForKey:ktestDataCommentId fromDictionary:dict];
        self.height = [self objectOrNilForKey:ktestDataHeight fromDictionary:dict];
        self.imagePath = [self objectOrNilForKey:ktestDataImagePath fromDictionary:dict];
        self.score = [self objectOrNilForKey:ktestDataScore fromDictionary:dict];
        self.addTime = [self objectOrNilForKey:ktestDataAddTime fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headImage forKey:ktestDataHeadImage];
    [mutableDict setValue:self.cutPath forKey:ktestDataCutPath];
    [mutableDict setValue:self.width forKey:ktestDataWidth];
    [mutableDict setValue:self.nickName forKey:ktestDataNickName];
    [mutableDict setValue:self.userId forKey:ktestDataUserId];
    [mutableDict setValue:self.comment forKey:ktestDataComment];
    [mutableDict setValue:self.cutHeight forKey:ktestDataCutHeight];
    [mutableDict setValue:self.cutWidth forKey:ktestDataCutWidth];
    [mutableDict setValue:self.ctime forKey:ktestDataCtime];
    [mutableDict setValue:self.imageId forKey:ktestDataImageId];
    [mutableDict setValue:self.commentId forKey:ktestDataCommentId];
    [mutableDict setValue:self.height forKey:ktestDataHeight];
    [mutableDict setValue:self.imagePath forKey:ktestDataImagePath];
    [mutableDict setValue:self.score forKey:ktestDataScore];
    [mutableDict setValue:self.addTime forKey:ktestDataAddTime];
    
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
    
    self.headImage = [aDecoder decodeObjectForKey:ktestDataHeadImage];
    self.cutPath = [aDecoder decodeObjectForKey:ktestDataCutPath];
    self.width = [aDecoder decodeObjectForKey:ktestDataWidth];
    self.nickName = [aDecoder decodeObjectForKey:ktestDataNickName];
    self.userId = [aDecoder decodeObjectForKey:ktestDataUserId];
    self.comment = [aDecoder decodeObjectForKey:ktestDataComment];
    self.cutHeight = [aDecoder decodeObjectForKey:ktestDataCutHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:ktestDataCutWidth];
    self.ctime = [aDecoder decodeObjectForKey:ktestDataCtime];
    self.imageId = [aDecoder decodeObjectForKey:ktestDataImageId];
    self.commentId = [aDecoder decodeObjectForKey:ktestDataCommentId];
    self.height = [aDecoder decodeObjectForKey:ktestDataHeight];
    self.imagePath = [aDecoder decodeObjectForKey:ktestDataImagePath];
    self.score = [aDecoder decodeObjectForKey:ktestDataScore];
    self.addTime = [aDecoder decodeObjectForKey:ktestDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_headImage forKey:ktestDataHeadImage];
    [aCoder encodeObject:_cutPath forKey:ktestDataCutPath];
    [aCoder encodeObject:_width forKey:ktestDataWidth];
    [aCoder encodeObject:_nickName forKey:ktestDataNickName];
    [aCoder encodeObject:_userId forKey:ktestDataUserId];
    [aCoder encodeObject:_comment forKey:ktestDataComment];
    [aCoder encodeObject:_cutHeight forKey:ktestDataCutHeight];
    [aCoder encodeObject:_cutWidth forKey:ktestDataCutWidth];
    [aCoder encodeObject:_ctime forKey:ktestDataCtime];
    [aCoder encodeObject:_imageId forKey:ktestDataImageId];
    [aCoder encodeObject:_commentId forKey:ktestDataCommentId];
    [aCoder encodeObject:_height forKey:ktestDataHeight];
    [aCoder encodeObject:_imagePath forKey:ktestDataImagePath];
    [aCoder encodeObject:_score forKey:ktestDataScore];
    [aCoder encodeObject:_addTime forKey:ktestDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserCommentData *copy = [[ZXY_UserCommentData alloc] init];
    
    if (copy) {
        
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.ctime = [self.ctime copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.commentId = [self.commentId copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
