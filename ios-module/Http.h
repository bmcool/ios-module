//
//  http.h
//  utility
//
//  Created by Chi-Cheng Lin on 11/11/4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Http : NSObject

/**
 * @brief Get/Post HTTP easier.
 * @param url Target URL.
 * @param body nil : HTTP Get.\n
 *             HTTP content : HTTP Post.
 * @param encoding encoding.
 * @param headers HTTP headers.
 * @retval NSString Response content.
 */

+(NSString *) getWithUrl:(NSString *)url encoding:(NSStringEncoding)encoding;
+(NSString *) getWithUrl:(NSString *)url encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers;

+(NSString *) postWithUrl:(NSString *)url body:(NSString *)body encoding:(NSStringEncoding)encoding;
+(NSString *) postWithUrl:(NSString *)url body:(NSString *)body encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers;

@end
