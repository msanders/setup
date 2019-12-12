#include <ApplicationServices/ApplicationServices.h>
#include <CoreFoundation/CoreFoundation.h>

extern bool CGDisplayUsesForceToGray(void);
extern void CGDisplayForceToGray(bool);

int main(int argc, char **argv) {
    bool isGrayscale = CGDisplayUsesForceToGray();
    CGDisplayForceToGray(!isGrayscale);
    return 0;
}
