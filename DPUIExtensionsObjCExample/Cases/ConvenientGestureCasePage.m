//
//  ConvenientGestureCasePage.m
//  DPUIExtensionsObjCExample
//
//  Created by 张鹏 on 2023/4/14.
//

#import "ConvenientGestureCasePage.h"
#import <DPUI/DPUI-Swift.h>

@interface ConvenientGestureCasePage ()

@property (weak, nonatomic) IBOutlet UILabel *tapLabel;
@property (weak, nonatomic) IBOutlet UILabel *longPressLabel;
@property (weak, nonatomic) IBOutlet UILabel *panLabel;

@end

@implementation ConvenientGestureCasePage

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tapLabel addTapGestureRecognizerWithTarget:self action:@selector(tapLabelDidTap:)];
    [self.longPressLabel addLongPressGestureRecognizerWithTarget:self action:@selector(longPressDidPress:)];
    [self.panLabel addPanGestureRecognizerWithTarget:self action:@selector(panDidToggle:)];
}

#pragma mark - Event Methods

- (void)tapLabelDidTap:(id)sender {
    [self alertMessage:NSLocalizedString(@"Tap Message", nil)
             withTitle:NSLocalizedString(@"Tips", nil)];
}

- (void)longPressDidPress:(id)sender {
    [self alertMessage:NSLocalizedString(@"Long Press Message", nil)
             withTitle:NSLocalizedString(@"Tips", nil)];
}

- (void)panDidToggle:(id)sender {
    [self alertMessage:NSLocalizedString(@"Pan Message", nil)
             withTitle:NSLocalizedString(@"Tips", nil)];
}


#pragma mark - Helper Methods

- (void)alertMessage:(NSString *)message withTitle:(nullable NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
