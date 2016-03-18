#import "WakaTime.h"
#import "CodaPlugInsController.h"

static NSString *VERSION = nil;
static NSString *CONFIG_FILE = @".wakatime.cfg";
static NSString *CLI = @"wakatime-master/wakatime/cli.py";
static NSString *CLI_ZIP = @"wakatime-master.zip";
static int FREQUENCY = 2;  // minutes
static NSString *CODA_VERSION = nil;

@interface WakaTime ()

@property (nonatomic, strong) NSString *lastFile;
@property (nonatomic) CFAbsoluteTime lastSent;
@property (nonatomic, strong) NSString *resourcesDir;
@property (nonatomic, strong) NSString *cli;
@property (nonatomic, strong) NSString *cliZip;

- (id)initWithController:(CodaPlugInsController*)inController;

@end

@implementation WakaTime

- (NSString*)name {
    return @"WakaTime";
}

//2.0 and lower
- (id)initWithPlugInController:(CodaPlugInsController*)aController bundle:(NSBundle*)aBundle {
    return [self initWithController:aController];
}

//2.0.1 and higher
- (id)initWithPlugInController:(CodaPlugInsController*)aController plugInBundle:(NSObject <CodaPlugInBundle> *)plugInBundle {
    return [self initWithController:aController];
}

- (id)initWithController:(CodaPlugInsController*)inController {
	if ( (self = [super init]) != nil )
    {
        controller = inController;
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        
        // Set runtime constants
        CONFIG_FILE = [NSHomeDirectory() stringByAppendingPathComponent:CONFIG_FILE];
        VERSION = [[bundle infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        CODA_VERSION = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        self.resourcesDir = [[[bundle resourceURL] absoluteURL] path];
        self.cli = [NSString stringWithFormat:@"%@/%@", self.resourcesDir, CLI];
        self.cliZip = [NSString stringWithFormat:@"%@/%@", self.resourcesDir, CLI_ZIP];
        
        NSLog(@"Initializing WakaTime v%@ (http://wakatime.com)", VERSION);
		
        // add menu item to Plugins menu
		[controller registerActionWithTitle:@"WakaTime API Key" target:self selector:@selector(settingsMenu:)];
        
        // prompt for api_key if not already set
        NSString *api_key = [[self getApiKey] stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (api_key == NULL || [api_key length] == 0) {
            [self promptForApiKey];
        }
        
        // extract wakatime-master.zip if not already extracted
        if (![self isCliExtracted]) {
            [self unzip:self.cliZip outputDir:self.resourcesDir];
        }
	}
	return self;
}

- (void)settingsMenu:(id)sender {
	[self promptForApiKey];
}

- (BOOL)validateMenuItem:(NSMenuItem*)menuItem {
	BOOL menuItemIsValid = NO;
	
	if ( [menuItem action] == @selector(writeUTFBOM:) )
	{
		CodaTextView* textView = [controller focusedTextView];
		
		if ( [textView path] != nil )
		{
			
		}
	}
	
	return menuItemIsValid;
}

- (void)textViewDidFocus:(CodaTextView*)textView {
    NSString *currentFile = [textView path];
    if (currentFile != nil) {
        
        CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
        
        if (!self.lastFile || !self.lastSent || ![self.lastFile isEqualToString:currentFile] || self.lastSent + FREQUENCY * 60 < currentTime) {
            self.lastFile = currentFile;
            self.lastSent = currentTime;
            [self sendHeartbeat:false];
        }
    }
}

- (void)textViewDidSave:(CodaTextView*)textView {
    NSString *currentFile = [textView path];
    if (currentFile != nil) {
        
        CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
        
        // always send heartbeat to api if isWrite is true
        self.lastFile = currentFile;
        self.lastSent = currentTime;
        [self sendHeartbeat:true];
    }
}

-(void)sendHeartbeat:(BOOL)isWrite {
    if (self.lastFile != nil) {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath: @"/usr/bin/python"];
        
        NSMutableArray *arguments = [NSMutableArray array];
        [arguments addObject:self.cli];
        [arguments addObject:@"--file"];
        [arguments addObject:self.lastFile];
        [arguments addObject:@"--plugin"];
        [arguments addObject:[NSString stringWithFormat:@"coda/%@ coda-wakatime/%@", CODA_VERSION, VERSION]];
        if (isWrite)
            [arguments addObject:@"--write"];
        NSString *project = [self getProjectName ];
        if (project != nil) {
            [arguments addObject:@"--alternate-project"];
            [arguments addObject:project];
        }
        // NSLog(@"%@", [arguments componentsJoinedByString:@", "]);
        [task setArguments: arguments];
        [task launch];
    }
}

- (NSString *)getProjectName {
    NSString *nickname = [controller siteNickname];
    if (nickname != nil)
        return nickname;
    return nil;
}

- (NSString *)getApiKey {
    // Read api key from config file
    NSString *contents = [NSString stringWithContentsOfFile:CONFIG_FILE encoding:NSUTF8StringEncoding error:nil];[NSString stringWithContentsOfFile:CONFIG_FILE encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [contents componentsSeparatedByString:@"\n"];
    for (NSString *s in lines) {
        NSArray *line = [s componentsSeparatedByString:@"="];
        if ([line count] == 2) {
            NSString *key = [[line objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([key isEqualToString:@"api_key"]) {
                NSString *value = [[line objectAtIndex:1] stringByReplacingOccurrencesOfString:@" " withString:@""];
                return value;
            }
        }
    }
    return NULL;
}

- (void)saveApiKey:(NSString *)api_key {
    // Write api key to config file
    NSString *contents = [NSString stringWithContentsOfFile:CONFIG_FILE encoding:NSUTF8StringEncoding error:nil];[NSString stringWithContentsOfFile:CONFIG_FILE encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [contents componentsSeparatedByString:@"\n"];
    NSMutableArray *new_contents = [NSMutableArray array];
    BOOL found = false;
    for (NSString *s in lines) {
        NSArray *line = [[s stringByReplacingOccurrencesOfString:@" = " withString:@"="] componentsSeparatedByString:@"="];
        if ([line count] == 2) {
            NSString *key = [line objectAtIndex:0];
            if ([key isEqualToString:@"api_key"]) {
                found = true;
                line = @[@"api_key", api_key];
            }
        }
        [new_contents addObject:[line componentsJoinedByString:@" = "]];
    }
    if ([new_contents count] == 0 || !found) {
        [new_contents removeAllObjects];
        [new_contents addObject:@"[settings]"];
        [new_contents addObject:[NSString stringWithFormat:@"api_key = %@", api_key]];
    }
    NSError *error = nil;
    NSString *to_write = [new_contents componentsJoinedByString:@"\n"];
    [to_write writeToFile:CONFIG_FILE atomically:YES encoding:NSASCIIStringEncoding error:&error];
    if (error) {
        NSLog(@"Fail: %@", [error localizedDescription]);
    }
}

- (void)promptForApiKey {
    // Prompt for api key
    NSString *api_key = [self getApiKey];
    NSAlert *alert = [NSAlert alertWithMessageText:@"Enter your api key from wakatime.com" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 300, 24)];
    if (api_key != NULL) {
        [input setStringValue:api_key];
    }
    [alert setAccessoryView:input];
    [alert runModal];
    api_key = [input stringValue];
    [self saveApiKey:api_key];
}

- (BOOL)isCliExtracted {
    NSFileManager* fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:self.cli];
}

- (void) unzip:(NSString *)zipFile outputDir:(NSString *)outputDir {
    NSArray *arguments = [NSArray arrayWithObject:zipFile];
    NSTask *unzipTask = [[NSTask alloc] init];
    [unzipTask setLaunchPath:@"/usr/bin/unzip"];
    [unzipTask setCurrentDirectoryPath:outputDir];
    [unzipTask setArguments:arguments];
    [unzipTask launch];
}

@end
