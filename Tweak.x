bool dateIsTapped = YES;

int counter = 0;

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

//maybe an option for which areas to tap on
@interface NCNotificationStructuredListViewController : UIViewController
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
	if(!dateIsTapped){
	counter=0;
	dateIsTapped = YES;

	
	}else{
		dateIsTapped = NO;
		counter++;
	}
	[timeVC _updateView];
}

%end

@interface SBFLockScreenDateView : UIView
@property (assign,getter=isSubtitleHidden,nonatomic) BOOL subtitleHidden;
@end


%hook SBFLockScreenDateView

int timer = 0;

-(void)_updateLabels{
	%orig;


	//check if area is tapped
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

%end
