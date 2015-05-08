//
//  SR_OrderDetailComment.m
//
//  Created by sun  on 15/5/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_OrderDetailComment.h"


NSString *const kSR_OrderDetailCommentImagePath = @"image_path";
NSString *const kSR_OrderDetailCommentCommentId = @"comment_id";
NSString *const kSR_OrderDetailCommentScore = @"score";
NSString *const kSR_OrderDetailCommentHeight = @"height";
NSString *const kSR_OrderDetailCommentImageId = @"image_id";
NSString *const kSR_OrderDetailCommentCutPath = @"cut_path";
NSString *const kSR_OrderDetailCommentWidth = @"width";
NSString *const kSR_OrderDetailCommentCutHeight = @"cut_height";
NSString *const kSR_OrderDetailCommentCutWidth = @"cut_width";
NSString *const kSR_OrderDetailCommentComment = @"comment";
NSString *const kSR_OrderDetailCommentAddTime = @"add_time";


@interface SR_OrderDetailComment ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_OrderDetailComment

@synthesize imagePath = _imagePath;
@synthesize commentId = _commentId;
@synthesize score = _score;
@synthesize height = _height;
@synthesize imageId = _imageId;
@synthesize cutPath = _cutPath;
@synthesize width = _width;
@synthesize cutHeight = _cutHeight;
@synthesize cutWidth = _cutWidth;
@synthesize comment = _comment;
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
            self.imagePath = [self objectOrNilForKey:kSR_OrderDetailCommentImagePath fromDictionary:dict];
            self.commentId = [self objectOrNilForKey:kSR_OrderDetailCommentCommentId fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_OrderDetailCommentScore fromDictionary:dict];
            self.height = [self objectOrNilForKey:kSR_OrderDetailCommentHeight fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kSR_OrderDetailCommentImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kSR_OrderDetailCommentCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kSR_OrderDetailCommentWidth fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kSR_OrderDetailCommentCutHeight fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kSR_OrderDetailCommentCutWidth fromDictionary:dict];
            self.comment = [self objectOrNilForKey:kSR_OrderDetailCommentComment fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kSR_OrderDetailCommentAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imagePath forKey:kSR_OrderDetailCommentImagePath];
    [mutableDict setValue:self.commentId forKey:kSR_OrderDetailCommentCommentId];
    [mutableDict setValue:self.score forKey:kSR_OrderDetailCommentScore];
    [mutableDict setValue:self.height forKey:kSR_OrderDetailCommentHeight];
    [mutableDict setValue:self.imageId forKey:kSR_OrderDetailCommentImageId];
    [mutableDict setValue:self.cutPath forKey:kSR_OrderDetailCommentCutPath];
    [mutableDict setValue:self.width forKey:kSR_OrderDetailCommentWidth];
    [mutableDict setValue:self.cutHeight forKey:kSR_OrderDetailCommentCutHeight];
    [mutableDict setValue:self.cutWidth forKey:kSR_OrderDetailCommentCutWidth];
    [mutableDict setValue:self.comment forKey:kSR_OrderDetailCommentComment];
    [mutableDict setValue:self.addTime forKey:kSR_OrderDetailCommentAddTime];

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

    self.imagePath = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentImagePath];
    self.commentId = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentCommentId];
    self.score = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentScore];
    self.height = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentHeight];
    self.imageId = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentCutPath];
    self.width = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentWidth];
    self.cutHeight = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentCutHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentCutWidth];
    self.comment = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentComment];
    self.addTime = [aDecoder decodeObjectForKey:kSR_OrderDetailCommentAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imagePath forKey:kSR_OrderDetailCommentImagePath];
    [aCoder encodeObject:_commentId forKey:kSR_OrderDetailCommentCommentId];
    [aCoder encodeObject:_score forKey:kSR_OrderDetailCommentScore];
    [aCoder encodeObject:_height forKey:kSR_OrderDetailCommentHeight];
    [aCoder encodeObject:_imageId forKey:kSR_OrderDetailCommentImageId];
    [aCoder encodeObject:_cutPath forKey:kSR_OrderDetailCommentCutPath];
    [aCoder encodeObject:_width forKey:kSR_OrderDetailCommentWidth];
    [aCoder encodeObject:_cutHeight forKey:kSR_OrderDetailCommentCutHeight];
    [aCoder encodeObject:_cutWidth forKey:kSR_OrderDetailCommentCutWidth];
    [aCoder encodeObject:_comment forKey:kSR_OrderDetailCommentComment];
    [aCoder encodeObject:_addTime forKey:kSR_OrderDetailCommentAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_OrderDetailComment *copy = [[SR_OrderDetailComment alloc] init];
    
    if (copy) {

        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.commentId = [self.commentId copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
