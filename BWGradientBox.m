//
//  BWGradientBox.m
//  BWToolkit
//
//  Created by Brandon Walkin (www.brandonwalkin.com)
//  All code is provided under the New BSD license.
//

#import "BWGradientBox.h"
#import "NSColor+BWAdditions.h"

@interface BWGradientBox (Private)

- (void) drawRect:(NSRect)inRect withGradient:(NSGradient *)inGradient angle:(CGFloat)inAngle;

@end


@implementation BWGradientBox

@synthesize fillStartingColor, fillEndingColor, fillColor, topBorderColor, rightBorderColor, bottomBorderColor, leftBorderColor, topInsetAlpha, rightInsetAlpha, bottomInsetAlpha, leftInsetAlpha, hasTopBorder, hasRightBorder, hasBottomBorder, hasLeftBorder, hasGradient, isVertical;

- (void) dealloc {
	
	[fillColor release];
	
	[fillStartingColor release];
	[fillEndingColor release];
	
	[topBorderColor release];
	[rightBorderColor release];
	[bottomBorderColor release];
	[leftBorderColor release];
	
	[super dealloc];
	
}

- (id)initWithCoder:(NSCoder *)decoder {

	if ((self = [super initWithCoder:decoder]) == nil) return self;

	[self setFillStartingColor:[decoder decodeObjectForKey:@"BWGBFillStartingColor"]];
	[self setFillEndingColor:[decoder decodeObjectForKey:@"BWGBFillEndingColor"]];
	[self setFillColor:[decoder decodeObjectForKey:@"BWGBFillColor"]];
	[self setTopBorderColor:[decoder decodeObjectForKey:@"BWGBTopBorderColor"]];
	[self setRightBorderColor:[decoder decodeObjectForKey:@"BWGBRightBorderColor"]];
	[self setBottomBorderColor:[decoder decodeObjectForKey:@"BWGBBottomBorderColor"]];
	[self setLeftBorderColor:[decoder decodeObjectForKey:@"BWGBLeftBorderColor"]];

	[self setHasTopBorder:[decoder decodeBoolForKey:@"BWGBHasTopBorder"]];
	[self setHasRightBorder:[decoder decodeBoolForKey:@"BWGBHasRightBorder"]];
	[self setHasBottomBorder:[decoder decodeBoolForKey:@"BWGBHasBottomBorder"]];
	[self setHasLeftBorder:[decoder decodeBoolForKey:@"BWGBHasLeftBorder"]];

	[self setHasGradient:[decoder decodeBoolForKey:@"BWGBHasGradient"]];
	[self setIsVertical:[decoder decodeBoolForKey:@"BWGBisVertical"]];
	
	[self setTopInsetAlpha:[decoder decodeFloatForKey:@"BWGBTopInsetAlpha"]];
	[self setRightInsetAlpha:[decoder decodeFloatForKey:@"BWGBRightInsetAlpha"]];
	[self setBottomInsetAlpha:[decoder decodeFloatForKey:@"BWGBBottomInsetAlpha"]];
	[self setLeftInsetAlpha:[decoder decodeFloatForKey:@"BWGBLeftInsetAlpha"]];
	
	if (self.fillStartingColor == nil) self.fillStartingColor = [NSColor whiteColor];
	if (self.fillEndingColor == nil) self.fillEndingColor = [NSColor grayColor];
	if (self.fillColor == nil) self.fillColor = [NSColor grayColor];
	if (self.topBorderColor == nil) self.topBorderColor = [NSColor clearColor];
	if (self.rightBorderColor == nil) self.rightBorderColor = [NSColor clearColor];
	if (self.bottomBorderColor == nil) self.bottomBorderColor = [NSColor clearColor];
	if (self.leftBorderColor == nil) self.leftBorderColor = [NSColor clearColor];

	return self;
		
}

- (void)encodeWithCoder:(NSCoder *)coder {

	[super encodeWithCoder:coder];

	[coder encodeObject:[self fillStartingColor] forKey:@"BWGBFillStartingColor"];
	[coder encodeObject:[self fillEndingColor] forKey:@"BWGBFillEndingColor"];
	[coder encodeObject:[self fillColor] forKey:@"BWGBFillColor"];

	[coder encodeObject:[self topBorderColor] forKey:@"BWGBTopBorderColor"];
	[coder encodeObject:[self rightBorderColor] forKey:@"BWGBRightBorderColor"];
	[coder encodeObject:[self bottomBorderColor] forKey:@"BWGBBottomBorderColor"];
	[coder encodeObject:[self leftBorderColor] forKey:@"BWGBLeftBorderColor"];

	[coder encodeBool:[self hasTopBorder] forKey:@"BWGBHasTopBorder"];
	[coder encodeBool:[self hasRightBorder] forKey:@"BWGBHasRightBorder"];
	[coder encodeBool:[self hasBottomBorder] forKey:@"BWGBHasBottomBorder"];
	[coder encodeBool:[self hasLeftBorder] forKey:@"BWGBHasLeftBorder"];

	[coder encodeBool:[self hasGradient] forKey:@"BWGBHasGradient"];
	[coder encodeBool:[self isVertical] forKey:@"BWGBisVertical"];

	[coder encodeFloat:[self topInsetAlpha] forKey:@"BWGBTopInsetAlpha"];
	[coder encodeFloat:[self rightInsetAlpha] forKey:@"BWGBRightInsetAlpha"];
	[coder encodeFloat:[self bottomInsetAlpha] forKey:@"BWGBBottomInsetAlpha"];
	[coder encodeFloat:[self leftInsetAlpha] forKey:@"BWGBLeftInsetAlpha"];

}





- (void) drawRect:(NSRect)rect {

	if (hasGradient) {

		NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:fillStartingColor endingColor:fillEndingColor];
		
		[gradient drawInRect:self.bounds angle:( isVertical ? 0 : 90 )];
		[gradient release];
		
	} else {

		[fillColor set];
		NSRectFillUsingOperation(self.bounds, NSCompositeSourceOver);

	}
	
	if (topInsetAlpha != 0) 
		[[[NSColor whiteColor] colorWithAlphaComponent:topInsetAlpha] bwDrawPixelThickLineAtPosition:( hasTopBorder ? 1 : 0 ) withInset:0 inRect:self.bounds inView:self horizontal:YES flip:NO];
	
	if (rightInsetAlpha != 0) 
		[[[NSColor whiteColor] colorWithAlphaComponent:rightInsetAlpha] bwDrawPixelThickLineAtPosition:( hasRightBorder ? 1 : 0 ) withInset:0 inRect:self.bounds inView:self horizontal:NO flip:YES];
	
	if (bottomInsetAlpha != 0) 
		[[[NSColor whiteColor] colorWithAlphaComponent:bottomInsetAlpha] bwDrawPixelThickLineAtPosition:( hasBottomBorder ? 1 : 0 ) withInset:0 inRect:self.bounds inView:self horizontal:YES flip:YES];
	
	if (leftInsetAlpha != 0) 
		[[[NSColor whiteColor] colorWithAlphaComponent:leftInsetAlpha] bwDrawPixelThickLineAtPosition:( hasLeftBorder ? 1 : 0 ) withInset:0 inRect:self.bounds inView:self horizontal:NO flip:NO];
	
	if (hasTopBorder) 
		[topBorderColor bwDrawPixelThickLineAtPosition:0 withInset:0 inRect:self.bounds inView:self horizontal:YES flip:NO];
	
	if (hasRightBorder)
		[rightBorderColor bwDrawPixelThickLineAtPosition:0 withInset:0 inRect:self.bounds inView:self horizontal:NO flip:YES];
	
	if (hasBottomBorder) 
		[bottomBorderColor bwDrawPixelThickLineAtPosition:0 withInset:0 inRect:self.bounds inView:self horizontal:YES flip:YES];
	
	if (hasLeftBorder) 
		[leftBorderColor bwDrawPixelThickLineAtPosition:0 withInset:0 inRect:self.bounds inView:self horizontal:NO flip:NO];

}





- (BOOL) isFlipped {

	return YES;

}

# pragma mark -
# pragma mark Setters

- (void)setFillColor:(NSColor *)color {

	if (fillColor == color) return;

        [fillColor release];
        fillColor = [color retain];
		
	[self setNeedsDisplay:YES];

}

- (void)setFillStartingColor:(NSColor *)color {

	if (fillStartingColor == color) return;

        [fillStartingColor release];
        fillStartingColor = [color retain];
		
	[self setNeedsDisplay:YES];
	
}

- (void)setFillEndingColor:(NSColor *)color {
	
	if (fillEndingColor == color) return;
	
        [fillEndingColor release];
        fillEndingColor = [color retain];
		
	[self setNeedsDisplay:YES];
	
}

- (void)setTopBorderColor:(NSColor *)color {

	//	if (topBorderColor == color) return;

        [topBorderColor release];
        topBorderColor = [color retain];		

	[self setNeedsDisplay:YES];

}

- (void)setRightBorderColor:(NSColor *)color {
	
	//	if (rightBorderColor == color) return;

	[rightBorderColor release];
	rightBorderColor = [color retain];
	
	[self setNeedsDisplay:YES];
	
}

- (void)setBottomBorderColor:(NSColor *)color {

	//	if (bottomBorderColor == color) return;
	
        [bottomBorderColor release];
        bottomBorderColor = [color retain];

	[self setNeedsDisplay:YES];

}

- (void)setLeftBorderColor:(NSColor *)color {
	
	//	if (leftBorderColor == color) return;
	
	[leftBorderColor release];
	leftBorderColor = [color retain];
	
	[self setNeedsDisplay:YES];
	
}

- (void) setIsVertical:(BOOL)flag {
	
	isVertical = flag;
	[self setNeedsDisplay:YES];
	
}

- (void) setTopInsetAlpha:(float)value {

	topInsetAlpha = value;
	[self setNeedsDisplay:YES];
	
}

- (void) setRightInsetAlpha:(float)value {
	
	rightInsetAlpha = value;
	[self setNeedsDisplay:YES];
	
}


- (void) setBottomInsetAlpha:(float)value {
	
	bottomInsetAlpha = value;
	[self setNeedsDisplay:YES];
	
}


- (void) setLeftInsetAlpha:(float)value {

	leftInsetAlpha = value;
	[self setNeedsDisplay:YES];
}





# pragma mark -
# pragma mark Private Drawing Methods

- (void) drawRect:(NSRect)inRect withGradient:(NSGradient *)inGradient angle:(CGFloat)inAngle {
	
	[inGradient drawInRect:inRect angle:inAngle];
	[inGradient release];
	
}


@end