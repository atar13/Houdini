#import <spawn.h>
#include "HOUDINIRootListController.h"

@implementation HOUDINIRootListController

// void respring(){
// 	NSTask *task = [[NSTask alloc] init];
// 	[task setLaunchPath:@"/usr/bin/killall"];
// 	[task setArguments:@[@"-9",@"SpringBoard"]];
// 	[task launch];
// }
-(void)respring {
	pid_t pid;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	UIBarButtonItem *respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
	self.navigationItem.rightBarButtonItem = respringButton; 
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
