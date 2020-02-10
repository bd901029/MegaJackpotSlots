
#import "LinesPosition.h"
#import "cfg.h"

@implementation LinesPosition

+ (CGPoint)getLinePosition:(int)lineNumber
{
    CGPoint pos;
    
    switch (lineNumber) {
        case 1:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 2:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.612) + (kHeightScreen *(IS_IPAD ? 0 : 0.124f))); break;
        case 3:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.255) + (kHeightScreen *(IS_IPAD ? 0 : 0.050f))); break;
        case 4:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.407) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 5:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.462) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 6:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.548) + (kHeightScreen *(IS_IPAD ? 0 : 0.115f))); break;
        case 7:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.318) + (kHeightScreen *(IS_IPAD ? 0 : 0.065f))); break;
        case 8:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 9:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.433) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 10:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 11:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.432) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 12:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.518) + (kHeightScreen *(IS_IPAD ? 0 : 0.119f))); break;
        case 13:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.348) + (kHeightScreen *(IS_IPAD ? 0 : 0.056f))); break;
        case 14:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.520) + (kHeightScreen *(IS_IPAD ? 0 : 0.110f))); break;
        case 15:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.345) + (kHeightScreen *(IS_IPAD ? 0 : 0.066f))); break;
        case 16:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.570) + (kHeightScreen *(IS_IPAD ? 0 : 0.105f))); break;
        case 17:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.301) + (kHeightScreen *(IS_IPAD ? 0 : 0.070f))); break;
        case 18:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 19:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 20:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 21:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 22:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.420) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 23:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.450) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 24:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 25:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.436) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 26:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.443) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 27:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.435) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 28:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.415) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 29:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.422) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
        case 30:pos = CGPointMake(kWidthScreen/2, (kHeightScreen*0.455) + (kHeightScreen *(IS_IPAD ? 0 : 0.085f))); break;
            
        default:
            break;
    }

    return pos;
}

@end
