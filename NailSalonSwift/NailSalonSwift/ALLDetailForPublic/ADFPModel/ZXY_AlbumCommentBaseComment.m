//
//  ZXY_AlbumCommentBaseComment.m
//
//  Created by   on 15/4/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumCommentBaseComment.h"
#import "ZXY_AlbumCommentData.h"


NSString *const kZXY_AlbumCommentBaseCommentResult = @"result";
NSString *const kZXY_AlbumCommentBaseCommentData = @"data";


@interface ZXY_AlbumCommentBaseComment ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumCommentBaseComment

@synthesize result = _result;
@synthesize data = _data;


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
            self.result = [[self objectOrNilForKey:kZXY_AlbumCommentBaseCommentResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXY_AlbumCommentData = [dict objectForKey:kZXY_AlbumCommentBaseCommentData];
    NSMutableArray *parsedZXY_AlbumCommentData = [NSMutableArray array];
    if ([receivedZXY_AlbumCommentData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXY_AlbumCommentData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXY_AlbumCommentData addObject:[ZXY_AlbumCommentData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXY_AlbumCommentData isKindOfClass:[NSDictionary class]]) {
       [parsedZXY_AlbumCommentData addObject:[ZXY_AlbumCommentData modelObjectWithDictionary:(NSDictionary *)receivedZXY_AlbumCommentData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXY_AlbumCommentData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_AlbumCommentBaseCommentResult];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXY_AlbumCommentBaseCommentData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_AlbumCommentBaseCommentResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_AlbumCommentBaseCommentData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_AlbumCommentBaseCommentResult];
    [aCoder encodeObject:_data forKey:kZXY_AlbumCommentBaseCommentData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumCommentBaseComment *copy = [[ZXY_AlbumCommentBaseComment alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
