#line 1 "Tweak.x"

#import <Cephei/HBPreferences.h>
















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
BOOL notifsAreHidden = TRUE;

NSTimer *longPressTimer = nil;
BOOL longPressHasBeenHidden;
double clockDisplayDuration;

BOOL isHideNotificationsEnabled;

BOOL areNotifsTracking;
BOOL areNotifsDragging;




@interface NCNotificationListView : UIScrollView
@property (nonatomic, assign, readwrite, getter=isHidden)BOOL hidden;
-(void)reloadHeaderView;
@end
NCNotificationListView *notifsView;



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class NCNotificationListView; @class SBFLockScreenDateView; @class NCNotificationStructuredListViewController; @class SBFLockScreenDateViewController; 
static BOOL (*_logos_orig$_ungrouped$NCNotificationListView$isTracking)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$NCNotificationListView$isTracking(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$NCNotificationListView$isDragging)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$NCNotificationListView$isDragging(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationListView$reloadHeaderView)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListView$reloadHeaderView(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBFLockScreenDateViewController$_updateView)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateViewController$_updateView(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateViewController$hideDateAfterDelay(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UITapGestureRecognizer *); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UILongPressGestureRecognizer *); static void (*_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); 

#line 54 "Tweak.x"


	static BOOL _logos_method$_ungrouped$NCNotificationListView$isTracking(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
		areNotifsTracking = _logos_orig$_ungrouped$NCNotificationListView$isTracking(self, _cmd);
		if(areNotifsTracking){
			HBLogWarn(@"notiftracking");
		}
		return _logos_orig$_ungrouped$NCNotificationListView$isTracking(self, _cmd);
	}

	static BOOL _logos_method$_ungrouped$NCNotificationListView$isDragging(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
		areNotifsDragging = _logos_orig$_ungrouped$NCNotificationListView$isDragging(self, _cmd);
		if(areNotifsDragging){
		HBLogWarn(@"notifdragging");
		}
		return _logos_orig$_ungrouped$NCNotificationListView$isDragging(self, _cmd);
	}

static void _logos_method$_ungrouped$NCNotificationListView$reloadHeaderView(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

	notifsView = (NCNotificationListView *)self;


	if(isEnabled){
	_logos_orig$_ungrouped$NCNotificationListView$reloadHeaderView(self, _cmd);
	if(notifsAreHidden){
		self.hidden = TRUE;
	}else{
		self.hidden = FALSE;
	}
}
else{
	_logos_orig$_ungrouped$NCNotificationListView$reloadHeaderView(self, _cmd);
}
}





@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@end

SBFLockScreenDateViewController *timeVC;



	static void _logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
		_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(self, _cmd);
		timeVC = (SBFLockScreenDateViewController *)self;
	}

	static void _logos_method$_ungrouped$SBFLockScreenDateViewController$_updateView(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
		_logos_orig$_ungrouped$SBFLockScreenDateViewController$_updateView(self, _cmd);
			if(longPressHasBeenHidden){

	
	

		dispatch_async(dispatch_get_main_queue(), ^{
			longPressTimer = [NSTimer scheduledTimerWithTimeInterval:clockDisplayDuration
										target:self
										selector:@selector(hideDateAfterDelay)
										userInfo:nil
										repeats:NO];
		});
	}
	}


static void _logos_method$_ungrouped$SBFLockScreenDateViewController$hideDateAfterDelay(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	dateIsHidden = TRUE;
	[timeVC _updateView];
	if(isHideNotificationsEnabled){
			notifsAreHidden = TRUE;
			[notifsView reloadHeaderView];
	}
	longPressHasBeenHidden = FALSE;
}







@interface NCNotificationStructuredListViewController : UIViewController
@end

NCNotificationStructuredListViewController *notifVC;



static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	notifVC = (NCNotificationStructuredListViewController *)self;
	UIViewController *_self = (UIViewController *)self;

	if(isTapModeEnabled){
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
		UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
		tapPress.numberOfTapsRequired = (int)numberOfTaps;
		tapPress.numberOfTouchesRequired = (int)numberOfFingersTapped;
		[_self.view addGestureRecognizer:tapPress];
		
	}else if(isLongPressModeEnabled){
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
		UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:_self action:@selector(handleLongPress:)];
		longPress.minimumPressDuration = longPressDuration;
		longPress.numberOfTouchesRequired = (int)numberOfFingersHeld;
		longPress.allowableMovement = allowableMovement;
		[_self.view addGestureRecognizer: longPress];
	}
	else if(isTapModeEnabled&&isLongPressModeEnabled){
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
		UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
		tapPress.numberOfTapsRequired = (int)numberOfTaps;
		tapPress.numberOfTouchesRequired = (int)numberOfFingersTapped;
		[_self.view addGestureRecognizer:tapPress];
		
	}
	else{
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
	}

	
	
	
	
	
	
	
	
	
	
	

}


static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITapGestureRecognizer * sender){
	if(!dateIsHidden){
		dateIsHidden = TRUE;	
		[timeVC _updateView];
		if(isHideNotificationsEnabled){
			notifsAreHidden = TRUE;
			[notifsView reloadHeaderView];
		}

	}else{
		dateIsHidden = FALSE;
		[timeVC _updateView];
		if(isHideNotificationsEnabled){
			notifsAreHidden = FALSE;
			[notifsView reloadHeaderView];
		}
	}
}


static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UILongPressGestureRecognizer * sender){

		if(!dateIsHidden){
		
		

	}else{
		longPressHasBeenHidden = TRUE;
	
		dateIsHidden = FALSE;
		[timeVC _updateView];
		if(isHideNotificationsEnabled){
			notifsAreHidden = FALSE;
			[notifsView reloadHeaderView];
		}
	}
}







@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end



static void _logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

	if(isEnabled){
	_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels(self, _cmd);
		
		if(dateIsHidden){
			self.subtitleHidden = TRUE;
			self.hidden = TRUE;
			

		}else{
			self.subtitleHidden = FALSE;
			self.hidden = FALSE;
			
		}

	}
	else{
		_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels(self, _cmd);
	}
}





void updateSettings(){
	[prefs registerBool:&isEnabled default:TRUE forKey:@"isEnabled"];

	[prefs registerBool:&isTapModeEnabled default:TRUE forKey:@"isTapModeEnabled"];
	[prefs registerInteger:&numberOfTaps default:2 forKey:@"numberOfTaps"];
	[prefs registerInteger:&numberOfFingersTapped default:1 forKey:@"numberOfFingersTapped"];

	[prefs registerBool:&isLongPressModeEnabled default:FALSE forKey:@"isLongPressModeEnabled"];
	[prefs registerInteger:&numberOfFingersHeld default:1 forKey:@"numberOfFingersHeld"];
	[prefs registerDouble:&longPressDuration default:0.5 forKey:@"longPressDuration"];
	[prefs registerDouble:&clockDisplayDuration default:0.5 forKey:@"clockDisplayDuration"];

	[prefs registerBool:&isHideNotificationsEnabled default:FALSE forKey:@"isHideNotificationsEnabled"];
}




static __attribute__((constructor)) void _logosLocalCtor_96660fcf(int __unused argc, char __unused **argv, char __unused **envp) {
	prefs= [[HBPreferences alloc] initWithIdentifier:@"com.atar13.houdiniprefs"];
	updateSettings();
	

	{Class _logos_class$_ungrouped$NCNotificationListView = objc_getClass("NCNotificationListView"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListView, @selector(isTracking), (IMP)&_logos_method$_ungrouped$NCNotificationListView$isTracking, (IMP*)&_logos_orig$_ungrouped$NCNotificationListView$isTracking);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListView, @selector(isDragging), (IMP)&_logos_method$_ungrouped$NCNotificationListView$isDragging, (IMP*)&_logos_orig$_ungrouped$NCNotificationListView$isDragging);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListView, @selector(reloadHeaderView), (IMP)&_logos_method$_ungrouped$NCNotificationListView$reloadHeaderView, (IMP*)&_logos_orig$_ungrouped$NCNotificationListView$reloadHeaderView);Class _logos_class$_ungrouped$SBFLockScreenDateViewController = objc_getClass("SBFLockScreenDateViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad);MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateViewController, @selector(_updateView), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateViewController$_updateView, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateViewController$_updateView);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBFLockScreenDateViewController, @selector(hideDateAfterDelay), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateViewController$hideDateAfterDelay, _typeEncoding); }Class _logos_class$_ungrouped$NCNotificationStructuredListViewController = objc_getClass("NCNotificationStructuredListViewController"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITapGestureRecognizer *), strlen(@encode(UITapGestureRecognizer *))); i += strlen(@encode(UITapGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(handleTap:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UILongPressGestureRecognizer *), strlen(@encode(UILongPressGestureRecognizer *))); i += strlen(@encode(UILongPressGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(handleLongPress:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$, _typeEncoding); }Class _logos_class$_ungrouped$SBFLockScreenDateView = objc_getClass("SBFLockScreenDateView"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateView, @selector(_updateLabels), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels);}
}
