#import "PRDataModel.h"
#import "rating.h"
#import "SimpleCSVFile.h"

@interface PRGame ()

// Private interface goes here.

@end


@implementation PRGame

- (double) passerRating
{
    double  rating = passer_rating(self.completionsValue,
                                   self.attemptsValue,
                                   self.yardsValue,
                                   self.touchdownsValue,
                                   self.interceptionsValue);
    return rating;
}

+ (NSUInteger) count: (NSManagedObjectContext *) moc
{
	NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName: @"PRGame"];
	return [moc countForFetchRequest: request
                               error: NULL];
}

#pragma mark - Loading from CSV

+ (BOOL) loadFromCSVFile: (NSString *) path
             intoContext: (NSManagedObjectContext *) moc
                   error: (NSError **) error
{
	SimpleCSVFile *		csv = [[SimpleCSVFile alloc] initWithPath: path];
    BOOL                success;
    
    //  csv.moc = moc;
    success = [csv run: ^BOOL(SimpleCSVFile *file,
                              NSDictionary *values,
                              NSError **error) {
        PRGame *		newGame;
        newGame = [self insertInManagedObjectContext: moc];
        assert(newGame);
        
        NSString *		firstName = values[@"firstName"];
        NSString *		lastName = values[@"lastName"];
        PRPasser *		passer = [PRPasser passerWithFirstName: firstName
                                                  lastName: lastName
                                                 inContext: moc];
        NSAssert(passer, @"%s Can't create passer %@, %@",
                 __PRETTY_FUNCTION__, firstName, lastName);
        
        newGame.passer = passer;
        passer.currentTeam = values[@"ourTeam"];
        
        for (NSString * key in [self numericAttributes]) {
            NSString *		datum = values[key];
            NSAssert(datum, @"Could not get %@ from CSV %@", key, values);
            [newGame setValue: @(datum.intValue)
                       forKey: key];
        }
        newGame.ourTeam = values[@"ourTeam"];
        newGame.theirTeam = values[@"theirTeam"];
        newGame.whenPlayed = [[self yyyy_MM_ddFormatter]
                              dateFromString: values[@"whenPlayed"]];
        return YES;
        
    } error: error
               ];
    
	return success;
}

#pragma mark - Formatters

+ (NSDateFormatter *) yyyy_MM_ddFormatter
{
    static NSDateFormatter *	sDateFormat;
    static dispatch_once_t      onceToken;
    dispatch_once(&onceToken, ^{
        sDateFormat = [[NSDateFormatter alloc] init];
		sDateFormat.dateFormat = @"yyyy-MM-dd";
    });
    return sDateFormat;
}

+ (NSDateFormatter *) shortFormatter
{
    static NSDateFormatter *    sShortFormat;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        sShortFormat = [[NSDateFormatter alloc] init];
		sShortFormat.dateStyle = NSDateFormatterShortStyle;
    });
    return sShortFormat;
}

#pragma mark - Editor support

+ (NSArray *) allAttributes
{
	static NSArray *			sAllAttributes = nil;
    static dispatch_once_t      onceToken;
    dispatch_once(&onceToken, ^{
        sAllAttributes = @[ @"whenPlayed", @"theirTeam",  @"theirScore",
                            @"touchdowns", @"completions", @"ourTeam",
                            @"ourScore", @"yards", @"attempts",
                            @"interceptions" ];
    });
	return sAllAttributes;
}

+ (NSArray *) numericAttributes
{
	static NSArray *			sNumericAttributes = nil;
    static dispatch_once_t      onceToken;
    dispatch_once(&onceToken, ^{
        sNumericAttributes = @[ @"theirScore", @"touchdowns",
                                @"completions", @"ourScore",
                                @"yards", @"attempts",
                                @"interceptions"];
    });
	return sNumericAttributes;
}

+ (NSDictionary *) defaultDictionary
{
	static NSDictionary *		sDict = nil;
    static dispatch_once_t      onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *	temp = [NSMutableDictionary	dictionary];
		for (NSString * key in [self numericAttributes])
			[temp setObject: @"0" forKey: key];
		[temp setObject: @"Opponents" forKey: @"theirTeam"];
		[temp setObject: @"Our Team" forKey: @"ourTeam"];
		[temp setObject: [[self shortFormatter] stringFromDate: [NSDate date]]
				 forKey: @"whenPlayed"];
		sDict = [temp copy];
    });
	return sDict;
}

- (NSMutableDictionary *) mutableDictionaryRepresentation
{
	NSMutableDictionary *		retval = [NSMutableDictionary dictionary];
	for (NSString * key in [PRGame numericAttributes]) {
		int				value = [[self valueForKey: key] intValue];
		NSString *		str = [NSString stringWithFormat: @"%d", value];
		[retval setObject: str forKey: key];
	}
	[retval setObject: self.theirTeam forKey: @"theirTeam"];
	[retval setObject: self.ourTeam forKey: @"ourTeam"];
	[retval setObject: [[PRGame shortFormatter] stringFromDate: self.whenPlayed]
			   forKey: @"whenPlayed"];
	
	return retval;
}

- (void) setValuesFromDictionary: (NSDictionary *) aDict
{
	for (NSString * key in [PRGame numericAttributes]) {
		[self setValue: [NSNumber numberWithInt: [[aDict objectForKey: key] intValue]]
				forKey: key];
	}
	self.theirTeam = [aDict objectForKey: @"theirTeam"];
	self.ourTeam = [aDict objectForKey: @"ourTeam"];
	self.whenPlayed = [[PRGame shortFormatter] dateFromString: [aDict objectForKey: @"whenPlayed"]];
}

@end
