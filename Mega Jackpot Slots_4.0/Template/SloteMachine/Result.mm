

#import "Result.h"
#import "Lines.h"
#import "cfg.h"

@implementation Result

+ (NSArray *)getResultFromArray:(NSArray *)elements lines:(int)lines_
{
   // int maxLines = 15;
    
    NSMutableArray *finalArray = [[[NSMutableArray alloc]init]autorelease];

    NSMutableArray *lines = [[[NSMutableArray alloc]initWithArray:[Lines returnLines:lines_]]autorelease];
    // xxx kiek kartu sita kviecia ? turi kviesti 1 karta jeigu daug kartu kreipiasi cia
    
    
    for (id line in (NSMutableArray *)lines) {

        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        for (id item_pos in (NSArray*)line) {
            
            NSNumber *number_ = (NSNumber *)item_pos;
            
            [array addObject:[elements objectAtIndex:number_.intValue]];
            
        }
        //NSLog(@"ARRAY:  %@  LINE:  %@",array,line);
        NSArray *check_ = [self check_if_won:array line:line lineNumber:([lines indexOfObject:line])+1];
        
        
               
        if ([check_ objectAtIndex:0] != nil) {
            [finalArray addObject:check_];
        }
        
       // NSLog(@"\n \n BONUS COUNT: %@ \n SCATTER COUNT: %@ \n WINNING_CHAR: %@ \n WINNINGCOUT: %@ \n IS_BONUS: %@ \n IS_SCATTER: %@ \n \n",[finalArray objectAtIndex:0],[finalArray objectAtIndex:1],[finalArray objectAtIndex:2],[finalArray objectAtIndex:3],[finalArray objectAtIndex:4],[finalArray objectAtIndex:5]);
  
    }
    return finalArray;
}

+ (NSArray *)check_if_won:(NSArray *)ar_ line:(NSArray *)line_ lineNumber:(int)lineNum
{
    
    NSMutableArray  *unique         = [[[NSMutableArray alloc]init]autorelease];
    NSMutableSet    *processed      = [[[NSMutableSet alloc]init]autorelease];
    NSMutableArray  *firstArray     = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray  *finalArray     = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray  *scatter_ar     = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray  *bonus_ar       = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray  *finalLine      = [[[NSMutableArray alloc]init]autorelease];
    
    NSString *winningChar = @"";
    
    int winningCount    = 0;
    
    int i_scatter       = 0;
    int i_bonus         = 0;
    
    bool b_scatter = false;
    bool b_bonus   = false;
    
    int index           = 0;
    
    int uniquelenght    = 0;
    
    NSRange range;
    
    for (NSString *item in ar_)
    {
       // NSLog(@"item:  %@",item);
        index++;
        
        if ([item isEqualToString:kSCATER]) {
			i_scatter++;
            [scatter_ar addObject:[line_ objectAtIndex:index-1]];
			continue;
		}
		
		if ([item isEqualToString:kBONUS]) {
			i_bonus++;
            [bonus_ar addObject:[line_ objectAtIndex:index-1]];
			continue;
		}
        
        if (index == 1) {continue;}
        
        range.location  = 0;
        range.length    = index;
        
        NSArray *subarray = [ar_ subarrayWithRange:range];
        
        for (NSString *uniqitem in subarray) {
    
            if ([processed containsObject:uniqitem] == NO) {
                [unique addObject:uniqitem];
                [processed addObject:uniqitem];
            }
        }
        
        uniquelenght = [unique count];
        
        if (uniquelenght == 1) {
            
            NSString *firstElement = [unique objectAtIndex:0];
            
            if ([firstElement isEqualToString:kWILD]) {
                continue;
            }
            
            winningChar     = [unique objectAtIndex:0];
            winningCount    = index;
            
        }
        if (uniquelenght == 2) {
            NSString *firstElement  = [unique objectAtIndex:0];
            NSString *secondElement = [unique objectAtIndex:1];
            
            if ([firstElement isEqualToString:kWILD]) {
                
                if ([secondElement isEqualToString:kSCATER]){ continue;};
                if ([secondElement isEqualToString:kBONUS]){ continue;};
                
                winningChar     = secondElement;
                winningCount    = index;
            }
            
            if ([secondElement isEqualToString:kWILD]) {
                
                if ([firstElement isEqualToString:kSCATER]){ continue;};
                if ([firstElement isEqualToString:kBONUS]){ continue;};
                
                winningChar     = firstElement;
                winningCount    = index;
            }
        }
    }
   // NSLog(@"scater:  %@   bonus:  %@",scatter_ar,bonus_ar);
    
    if (i_bonus >= 3) { b_bonus = true; winningChar = kBONUS;}
    if (i_scatter >= 3) { b_scatter = true; winningChar = kSCATER;}
    
    [firstArray addObject:[NSNumber numberWithInt:lineNum]];// line number
    [firstArray addObject:[NSNumber numberWithInt:i_bonus]];// bonus count
    [firstArray addObject:[NSNumber numberWithInt:i_scatter]];// scater count
    [firstArray addObject:winningChar];// winning char
    [firstArray addObject:[NSNumber numberWithInt:winningCount]];// winning count
    [firstArray addObject:[NSNumber numberWithBool:b_bonus]];// bonus bool
    [firstArray addObject:[NSNumber numberWithBool:b_scatter]];// scater bool
    
    
    if (winningCount > 0 || b_bonus == true || b_scatter == true) {
        
        for (int i = 0; i < winningCount; i++) {
            [finalLine addObject:[line_ objectAtIndex:i]];
        }
        
        finalArray = [NSMutableArray arrayWithObjects:firstArray,finalLine, nil];
        
        if (b_bonus) {
            
            if (finalArray != nil) {
                [finalArray removeAllObjects];
            }
            
            finalArray = [NSMutableArray arrayWithObjects:firstArray,bonus_ar, nil];
        }
        if (b_scatter) {
            
            if (finalArray != nil) {
                [finalArray removeAllObjects];
            }
            
            finalArray = [NSMutableArray arrayWithObjects:firstArray,scatter_ar, nil];
        }
        return finalArray;
    }
    
    return nil;
}

@end
