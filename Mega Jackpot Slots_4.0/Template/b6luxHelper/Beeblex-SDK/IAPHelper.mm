

#import "IAPHelper.h"
#import "cfg.h"
#import "b6luxLoadingView.h"
#import "TopMenu.h"
#import "BottomMenu.h"
#import "IDSTOREPLACE.h"

//#import "ASIFormDataRequest.h"
//#import "SBJson.h"

#import "BBXIAPTransaction.h"
#import "BBXBeeblex.h"

#define IAPHelperProductPurchasedNotification @"IAPHelperProductPurchasedNotification"

#define ITMS_PROD_VERIFY_RECEIPT_URL        @"https://buy.itunes.apple.com/verifyReceipt"
#define ITMS_SANDBOX_VERIFY_RECEIPT_URL     @"https://sandbox.itunes.apple.com/verifyReceipt";
#define SHARED_SECRET                       @""


@implementation IAPHelper
@synthesize isPurchasedNow, isRestoringNow;

- (id)init{
    
    if ((self = [super init])) {
        // Add self as transaction observer
    }
    return self;
}

static const char* jailbreak_apps[] =

{
    
    "/bin/bash",
    
    "/Applications/Cydia.app",
    
    "/Applications/limera1n.app",
    
    "/Applications/greenpois0n.app",
    
    "/Applications/blackra1n.app",
    
    "/Applications/blacksn0w.app",
    
    "/Applications/redsn0w.app",
    
    NULL,
    
};



- (BOOL)isJailBroken

{
    
//#if TARGET_IPHONE_SIMULATOR
    
   // returnNO;
    
//#endif
    
    
    
    // Check for known jailbreak apps. If we encounter one, the device is jailbroken.
    
    for (int i = 0; jailbreak_apps[i] != NULL; ++i)
        
    {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]])
            
        {
            
            //NSLog(@"isjailbroken: %s", jailbreak_apps[i]);
            
            return YES;
            
        }
        
    }
    
    
    
    return NO;
    
}

- (void)requestProductsWithIndetifier:(NSString *)_indetifier parent:(CCNode *)sender{
    
    UIView *view__ = [[[b6luxLoadingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) loading:kLOADING_PURCHASE]autorelease];
    view__.tag = kLOADINGTAG;
    [[[CCDirector sharedDirector] openGLView]addSubview:view__];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/iap.dylib"]){
        NSLog(@"IAP Cracker detected");
        [self hackAlert];
        return;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/LocalIAPStore.dylib"]) {
        NSLog(@"Local IAP Store detected");
        [self hackAlert];
        return;
    }
    
   // NSLog(@"%@",sender.parent.parent.parent.parent);
    

    
    isPurchasedNow = YES;
    isRestoringNow = YES;
    parent__ = sender;
    identifier_ = _indetifier;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:identifier_]];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

- (void)buyProduct:(SKProduct *)product {
    
   // NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {

//    NSArray * skProducts = response.products;
//    for (SKProduct * skProduct in skProducts) {
//        NSLog(@"Found product: %@ %@ %0.2f",
//              skProduct.productIdentifier,
//              skProduct.localizedTitle,
//              skProduct.price.floatValue);
//    }
    
    SKProduct *_product = nil;
    _productsRequest = nil;
    int count = [response.products count];
    
    if (count>0) {
        _product = [response.products objectAtIndex:0];
        [self buyProduct:_product];
         NSLog(@"PRODUCTS:   %@",[response.products objectAtIndex:0]);
    
    } else {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil, nil];
        [tmp show];
        [tmp release];
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    
    UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Error"
                        message:@"Your purchase was not completed. You will not be charged. Please try again."
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil, nil];
    [tmp show];
    [tmp release];

    _productsRequest = nil;
    isPurchasedNow = NO;
    isRestoringNow = NO;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
            if ([a viewWithTag:kLOADINGTAG]) {
                [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
            }
        }
    }
}




- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
               // [db SS_purchase_player:[gc_ getLocalPlayerAlias] type:@"purchased" state:transaction.transactionState];
                
                
                
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
               // [db SS_purchase_player:[gc_ getLocalPlayerAlias] type:@"failed" state:transaction.transactionState];
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
               // [db SS_purchase_player:[gc_ getLocalPlayerAlias] type:@"restored" state:transaction.transactionState];
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    };
}
-(void)updateDB:(NSString *)row num:(float)num
{
    int n = [DB_ getValueBy:row table:d_DB_Table];
    
    [DB_ updateValue:row table:d_DB_Table :(n + num)];
    
    if ([row isEqualToString:d_Coins]) {
        [(TopMenu *)parent__.parent.parent addCoins:num];
    }
    else
    {
        [(BottomMenu *)[parent__.parent.parent.parent.parent getChildByTag:kBottomMenuTAG]updateBoostLabels];
    }
    
    UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Success"
                        message:@"Purchased successfully!"
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil, nil];
    [tmp show];
    [tmp release];

}
-(void)calculatePoits:(NSString *)indetifier
{
    NSString* amount = @"";
    if ([identifier_ isEqualToString:kIAP_I_COINS_1_99])        {[self updateDB:d_Coins num:1050]; amount = @"Bought Coins for 1,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_COINS_4_99])   {[self updateDB:d_Coins num:4400];amount = @"Bought Coins for 4,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_COINS_9_99])   {[self updateDB:d_Coins num:17250];amount = @"Bought Coins for 9,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_COINS_19_99])  {[self updateDB:d_Coins num:52000];amount = @"Bought Coins for 19,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_COINS_49_99])  {[self updateDB:d_Coins num:217500];amount = @"Bought Coins for 49,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_COINS_99_99])  {[self updateDB:d_Coins num:612500];amount = @"Bought Coins for 99,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST2X_1_99]) {[self updateDB:d_Boost2x num:20];amount = @"Bought Boost2x for 1,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST2X_2_99]) {[self updateDB:d_Boost2x num:40];amount = @"Bought Boost2x for 2,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST2X_3_99]) {[self updateDB:d_Boost2x num:60];amount = @"Bought Boost2x for 3,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST2X_4_99]) {[self updateDB:d_Boost2x num:80];amount = @"Bought Boost2x for 4,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST3X_2_99]) {[self updateDB:d_Boost3x num:20];amount = @"Bought Boost3x for 2,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST3X_4_99]) {[self updateDB:d_Boost3x num:40];amount = @"Bought Boost3x for 4,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST3X_6_99]) {[self updateDB:d_Boost3x num:80];amount = @"Bought Boost3x for 6,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST3X_8_99]) {[self updateDB:d_Boost3x num:100];amount = @"Bought Boost3x for 8,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST4X_6_99]) {[self updateDB:d_Boost4x num:40];amount = @"Bought Boost4x for 6,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST4X_8_99]) {[self updateDB:d_Boost4x num:80];amount = @"Bought Boost4x for 8,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST4X_14_99]){[self updateDB:d_Boost4x num:100];amount = @"Bought Boost4x for 14,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST4X_19_99]){[self updateDB:d_Boost4x num:120];amount = @"Bought Boost4x for 19,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST5X_14_99]){[self updateDB:d_Boost5x num:80];amount = @"Bought Boost5x for 14,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST5X_24_99]){[self updateDB:d_Boost5x num:100];amount = @"Bought Boost5x for 24,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST5X_34_99]){[self updateDB:d_Boost5x num:150];amount = @"Bought Boost5x for 34,99$";}
    else if ([identifier_ isEqualToString:kIAP_I_BOOST5X_49_99]){[self updateDB:d_Boost5x num:250];amount = @"Bought Boost5x for 49,99$";}
    
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                          action:amount
                                                           label:nil
                                                           value:nil] build]];
    
}

- (void) validatePurchaseOrRestore:(SKPaymentTransaction *)transaction
{
    __block int  transactionResult = 0;
   __block BOOL  purchaseDidFail = NO;
    __block BOOL hacked = NO;
    
    //The transaction has been reported as complete for a new purchase of the upgrade.  I now make use of Beeblex
    //to verify the receipt to ensure the purchase is legit.
    if (![BBXIAPTransaction canValidateTransactions])
    {
        transactionResult = 4;
        return; // There is no connectivity to reach the server.
        // You should try the validation at a later date.
    }
    
    BBXIAPTransaction *bbxTransaction = [[BBXIAPTransaction alloc] initWithTransaction:transaction];
    
    [bbxTransaction setUseSandbox:YES];
    
    [bbxTransaction validateWithCompletionBlock:^(NSError *error)
     {
         if (bbxTransaction.transactionVerified)
         {
             if (bbxTransaction.transactionIsDuplicate)
             {
                 // The transaction is valid, but duplicate - it has already been
                 // sent to Beeblex in the past.
                 transactionResult = 1;
                 hacked = NO;
                //  [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
             }
             else
             {
                 // The transaction has been successfully validated
                 // and is unique.
                 
                 NSLog(@"Transaction data: %@", bbxTransaction.validatedTransactionData);
                 
                [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
                 
                 /*
                 transactionResult = 0;
                 
//                 if (transaction !=nil) {
//                       [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
//                 }
                 
                  if (bbxTransaction.validatedTransactionData == nil) {
                     
                     if ([self isJailBroken])
                     {
                        NSLog(@"HACKER , DONT GIVE ANYTHING");
                         [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Hacked];
                         hacked = YES;
                     }
                     else {
                         NSLog(@"validation passed successfuly!");
                         [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
                     }
                   
                 }
                 else {
                     NSLog(@"validation passed successfuly!");
                     [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
                 }
                  */
                 
             }
         }
         else
         {
             // Check whether this is a validation error, or if something
             // went wrong with Beeblex.
             
             if (bbxTransaction.hasServerError)
             {
                 // The error was not caused by a problem with the data, but is
                 // most likely due to some transient networking issues.
                 transactionResult = 4;
                  [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
             }
             else
             {                 
                 // The transaction supplied to the validation service was not valid according to Apple.
                 transactionResult = 3;
                 purchaseDidFail = TRUE;
                 
                 if ([self isJailBroken])
                 {
                     NSLog(@"HACKER , DONT GIVE ANYTHING");
                     [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Hacked];
                     hacked = YES;
                 }
                //  [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
             }    
         }
     }];
    

    
}

-(void)_secure_finishTransactionWithValidation:(SKPaymentTransaction *)transaction withState:(int)state_{
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    int state = transaction.transactionState;
    if (state_==stateValidation_Hacked) {
        state = 9;
    }
    
    if(identifier_ != nil){
        
        [cfg SS_purchase_player:[Combinations getNSDEFAULTS_String:kUSER_UNIQE_IDE] type:identifier_ state:state];
        
        if (state_!=stateValidation_Hacked)
        {
            [self calculatePoits:identifier_];
        }
        
        identifier_ = nil;
        
    }
    
   
    
    for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
        if ([a viewWithTag:kLOADINGTAG]) {
            [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
        }
    }
    
    parent__ = nil;
    
    isPurchasedNow = NO;
    isRestoringNow = NO;
    
}

-(void)hackAlert{
    
    [cfg SS_purchase_player:[Combinations getNSDEFAULTS_String:kUSER_UNIQE_IDE] type:identifier_ state:stateValidation_Hacked];
    
    UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Error"
                        message:@"Purchse error...You might be using hacks to puchase products"
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil, nil];
    [tmp show];
    [tmp release];
    
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
   /* UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Success!"
                        message:@"You've bought all levels."
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil, nil];
    [tmp show];
    [tmp release];*/
    
    
    NSLog(@"completeTransaction... %@, transaction receipt %@",transaction,transaction.transactionReceipt);

    if(identifier_ != nil){
        
      [self _secure_finishTransactionWithValidation:transaction withState:stateValidation_Passed];
        
       //         [self validatePurchaseOrRestore:transaction];
    }

    /*
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];


    
    parent__ = nil;
    
    isPurchasedNow = NO;
    isRestoringNow = NO;
     
     */
}



- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
  //  NSLog(@"restoreTransaction...");
    
 /*   UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Success"
                        message:@"You have successfully restored all levels"
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil, nil];
    [tmp show];
    [tmp release];*/

//    if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//        [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
    

    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    isRestoringNow = NO;
    isPurchasedNow = NO;

    
//    if ([parent isKindOfClass:[B6luxPopUpManager class]]) {
//        [parent performSelector:@selector(smoothRemove) withObject:nil];
//    }
    parent__ = nil;
    
}


- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    
    
    NSLog(@"failedTransaction...");
    
    for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
        if ([a viewWithTag:kLOADINGTAG]) {
            [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
        }
    }
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Error"
                            message:@"Your purchase was not completed. You will not be charged. Please try again."
                            delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil, nil];
        [tmp show];
        [tmp release];
        
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    
    if(identifier_ != nil){
        [cfg SS_purchase_player:[Combinations getNSDEFAULTS_String:kUSER_UNIQE_IDE] type:identifier_ state:transaction.transactionState];
        identifier_ = nil;
    }
    
    isPurchasedNow = NO;
    isRestoringNow = NO;
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    
    if (alertView.visible) {
        [alertView removeFromSuperview];
    }
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
   //  NSLog(@"Post Natification...");
    [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchasedNotification object:productIdentifier userInfo:nil];
    
}

- (void)paymentQueue:(SKPaymentQueue*)queue restoreCompletedTransactionsFailedWithError:(NSError*)error
{
    for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
        if ([a viewWithTag:kLOADINGTAG]) {
            [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
        }
    }
 //   NSLog(@"canceled restore... Error %@",error);
    
    UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Error"
                        message:@"Your purchases restore was not completed. Please try again."
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil, nil];
    [tmp show];
    [tmp release];
    // DO AGAIN !!!!!!!!!
    
    
    isRestoringNow = NO;
    isPurchasedNow = NO;
    
}

- (void)restoreCompletedTransactionsWithparent:(CCNode *)sender{
    
    parent__ = sender;
    
    isPurchasedNow = YES;
    isRestoringNow = YES;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

@end
