#import <Cephei/HBPreferences.h>


//TODO:
//TIMER
//maybe an option for which areas to tap on
//number of taps : DONE
//number of fingers : DONE
//maybe long press : DONE
//enabled or not : DONE
//timeout number vs toggling mode : DONE
//maybe hide notifs too : DONE
//Fade animation? : possible in v1.2
//change prefs from Cephei to something else idk : not happening for a while
//add cephei package info cell
//add cephei twitter info cell : DONE

HBPreferences *prefs;

BOOL isEnabled;

NSString *userInteractionMode = nil;

NSString *tapControlMode = nil;
NSString *longPressControlMode = nil;

NSInteger numberOfTaps;
NSInteger numberOfFingersTapped;


BOOL firstTimeHide = TRUE;

NSInteger numberOfFingersHeld;
double longPressDuration;
CGFloat allowableMovement = 100;

BOOL dateIsHidden = FALSE;

NSTimer *longPressTimer = nil;
double clockDisplayDuration;

BOOL isHideNotificationsEnabled;

BOOL areNotifsTracking;
BOOL areNotifsDragging;

NSTimer *stoppedScrollingTimer = nil;

%group iOS13
//clock vc that creates the instance variable and starts timer when the view gets updated and the user just long pressed
@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@end

SBFLockScreenDateViewController *timeVC;

%hook SBFLockScreenDateViewController

	-(void)viewDidLoad{
		%orig;
		timeVC = (SBFLockScreenDateViewController *)self;
	}


%end

//hides the clock/date 
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
		}else{
			self.subtitleHidden = FALSE;
			self.hidden = FALSE;
		}
	}
	else{
		%orig;
	}
}

%end
%end


%group iOS12

@interface SBLockScreenDateViewController : UIViewController
-(void)_updateView;
// @property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end

SBLockScreenDateViewController *ios12TimeVC;

%hook SBLockScreenDateViewController

	-(void)viewDidLoad{
		%orig;
		ios12TimeVC = (SBLockScreenDateViewController *)self;

	}

	-(void)_updateView{
	if(isEnabled){
	%orig;
		//check if area is tapped
		if(dateIsHidden){
			// self.view.subtitleHidden = TRUE;
			self.view.hidden = TRUE;
		}else{
			// self.view.subtitleHidden = FALSE;
			self.view.hidden = FALSE;
		}
	}
	else{
		%orig;
	}
	}


%end
%end


//mabye add code that will hide notifs the first time the tweak is run
//handles the tap/long press gestures
@interface NCNotificationStructuredListViewController : UIViewController
@property (nonatomic, assign, readwrite) UIScrollView *scrollView;
-(void)hideDateAfterDelay;
@end

NCNotificationStructuredListViewController *notifVC;

%hook NCNotificationStructuredListViewController

-(void)viewWillAppear {
	// notifVC.scrollView.hidden = TRUE;

	%orig;
// 	if(isHideNotificationsEnabled){
// 		// dateIsHidden = TRUE;	
// // 		if(kCFCoreFoundationVersionNumber>1655){
// // 	[timeVC _updateView];
// // }else{
// // 	[ios12TimeVC _updateView];
// // }
// 		notifVC.scrollView.hidden = TRUE;
// 		// firstTimeHide = FALSE;
// 	}
}

-(void)viewDidLoad {
	notifVC = (NCNotificationStructuredListViewController *)self;
	 UIViewController *_self = (UIViewController *)self;

if(isEnabled){
	if(firstTimeHide){
		dateIsHidden = TRUE;	
		if(kCFCoreFoundationVersionNumber>1655){
	[timeVC _updateView];
}else{
	[ios12TimeVC _updateView];
}
		if(isHideNotificationsEnabled){
			notifVC.scrollView.hidden = TRUE;
		}
		// [self hideDateAfterDelay];
		firstTimeHide = FALSE;
	}

	if([userInteractionMode isEqualToString:@"tap"]){
		%orig;
		UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
		tapPress.numberOfTapsRequired = (int)numberOfTaps;
		tapPress.numberOfTouchesRequired = (int)numberOfFingersTapped;
		[_self.view addGestureRecognizer:tapPress];
		// _self.userInteractionEnabled = TRUE;
	}else if([userInteractionMode isEqualToString:@"longPress"]){
		%orig;
		UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:_self action:@selector(handleLongPress:)];
		longPress.minimumPressDuration = longPressDuration;
		longPress.numberOfTouchesRequired = (int)numberOfFingersHeld;
		longPress.allowableMovement = allowableMovement;
		[_self.view addGestureRecognizer: longPress];
	}
	else{
		%orig;
	}
}
else{
	%orig;
}

}


%new
-(void)handleTap:(UITapGestureRecognizer *)sender{
	NSString *iosVersion = [NSString stringWithFormat:@"%f", kCFCoreFoundationVersionNumber];

	HBLogWarn(@"iosVersion %@",iosVersion);
	if([tapControlMode isEqualToString:@"toggle"]){
	if(!dateIsHidden){
		dateIsHidden = TRUE;	
		if(kCFCoreFoundationVersionNumber>1655){
	[timeVC _updateView];
	}else{
	[ios12TimeVC _updateView];
	}
		if(isHideNotificationsEnabled){
			notifVC.scrollView.hidden = TRUE;
		}
	}else{
		dateIsHidden = FALSE;
		if(kCFCoreFoundationVersionNumber>1655){
			[timeVC _updateView];
		}else{
			[ios12TimeVC _updateView];
		}
		if(isHideNotificationsEnabled){
			notifVC.scrollView.hidden=FALSE;
		}
	}
	}
	else if([tapControlMode isEqualToString:@"automaticallyHide"]){
		HBLogWarn(@"taptimer");

	if(!dateIsHidden){

	}else{
	
		dateIsHidden = FALSE;
		if(kCFCoreFoundationVersionNumber>1655){
	[timeVC _updateView];
}else{
	[ios12TimeVC _updateView];
}
		if(isHideNotificationsEnabled){
			notifVC.scrollView.hidden = FALSE;
		}

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
	else{

	}
}

%new
-(void)hideDateAfterDelay{
	dateIsHidden = TRUE;
	if(kCFCoreFoundationVersionNumber>1655){
	[timeVC _updateView];
}else{
	[ios12TimeVC _updateView];
}
	if(isHideNotificationsEnabled){
		notifVC.scrollView.hidden = TRUE;
	}
}

%new 
-(void)doNothing{

}

%new
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender{

// if([longPressControlMode isEqualToString:@"toggle"]){
	// if(!dateIsHidden){
	// 	dateIsHidden = TRUE;	
	// 	if(kCFCoreFoundationVersionNumber>1655){
	// 		[timeVC _updateView];
	// 	}else{
	// 		[ios12TimeVC _updateView];
	// 	}
	// 	if(isHideNotificationsEnabled){
	// 		notifVC.scrollView.hidden = TRUE;
	// 	}
	// 	dispatch_async(dispatch_get_main_queue(), ^{
	// 		longPressTimer = [NSTimer scheduledTimerWithTimeInterval:2
	// 									target:self
	// 									selector:@selector(hideDateAfterDelay)
	// 									userInfo:nil
	// 									repeats:NO];	

	// 	});
	// 	}else{
	// 		dateIsHidden = FALSE;
	// 	if(kCFCoreFoundationVersionNumber>1655){
	// 		[timeVC _updateView];
	// 	}else{
	// 		[ios12TimeVC _updateView];
	// 	}
	// 	if(isHideNotificationsEnabled){
	// 		notifVC.scrollView.hidden=FALSE;
	// 	}
	// 	dispatch_async(dispatch_get_main_queue(), ^{
	// 		longPressTimer = [NSTimer scheduledTimerWithTimeInterval:2
	// 									target:self
	// 									selector:@selector(doNothing)
	// 									userInfo:nil
	// 									repeats:NO];	

	// 	});
	// }
// }
// else if([longPressControlMode isEqualToString:@"automaticallyHide"]){
	if(!dateIsHidden){

	}else{
		dateIsHidden = FALSE;
		if(kCFCoreFoundationVersionNumber>1655){
	[timeVC _updateView];
}else{
	[ios12TimeVC _updateView];
}
		if(isHideNotificationsEnabled){
			notifVC.scrollView.hidden = FALSE;
		}

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
// }
// else{

// }
}

%end



@interface NCNotificationListView : UIScrollView
@end

//SBLockScreenDateViewController
%hook NCNotificationListView


//hook scrollviewdidscroll


//stops the original timer that hides notifs from firing
-(void)_trackingDidBegin{
	%orig;
	// HBLogWarn(@"StringMode %@", userInteractionMode);
	if(isHideNotificationsEnabled&&[userInteractionMode isEqualToString:@"longPress"]){
	[longPressTimer invalidate];
	
	dispatch_async(dispatch_get_main_queue(), ^{
			longPressTimer = [NSTimer scheduledTimerWithTimeInterval:clockDisplayDuration
										target:self
										selector:@selector(hideNotifsAfterScrollingEnds)
										userInfo:nil
										repeats:NO];	
});
	}
}


//hides the notifs once the user stops scrolling
-(void)_scrollViewDidEndDecelerating{
	%orig;
	if(isHideNotificationsEnabled&&[userInteractionMode isEqualToString:@"longPress"]){
	dispatch_async(dispatch_get_main_queue(), ^{
			stoppedScrollingTimer = [NSTimer scheduledTimerWithTimeInterval:2
										target:self
										selector:@selector(hideNotifsAfterScrollingEnds)
										userInfo:nil
										repeats:NO];	
		});
	}
}

%new
-(void)hideNotifsAfterScrollingEnds{
	[notifVC hideDateAfterDelay];
}

%end





// %hook CSQuickActionView

// -(void)

// %end









void updateSettings(){
	[prefs registerBool:&isEnabled default:TRUE forKey:@"isEnabled"];

	[prefs registerObject:&userInteractionMode default:@"tap" forKey:@"userInteractionMode"];

	[prefs registerObject:&tapControlMode default:@"toggle" forKey:@"tapControlMode"];

	[prefs registerObject:&longPressControlMode default:@"toggle" forKey:@"longPressControlMode"];

	[prefs registerInteger:&numberOfTaps default:2 forKey:@"numberOfTaps"];
	[prefs registerInteger:&numberOfFingersTapped default:1 forKey:@"numberOfFingersTapped"];

	[prefs registerInteger:&numberOfFingersHeld default:1 forKey:@"numberOfFingersHeld"];
	[prefs registerDouble:&longPressDuration default:0.5 forKey:@"longPressDuration"];
	[prefs registerDouble:&clockDisplayDuration default:0.5 forKey:@"clockDisplayDuration"];

	[prefs registerBool:&isHideNotificationsEnabled default:FALSE forKey:@"isHideNotificationsEnabled"];
	
}




%ctor {
	prefs= [[HBPreferences alloc] initWithIdentifier:@"com.atar13.houdiniprefs"];
	updateSettings();
	// CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)updateSettings, CFSTR("com.atar13.houdini/updateSettings"), NULL, kNilOptions);	
	// HBLogWarn(@"StringMode %@", mode);
	if(kCFCoreFoundationVersionNumber>1665){
		%init(iOS13);
	}else{
		%init(iOS12);
	}
	%init;

}


