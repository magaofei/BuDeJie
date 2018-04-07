//
//  MKFileTool.m
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/10.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKFileTool.h"

@implementation MKFileTool

+ (BOOL)removeDirectoryPath:(NSString *)directoryPath {
    // 获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        
        /**
         抛异常
          NSExceptionName 异常名称
                        reason 报错原因
         */
        NSException *excp = [NSException exceptionWithName:@"fileError" reason:@"需要传入的是文件夹路径" userInfo:nil];
        [excp raise];
    }
    
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    // 获取cache文件夹下所有文件 ,不包括里面的子路径
    NSArray *contentPaths = [manager contentsOfDirectoryAtPath:directoryPath error:nil];
    
    BOOL success = false;
    for (NSString *contentPath in contentPaths) {
        // 拼接完全路径
        NSString *direPath = [cachePath stringByAppendingPathComponent:contentPath];
        
        success = [manager removeItemAtPath:direPath error:nil];
    }
    return success;
    
}

// 自己去计算缓存大小
+ (void)getFileSize:(NSString *)DirectoriesPath completion:(void (^)(unsigned long long))completionBlock{
    
    // NSFileManager
    // attributesOfItemAtPath:指定文件路径，就能获取文件属性
    // 把所有文件尺寸加起来
    
    // 遍历文件夹所有文件，一个一个加起来
    
    // 获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取文件夹下所有的子路径
    //    NSArray *subCachePaths = [fileManager subpathsAtPath:cachePath];
    //    NSLog(@"%@", subCachePaths);
    
    
    // 异步，不需要等待返回
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        unsigned long long totalSize = 0;
        // 根据传入的文件夹遍历
        
        NSArray *subPaths = [fileManager subpathsAtPath:DirectoriesPath];
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [DirectoriesPath stringByAppendingPathComponent:subPath];
            
            // 判断是否是隐藏文件
            if ([filePath hasPrefix:@"."]) {
                continue;
            }
            
            // 判断是否是文件夹
            BOOL isDictionary ;
            BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDictionary];
            if (!isExist || isDictionary) {
                continue;
            }
            
            // 获取文件属性
            // attributesOfItemAtPath: 获取文件夹不对，只能获取文件尺寸
            NSDictionary *attr = [fileManager attributesOfItemAtPath:filePath error:nil];
            // default尺寸
            unsigned long long defaultSize = [attr fileSize];
            totalSize += defaultSize;
        }
        
        
        // 
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(totalSize);
            }
        });
        
        
    });
    
    
    
    
}

@end
