#include "HOUDINIRootListController.h"

#import <spawn.h>
#import "NSTask.h"


@implementation HOUDINIRootListController


- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}


//OLD RESPRING FUNCTION
// void respring(){
// 	NSTask *task = [[NSTask alloc] init];
// 	[task setLaunchPath:@"/usr/bin/killall"];
// 	[task setArguments:@[@"-9",@"SpringBoard"]];
// 	[task launch];
// }

//respring functionality for right side bar button
-(void)respring {
	pid_t pid;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}



//methods for links to social media/github
-(void)reddit {
	[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"https://reddit.com/u/atar13"] 
		options:@{} 
	completionHandler:nil];
}

- (void)twitter {
	[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"https://twitter.com/atar137h"] 
		options:@{} 
	completionHandler:nil];
}

-(void)email{
	[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"mailto:atar13dev@gmail.com"] 
		options:@{} 
	completionHandler:nil];
}

-(void)github{
	[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"https://github.com/atar13/Houdini"] 
		options:@{} 
	completionHandler:nil];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	UIBarButtonItem *respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
	self.navigationItem.rightBarButtonItem = respringButton; 
}



@end


@implementation TapModeController

-(void)respring {
	pid_t pid;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Tap" target:self];
	}

	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	UIBarButtonItem *respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
	self.navigationItem.rightBarButtonItem = respringButton; 
}
@end

@implementation LongPressModeController

-(void)respring {
	pid_t pid;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"LongPress" target:self];
	}

	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	UIBarButtonItem *respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
	self.navigationItem.rightBarButtonItem = respringButton; 
}
@end