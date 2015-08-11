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
@property (nonatomic, readonly, strong) PRGameID* objectID;

@property (nonatomic, strong) NSNumber* attempts;

@property (atomic) uint32_t attemptsValue;
- (uint32_t)attemptsValue;
- (void)setAttemptsValue:(uint32_t)value_;

//- (BOOL)validateAttempts:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* completions;

@property (atomic) uint32_t completionsValue;
- (uint32_t)completionsValue;
- (void)setCompletionsValue:(uint32_t)value_;

//- (BOOL)validateCompletions:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* interceptions;

@property (atomic) uint32_t interceptionsValue;
- (uint32_t)interceptionsValue;
- (void)setInterceptionsValue:(uint32_t)value_;

//- (BOOL)validateInterceptions:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* ourScore;

@property (atomic) uint32_t ourScoreValue;
- (uint32_t)ourScoreValue;
- (void)setOurScoreValue:(uint32_t)value_;

//- (BOOL)validateOurScore:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* ourTeam;

//- (BOOL)validateOurTeam:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* theirScore;

@property (atomic) uint32_t theirScoreValue;
- (uint32_t)theirScoreValue;
- (void)setTheirScoreValue:(uint32_t)value_;

//- (BOOL)validateTheirScore:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* theirTeam;

//- (BOOL)validateTheirTeam:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* touchdowns;

@property (atomic) uint32_t touchdownsValue;
- (uint32_t)touchdownsValue;
- (void)setTouchdownsValue:(uint32_t)value_;

//- (BOOL)validateTouchdowns:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* whenPlayed;

//- (BOOL)validateWhenPlayed:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* yards;

@property (atomic) uint32_t yardsValue;
- (uint32_t)yardsValue;
- (void)setYardsValue:(uint32_t)value_;

//- (BOOL)validateYards:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRPasser *passer;

//- (BOOL)validatePasser:(id*)value_ error:(NSError**)error_;

@end

@interface _PRGame (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAttempts;
- (void)setPrimitiveAttempts:(NSNumber*)value;

- (uint32_t)primitiveAttemptsValue;
- (void)setPrimitiveAttemptsValue:(uint32_t)value_;

- (NSNumber*)primitiveCompletions;
- (void)setPrimitiveCompletions:(NSNumber*)value;

- (uint32_t)primitiveCompletionsValue;
- (void)setPrimitiveCompletionsValue:(uint32_t)value_;

- (NSNumber*)primitiveInterceptions;
- (void)setPrimitiveInterceptions:(NSNumber*)value;

- (uint32_t)primitiveInterceptionsValue;
- (void)setPrimitiveInterceptionsValue:(uint32_t)value_;

- (NSNumber*)primitiveOurScore;
- (void)setPrimitiveOurScore:(NSNumber*)value;

- (uint32_t)primitiveOurScoreValue;
- (void)setPrimitiveOurScoreValue:(uint32_t)value_;

- (NSString*)primitiveOurTeam;
- (void)setPrimitiveOurTeam:(NSString*)value;

- (NSNumber*)primitiveTheirScore;
- (void)setPrimitiveTheirScore:(NSNumber*)value;

- (uint32_t)primitiveTheirScoreValue;
- (void)setPrimitiveTheirScoreValue:(uint32_t)value_;

- (NSString*)primitiveTheirTeam;
- (void)setPrimitiveTheirTeam:(NSString*)value;

- (NSNumber*)primitiveTouchdowns;
- (void)setPrimitiveTouchdowns:(NSNumber*)value;

- (uint32_t)primitiveTouchdownsValue;
- (void)setPrimitiveTouchdownsValue:(uint32_t)value_;

- (NSDate*)primitiveWhenPlayed;
- (void)setPrimitiveWhenPlayed:(NSDate*)value;

- (NSNumber*)primitiveYards;
- (void)setPrimitiveYards:(NSNumber*)value;

- (uint32_t)primitiveYardsValue;
- (void)setPrimitiveYardsValue:(uint32_t)value_;

- (PRPasser*)primitivePasser;
- (void)setPrimitivePasser:(PRPasser*)value;

@end
