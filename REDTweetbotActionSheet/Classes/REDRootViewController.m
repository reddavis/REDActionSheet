//
//  REDRootViewController.m
//  REDTweetbotActionSheet
//
//  Created by Red Davis on 23/12/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import "REDRootViewController.h"
#import "REDActionSheet.h"


@interface REDRootViewController () <UIActionSheetDelegate>

- (void)showActionSheetButtonTapped:(id)sender;

@end


@implementation REDRootViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		
    }
	
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = NSLocalizedString(@"REDActionSheet", nil);
	self.edgesForExtendedLayout = UIRectEdgeNone;
		
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
	[button setTitle:@"Show" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(showActionSheetButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[button sizeToFit];
	button.frame = CGRectMake(0.0, 50.0, button.frame.size.width, button.frame.size.height);
	[self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (void)showActionSheetButtonTapped:(id)sender
{
	REDActionSheet *actionSheet = [[REDActionSheet alloc] initWithCancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitlesList:@"1", @"2", @"3", nil];
    [actionSheet addButtonWithTitle:@"4"];
	actionSheet.actionSheetTappedButtonAtIndexBlock = ^(REDActionSheet *actionSheet, NSUInteger buttonIndex) {
		//...
	};
	[actionSheet showInView:self.view];
}

@end
