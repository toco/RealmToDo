// --------------------------------------------------------------------------------
// The MIT License (MIT)
//
// Copyright (c) 2014 Shiny Development
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// --------------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "SDStatusBarManager.h"

/* Generated by RuntimeBrowser.
 Image: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/UIKit.framework/UIKit
 */

typedef struct {
  char boolitemIsEnabled[25];
  char timeString[64];
  int gsmSignalStrengthRaw;
  int gsmSignalStrengthBars;
  char serviceString[100];
  char serviceCrossfadeString[100];
  char serviceImages[2][100];
  char operatorDirectory[1024];
  unsigned int serviceContentType;
  int wifiSignalStrengthRaw;
  int wifiSignalStrengthBars;
  unsigned int dataNetworkType;
  int batteryCapacity;
  unsigned int batteryState;
  char batteryDetailString[150];
  int bluetoothBatteryCapacity;
  int thermalColor;
  unsigned int thermalSunlightMode : 1;
  unsigned int slowActivity : 1;
  unsigned int syncActivity : 1;
  BOOL activityDisplayId[256];
  unsigned int bluetoothConnected : 1;
  unsigned int displayRawGSMSignal : 1;
  unsigned int displayRawWifiSignal : 1;
  unsigned int locationIconType : 1;
  unsigned int quietModeInactive : 1;
  unsigned int tetheringConnectionCount;
} StatusBarRawData;

typedef struct {
  char booloverrideItemIsEnabled[25];
  unsigned int overrideTimeString : 1;
  unsigned int overrideGsmSignalStrengthRaw : 1;
  unsigned int overrideGsmSignalStrengthBars : 1;
  unsigned int overrideServiceString : 1;
  unsigned int overrideServiceImages : 2;
  unsigned int overrideOperatorDirectory : 1;
  unsigned int overrideServiceContentType : 1;
  unsigned int overrideWifiSignalStrengthRaw : 1;
  unsigned int overrideWifiSignalStrengthBars : 1;
  unsigned int overrideDataNetworkType : 1;
  unsigned int disallowsCellularDataNetworkTypes : 1;
  unsigned int overrideBatteryCapacity : 1;
  unsigned int overrideBatteryState : 1;
  unsigned int overrideBatteryDetailString : 1;
  unsigned int overrideBluetoothBatteryCapacity : 1;
  unsigned int overrideThermalColor : 1;
  unsigned int overrideSlowActivity : 1;
  unsigned int overrideActivityDisplayId : 1;
  unsigned int overrideBluetoothConnected : 1;
  unsigned int overrideDisplayRawGSMSignal : 1;
  unsigned int overrideDisplayRawWifiSignal : 1;
  struct {
    char boolitemIsEnabled[25];
    char timeString[64];
    int gsmSignalStrengthRaw;
    int gsmSignalStrengthBars;
    char serviceString[100];
    char serviceCrossfadeString[100];
    char serviceImages[2][100];
    char operatorDirectory[1024];
    unsigned int serviceContentType;
    int wifiSignalStrengthRaw;
    int wifiSignalStrengthBars;
    unsigned int dataNetworkType;
    int batteryCapacity;
    unsigned int batteryState;
    char batteryDetailString[150];
    int bluetoothBatteryCapacity;
    int thermalColor;
    unsigned int thermalSunlightMode : 1;
    unsigned int slowActivity : 1;
    unsigned int syncActivity : 1;
    BOOL activityDisplayId[256];
    unsigned int bluetoothConnected : 1;
    unsigned int displayRawGSMSignal : 1;
    unsigned int displayRawWifiSignal : 1;
    unsigned int locationIconType : 1;
    unsigned int quietModeInactive : 1;
    unsigned int tetheringConnectionCount;
  } values;
} StatusBarOverrideData;

@class UIStatusBarServerClient;

@interface UIStatusBarServer : NSObject  {
  UIStatusBarServerClient *_statusBar;
  struct __CFRunLoopSource { } *_source;
}

@property(retain) UIStatusBarServerClient * statusBar;

+ (unsigned int)_serverPort;
+ (void)runServer;
+ (id)getDoubleHeightStatusStringForStyle:(long long)arg1;
+ (bool)getGlowAnimationStateForStyle:(long long)arg1;
+ (int)getStyleOverrides;
+ (StatusBarOverrideData *)getStatusBarOverrideData;
+ (const StatusBarRawData*)getStatusBarData;
+ (void)permanentizeStatusBarOverrideData;
+ (void)postStatusBarOverrideData:(StatusBarOverrideData*)arg1;
+ (void)postStatusBarData:(const StatusBarRawData*)arg1 withActions:(int)arg2;
+ (unsigned int)_publisherPort;
+ (double)getGlowAnimationEndTimeForStyle:(long long)arg1;
+ (void)removeStatusBarItem:(int)arg1;
+ (void)addStatusBarItem:(int)arg1;
+ (void)postDoubleHeightStatusString:(id)arg1 forStyle:(long long)arg2;
+ (void)postGlowAnimationState:(bool)arg1 forStyle:(long long)arg2;
+ (void)removeStyleOverrides:(int)arg1;
+ (void)addStyleOverrides:(int)arg1;
@end

@implementation SDStatusBarManager

- (void)enableOverrides
{
  self.usingOverrides = YES;

  StatusBarOverrideData *overrides = [UIStatusBarServer getStatusBarOverrideData];

  // Set 9:41 time in current localization
  NSString *dateString = [self localizedTimeString];
  overrides->overrideTimeString = 1;
  strcpy(overrides->values.timeString, [dateString cStringUsingEncoding:NSUTF8StringEncoding]);

  // Enable 5 bars of mobile (iPhone only)
  if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
    overrides->booloverrideItemIsEnabled[3] = 1;
    overrides->values.boolitemIsEnabled[3] = 1;
    overrides->overrideGsmSignalStrengthBars = 1;
    overrides->values.gsmSignalStrengthBars = 5;
  }

  // Remove carrier text for iPhone, set it to "iPad" for the iPad
  NSString *carrierText = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? @"" : @"iPad";
  overrides->overrideServiceString = 1;
  strcpy(overrides->values.serviceString, [carrierText cStringUsingEncoding:NSUTF8StringEncoding]);

  // Battery
  overrides->booloverrideItemIsEnabled[8] = 1;
  overrides->values.boolitemIsEnabled[8] = 1;
  overrides->overrideBatteryDetailString = 1;
  strcpy(overrides->values.batteryDetailString, [@"100%" cStringUsingEncoding:NSUTF8StringEncoding]);

//  // Bluetooth (uncomment to turn on bluetooth icon).
//  overrides->booloverrideItemIsEnabled[11] = 1;
//  overrides->values.boolitemIsEnabled[11] = 1;
//  overrides->overrideBluetoothConnected = 1;
//  overrides->values.bluetoothConnected = 1;

  // Actually update the status bar
  [UIStatusBarServer postStatusBarOverrideData:overrides];

  // Lock in the changes, reset simulator will remove this
  [UIStatusBarServer permanentizeStatusBarOverrideData];
}

- (void)disableOverrides
{
  self.usingOverrides = NO;

  StatusBarOverrideData *overrides = [UIStatusBarServer getStatusBarOverrideData];

  // Remove specific overrides (separate flags)
  overrides->overrideTimeString = 0;
  overrides->overrideGsmSignalStrengthBars = 0;
  overrides->overrideBatteryDetailString = 0;
  overrides->overrideBatteryDetailString = 0;
  overrides->overrideBluetoothConnected = 0;

  // Remove all overrides that use the array of bools
  for (int i = 0; i < 25; i++) {
    overrides->booloverrideItemIsEnabled[i] = 0;
    overrides->values.boolitemIsEnabled[i] = 0;
  }

  // Carrier text (it's an override to set it back to the default)
  overrides->overrideServiceString = 1;
  strcpy(overrides->values.serviceString, [NSLocalizedString(@"Carrier",@"Carrier") cStringUsingEncoding:NSUTF8StringEncoding]);

  // Actually update the status bar
  [UIStatusBarServer postStatusBarOverrideData:overrides];

  // Have to call this to remove all the overrides
  [UIStatusBarServer permanentizeStatusBarOverrideData];
}

#pragma mark Properties
- (BOOL)usingOverrides
{
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"using_overrides"];
}

- (void)setUsingOverrides:(BOOL)usingOverrides
{
  [[NSUserDefaults standardUserDefaults] setBool:usingOverrides forKey:@"using_overrides"];
}

#pragma mark Singleton instance
+ (SDStatusBarManager *)sharedInstance
{
  static dispatch_once_t predicate = 0;
  __strong static id sharedObject = nil;
  dispatch_once(&predicate, ^{ sharedObject = [[self alloc] init]; });
  return sharedObject;
}

#pragma mark Helper

- (NSString *)localizedTimeString
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateStyle = NSDateFormatterNoStyle;
  formatter.timeStyle = NSDateFormatterShortStyle;
	
  NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
  components.hour = 9;
  components.minute = 41;
  NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
  return [formatter stringFromDate:date];
}

@end
