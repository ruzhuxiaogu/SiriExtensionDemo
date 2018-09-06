//
//  ViewController.m
//  SiriExtensionDemo
//
//  Created by haofree on 2017/7/8.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ViewController.h"
#import "KuaibaoIntent.h"
#import "TestIntent.h"
#import <IntentsUI/IntentsUI.h>


@interface ViewController ()<INUIAddVoiceShortcutButtonDelegate, INUIAddVoiceShortcutViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *addSiriView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSiriButton];
}

- (void)addSiriButton{
    if (@available(iOS 12.0, *)) {
        TestIntent *kuaibaoIntent = [[TestIntent alloc] init];
        kuaibaoIntent.content = @"App内Siri按钮生成的ShortCut 2";
        INUIAddVoiceShortcutButton *button = [[INUIAddVoiceShortcutButton alloc] initWithStyle:INUIAddVoiceShortcutButtonStyleWhiteOutline];
        INShortcut *shortCut = [[INShortcut alloc] initWithIntent:kuaibaoIntent];
        button.delegate = self;
        button.shortcut = shortCut;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.addSiriView addSubview:button];
    } else {
        // Fallback on earlier versions
    }
}

- (IBAction)generateShortCutAction:(id)sender {
    if (@available(iOS 12.0, *)) {
        KuaibaoIntent *kuaibaoIntent = [[KuaibaoIntent alloc] init];
        kuaibaoIntent.content = @"新生成的Extension处理的ShortCut";
        INInteraction *interaction = [[INInteraction alloc] initWithIntent:kuaibaoIntent response:nil];
        [interaction donateInteractionWithCompletion:^(NSError * _Nullable error) {
            
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (IBAction)generateInAppShortCut:(id)sender {
    if (@available(iOS 12.0, *)) {
        TestIntent *kuaibaoIntent = [[TestIntent alloc] init];
        kuaibaoIntent.content = @"新生成的App内处理的ShortCut";
        INInteraction *interaction = [[INInteraction alloc] initWithIntent:kuaibaoIntent response:nil];
        [interaction donateInteractionWithCompletion:^(NSError * _Nullable error) {
            
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)presentAddVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)addVoiceShortcutViewController forAddVoiceShortcutButton:(INUIAddVoiceShortcutButton *)addVoiceShortcutButton{
    addVoiceShortcutViewController.delegate = self;
    [self presentViewController:addVoiceShortcutViewController animated:YES completion:^{
        
    }];
    
}
- (void)presentEditVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)editVoiceShortcutViewController forAddVoiceShortcutButton:(INUIAddVoiceShortcutButton *)addVoiceShortcutButton{
    
}

- (void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
