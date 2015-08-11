//
//  PRGameListController.m
//  Passer Rating
//
//  Created by Xcode User on 8/5/13.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import "PRGameListController.h"
#import "PRDataModel.h"
#import "PRPasser.h"
// Loads the declaration PRPasser and PRGame

//  Declare the formatters.
//  Formatters work better than passing values through
//  +[NSString stringWithFormat:] because the resulting
//  strings will always match the user's locale and
//  preferences.
static NSDateFormatter *		shortDateFormatter;
static NSNumberFormatter *		intFormatter;
static NSNumberFormatter *		ratingFormatter;


@interface PRGameListController () {
    NSArray *_arrangedGamesCache;
}

- (void)configureView;
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
        _arrangedGamesCache = nil;
        
        //  Update the UI
        [self.tableView reloadData];
        [self configureView];
    }
}



- (void) configureView
{
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

- (NSArray *) arrangedGames
{
    static NSArray *    sByDate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sByDate = @[
                    [NSSortDescriptor sortDescriptorWithKey: @"whenPlayed"
                                                  ascending: YES]
                    ];
    });
    
    if (!_arrangedGamesCache) {
        PRPasser *		passer = self.detailItem;
        _arrangedGamesCache = [passer.games sortedArrayUsingDescriptors: sByDate];
    }
    return _arrangedGamesCache;
}


#pragma mark - UITableViewDataSource

- (NSInteger) tableView: (UITableView *) tableView
  numberOfRowsInSection: (NSInteger) section
{
    PRPasser *        passer = self.detailItem;
    return passer.games.count;
}

#define BASIC_CELL			1
#define CUSTOM_CELL			2
#define GRAPHIC_CELL		3
#define CELL_TO_USE			GRAPHIC_CELL

#if CELL_TO_USE == CUSTOM_CELL || CELL_TO_USE == GRAPHIC_CELL
//  Tag values for the labels in the game cell
#define CELL_RATING_LABEL   1
#define CELL_SCORE_LABEL    2
#define CELL_STATS_LABEL    3
#define CELL_REACTION_IMAGE	4
#endif

- (UITableViewCell *) tableView: (UITableView *) aTableView
          cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    UITableViewCell *		cell;
    NSString *				cellIdentifier;
    
#if CELL_TO_USE == BASIC_CELL
    cellIdentifier = @"Basic Game Cell";
#elif CELL_TO_USE == CUSTOM_CELL
    cellIdentifier = @"Custom Game Cell";
#elif CELL_TO_USE == GRAPHIC_CELL
    cellIdentifier = @"Graphical Game Cell";
#else
#error No cell type was selected
#endif
    
    cell =
    [self.tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    PRGame *		game = [self.arrangedGames objectAtIndex: indexPath.row];
    
    
#if CELL_TO_USE == BASIC_CELL
    //  Pull data from this row's Game.
    NSString *		content;
    content = [NSString stringWithFormat: @"vs %@ %@ - %@",
               game.theirTeam,
               [shortDateFormatter stringFromDate: game.whenPlayed],
               [ratingFormatter stringFromNumber: @(game.passerRating)]];
    cell.textLabel.text = content;
    //	Why box the passer rating in an NSNumber when it could go into
    //	%.1lf? The float formatter doesn't automatically localize the format.
    
#elif CELL_TO_USE == CUSTOM_CELL || CELL_TO_USE == GRAPHIC_CELL
    UILabel *	currentLabel;
    currentLabel = (UILabel *)[cell viewWithTag: CELL_RATING_LABEL];
    currentLabel.text = [ratingFormatter stringFromNumber: @(game.passerRating)];
    
    currentLabel = (UILabel *)[cell viewWithTag: CELL_SCORE_LABEL];
    NSString *	content;
    content = [NSString stringWithFormat:
               @"%@ %d\n%@ %d\n%@",
               game.ourTeam, game.ourScore.intValue,
               game.theirTeam, game.theirScore.intValue,
               [shortDateFormatter stringFromDate: game.whenPlayed]];
    currentLabel.text = content;
    
    currentLabel = (UILabel *) [cell viewWithTag: CELL_STATS_LABEL];
    content = [NSString stringWithFormat:
               @"%d/%d - %d yd - %d TD - %d INT",
               game.completions.intValue, game.attempts.intValue,
               game.yards.intValue, game.touchdowns.intValue,
               game.interceptions.intValue];
    currentLabel.text = content;
#if CELL_TO_USE == GRAPHIC_CELL
    //	Nope, that's the wrong format for the stats label.
    content = [NSString stringWithFormat:
               @"%d/%d - %d yd\n%d TD - %d INT",
               game.completions.intValue, game.attempts.intValue,
               game.yards.intValue, game.touchdowns.intValue,
               game.interceptions.intValue];
    currentLabel.text = content;
    
    //	Get the image view
    UIImageView *	reactionView;
    reactionView = (UIImageView *)[cell viewWithTag: CELL_REACTION_IMAGE];
    //	Fetch the reaction image for the rating
    UIImage *		reactionImage;
    if (game.passerRating < 122.0) {
        reactionImage = [UIImage imageNamed: @"Despondent"];
    }
    else {
        reactionImage = [UIImage imageNamed: @"Elated"];
    }
    //	Set the image.
    reactionView.image = reactionImage;
#endif	//	Graphic
#else	//	Ends Custom + Graphic
#error No cell type was selected
#endif
    
    return cell;
}


@end
