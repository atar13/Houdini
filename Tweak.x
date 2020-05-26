
#import <Cephei/HBPreferences.h>


//pref ideas
//TIMER
//maybe an option for which areas to tap on
//number of taps
//number of fingers
//maybe long press
//enabled or not
//timeout number vs toggling mode
//maybe hide notifs too
//Fade animation?

BOOL isEnabled;
NSInteger numberOfTaps;
NSInteger numberOfFingersTapped;
BOOL dateIsHidden = TRUE;

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




@interface NCNotificationStructuredListViewController : UIViewController
-(void)onTick;
@end

%hook NCNotificationStructuredListViewController

-(void)viewDidLoad {
	%orig;
	UIViewController *_self = (UIViewController *)self;
	UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
	tapPress.numberOfTapsRequired = (int)numberOfTaps;
	tapPress.numberOfTouchesRequired = (int)numberOfFingersTapped;
	[_self.view addGestureRecognizer:tapPress];
	// _self.userInteractionEnabled = TRUE;

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


%ctor {
	HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.atar13.houdiniprefs"];
	[prefs registerBool:&isEnabled default:TRUE forKey:@"isEnabled"];
	[prefs registerInteger:&numberOfTaps default:2 forKey:@"numberOfTaps"];
	[prefs registerInteger:&numberOfFingersTapped default:1 forKey:@"numberOfFingersTapped"];
	%init;
}