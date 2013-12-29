//
//  REDActionSheetButton.h
//  REDTweetbotActionSheet
//
//  Created by Red Davis on 23/12/2013.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, REDActionSheetButtonPosition)
{
	REDActionSheetButtonPositionUnknown,
	REDActionSheetButtonPositionTop,
	REDActionSheetButtonPositionMiddle,
	REDActionSheetButtonPositionBottom
};

typedef NS_ENUM(NSUInteger, REDActionSheetButtonType)
{
	REDActionSheetButtonTypeUnknown,
	REDActionSheetButtonTypeDefault,
	REDActionSheetButtonTypeCancel,
	REDActionSheetButtonTypeDestructive
};


@interface REDActionSheetButton : UIButton

@property (assign, nonatomic) REDActionSheetButtonPosition position;
@property (assign, nonatomic) REDActionSheetButtonType type;

- (instancetype)initWithTitle:(NSString *)title;

@end
