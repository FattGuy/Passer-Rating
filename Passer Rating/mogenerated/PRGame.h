#import "_PRGame.h"

@interface PRGame : _PRGame {}

+ (NSUInteger) count: (NSManagedObjectContext *) moc;
+ (BOOL) loadFromCSVFile: (NSString *) path
             intoContext: (NSManagedObjectContext *) moc
                   error: (NSError **) error;


@property(nonatomic, readonly) double   passerRating;

#pragma mark - Editor support

+ (NSDictionary *) defaultDictionary;
- (NSMutableDictionary *) mutableDictionaryRepresentation;
- (void) setValuesFromDictionary: (NSDictionary *) aDict;
@end
