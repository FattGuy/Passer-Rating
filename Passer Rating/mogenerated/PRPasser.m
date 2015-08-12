#import "PRPasser.h"
#import "PRGame.h"

//  Search for passers by normal Core Data
#define VANILLA_CORE_DATA   1

//  Search for passers by:
//      Using Core Data to fetch by first name only
//      Filtering the results in memory by last name
#define TWO_LEVEL_FETCH     2

//  Keep the passer roster in a dictionary
#define ALL_IN_MEMORY       3

//  Choice of method:
#define FETCH_METHOD        VANILLA_CORE_DATA

#if ALL_IN_MEMORY
static NSMutableDictionary *   sAllPassers;
#endif

@interface PRPasser ()

// Private interface goes here.

@end


@implementation PRPasser

#if FETCH_METHOD == VANILLA_CORE_DATA

+ (NSArray *) existingPassersWithLastName: (NSString *) last
								firstName: (NSString *) first
								inContext: (NSManagedObjectContext *) moc
{
	NSParameterAssert(last && last.length > 0);
	NSParameterAssert(first && first.length > 0);
    
    NSFetchRequest *	req = [NSFetchRequest
                               fetchRequestWithEntityName: @"Passer"];
    NSPredicate *       byName;
	byName = [NSPredicate predicateWithFormat:
              @"firstName = %@ AND lastName = %@",
              first, last];
	req.predicate = byName;
	
	NSArray *			result = [moc executeFetchRequest: req
                                            error: NULL];
    //  FIXME: No error handling
	return result;
}

#elif FETCH_METHOD == TWO_LEVEL_FETCH

+ (NSArray *) existingPassersWithLastName: (NSString *) last
								firstName: (NSString *) first
								inContext: (NSManagedObjectContext *) moc
{
	NSParameterAssert(last && last.length > 0);
	NSParameterAssert(first && first.length > 0);
    
    //  Ask Core Data for a first-name match ONLY:
    NSFetchRequest *	req = [NSFetchRequest fetchRequestWithEntityName: @"Passer"];
    
    NSPredicate *       byName;
    byName = [NSPredicate predicateWithFormat: @"firstName = %@", first];
	req.predicate = byName;
	
	NSArray *			result = [moc executeFetchRequest: req
                                            error: NULL];
    //  FIXME: No error handling
    
    //  Once you have the first names, filter by last name:
    result = [result filteredArrayUsingPredicate:
              [NSPredicate predicateWithFormat: @"lastName = %@", last]];
	return result;
}

#elif FETCH_METHOD == ALL_IN_MEMORY

+ (NSArray *) existingPassersWithLastName: (NSString *) last
								firstName: (NSString *) first
								inContext: (NSManagedObjectContext *) moc
{
	NSParameterAssert(last && last.length > 0);
	NSParameterAssert(first && first.length > 0);
    
    //  FIXME: Retrieve from a static dictionary on a last|first key
    NSString *      key = [NSString stringWithFormat: @"%@|%@", last, first];
    PRPasser *      passer = [sAllPassers objectForKey: key];
    NSArray *       result;
    
    //  Conform to the promise to return an array
    if (passer)
        result = [NSArray arrayWithObject: passer];
    else
        result = [NSArray array];
	return result;
}

#else

#error No choice of FETCH_METHOD

#endif


+ (PRPasser *) passerWithFirstName: (NSString *) firstName
                          lastName: (NSString *) lastName
                         inContext: (NSManagedObjectContext *) moc
{
    NSArray *	result = [self existingPassersWithLastName: lastName
                                                 firstName: firstName
                                                 inContext: moc];
    if (result.count > 0)
        return result.lastObject;
    else {
        PRPasser *		retval;
        retval = [self insertInManagedObjectContext: moc];
        assert(retval);
        retval.firstName = firstName;
        retval.lastName = lastName;
        
#if FETCH_METHOD == ALL_IN_MEMORY
        NSString *      key = [NSString stringWithFormat: @"%@|%@", lastName, firstName];
        [sAllPassers setObject: retval forKey: key];
#endif
        
        return retval;
    }
}

- (double) passerRating
{
    double rating = passer_rating(self.completions,
								  self.attempts,
								  self.yards,
								  self.touchdowns,
								  self.interceptions);
    return rating;
}

- (int) sumOfGameAttribute: (NSString *) attribute
{
	NSString *		keyPath = [NSString stringWithFormat:
							   @"@sum.%@", attribute];
	return [[self.games valueForKeyPath: keyPath] intValue];
}

- (int) attempts
{
    return [self sumOfGameAttribute: @"attempts"];
}

- (int) completions
{
    return [self sumOfGameAttribute: @"completions"];
}

- (int) yards
{
    return [self sumOfGameAttribute: @"yards"];
}

- (int) touchdowns
{
    return [self sumOfGameAttribute: @"touchdowns"];
}

- (int) interceptions
{
    return [self sumOfGameAttribute: @"interceptions"];
}

- (NSDate *) lastPlayed
{
    //  The date of the last game the passer played
    return [self.games valueForKeyPath: @"@max.whenPlayed"];
}

- (NSDate *) firstPlayed
{
    //  The date of the first game the passer played
    return [self.games valueForKeyPath: @"@min.whenPlayed"];
}

- (NSArray *) teams
{
    //  The name of every team the passer played for
    return [[self.games valueForKeyPath:
             @"@distinctUnionOfObjects.ourTeam"]
            allObjects];
}

#pragma mark - Editing Support

+ (NSArray *) allAttributes
{
    return @[@"firstName", @"lastName", @"currentTeam"];
}

+ (NSDictionary *) defaultDictionary
{
    return @{
             @"firstName"       : @"First Name",
             @"lastName"        : @"Last Name",
             @"currentTeam"     : @"Team Name"
             };
}


- (NSMutableDictionary *) mutableDictionaryRepresentation
{
    NSMutableDictionary *	retval = [NSMutableDictionary dictionary];
    for (NSString * key in [PRPasser allAttributes]) {
        NSString *			value = [self valueForKey: key];
        [retval setObject: value forKey: key];
    }
    return retval;
}

- (void) setValuesFromDictionary: (NSDictionary *) aDict
{
	for (NSString * key in [PRPasser allAttributes]) {
		[self setValue: [aDict valueForKey: key]
				forKey: key];
	}
}


@end
