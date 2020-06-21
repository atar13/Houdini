#line 1 "Tweak.x"
#import <Cephei/HBPreferences.h>

















@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@property (assign,nonatomic) BOOL screenOff;    
@end

@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end


@interface NCNotificationStructuredListViewController : UIViewController
@property (nonatomic, assign, readwrite) UIScrollView *scrollView;
-(void)hideDateAfterDelay;
@end


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

@class NCNotificationStructuredListViewController; @class CSQuickActionsViewController; @class CSTeachableMomentsContainerViewController; @class NCNotificationListView; @class SBFLockScreenDateView; @class SBFLockScreenDateViewController; 
static void (*_logos_orig$_ungrouped$SBFLockScreenDateViewController$setScreenOff$)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SBFLockScreenDateViewController$setScreenOff$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UITapGestureRecognizer *); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$hideDateAfterDelay(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UILongPressGestureRecognizer *); static void (*_logos_orig$_ungrouped$NCNotificationListView$_trackingDidBegin)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListView$_trackingDidBegin(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListView$hideNotifsAfterScrollingEnds(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$CSQuickActionsViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL CSQuickActionsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSQuickActionsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL CSQuickActionsViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$CSTeachableMomentsContainerViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL CSTeachableMomentsContainerViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSTeachableMomentsContainerViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL CSTeachableMomentsContainerViewController* _LOGOS_SELF_CONST, SEL); 

#line 141 "Tweak.x"



	static void _logos_method$_ungrouped$SBFLockScreenDateViewController$setScreenOff$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {

			_logos_orig$_ungrouped$SBFLockScreenDateViewController$setScreenOff$(self, _cmd, arg1);
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

	static void _logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
		_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(self, _cmd);
		timeVC = (SBFLockScreenDateViewController *)self;
		
		if(self.screenOff){

		}
	}







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













static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	notifVC = (NCNotificationStructuredListViewController *)self;
	 UIViewController *_self = (UIViewController *)self;

if(isEnabled){

	
	
	
	
	
	
	
	
	
	
	
	
	

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
	hide();
}



static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UILongPressGestureRecognizer * sender){


	if(!dateIsHidden){

	}else{
		show();
	 	
		
		dispatch_async(dispatch_get_main_queue(), ^{
			longPressTimer = [NSTimer scheduledTimerWithTimeInterval:clockDisplayDuration
										target:self
										selector:@selector(hideDateAfterDelay)
										userInfo:nil
										repeats:NO];	

		});
	}
}














static void _logos_method$_ungrouped$NCNotificationListView$_trackingDidBegin(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$NCNotificationListView$_trackingDidBegin(self, _cmd);
	
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



static void _logos_method$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating(self, _cmd);
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


static void _logos_method$_ungrouped$NCNotificationListView$hideNotifsAfterScrollingEnds(_LOGOS_SELF_TYPE_NORMAL NCNotificationListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	[notifVC hideDateAfterDelay];
}










static void _logos_method$_ungrouped$CSQuickActionsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL CSQuickActionsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    actionsVC = (UIViewController *)self;
	_logos_orig$_ungrouped$CSQuickActionsViewController$viewDidLoad(self, _cmd);

}







static void _logos_method$_ungrouped$CSTeachableMomentsContainerViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL CSTeachableMomentsContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	unlockVC = (UIViewController *)self;
	
	_logos_orig$_ungrouped$CSTeachableMomentsContainerViewController$viewDidLoad(self, _cmd);
	

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

	[prefs registerBool:&isHideOnScreenLockEnabled default:FALSE forKey:@"isHideOnScreenLockEnabled"];

	[prefs registerBool:&isHideNotificationsEnabled default:FALSE forKey:@"isHideNotificationsEnabled"];

	[prefs registerBool:&isHideQuickActionsEnabled default:FALSE forKey:@"isHideQuickActionsEnabled"];

	

	[prefs registerBool:&isHideUnlockTextEnabled default:FALSE forKey:@"isHideUnlockTextEnabled"];
	
}




static __attribute__((constructor)) void _logosLocalCtor_4e95f3b8(int __unused argc, char __unused **argv, char __unused **envp) {
	prefs= [[HBPreferences alloc] initWithIdentifier:@"com.atar13.houdiniprefs"];
	updateSettings();
	
	
	
	
	
	
	
	{Class _logos_class$_ungrouped$SBFLockScreenDateViewController = objc_getClass("SBFLockScreenDateViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateViewController, @selector(setScreenOff:), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateViewController$setScreenOff$, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateViewController$setScreenOff$);MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad);Class _logos_class$_ungrouped$SBFLockScreenDateView = objc_getClass("SBFLockScreenDateView"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateView, @selector(_updateLabels), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels);Class _logos_class$_ungrouped$NCNotificationStructuredListViewController = objc_getClass("NCNotificationStructuredListViewController"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITapGestureRecognizer *), strlen(@encode(UITapGestureRecognizer *))); i += strlen(@encode(UITapGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(handleTap:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(hideDateAfterDelay), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$hideDateAfterDelay, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UILongPressGestureRecognizer *), strlen(@encode(UILongPressGestureRecognizer *))); i += strlen(@encode(UILongPressGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(handleLongPress:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$handleLongPress$, _typeEncoding); }Class _logos_class$_ungrouped$NCNotificationListView = objc_getClass("NCNotificationListView"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListView, @selector(_trackingDidBegin), (IMP)&_logos_method$_ungrouped$NCNotificationListView$_trackingDidBegin, (IMP*)&_logos_orig$_ungrouped$NCNotificationListView$_trackingDidBegin);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListView, @selector(_scrollViewDidEndDecelerating), (IMP)&_logos_method$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating, (IMP*)&_logos_orig$_ungrouped$NCNotificationListView$_scrollViewDidEndDecelerating);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationListView, @selector(hideNotifsAfterScrollingEnds), (IMP)&_logos_method$_ungrouped$NCNotificationListView$hideNotifsAfterScrollingEnds, _typeEncoding); }Class _logos_class$_ungrouped$CSQuickActionsViewController = objc_getClass("CSQuickActionsViewController"); MSHookMessageEx(_logos_class$_ungrouped$CSQuickActionsViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$CSQuickActionsViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$CSQuickActionsViewController$viewDidLoad);Class _logos_class$_ungrouped$CSTeachableMomentsContainerViewController = objc_getClass("CSTeachableMomentsContainerViewController"); MSHookMessageEx(_logos_class$_ungrouped$CSTeachableMomentsContainerViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$CSTeachableMomentsContainerViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$CSTeachableMomentsContainerViewController$viewDidLoad);}
}


