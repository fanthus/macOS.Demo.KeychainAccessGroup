//
//  ViewController.m
//  macOSReadKeychain
//
//  Created by Fan's iMac  on 11/23/17.
//  Copyright © 2017 Fan's iMac . All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(50, 50, 100, 100)];
    button.target = self;
    button.action = @selector(btnPressed:);
    [button setKeyEquivalent:@"\e"];  //按 esc 键会自动触发 action.
    [self.view addSubview:button];
}

- (void)btnPressed:(id)sender {
    NSLog(@"sender = %@",sender);
    NSLog(@">>>>>>>>>>>>> read ");
    NSMutableDictionary *searchDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [searchDict setObject:@"this is account" forKey:(__bridge NSString *)kSecAttrAccount];
    [searchDict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [searchDict setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge NSString *)kSecAttrSynchronizable]; //different from iOS
    [searchDict setObject:@"DZQ5YNVEU2.fan" forKey:(__bridge NSString *)kSecAttrAccessGroup];
    [searchDict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [searchDict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnAttributes];
    [searchDict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    CFTypeRef cfDictionary = NULL;
    NSInteger searchResult =  SecItemCopyMatching((__bridge CFDictionaryRef)searchDict, &cfDictionary);
    NSMutableDictionary *resultDict = (__bridge NSMutableDictionary *)cfDictionary;
    NSLog(@"searchResult %d | resultDict = %@",searchResult,resultDict);
    NSString *serviceName = [resultDict objectForKey:kSecAttrAccount];
    NSString *secInfo = [[NSString alloc ] initWithData:[resultDict objectForKey:(__bridge NSString *)kSecValueData] encoding:NSUTF8StringEncoding];
    NSLog(@"serviceName = %@,secInfo = %@",serviceName,secInfo);
    NSLog(@"<<<<<<<<<<<<< read ");
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
