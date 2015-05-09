//
//  ArtistList.h
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArtistList : NSManagedObject

@property (nonatomic, retain) NSString * artistID;
@property (nonatomic, retain) NSString * artistImg;
@property (nonatomic, retain) NSString * artistName;

@end
