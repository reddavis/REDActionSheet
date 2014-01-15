//
//  REDActionSheet.m
//  REDTweetbotActionSheet
//
//  Created by Red Davis on 23/12/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import "REDActionSheet.h"
#import "REDActionSheetButton.h"


@interface REDActionSheet ()

@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) REDActionSheetButton *cancelButton;
@property (strong, nonatomic) UIView *buttonsContainerView;

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *maskBackgroundView;

@property (assign, nonatomic) NSUInteger selectedButtonIndex;

- (void)cancelButtonTapped:(id)sender;
- (void)buttonTapped:(id)sender;

- (REDActionSheetButton *)buttonWithTitle:(NSString *)title;
- (REDActionSheetButton *)destructiveButtonWithTitle:(NSString *)title;
- (REDActionSheetButton *)cancelButtonWithTitle:(NSString *)title;

- (void)showButtons;
- (void)dismiss;

- (void)tapGestureEngadged:(UITapGestureRecognizer *)gesture;

@end


@implementation REDActionSheet

#pragma mark - Initialization

- (instancetype)initWithCancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesList:(NSString *)otherButtonsList, ...
{
    self = [super initWithFrame:CGRectZero];
    if (self)
	{
		self.backgroundColor = [UIColor blackColor];
		self.userInteractionEnabled = YES;
		self.buttons = [NSMutableArray array];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEngadged:)];
		[self addGestureRecognizer:tapGesture];
		
		// Build normal buttons
        if (otherButtonsList) {
            va_list args;
            va_start(args, otherButtonsList);
            NSString *argString = va_arg(args, NSString *);
            
            REDActionSheetButton *button = [self buttonWithTitle:otherButtonsList];
            [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons addObject:button];
            
            while (argString)
            {
                REDActionSheetButton *button = [self buttonWithTitle:argString];
                [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
                [self.buttons addObject:button];
                
                argString = va_arg(args, NSString *);
            }
            va_end(args);
        }
		
		if (destructiveButtonTitle)
		{
			REDActionSheetButton *destructiveButton = [self destructiveButtonWithTitle:destructiveButtonTitle];
			[self.buttons insertObject:destructiveButton atIndex:0];
		}
		
		if (cancelButtonTitle)
		{
			self.cancelButton = [self cancelButtonWithTitle:cancelButtonTitle];
			[self.cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		}
    }
	
    return self;
}

#pragma mark - View Setup

static CGFloat const REDActionSheetButtonHeight = 44.0;
static CGFloat const REDActionSheetCancelButtonMargin = 5.0;

- (void)didMoveToSuperview
{
	self.frame = self.superview.bounds;
	CGRect bounds = self.bounds;
	
	self.backgroundView.frame = bounds;
	self.maskBackgroundView.frame = bounds;
	
	CGFloat buttonYCoor = 0.0;
	CGFloat buttonWidth = bounds.size.width*0.95;
	CGFloat buttonXCoor = floorf(bounds.size.width/2.0 - buttonWidth/2.0);
	for (REDActionSheetButton *button in self.buttons)
	{
		button.frame = CGRectMake(buttonXCoor, buttonYCoor, buttonWidth, REDActionSheetButtonHeight);
		buttonYCoor = CGRectGetMaxY(button.frame);
	}
	
	self.buttonsContainerView.frame = CGRectMake(0.0, bounds.size.height, bounds.size.width, buttonYCoor);
	self.cancelButton.frame = CGRectMake(buttonXCoor, CGRectGetMaxY(self.buttonsContainerView.frame)+REDActionSheetCancelButtonMargin, buttonWidth, REDActionSheetButtonHeight);
}

#pragma mark -

- (void)showInView:(UIView *)view
{
	// Background
	self.backgroundView = [view.window snapshotViewAfterScreenUpdates:YES];
	[self addSubview:self.backgroundView];
	
	self.maskBackgroundView = [[UIView alloc] init];
	self.maskBackgroundView.backgroundColor = [UIColor blackColor];
	self.maskBackgroundView.alpha = 0.0;
	[self addSubview:self.maskBackgroundView];
	
	// Button
	self.buttonsContainerView = [[UIView alloc] init];
	
	[self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		REDActionSheetButton *button = (REDActionSheetButton *)obj;
		
		if (idx == 0)
			button.position = REDActionSheetButtonPositionTop;
		else if (idx == self.buttons.count-1)
			button.position = REDActionSheetButtonPositionBottom;
		else
			button.position = REDActionSheetButtonPositionMiddle;
		
		[self.buttonsContainerView addSubview:obj];
	}];
	
	[self addSubview:self.buttonsContainerView];
	
	// Cancel button
	if (self.cancelButton)
	{
		[self addSubview:self.cancelButton];
	}
	
	if (self.actionSheetWillPresentBlock)
		self.actionSheetWillPresentBlock(self);
	
	[view.window addSubview:self];
	[self showButtons];
}

- (void)addButtonWithTitle:(NSString *)title
{
    REDActionSheetButton *button = [self buttonWithTitle:title];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:button];
}

static CGFloat const REDShowAnimationDuration = 0.60;
static CGFloat const REDDismissAnimationDuration = 0.4;
static CGFloat const REDAnimationSpringDamping = 0.70;

- (void)showButtons
{
	CGFloat buttonContainerLastYCoor = CGRectGetHeight(self.frame) - (CGRectGetHeight(self.buttonsContainerView.frame) + CGRectGetHeight(self.cancelButton.frame) + (REDActionSheetCancelButtonMargin * 2.0));
	
	[UIView animateWithDuration:REDShowAnimationDuration delay:0.0 usingSpringWithDamping:REDAnimationSpringDamping initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self.maskBackgroundView.alpha = 0.50;
		self.backgroundView.transform = CGAffineTransformMakeScale(0.90, 0.90);
		
		CGRect frame = self.buttonsContainerView.frame;
		frame.origin.y = buttonContainerLastYCoor;
		self.buttonsContainerView.frame = frame;
	} completion:^(BOOL finished) {
		
	}];
	
	CGFloat cancelButtonLastYCoor = CGRectGetHeight(self.frame) - (CGRectGetHeight(self.cancelButton.frame) + REDActionSheetCancelButtonMargin);
	
	[UIView animateWithDuration:REDShowAnimationDuration delay:0.15 usingSpringWithDamping:REDAnimationSpringDamping initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		CGRect frame = self.cancelButton.frame;
		frame.origin.y = cancelButtonLastYCoor;
		self.cancelButton.frame = frame;
	} completion:^(BOOL finished) {
		if (self.actionSheetDidPresentBlock)
			self.actionSheetDidPresentBlock(self);
	}];
}

- (void)dismiss
{
	self.userInteractionEnabled = NO;
	
	CGFloat yCoorDifferenceBetweenContainerAndCancelButton = fabsf(self.buttonsContainerView.frame.origin.y - self.cancelButton.frame.origin.y);
	
	[UIView animateWithDuration:REDDismissAnimationDuration animations:^{
		self.backgroundView.transform = CGAffineTransformIdentity;
		
		CGRect buttonContainerFrame = self.buttonsContainerView.frame;
		buttonContainerFrame.origin.y = CGRectGetHeight(self.frame);
		
		CGRect cancelButtonFrame = self.cancelButton.frame;
		cancelButtonFrame.origin.y = buttonContainerFrame.origin.y + yCoorDifferenceBetweenContainerAndCancelButton;
		
		self.buttonsContainerView.frame = buttonContainerFrame;
		self.cancelButton.frame = cancelButtonFrame;
	} completion:^(BOOL finished) {
		self.backgroundColor = [UIColor clearColor];
		[self.backgroundView removeFromSuperview];
	}];
	
	[UIView animateWithDuration:REDDismissAnimationDuration+0.1 animations:^{
		self.maskBackgroundView.alpha = 0.0;
	} completion:^(BOOL finished) {
		if (self.actionSheetDidDismissWithButtonIndexBlock)
			self.actionSheetDidDismissWithButtonIndexBlock(self, self.selectedButtonIndex);
        
		[self removeFromSuperview];
	}];
}

#pragma mark -

- (REDActionSheetButton *)buttonWithTitle:(NSString *)title
{
	REDActionSheetButton *button = [[REDActionSheetButton alloc] initWithTitle:title];
	button.type = REDActionSheetButtonTypeDefault;
	
	return button;
}

- (REDActionSheetButton *)destructiveButtonWithTitle:(NSString *)title
{
	REDActionSheetButton *button = [[REDActionSheetButton alloc] initWithTitle:title];
	button.type = REDActionSheetButtonTypeDestructive;
	
	return button;
}

- (REDActionSheetButton *)cancelButtonWithTitle:(NSString *)title
{
	REDActionSheetButton *button = [[REDActionSheetButton alloc] initWithTitle:title];
	button.type = REDActionSheetButtonTypeCancel;
	
	return button;
}

#pragma mark - Actions

- (void)buttonTapped:(id)sender
{
	self.selectedButtonIndex = [self.buttons indexOfObject:sender];
	if (self.actionSheetWillDismissWithButtonIndexBlock)
		self.actionSheetWillDismissWithButtonIndexBlock(self, self.selectedButtonIndex);
	
	if (self.actionSheetTappedButtonAtIndexBlock)
		self.actionSheetTappedButtonAtIndexBlock(self, self.selectedButtonIndex);
	
	[self dismiss];
}

- (void)cancelButtonTapped:(id)sender
{
	self.selectedButtonIndex = self.buttons.count;
	if (self.actionSheetWillDismissWithButtonIndexBlock)
		self.actionSheetWillDismissWithButtonIndexBlock(self, self.selectedButtonIndex);
	
	if (self.actionSheetTappedButtonAtIndexBlock)
		self.actionSheetTappedButtonAtIndexBlock(self, self.buttons.count);
	
	[self dismiss];
		
	if (self.actionSheetCancelBlock)
		self.actionSheetCancelBlock(self);
}

#pragma mark - Gestures

- (void)tapGestureEngadged:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateEnded)
		[self dismiss];
}

@end
