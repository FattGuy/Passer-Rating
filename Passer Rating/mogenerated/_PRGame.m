// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRGame.m instead.

#import "_PRGame.h"


const struct PRGameAttributes PRGameAttributes = {
	.attempts = @"attempts",
	.completions = @"completions",
	.interceptions = @"interceptions",
	.ourScore = @"ourScore",
	.ourTeam = @"ourTeam",
	.theirScore = @"theirScore",
	.theirTeam = @"theirTeam",
	.touchdowns = @"touchdowns",
	.whenPlayed = @"whenPlayed",
	.yards = @"yards",
};



const struct PRGameRelationships PRGameRelationships = {
	.passer = @"passer",
};






@implementation PRGameID
@end

@implementation _PRGame

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Game";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Game" inManagedObjectContext:moc_];
}

- (PRGameID*)objectID {
	return (PRGameID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"attemptsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attempts"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"completionsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"completions"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"interceptionsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"interceptions"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ourScoreValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ourScore"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"theirScoreValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"theirScore"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"touchdownsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"touchdowns"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"yardsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"yards"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic attempts;



- (int32_t)attemptsValue {
	NSNumber *result = [self attempts];
	return [result intValue];
}


- (void)setAttemptsValue:(int32_t)value_ {
	[self setAttempts:@(value_)];
}


- (int32_t)primitiveAttemptsValue {
	NSNumber *result = [self primitiveAttempts];
	return [result intValue];
}

- (void)setPrimitiveAttemptsValue:(int32_t)value_ {
	[self setPrimitiveAttempts:@(value_)];
}





@dynamic completions;



- (int32_t)completionsValue {
	NSNumber *result = [self completions];
	return [result intValue];
}


- (void)setCompletionsValue:(int32_t)value_ {
	[self setCompletions:@(value_)];
}


- (int32_t)primitiveCompletionsValue {
	NSNumber *result = [self primitiveCompletions];
	return [result intValue];
}

- (void)setPrimitiveCompletionsValue:(int32_t)value_ {
	[self setPrimitiveCompletions:@(value_)];
}





@dynamic interceptions;



- (int32_t)interceptionsValue {
	NSNumber *result = [self interceptions];
	return [result intValue];
}


- (void)setInterceptionsValue:(int32_t)value_ {
	[self setInterceptions:@(value_)];
}


- (int32_t)primitiveInterceptionsValue {
	NSNumber *result = [self primitiveInterceptions];
	return [result intValue];
}

- (void)setPrimitiveInterceptionsValue:(int32_t)value_ {
	[self setPrimitiveInterceptions:@(value_)];
}





@dynamic ourScore;



- (int32_t)ourScoreValue {
	NSNumber *result = [self ourScore];
	return [result intValue];
}


- (void)setOurScoreValue:(int32_t)value_ {
	[self setOurScore:@(value_)];
}


- (int32_t)primitiveOurScoreValue {
	NSNumber *result = [self primitiveOurScore];
	return [result intValue];
}

- (void)setPrimitiveOurScoreValue:(int32_t)value_ {
	[self setPrimitiveOurScore:@(value_)];
}





@dynamic ourTeam;






@dynamic theirScore;



- (int32_t)theirScoreValue {
	NSNumber *result = [self theirScore];
	return [result intValue];
}


- (void)setTheirScoreValue:(int32_t)value_ {
	[self setTheirScore:@(value_)];
}


- (int32_t)primitiveTheirScoreValue {
	NSNumber *result = [self primitiveTheirScore];
	return [result intValue];
}

- (void)setPrimitiveTheirScoreValue:(int32_t)value_ {
	[self setPrimitiveTheirScore:@(value_)];
}





@dynamic theirTeam;






@dynamic touchdowns;



- (int32_t)touchdownsValue {
	NSNumber *result = [self touchdowns];
	return [result intValue];
}


- (void)setTouchdownsValue:(int32_t)value_ {
	[self setTouchdowns:@(value_)];
}


- (int32_t)primitiveTouchdownsValue {
	NSNumber *result = [self primitiveTouchdowns];
	return [result intValue];
}

- (void)setPrimitiveTouchdownsValue:(int32_t)value_ {
	[self setPrimitiveTouchdowns:@(value_)];
}





@dynamic whenPlayed;






@dynamic yards;



- (int32_t)yardsValue {
	NSNumber *result = [self yards];
	return [result intValue];
}


- (void)setYardsValue:(int32_t)value_ {
	[self setYards:@(value_)];
}


- (int32_t)primitiveYardsValue {
	NSNumber *result = [self primitiveYards];
	return [result intValue];
}

- (void)setPrimitiveYardsValue:(int32_t)value_ {
	[self setPrimitiveYards:@(value_)];
}





@dynamic passer;

	






@end




