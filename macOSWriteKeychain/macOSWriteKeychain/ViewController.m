//
//  ViewController.m
//  macOSWriteKeychain
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:(__bridge NSString *)kSecClassGenericPassword forKey:(__bridge NSString *)kSecClass];
    [dict setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge NSString *)kSecAttrSynchronizable];
    [dict setObject:@"DZQ5YNVEU2.fan" forKey:(__bridge NSString *)kSecAttrAccessGroup];
    [dict setObject:@"this is account" forKey:(__bridge NSString *)kSecAttrAccount];
    [dict setObject:@"this is service" forKey:(__bridge NSString *)kSecAttrService];
    [dict setObject:[@"this is password" dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge NSString *)kSecValueData];
    NSInteger result = SecItemAdd((__bridge CFMutableDictionaryRef)dict, NULL);
    NSLog(@"%d",result);
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
