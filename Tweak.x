#import <Cephei/HBPreferences.h>

//TODO:
//hide when phone is locked
//alert to respring when a setting is changed
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

@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@property (assign,nonatomic) BOOL screenOff;    
@end

@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end

//handles hiding 
@interface NCNotificationStructuredListViewController : UIViewController
@property (nonatomic, assign, readwrite) UIScrollView *scrollView;
-(void)hideDateAfterDelay;
@end

//handles hiding elements after scrolling
@interface NCNotificationListView : UIScrollView
@end

@interface CSQuickActionsViewController : UIViewController
@end

@interface CSTeachableMomentsContainerViewController : UIViewController
-(id)view;
@end

@interface CSCoverSheetViewBaseController
@end

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

BOOL isHideOnScreenLockEnabled;

BOOL isHideNotificationsEnabled;

BOOL isHideQuickActionsEnabled;

BOOL isHideUnlockTextEnabled;

BOOL areNotifsTracking;
BOOL areNotifsDragging;

NSTimer *stoppedScrollingTimer = nil;

SBFLockScreenDateViewController *timeVC;

NCNotificationStructuredListViewController *notifVC;

UIViewController *actionsVC;
UIViewController *unlockVC;



// UIViewController *simpleLSVC;

// @interface SLSDateViewController : UIViewController

// -(id)sharedInstance;
// @end
// %hook SLSDateViewController 

// 	-(void) viewDidLoad{
// 		simpleLSVC = (UIViewController *)self;

// 		%orig;
// 		// self.view.hidden = TRUE;
	
// 	}
// %end

//clock vc that creates the instance variable and starts timer when the view gets updated and the user just long pressed

void hide(){
	dateIsHidden = TRUE;
	[timeVC _updateView];
	if(isHideNotificationsEnabled){
		notifVC.scrollView.hidden = TRUE;
	}
	if(isHideQuickActionsEnabled){
		actionsVC.view.hidden = TRUE;
	}
	if(isHideUnlockTextEnabled){
		unlockVC.view.hidden = TRUE;
	}
}

void show(){
	dateIsHidden = FALSE;
	[timeVC _updateView];
	if(isHideNotificationsEnabled){
		notifVC.scrollView.hidden=FALSE;
	}
	if(isHideQuickActionsEnabled){
		actionsVC.view.hidden = FALSE;
	}
	if(isHideUnlockTextEnabled){
		unlockVC.view.hidden = FALSE;
	}
}

%hook SBFLockScreenDateViewController


	-(void)setScreenOff:(BOOL)arg1 {

			%orig;
			if(isEnabled&&firstTimeHide){
				hide();
				firstTimeHide = FALSE;
			}
			if(isEnabled&&isHideOnScreenLockEnabled){
			if(arg1){
			hide();
			}
			}
		}

	-(void)viewDidLoad{
		%orig;
		timeVC = (SBFLockScreenDateViewController *)self;
		// hide();
		if(self.screenOff){

		}
	}

%end

//hides the clock/date 

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




//handles the tap/long press gestures
%hook NCNotificationStructuredListViewController

// -(void)viewWillDissapear {
// 	%orig;
// 	HBLogWarn(@"screenlockedrn");
// }
-(void)viewDidLoad {
	notifVC = (NCNotificationStructuredListViewController *)self;
	 UIViewController *_self = (UIViewController *)self;

if(isEnabled){

	// if(firstTimeHide){
	// 	dateIsHidden = TRUE;	
	// 	if(kCFCoreFoundationVersionNumber>1655){
	// 	[timeVC _updateView];
	// 	}else{
	// 		ios12TimeVC.view.hidden = TRUE;
	// 	}
	// 	if(isHideNotificationsEnabled){
	// 		notifVC.scrollView.hidden = TRUE;
	// 		// HBLogWarn(@"firsttimehide");
	// 	}
	// firstTimeHide = FALSE;
	// }

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

	if([tapControlMode isEqualToString:@"toggle"]){
	if(!dateIsHidden){
		hide();
	}else{
		show();	
	}
	}
	else if([tapControlMode isEqualToString:@"automaticallyHide"]){

	if(!dateIsHidden){

	}else{
	
		show();

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
	hide();
}


%new
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender{


	if(!dateIsHidden){

	}else{
		show();
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

%end


//add if the control mode is automaticallyhide too

//SBLockScreenDateViewController
%hook NCNotificationListView


//hook scrollviewdidscroll


//stops the original timer that hides notifs from firing
-(void)_trackingDidBegin{
	%orig;
	// HBLogWarn(@"StringMode %@", userInteractionMode);
	if(isEnabled&&isHideNotificationsEnabled&&([longPressControlMode isEqualToString:@"automaticallyHide"]||[tapControlMode isEqualToString:@"automaticallyHide"])){
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
	if(isEnabled&&isHideNotificationsEnabled&&([longPressControlMode isEqualToString:@"automaticallyHide"]||[tapControlMode isEqualToString:@"automaticallyHide"])){
	dispatch_async(dispatch_get_main_queue(), ^{
			stoppedScrollingTimer = [NSTimer scheduledTimerWithTimeInterval:clockDisplayDuration
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






%hook CSQuickActionsViewController

-(void)viewDidLoad {
    actionsVC = (UIViewController *)self;
	%orig;

}

%end



%hook CSTeachableMomentsContainerViewController

-(void)viewDidLoad{
	unlockVC = (UIViewController *)self;
	// unlockVC.view.hidden = FALSE;
	%orig;
	// unlockVC.view.hidden = true;

}
%end


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

	[prefs registerBool:&isHideOnScreenLockEnabled default:FALSE forKey:@"isHideOnScreenLockEnabled"];

	[prefs registerBool:&isHideNotificationsEnabled default:FALSE forKey:@"isHideNotificationsEnabled"];

	[prefs registerBool:&isHideQuickActionsEnabled default:FALSE forKey:@"isHideQuickActionsEnabled"];

	// [prefs registerBool:&isSimpleLS2CompatibilityEnabled default:FALSE forKey:@"isSimpleLS2CompatibilityEnabled"];

	[prefs registerBool:&isHideUnlockTextEnabled default:FALSE forKey:@"isHideUnlockTextEnabled"];
	
}




%ctor {
	prefs= [[HBPreferences alloc] initWithIdentifier:@"com.atar13.houdiniprefs"];
	updateSettings();
	// CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)updateSettings, CFSTR("com.atar13.houdini/updateSettings"), NULL, kNilOptions);	
	// HBLogWarn(@"StringMode %@", mode);
	// if(kCFCoreFoundationVersionNumber>1665){
	// 	%init(iOS13);
	// }else{
	// 	%init(iOS12);
	// }
	%init;
}


