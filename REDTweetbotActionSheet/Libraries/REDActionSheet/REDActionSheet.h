//
//  REDActionSheet.h
//  REDTweetbotActionSheet
//
//  Created by Red Davis on 23/12/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>


@class REDActionSheet;
typedef void(^REDActionSheetCancelBlock)(REDActionSheet *actionSheet);
typedef void(^REDActionSheetWillPresentBlock)(REDActionSheet *actionSheet);
typedef void(^REDActionSheetDidPresentBlock)(REDActionSheet *actionSheet);
typedef void(^REDActionSheetWillDismissWithButtonIndexBlock)(REDActionSheet *actionSheet, NSUInteger buttonIndex);
typedef void(^REDActionSheetDidDismissWithButtonIndexBlock)(REDActionSheet *actionSheet, NSUInteger buttonIndex);
typedef void(^REDActionSheetTappedButtonAtIndexBlock)(REDActionSheet *actionSheet, NSUInteger buttonIndex);


@interface REDActionSheet : UIView

@property (copy, nonatomic) REDActionSheetCancelBlock actionSheetCancelBlock;
@property (copy, nonatomic) REDActionSheetWillPresentBlock actionSheetWillPresentBlock;
@property (copy, nonatomic) REDActionSheetDidPresentBlock actionSheetDidPresentBlock;
@property (copy, nonatomic) REDActionSheetWillDismissWithButtonIndexBlock actionSheetWillDismissWithButtonIndexBlock;
@property (copy, nonatomic) REDActionSheetDidDismissWithButtonIndexBlock actionSheetDidDismissWithButtonIndexBlock;
@property (copy, nonatomic) REDActionSheetTappedButtonAtIndexBlock actionSheetTappedButtonAtIndexBlock;

- (instancetype)initWithCancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesList:(NSString *)otherButtonsList, ...;
- (void)showInView:(UIView *)view;
- (void)addButtonWithTitle:(NSString *)title;

@end
