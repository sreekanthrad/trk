//
//  ATTGAHelper.m
//  Pods
//
//  Created by Sreekanth R on 16/01/17.
//
//

#import "ATTGAHelper.h"
#ifdef GA_EXISTS
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIFields.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#endif

@interface ATTGAHelper()

@property (copy, nonatomic) NSString *trackingID;

@end

@implementation ATTGAHelper

- (instancetype)initWithTrackingID:(NSString*)trackingID {
    if (self = [super init]) {
        _trackingID = trackingID;
        [self initGA];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventTriggered:)
                                                     name:@"RegisterForTrakingNotification"
                                                   object:nil];
    }
    
    return self;
}

- (void)eventTriggered:(NSNotification*)notification {
    NSDictionary *notificationObject = notification.object;
    if (notificationObject) {
        for (NSDictionary *eachItem in notificationObject[@"configuration"]) {
            if ([eachItem[@"agent"] isEqualToString:@"GoogleAnalytics"]) {
                if ([eachItem[@"key_type"] isEqualToString:@"state"]) {
                    NSArray *agentParams = eachItem[@"param"];
                    if (agentParams && agentParams.count > 0) {
                        NSDictionary *agentParam = [agentParams firstObject];
                        if (agentParam) {
                            [self trackScreenChange:agentParam[@"param_agentKey"]];
                        }
                    }  
                }
                
                if ([eachItem[@"key_type"] isEqualToString:@"action"]) {
                    [self trackEventNamed:eachItem[@"app_specific_key"]
                            forScreenName:eachItem[@"agentKey"]
                               withAction:eachItem[@"app_specific_method"]];
                }
            }
        }
    }
}

- (void)initGA {
#ifdef GA_EXISTS
    NSString *bundleDisplayName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    [GAI sharedInstance].defaultTracker = [[GAI sharedInstance] trackerWithName:bundleDisplayName
                                                                     trackingId:self.trackingID];
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;
    gai.logger.logLevel = kGAILogLevelVerbose;
#endif
}

- (void)trackScreenChange:(NSString*)screenName {
#ifdef GA_EXISTS
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
#endif
}

- (void)trackEventNamed:(NSString*)eventName forScreenName:(NSString*)screenName{
#ifdef GA_EXISTS
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@""
                                                          action:@"click"
                                                           label:eventName
                                                           value:nil] build]];
#endif
}

- (void)trackEventNamed:(NSString*)eventName forScreenName:(NSString*)screenName withAction:(NSString*)action{
#ifdef GA_EXISTS
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@""
                                                          action:action
                                                           label:eventName
                                                           value:nil] build]];
#endif
}

@end
