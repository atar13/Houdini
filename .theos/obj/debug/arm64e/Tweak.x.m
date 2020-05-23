#line 1 "Tweak.x"
bool dateIsTapped = YES;

int counter = 0;

@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@end

SBFLockScreenDateViewController *timeVC;


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

@class NCNotificationStructuredListViewController; @class SBFLockScreenDateView; @class SBFLockScreenDateViewController; 
static void (*_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UITapGestureRecognizer *); static void (*_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); 

#line 11 "Tweak.x"



	static void _logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad(self, _cmd);

	timeVC = (SBFLockScreenDateViewController *)self;

	}



@interface NCNotificationStructuredListViewController : UIViewController
@end




static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
	UIViewController *_self = (UIViewController *)self;
	UITapGestureRecognizer *tapPress =  [[UITapGestureRecognizer alloc] initWithTarget:_self action:@selector(handleTap:)];
	tapPress.numberOfTapsRequired = 2;
	[_self.view addGestureRecognizer:tapPress];
	
}


static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITapGestureRecognizer * sender){
	if(!dateIsTapped){
	counter=0;
	dateIsTapped = YES;

	
	}else{
		dateIsTapped = NO;
		counter++;
	}
	[timeVC _updateView];
}



@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end




int timer = 0;

static void _logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels(self, _cmd);


	
	if(dateIsTapped){
	self.subtitleHidden = YES;
	self.hidden = YES;
	HBLogWarn(@"NOTLOADED");

	}else{
	self.subtitleHidden = NO;
	self.hidden = NO;
	HBLogWarn(@"ISLOADED");

	}

}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBFLockScreenDateViewController = objc_getClass("SBFLockScreenDateViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateViewController$viewDidLoad);Class _logos_class$_ungrouped$NCNotificationStructuredListViewController = objc_getClass("NCNotificationStructuredListViewController"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITapGestureRecognizer *), strlen(@encode(UITapGestureRecognizer *))); i += strlen(@encode(UITapGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(handleTap:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$handleTap$, _typeEncoding); }Class _logos_class$_ungrouped$SBFLockScreenDateView = objc_getClass("SBFLockScreenDateView"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateView, @selector(_updateLabels), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateView$_updateLabels, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateView$_updateLabels);} }
#line 83 "Tweak.x"
