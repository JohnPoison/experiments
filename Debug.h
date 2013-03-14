#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:%d (%@)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  NSStringFromSelector(_cmd), [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif
#if DEBUG
#define CHECK_GL_ERROR_DEBUG() ({ GLenum __error = glGetError(); if(__error) printf("OpenGL error 0x%04X in %s %d\n", __error, __FUNCTION__, __LINE__); })
#else
#define CHECK_GL_ERROR_DEBUG()
#endif
