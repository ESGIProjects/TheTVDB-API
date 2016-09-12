//
//  TVDBApi.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVDBApi : NSObject
+(NSString*)authenticateWithUsername:(NSString*)username andUserKey:(NSString*)userkey;
@end
