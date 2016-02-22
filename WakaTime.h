#import <Cocoa/Cocoa.h>
#import "CodaPluginsController.h"

@class CodaPlugInsController;

@interface WakaTime : NSObject <CodaPlugIn>
{
	CodaPlugInsController* controller;
}


@end
