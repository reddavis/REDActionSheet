//
//  REDActionSheetButton.m
//  REDTweetbotActionSheet
//
//  Created by Red Davis on 23/12/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import "REDActionSheetButton.h"


@interface REDActionSheetButton ()

- (void)updateStyle;

@end


@implementation REDActionSheetButton

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title
{
	self = [self initWithFrame:CGRectZero];
	if (self)
	{
		[self setTitle:title forState:UIControlStateNormal];
	}
	
	return self;
}

#pragma mark - 

- (void)updateStyle
{
	self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
	self.alpha = 0.98;
	
	if (self.highlighted)
	{
		self.backgroundColor = [UIColor colorWithRed:0.078 green:0.490 blue:0.965 alpha:1];
		[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else
	{
		switch (self.type)
		{
			case REDActionSheetButtonTypeDefault:
				self.backgroundColor = [UIColor whiteColor];
				[self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				break;
			case REDActionSheetButtonTypeCancel:
				self.backgroundColor = [UIColor colorWithRed:0.204 green:0.204 blue:0.204 alpha:1];
				[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
				break;
			case REDActionSheetButtonTypeDestructive:
				self.backgroundColor = [UIColor redColor];
				[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
				break;
				
			default:
				break;
		}
	}
}

#pragma mark -

- (void)setType:(REDActionSheetButtonType)type
{
	if (type == _type)
		return;
	
	_type = type;
	[self updateStyle];
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	[self updateStyle];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	if (self.position == REDActionSheetButtonPositionMiddle || self.position == REDActionSheetButtonPositionBottom)
	{
		[[UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1] set];
		
		UIBezierPath *linePath = [UIBezierPath bezierPath];
		linePath.lineWidth = 0.5;
		[linePath moveToPoint:CGPointMake(0.0, 0.0)];
		[linePath addLineToPoint:CGPointMake(rect.size.width, 0.0)];
		[linePath stroke];
	}
		
	UIBezierPath *path = nil;
	if (self.position == REDActionSheetButtonPositionTop)
	{
		path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5.0, 5.0)];
	}
	else if (self.position == REDActionSheetButtonPositionBottom)
	{
		path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
	}
	else if (self.type == REDActionSheetButtonTypeCancel)
	{
		path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0];
	}
	
	if (path)
	{
		CAShapeLayer *maskLayer = [CAShapeLayer layer];
		maskLayer.path = path.CGPath;
		self.layer.mask = maskLayer;
	}
}

@end
