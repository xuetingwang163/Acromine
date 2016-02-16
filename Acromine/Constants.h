//
//  Constants.h
//  Acromine
//
//  Created by DevanRaju on 08/01/16.
//  Copyright © 2016 First-tek. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#endif /* Constants_h */

#define ACROMINE_URL @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@"

#ifdef RELEASE
#define DebugLog( s, ... )
#else
#define DebugLog( s, ... ) NSLog( @"<%p %@:%d (%@)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  NSStringFromSelector(_cmd), [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#endif