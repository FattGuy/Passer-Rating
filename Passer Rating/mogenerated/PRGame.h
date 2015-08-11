#import "_PRGame.h"

@interface PRGame : _PRGame {}

+ (BOOL) loadFromCSVFile: (NSString *) path
             intoContext: (NSManagedObjectContext *) moc
                   error: (NSError **) error;

@property(nonatomic, readonly) double   passerRating;

@end
