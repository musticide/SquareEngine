#pragma once

#ifdef SQ_PLATFORM_WINDOWS
    #ifdef SQ_BUILD_DLL
        #define SQUARE_API __declspec(dllexport)
    #else
        #define SQUARE_API __declspec(dllimport)
    #endif // BUILD DLL 
#else
    #pragma message "Square engine Supports windows only!"
#endif //windows platform 


// #define SQUARE_API __declspec(dllexport)
