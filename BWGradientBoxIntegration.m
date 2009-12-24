//
//  BWGradientBoxIntegration.m
//  BWToolkit
//
//  Created by Brandon Walkin (www.brandonwalkin.com)
//  All code is provided under the New BSD license.
//

#import <InterfaceBuilderKit/InterfaceBuilderKit.h>
#import "BWGradientBox.h"
#import "BWGradientBoxInspector.h"

@implementation BWGradientBox (BWGradientBoxIntegration)

- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths 
{
	
    [super ibPopulateKeyPaths:keyPaths];
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:@"topBorderColor", @"rightBorderColor", @"bottomBorderColor", @"leftBorderColor", @"fillStartingColor", @"fillEndingColor", @"fillColor", @"topInsetAlpha", @"rightInsetAlpha", @"bottomInsetAlpha", @"leftInsetAlpha", @"hasTopBorder", @"hasRightBorder", @"hasBottomBorder", @"hasLeftBorder", @"hasGradient", @"isVertical", nil]];

}

- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes 
{

    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[BWGradientBoxInspector class]];

}

- (NSView *)ibDesignableContentView
{
	return self;
}

@end
