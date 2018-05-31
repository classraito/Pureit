//
//  DatabaseManager.h
//  WeatherTestPorject
//
//  Created by Lu Yang on 12-9-15.
//  Copyright (c) 2012年 Lu Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IMAGETABLENAME @"imageTable"
#define PHOTOTABLENAME @"myphotoTable"
#define CATEGORYTABLENAME @"categoryTable"
#define EACHCATEGORYTABLENAME @"eachcategoryTable"
#define MESSAGETABLENAME @"messageTable"

@class EventObject;
@class FMDatabase;
@class FMDatabaseAdditions;

@interface DatabaseManager : NSObject
{
    FMDatabase *db;
}
//单例模式
+ (DatabaseManager*)singleDatabaseManager;
- (id)searchByKeyWord:(NSString*)_keyword type:(int)_type columnName:(NSString *)_str_columnName;
- (id)searchByKeyWord:(NSString*)_keyword type:(int)_type;
- (id)searchByKeyWord:(NSString*)_keyword;

- (FMDatabase*)openDatabase;
- (void)closeDatabase;
@end
