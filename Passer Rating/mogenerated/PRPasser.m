#import "PRPasser.h"
#import "PRGame.h"

@interface PRPasser ()

// Private interface goes here.

@end


@implementation PRPasser

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
        
        return retval;
    }
}


- (double) passerRating
{
    int attempts = [[self.games valueForKeyPath: @"@sum.attempts"] intValue];
    int comps = [[self.games valueForKeyPath: @"@sum.completions"] intValue];
    int yards = [[self.games valueForKeyPath: @"@sum.yards"] intValue];
    int tds = [[self.games valueForKeyPath: @"@sum.touchdowns"] intValue];
    int ints = [[self.games valueForKeyPath: @"@sum.interceptions"] intValue];
    
    double rating = passer_rating(attempts, comps, yards, tds, ints);
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
    //  All-career passing attempts
    return [[self.games valueForKeyPath: @"@sum.attempts"] intValue];
}

- (NSDate *) firstPlayed
{
    //  The date of the first game the passer played
    return [self.games valueForKeyPath: @"@min.whenPlayed"];
}

- (NSDate *) lastPlayed
{
    //  The date of the last game the passer played
    return [self.games valueForKeyPath: @"@max.whenPlayed"];
}

- (NSArray *) teams
{
    //  The name of every team the passer played for
    return [[self.games valueForKeyPath:
             @"@distinctUnionOfObjects.ourTeam"]
            allObjects];
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

@end
