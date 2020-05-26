//pref ideas
//TIMER
//maybe an option for which areas to tap on
//number of taps
//number of fingers
//maybe long press
//enabled or not
//timeout number vs toggling mode
//maybe hide notifs too


bool dateIsHidden = YES;
int timer = 0;

@interface SBFLockScreenDateViewController : UIViewController
-(void)_updateView;
@end

SBFLockScreenDateViewController *timeVC;



%hook SBFLockScreenDateViewController


	-(void)viewDidLoad{
	%orig;

	timeVC = (SBFLockScreenDateViewController *)self;



		NSString *timerString = [NSString stringWithFormat:@"%d",timer];

	HBLogWarn(@"TimerString %@\n",timerString);
	



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
	tapPress.numberOfTapsRequired = 2;
	[_self.view addGestureRecognizer:tapPress];
	// _self.userInteractionEnabled = YES;

	
}

%new
-(void)handleTap:(UITapGestureRecognizer *)sender{
	if(!dateIsHidden){
		dateIsHidden = YES;
	
	[timeVC _updateView];

	}else{
		dateIsHidden = NO;
		[timeVC _updateView];

	}



}

%end

@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end


%hook SBFLockScreenDateView



-(void)_updateLabels{
	%orig;



	//check if area is tapped
	if(dateIsHidden){
	self.subtitleHidden = YES;
	self.hidden = YES;
	HBLogWarn(@"NOTLOADED");

	}else{
	self.subtitleHidden = NO;
	self.hidden = NO;
	HBLogWarn(@"ISLOADED");

	
	// self.subtitleHidden = YES;
	// self.hidden = YES;	
	}


//


}

%end
