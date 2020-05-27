
#import <Cephei/HBPreferences.h>


//TODO:
//TIMER
//maybe an option for which areas to tap on
//number of taps : DONE
//number of fingers : DONE
//maybe long press : DONE
//enabled or not : DONE
//timeout number vs toggling mode
//maybe hide notifs too
//Fade animation?
//change prefs from Cephei to something else idk
//add cephei package info cell
//add cephei twitter info cell

HBPreferences *prefs;

BOOL isEnabled;

BOOL isTapModeEnabled;
NSInteger numberOfTaps;
NSInteger numberOfFingersTapped;

BOOL isLongPressModeEnabled;
NSInteger numberOfFingersHeld;
double longPressDuration;
CGFloat allowableMovement = 20;

BOOL dateIsHidden = TRUE;

NSTimer *longPressTimer = nil;
BOOL longPressHasBeenHidden;
double clockDisplayDuration;

@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@end

SBFLockScreenDateViewController *timeVC;

%hook SBFLockScreenDateViewController

	-(void)viewDidLoad{
		%orig;
		timeVC = (SBFLockScreenDateViewController *)self;
	}

	-(void)_updateView{
		%orig;
			if(longPressHasBeenHidden){

	//credits to NoisyFlake for the timer code and getting it to run in the main thread
	//https://github.com/NoisyFlake/OhMyFlash

		dispatch_async(dispatch_get_main_queue(), ^{
			longPressTimer = [NSTimer scheduledTimerWithTimeInterval:clockDisplayDuration
										target:self
										selector:@selector(hideDateAfterDelay)
										userInfo:nil
										repeats:NO];
		});
	}
	}

%new
-(void)hideDateAfterDelay{
	dateIsHidden = TRUE;
	[timeVC _updateView];
	longPressHasBeenHidden = FALSE;
}
%end





@interface NCNotificationStructuredListViewController : UIViewController
@end

%hook NCNotificationStructuredListViewController

-(void)viewDidLoad {
	UIViewController *_self = (UIViewController *)self;

	if(isTapModeEnabled){
		%orig;
		UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
		tapPress.numberOfTapsRequired = (int)numberOfTaps;
		tapPress.numberOfTouchesRequired = (int)numberOfFingersTapped;
		[_self.view addGestureRecognizer:tapPress];
		// _self.userInteractionEnabled = TRUE;
	}else if(isLongPressModeEnabled){
		%orig;
		UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:_self action:@selector(handleLongPress:)];
		longPress.minimumPressDuration = longPressDuration;
		longPress.numberOfTouchesRequired = (int)numberOfFingersHeld;
		longPress.allowableMovement = allowableMovement;
		[_self.view addGestureRecognizer: longPress];
	}
	else if(isTapModeEnabled&&isLongPressModeEnabled){
		%orig;
		UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
		tapPress.numberOfTapsRequired = (int)numberOfTaps;
		tapPress.numberOfTouchesRequired = (int)numberOfFingersTapped;
		[_self.view addGestureRecognizer:tapPress];
		// _self.userInteractionEnabled = TRUE;
	}
	else{
		%orig;
	}

	// if(longPressHasBeenHidden){
	// 	// longPressHasBeenHidden = FALSE;
	// 	HBLogWarn(@"LONGPRESSDELAY");
	// 	dispatch_async(dispatch_get_main_queue(), ^{
	// 		longPressTimer = [NSTimer scheduledTimerWithTimeInterval:1
	// 									target:self
	// 									selector:@selector(hideDateAfterDelay)
	// 									userInfo:nil
	// 									repeats:NO];
	// 	});
	// }

}

%new
-(void)handleTap:(UITapGestureRecognizer *)sender{
	if(!dateIsHidden){
		dateIsHidden = TRUE;	
		[timeVC _updateView];
	}else{
		dateIsHidden = FALSE;
		[timeVC _updateView];
	}
}

%new
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender{

		if(!dateIsHidden){
		// dateIsHidden = TRUE;	
		// [timeVC _updateView];
	}else{
		dateIsHidden = FALSE;
		longPressHasBeenHidden = TRUE;
		[timeVC _updateView];
	}
}


%end




@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end

%hook SBFLockScreenDateView

-(void)_updateLabels{

	if(isEnabled){
	%orig;
		//check if area is tapped
		if(dateIsHidden){
			self.subtitleHidden = TRUE;
			self.hidden = TRUE;
			// HBLogWarn(@"NOTLOADED");

		}else{
			self.subtitleHidden = FALSE;
			self.hidden = FALSE;
			// HBLogWarn(@"ISLOADED");
		}

	}
	else{
		%orig;
	}
}

%end

void updateSettings(){
	[prefs registerBool:&isEnabled default:TRUE forKey:@"isEnabled"];
	[prefs registerBool:&isTapModeEnabled default:TRUE forKey:@"isTapModeEnabled"];
	[prefs registerInteger:&numberOfTaps default:2 forKey:@"numberOfTaps"];
	[prefs registerInteger:&numberOfFingersTapped default:1 forKey:@"numberOfFingersTapped"];
	[prefs registerBool:&isLongPressModeEnabled default:FALSE forKey:@"isLongPressModeEnabled"];
	[prefs registerInteger:&numberOfFingersHeld default:1 forKey:@"numberOfFingersHeld"];
	[prefs registerDouble:&longPressDuration default:0.5 forKey:@"longPressDuration"];
	[prefs registerDouble:&clockDisplayDuration default:0.5 forKey:@"clockDisplayDuration"];
}




%ctor {
	prefs= [[HBPreferences alloc] initWithIdentifier:@"com.atar13.houdiniprefs"];
	updateSettings();
	// CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)updateSettings, CFSTR("com.atar13.houdini/updateSettings"), NULL, kNilOptions);

	%init;
}