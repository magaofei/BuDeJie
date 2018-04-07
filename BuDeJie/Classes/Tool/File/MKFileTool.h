//
//  MKFileTool.h
//  BuDeJie
//
//  Created by MAMIAN on 2017/2/10.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>

@interface MKFileTool : NSObject


/**
 获取文件尺寸
 
 @param DirectoriesPath 文件夹路径
 @ 返回文件夹尺寸
 */
+ (void)getFileSize:(NSString *)DirectoriesPath completion:(void (^)(unsigned long long))completionBlock;


/**
 删除文件夹所有文件

 @param directoryPath cache里面的文件夹路径
 */
+ (BOOL)removeDirectoryPath:(NSString *)directoryPath;

@end
