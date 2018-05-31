//
//  DatabaseManager.m
//  WeatherTestPorject
//
//  Created by Lu Yang on 12-9-15.
//  Copyright (c) 2012年 Lu Yang. All rights reserved.
//

//#import "Const.h"
#import "DatabaseManager.h"
#import "sqlite3.h"

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

#define DATABASENAME @"pureitDB.sqlite"

#define TABLENAME @"QAList"

#import "Global.h"


static DatabaseManager* singleDatabaseManager = nil;
sqlite3 *database;


@implementation DatabaseManager


+ (DatabaseManager*)singleDatabaseManager
{
    @synchronized(self)
    {
        if (singleDatabaseManager == nil)
            singleDatabaseManager = [[self alloc] init];
    }
    
    return singleDatabaseManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (singleDatabaseManager == nil)
        {
            singleDatabaseManager = [super allocWithZone:zone];
            
            [singleDatabaseManager createEditableCopyOfFileIfNeeded:DATABASENAME];
            
            return singleDatabaseManager;
        }
    }
    return nil;
}

-(void)createEditableCopyOfFileIfNeeded:(NSString *)adbName
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:adbName];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        NSLog(@"已經創建了文件:%@，不需要再創建",adbName);
        return;
    }
    else {
        NSLog(@"未創建文件，需要創建默認文件，文件名是:%@",adbName);
    }
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:adbName];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
    if (!success) {
        NSLog(@"error=%@",error);
        
    }
    NSLog(@"\nfrom=%@,\nto=%@", defaultDBPath,writableDBPath	);
    //	assert([fileManager fileExistsAtPath:writableDBPath]);
    [pool release];
    
}

- (FMDatabase*)openDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [cacheDirectory stringByAppendingPathComponent:DATABASENAME];
    NSLog(@"dbPath = %@",dbPath);
    
    db = [FMDatabase databaseWithPath:dbPath];
    if (![db open])
    {
        NSLog(@"could not open db.");
    }
    
    return db;
}

- (void)closeDatabase
{
    if(!db)
        return;
    
    [db close];
}

- (id)searchByKeyWord:(NSString*)_keyword type:(int)_type columnName:(NSString *)_str_columnName
{
    
    NSString* queryString = nil;
    FMResultSet *rs = nil;
    
    NSString *str_key_question = @"question_en";
    NSString *str_key_answer = @"answer_en";
    
    if([commond isChinese])
    {
        str_key_question = @"question_cn";
        str_key_answer = @"answer_cn";
    }
    
    queryString = [NSString stringWithFormat:@"select %@ from %@ where (%@ LIKE '%%%@%%' or %@ LIKE '%%%@%%')",_str_columnName,TABLENAME, str_key_question,_keyword,str_key_answer,_keyword];
    if(_type > 0)
    {
        queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@" and type = %d",_type]];
    }
    
    NSLog(@"querString=%@",queryString);
    FMDatabase * _db = [self openDatabase];
    rs = [_db executeQuery:queryString];
    
    
    NSMutableArray* array = [[[NSMutableArray alloc] init] autorelease];
    
    while ([rs next]) {
        
        if([_str_columnName isEqualToString:@"*"])
        {
            NSMutableDictionary* dic = [[[NSMutableDictionary alloc] init]autorelease];
            [dic setObject:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dic setObject:[rs stringForColumn:str_key_question] forKey:@"question"];
            [dic setObject:[rs stringForColumn:str_key_answer] forKey:@"answer"];
            [dic setObject:[NSNumber numberWithInt:[rs intForColumn:@"type"]] forKey:@"type"];
            [dic setObject:[NSNumber numberWithBool:NO] forKey:@"answershowed"];
            [dic setObject:[NSNumber numberWithBool:YES] forKey:@"isquestion"];
            [array addObject:dic];
        }
        else
        {
            if([_str_columnName containsString:@"id"])
                [array addObject:[NSNumber numberWithInt:[rs intForColumn:@"id"]]];
            
            if([_str_columnName containsString:@"question"])
                [array addObject:[rs stringForColumn:str_key_question]];
                
            if([_str_columnName containsString:@"answer"])
                [array addObject:[rs stringForColumn:str_key_answer]];
                    
            if([_str_columnName containsString:@"type"])
                [array addObject:[NSNumber numberWithInt:[rs intForColumn:@"type"]]];
                        
            if([_str_columnName containsString:@"answershowed"])
                [array addObject:[NSNumber numberWithBool:NO]];
            
            
        }
        
        
        
    }
    [rs close];
    return array;

}

- (id)searchByKeyWord:(NSString*)_keyword type:(int)_type
{
    return [self searchByKeyWord:_keyword type:_type columnName:@"*"];
}


- (id)searchByKeyWord:(NSString*)_keyword
{
    return [self searchByKeyWord:_keyword type:0];
}
@end
