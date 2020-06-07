#line 1 "Tweak.x"
#import <Cephei/HBPreferences.h>
















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

@class NCNotificationListView; @class SBFLockScreenDateViewController; @class SBFLockScreenDateView; @class NCNotificationStructuredListViewController; @class SBLockScreenDateViewController; 
static void (*_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewWillAppear)(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewWillAppear(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UITapGestureRecognizer *); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$hideDateAfterDelay(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$doNothing(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UILongPressGestureRecognizer *); static void (*_logos_orig$_ungrouped$NCNotificationListView$_trackingDidBegin)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListView$_trackingDidBegin(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListView$hideNotifsAfterScrollingEnds(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); 

#line 49 "Tweak.x"
static void (*_logos_orig$iOS13$SBFLockScreenDateViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS13$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$iOS13$SBFLockScreenDateView$_updateLabels)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS13$SBFLockScreenDateView$_updateLabels(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); 

@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@end

SBFLockScreenDateViewController *timeVC;



	static void _logos_method$iOS13$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
		_logos_orig$iOS13$SBFLockScreenDateViewController$viewDidLoad(self, _cmd);
		timeVC = (SBFLockScreenDateViewController *)self;
	}





@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end



static void _logos_method$iOS13$SBFLockScreenDateView$_updateLabels(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

	if(isEnabled){
	_logos_orig$iOS13$SBFLockScreenDateView$_updateLabels(self, _cmd);
		
		if(dateIsHidden){
			self.subtitleHidden = TRUE;
			self.hidden = TRUE;
		}else{
			self.subtitleHidden = FALSE;
			self.hidden = FALSE;
		}
	}
	else{
		_logos_orig$iOS13$SBFLockScreenDateView$_updateLabels(self, _cmd);
	}
}





static void (*_logos_orig$iOS12$SBLockScreenDateViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS12$SBLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$iOS12$SBLockScreenDateViewController$_updateView)(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS12$SBLockScreenDateViewController$_updateView(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); 

@interface SBLockScreenDateViewController : UIViewController
-(void)_updateView;

@end

SBLockScreenDateViewController *ios12TimeVC;



	static void _logos_method$iOS12$SBLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
		_logos_orig$iOS12$SBLockScreenDateViewController$viewDidLoad(self, _cmd);
		ios12TimeVC = (SBLockScreenDateViewController *)self;

	}

	static void _logos_method$iOS12$SBLockScreenDateViewController$_updateView(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	if(isEnabled){
	_logos_orig$iOS12$SBLockScreenDateViewController$_updateView(self, _cmd);
		
		if(dateIsHidden){
			
			self.view.hidden = TRUE;
		}else{
			
			self.view.hidden = FALSE;
		}
	}
	else{
		_logos_orig$iOS12$SBLockScreenDateViewController$_updateView(self, _cmd);
	}
	}








@interface NCNotificationStructuredListViewController : UIViewController
@property (nonatomic, assign, readwrite) UIScrollView *scrollView;
-(void)hideDateAfterDelay;
@end

NCNotificationStructuredListViewController *notifVC;



static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewWillAppear(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	notifVC.scrollView.hidden = TRUE;

	










}

static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
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
		
		firstTimeHide = FALSE;
	}

	if([userInteractionMode isEqualToString:@"tap"]){
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
		UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
		tapPress.numberOfTapsRequired = (int)numberOfTaps;
		tapPress.numberOfTouchesRequired = (int)numberOfFingersTapped;
		[_self.view addGestureRecognizer:tapPress];
		
	}else if([userInteractionMode isEqualToString:@"longPress"]){
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
		UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:_self action:@selector(handleLongPress:)];
		longPress.minimumPressDuration = longPressDuration;
		longPress.numberOfTouchesRequired = (int)numberOfFingersHeld;
		longPress.allowableMovement = allowableMovement;
		[_self.view addGestureRecognizer: longPress];
	}
	else{
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
	}
}
else{
	_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
}

}



static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITapGestureRecognizer * sender){
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


static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$hideDateAfterDelay(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
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

 
static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$doNothing(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

}


static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UILongPressGestureRecognizer * sender){


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	


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

	 	
		
		dispatch_async(dispatch_get_main_queue(), ^{
			longPressTimer = [NSTimer scheduledTimerWithTimeInterval:clockDisplayDuration
										target:self
										selector:@selector(hideDateAfterDelay)
										userInfo:nil
										repeats:NO];	

		});
	}




}





@interface NCNotificationListView : UIScrollView
@end









static void _logos_method$_ungrouped$NCNotificationListView$_trackingDidBegin(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$NCNotificationListView$_trackingDidBegin(self, _cmd);
	
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



static void _logos_method$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating(self, _cmd);
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


static void _logos_method$_ungrouped$NCNotificationListView$hideNotifsAfterScrollingEnds(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	[notifVC hideDateAfterDelay];
}











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




static __attribute__((constructor)) void _logosLocalCtor_8b2915ba(int __unused argc, char __unused **argv, char __unused **envp) {
	prefs= [[HBPreferences alloc] initWithIdentifier:@"com.atar13.houdiniprefs"];
	updateSettings();
	
	
	if(kCFCoreFoundationVersionNumber>1665){
		{Class _logos_class$iOS13$SBFLockScreenDateViewController = objc_getClass("SBFLockScreenDateViewController"); MSHookMessageEx(_logos_class$iOS13$SBFLockScreenDateViewController, @selector(viewDidLoad), (IMP)&_logos_method$iOS13$SBFLockScreenDateViewController$viewDidLoad, (IMP*)&_logos_orig$iOS13$SBFLockScreenDateViewController$viewDidLoad);Class _logos_class$iOS13$SBFLockScreenDateView = objc_getClass("SBFLockScreenDateView"); MSHookMessageEx(_logos_class$iOS13$SBFLockScreenDateView, @selector(_updateLabels), (IMP)&_logos_method$iOS13$SBFLockScreenDateView$_updateLabels, (IMP*)&_logos_orig$iOS13$SBFLockScreenDateView$_updateLabels);}
	}else{
		{Class _logos_class$iOS12$SBLockScreenDateViewController = objc_getClass("SBLockScreenDateViewController"); MSHookMessageEx(_logos_class$iOS12$SBLockScreenDateViewController, @selector(viewDidLoad), (IMP)&_logos_method$iOS12$SBLockScreenDateViewController$viewDidLoad, (IMP*)&_logos_orig$iOS12$SBLockScreenDateViewController$viewDidLoad);MSHookMessageEx(_logos_class$iOS12$SBLockScreenDateViewController, @selector(_updateView), (IMP)&_logos_method$iOS12$SBLockScreenDateViewController$_updateView, (IMP*)&_logos_orig$iOS12$SBLockScreenDateViewController$_updateView);}
	}
	{Class _logos_class$_ungrouped$NCNotificationStructuredListViewController = objc_getClass("NCNotificationStructuredListViewController"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(viewWillAppear), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$viewWillAppear, (IMP*)&_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewWillAppear);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITapGestureRecognizer *), strlen(@encode(UITapGestureRecognizer *))); i += strlen(@encode(UITapGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(handleTap:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(hideDateAfterDelay), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$hideDateAfterDelay, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(doNothing), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$doNothing, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UILongPressGestureRecognizer *), strlen(@encode(UILongPressGestureRecognizer *))); i += strlen(@encode(UILongPressGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(handleLongPress:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$, _typeEncoding); }Class _logos_class$_ungrouped$NCNotificationListView = objc_getClass("NCNotificationListView"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListView, @selector(_trackingDidBegin), (IMP)&_logos_method$_ungrouped$NCNotificationListView$_trackingDidBegin, (IMP*)&_logos_orig$_ungrouped$NCNotificationListView$_trackingDidBegin);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListView, @selector(_scrollViewDidEndDecelerating), (IMP)&_logos_method$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating, (IMP*)&_logos_orig$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationListView, @selector(hideNotifsAfterScrollingEnds), (IMP)&_logos_method$_ungrouped$NCNotificationListView$hideNotifsAfterScrollingEnds, _typeEncoding); }}

}


