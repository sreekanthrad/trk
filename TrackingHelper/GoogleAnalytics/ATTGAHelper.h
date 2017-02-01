//
//  ATTGAHelper.h
//  Pods
//
//  Created by Sreekanth R on 16/01/17.
//
//

#import <Foundation/Foundation.h>

@interface ATTGAHelper : NSObject

- (instancetype)initWithTrackingID:(NSString*)trackingID;
- (void)trackScreenChange:(NSDictionary*)info;

@end
