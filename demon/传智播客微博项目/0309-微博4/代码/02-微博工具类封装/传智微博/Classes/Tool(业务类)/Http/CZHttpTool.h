//
//  CZHttpTool.h
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//  处理网络的请求

#import <Foundation/Foundation.h>

@interface CZHttpTool : NSObject

// get
/**
 *  发送get请求
    不需要返回值：1.网络的数据会延迟，并不会马上返回。
 */

/**
 [mgr GET:<#(NSString *)#> parameters:<#(id)#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>]
*/

+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


@end
