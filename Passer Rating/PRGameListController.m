//
//  PRGameListController.m
//  Passer Rating
//
//  Created by Xcode User on 8/5/13.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import "PRGameListController.h"
#import "PRDataModel.h"
	// Loads the declaration PRPasser and PRGame

//  Declare the formatters.
//  Formatters work better than passing values through
//  +[NSString stringWithFormat:] because the resulting
//  strings will always match the user's locale and
//  preferences.
static NSDateFormatter *		shortDateFormatter;
static NSNumberFormatter *		intFormatter;
static NSNumberFormatter *		ratingFormatter;


@interface PRGameListController ()
@property (weak, nonatomic) IBOutlet UILabel *passerRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *attemptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *completionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *yardsLabel;
@property (weak, nonatomic) IBOutlet UILabel *touchdownsLabel;
@property (weak, nonatomic) IBOutlet UILabel *interceptionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *datesLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
	
- (void) configureView;

@end

@implementation PRGameListController

//  The runtime calls +initialize before the first use
//  of a class. This is simplified here; look +initialize
//  up in the documentation for the problem of it being
//  called more than once.

+ (void) initialize
{
#if DISPATCH_ONCE
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		//  Cache integer and date formatters
        intFormatter = [[NSNumberFormatter alloc] init];
        intFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        intFormatter.minimumIntegerDigits = 1;
        intFormatter.maximumFractionDigits = 0;
		
		ratingFormatter = [[NSNumberFormatter alloc] init];
		ratingFormatter.numberStyle = NSNumberFormatterDecimalStyle;
		ratingFormatter.minimumIntegerDigits = 1;
		ratingFormatter.maximumFractionDigits =
			ratingFormatter.minimumFractionDigits = 1;
        
        shortDateFormatter = [[NSDateFormatter alloc] init];
        shortDateFormatter.timeStyle = NSDateFormatterNoStyle;
        shortDateFormatter.dateStyle = NSDateFormatterShortStyle;
	});
#else
    if (! shortDateFormatter) {
        intFormatter = [[NSNumberFormatter alloc] init];
        intFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        intFormatter.minimumIntegerDigits = 1;
        intFormatter.maximumFractionDigits = 0;
		
		ratingFormatter = [[NSNumberFormatter alloc] init];
		ratingFormatter.numberStyle = NSNumberFormatterDecimalStyle;
		ratingFormatter.minimumIntegerDigits = 1;
		ratingFormatter.maximumFractionDigits =
		ratingFormatter.minimumFractionDigits = 1;
        
        shortDateFormatter = [[NSDateFormatter alloc] init];
        shortDateFormatter.timeStyle = NSDateFormatterNoStyle;
        shortDateFormatter.dateStyle = NSDateFormatterShortStyle;
    }
#endif
}

#pragma mark - Managing the detail item

- (void) setDetailItem: (id <NSObject>) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
		PRPasser *		thePasser = self.detailItem;
		NSArray *	integerProperties = @[
						  @"attempts",
						  @"completions",
						  @"yards",
						  @"touchdowns",
						  @"interceptions"];
		for (NSString * prop in integerProperties) {
			//	Get the property from the PRPasser
			//	valueForKey: will wrap it as an NSNumber object
			NSNumber *	statObject;
			statObject = [thePasser valueForKey: prop];
			
			//	Find my label by name
			NSString *	labelName = [prop stringByAppendingString: @"Label"];
			UILabel *	label = (UILabel *) [self valueForKey: labelName];
			
			//	Put the stat's formatted string into the label.
			label.text = [intFormatter stringFromNumber: statObject];
		}
		
		//	Passer rating
		NSString *		ratingString;
		ratingString = [NSString stringWithFormat: @"%.1lf",
						thePasser.passerRating];
		self.passerRatingLabel.text = ratingString;
		
		//	Team name
		self.currentTeamLabel.text = thePasser.currentTeam;
		
		//	Start and end of career
		NSString *		startString, * endString;
		startString = [shortDateFormatter stringFromDate:
					   thePasser.firstPlayed];
		endString = [shortDateFormatter stringFromDate:
					 thePasser.lastPlayed];
		self.datesLabel.text = [NSString stringWithFormat: @"%@ – %@",
							   startString, endString];
		
		//	Name label and controller (nav bar) title.
		self.title =
		self.fullNameLabel.text = [NSString stringWithFormat: @"%@ %@",
								   thePasser.firstName, thePasser.lastName];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
