# Objective-C Interoperability

Although BiteFlow is a pure Swift app, Objective-C interoperability is an essential skill. 
To include Objective-C:
1. Create `BFStringUtilities.h` and `BFStringUtilities.m`.
2. Ensure you have a Bridging Header (`BiteFlow-Bridging-Header.h`).
3. Import `#import "BFStringUtilities.h"` into the bridging header.
4. Call `[BFStringUtilities sanitizeString:]` directly from Swift.
