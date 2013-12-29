# REDActionSheet

Tweet me [@reddavis](http://twitter.com/reddavis)

Email me me@red.to

Hire me http://red.to

## Overview

Action sheet similar to Tweetbot's.

## Example

```objc
	REDActionSheet *actionSheet = [[REDActionSheet alloc] initWithCancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitlesList:@"1", @"2", @"3", nil];
	actionSheet.actionSheetTappedButtonAtIndexBlock = ^(REDActionSheet *actionSheet, NSUInteger buttonIndex) {
		//...
	};
	[actionSheet showInView:self.view];
```

Video: http://taylorswift.ly/FEF3

## Getting Started

Copy "**REDActionSheet.h**", "**REDActionSheet.m**", "**REDActionSheetButton.h**" and "**REDActionSheetButton.m**" into your project.

## License

Copyright (c) Forever and ever Red Davis

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.