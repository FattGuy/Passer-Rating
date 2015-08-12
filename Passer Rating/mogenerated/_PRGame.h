// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRGame.h instead.

#import <CoreData/CoreData.h>



extern const struct PRGameAttributes {
	__unsafe_unretained NSString *attempts;
	__unsafe_unretained NSString *completions;
	__unsafe_unretained NSString *interceptions;
	__unsafe_unretained NSString *ourScore;
	__unsafe_unretained NSString *ourTeam;
	__unsafe_unretained NSString *theirScore;
	__unsafe_unretained NSString *theirTeam;
	__unsafe_unretained NSString *touchdowns;
	__unsafe_unretained NSString *whenPlayed;
	__unsafe_unretained NSString *yards;
} PRGameAttributes;



extern const struct PRGameRelationships {
	__unsafe_unretained NSString *passer;
} PRGameRelationships;






@class PRPasser;






















@interface PRGameID : NSManagedObjectID {}
@end

@interface _PRGame : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRGameID*)objectID;





@property (nonatomic, strong) NSNumber* attempts;




@property (atomic) int32_t attemptsValue;
- (int32_t)attemptsValue;
- (void)setAttemptsValue:(int32_t)value_;


//- (BOOL)validateAttempts:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* completions;




@property (atomic) int32_t completionsValue;
- (int32_t)completionsValue;
- (void)setCompletionsValue:(int32_t)value_;


//- (BOOL)validateCompletions:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* interceptions;




@property (atomic) int32_t interceptionsValue;
- (int32_t)interceptionsValue;
- (void)setInterceptionsValue:(int32_t)value_;


//- (BOOL)validateInterceptions:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* ourScore;




@property (atomic) int32_t ourScoreValue;
- (int32_t)ourScoreValue;
- (void)setOurScoreValue:(int32_t)value_;


//- (BOOL)validateOurScore:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* ourTeam;



//- (BOOL)validateOurTeam:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* theirScore;




@property (atomic) int32_t theirScoreValue;
- (int32_t)theirScoreValue;
- (void)setTheirScoreValue:(int32_t)value_;


//- (BOOL)validateTheirScore:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* theirTeam;



//- (BOOL)validateTheirTeam:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* touchdowns;




@property (atomic) int32_t touchdownsValue;
- (int32_t)touchdownsValue;
- (void)setTouchdownsValue:(int32_t)value_;


//- (BOOL)validateTouchdowns:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* whenPlayed;



//- (BOOL)validateWhenPlayed:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* yards;




@property (atomic) int32_t yardsValue;
- (int32_t)yardsValue;
- (void)setYardsValue:(int32_t)value_;


//- (BOOL)validateYards:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PRPasser *passer;

//- (BOOL)validatePasser:(id*)value_ error:(NSError**)error_;





@end



@interface _PRGame (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAttempts;
- (void)setPrimitiveAttempts:(NSNumber*)value;

- (int32_t)primitiveAttemptsValue;
- (void)setPrimitiveAttemptsValue:(int32_t)value_;




- (NSNumber*)primitiveCompletions;
- (void)setPrimitiveCompletions:(NSNumber*)value;

- (int32_t)primitiveCompletionsValue;
- (void)setPrimitiveCompletionsValue:(int32_t)value_;




- (NSNumber*)primitiveInterceptions;
- (void)setPrimitiveInterceptions:(NSNumber*)value;

- (int32_t)primitiveInterceptionsValue;
- (void)setPrimitiveInterceptionsValue:(int32_t)value_;




- (NSNumber*)primitiveOurScore;
- (void)setPrimitiveOurScore:(NSNumber*)value;

- (int32_t)primitiveOurScoreValue;
- (void)setPrimitiveOurScoreValue:(int32_t)value_;




- (NSString*)primitiveOurTeam;
- (void)setPrimitiveOurTeam:(NSString*)value;




- (NSNumber*)primitiveTheirScore;
- (void)setPrimitiveTheirScore:(NSNumber*)value;

- (int32_t)primitiveTheirScoreValue;
- (void)setPrimitiveTheirScoreValue:(int32_t)value_;




- (NSString*)primitiveTheirTeam;
- (void)setPrimitiveTheirTeam:(NSString*)value;




- (NSNumber*)primitiveTouchdowns;
- (void)setPrimitiveTouchdowns:(NSNumber*)value;

- (int32_t)primitiveTouchdownsValue;
- (void)setPrimitiveTouchdownsValue:(int32_t)value_;




- (NSDate*)primitiveWhenPlayed;
- (void)setPrimitiveWhenPlayed:(NSDate*)value;




- (NSNumber*)primitiveYards;
- (void)setPrimitiveYards:(NSNumber*)value;

- (int32_t)primitiveYardsValue;
- (void)setPrimitiveYardsValue:(int32_t)value_;





- (PRPasser*)primitivePasser;
- (void)setPrimitivePasser:(PRPasser*)value;


@end
