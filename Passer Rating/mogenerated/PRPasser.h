#import "_PRPasser.h"
#import "rating.h"

@interface PRPasser : _PRPasser {}

+ (PRPasser *) passerWithFirstName: (NSString *) firstName
                          lastName: (NSString *) lastName
                         inContext: (NSManagedObjectContext *) moc;

#pragma mark - Derived stats
/// @name Derived stats
//@{
@property(nonatomic, readonly) double passerRating;
@property(nonatomic, readonly) int attempts;
@property(nonatomic, readonly) int completions;
@property(nonatomic, readonly) int yards;
@property(nonatomic, readonly) int touchdowns;
@property(nonatomic, readonly) int interceptions;

@property(nonatomic, readonly) NSDate * firstPlayed;
@property(nonatomic, readonly) NSDate * lastPlayed;
@property(nonatomic, readonly) NSArray * teams;
//@}

#pragma mark - Editor support
/// @name Editor support
//#{
+ (NSDictionary *) defaultDictionary;
@property(nonatomic, readonly) NSMutableDictionary *    mutableDictionaryRepresentation;
- (void) setValuesFromDictionary: (NSDictionary *) aDict;
//@}

@end
