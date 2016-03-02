//
//  SJHttpTool.h
//  微博项目
//
//  Created by joe on 16/2/26.
//  Copyright © 2016年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJHttpTool : NSObject

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
