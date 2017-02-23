# Pre-work - *Advanced Tip Calculator*

**Advanced Tip Calculator** is a tip calculator application for iOS.

Submitted by: **Kaamel Kermaani**

Time spent: **6** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesnt have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
* The user can set a rounding option for the tip amount or total
* The options are 1) round up 2) round normal ) round down
 * Examples for each options are displayed for clarity
 * If rounding is not enabled, the rounding options and examples are hidden
* The user can set a minimum tip (e.g. $1.00) and/or a maximum tip (e.g. $100.00)
 * If there are conflicts between rounding and the limits, the rounding is ignored. For example if minimum tip is set to $1.00 and user
has set the default to round down and the tip is rounded down to 0, it will still be kept at $1.00.
* The app theme can be set to light to dark
 * The app needs to be reinitialized for the new theme to take effect

## Video Walkthrough 

Here is a walkthrough of implemented user stories:

<img src='http://i.imgur.com/n6K0cw6.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Here is an the second part where locale is changed:

<img src='http://i.imgur.com/1BUtoYh.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Most of the challenges had to do with figuring out the life cycles and text & currency <-> numbers converssions. I am sure
there is an easy way to make theme changes without restarting the application but as of this writing I need do some more
reading/searching before making it happen. I also was rushing it out the solution so didn't get to change the app  icon
successfully.

## License

Copyright 2017 [Kaamel Kermaani]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
