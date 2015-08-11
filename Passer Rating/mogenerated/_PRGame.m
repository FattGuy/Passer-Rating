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

- (uint32_t)attemptsValue {
	NSNumber *result = [self attempts];
	return [result unsignedIntValue];
}

- (void)setAttemptsValue:(uint32_t)value_ {
	[self setAttempts:[NSNumber numberWithUnsignedInt:value_]];
}

- (uint32_t)primitiveAttemptsValue {
	NSNumber *result = [self primitiveAttempts];
	return [result unsignedIntValue];
}

- (void)setPrimitiveAttemptsValue:(uint32_t)value_ {
	[self setPrimitiveAttempts:[NSNumber numberWithUnsignedInt:value_]];
}

@dynamic completions;

- (uint32_t)completionsValue {
	NSNumber *result = [self completions];
	return [result unsignedIntValue];
}

- (void)setCompletionsValue:(uint32_t)value_ {
	[self setCompletions:[NSNumber numberWithUnsignedInt:value_]];
}

- (uint32_t)primitiveCompletionsValue {
	NSNumber *result = [self primitiveCompletions];
	return [result unsignedIntValue];
}

- (void)setPrimitiveCompletionsValue:(uint32_t)value_ {
	[self setPrimitiveCompletions:[NSNumber numberWithUnsignedInt:value_]];
}

@dynamic interceptions;

- (uint32_t)interceptionsValue {
	NSNumber *result = [self interceptions];
	return [result unsignedIntValue];
}

- (void)setInterceptionsValue:(uint32_t)value_ {
	[self setInterceptions:[NSNumber numberWithUnsignedInt:value_]];
}

- (uint32_t)primitiveInterceptionsValue {
	NSNumber *result = [self primitiveInterceptions];
	return [result unsignedIntValue];
}

- (void)setPrimitiveInterceptionsValue:(uint32_t)value_ {
	[self setPrimitiveInterceptions:[NSNumber numberWithUnsignedInt:value_]];
}

@dynamic ourScore;

- (uint32_t)ourScoreValue {
	NSNumber *result = [self ourScore];
	return [result unsignedIntValue];
}

- (void)setOurScoreValue:(uint32_t)value_ {
	[self setOurScore:[NSNumber numberWithUnsignedInt:value_]];
}

- (uint32_t)primitiveOurScoreValue {
	NSNumber *result = [self primitiveOurScore];
	return [result unsignedIntValue];
}

- (void)setPrimitiveOurScoreValue:(uint32_t)value_ {
	[self setPrimitiveOurScore:[NSNumber numberWithUnsignedInt:value_]];
}

@dynamic ourTeam;

@dynamic theirScore;

- (uint32_t)theirScoreValue {
	NSNumber *result = [self theirScore];
	return [result unsignedIntValue];
}

- (void)setTheirScoreValue:(uint32_t)value_ {
	[self setTheirScore:[NSNumber numberWithUnsignedInt:value_]];
}

- (uint32_t)primitiveTheirScoreValue {
	NSNumber *result = [self primitiveTheirScore];
	return [result unsignedIntValue];
}

- (void)setPrimitiveTheirScoreValue:(uint32_t)value_ {
	[self setPrimitiveTheirScore:[NSNumber numberWithUnsignedInt:value_]];
}

@dynamic theirTeam;

@dynamic touchdowns;

- (uint32_t)touchdownsValue {
	NSNumber *result = [self touchdowns];
	return [result unsignedIntValue];
}

- (void)setTouchdownsValue:(uint32_t)value_ {
	[self setTouchdowns:[NSNumber numberWithUnsignedInt:value_]];
}

- (uint32_t)primitiveTouchdownsValue {
	NSNumber *result = [self primitiveTouchdowns];
	return [result unsignedIntValue];
}

- (void)setPrimitiveTouchdownsValue:(uint32_t)value_ {
	[self setPrimitiveTouchdowns:[NSNumber numberWithUnsignedInt:value_]];
}

@dynamic whenPlayed;

@dynamic yards;

- (uint32_t)yardsValue {
	NSNumber *result = [self yards];
	return [result unsignedIntValue];
}

- (void)setYardsValue:(uint32_t)value_ {
	[self setYards:[NSNumber numberWithUnsignedInt:value_]];
}

- (uint32_t)primitiveYardsValue {
	NSNumber *result = [self primitiveYards];
	return [result unsignedIntValue];
}

- (void)setPrimitiveYardsValue:(uint32_t)value_ {
	[self setPrimitiveYards:[NSNumber numberWithUnsignedInt:value_]];
}

@dynamic passer;

@end

