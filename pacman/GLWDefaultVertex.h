//
//  glwDefaultVertex.h
//  pacman
//
//  Created by JohnPoison on 3/13/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

"													\n\
attribute vec4 a_position;							\n\
//attribute vec2 a_texCoord;							\n\
//attribute vec4 a_color;								\n\
                                                    \n\
//uniform		mat4 u_MVP;                             \n\
                                                    \n\
//varying lowp vec4 v_fragmentColor;                  \n\
//varying mediump vec2 v_texCoord;                    \n\
                                                    \n\
void main()											\n\
{													\n\
//    gl_Position = u_MVP * a_position;               \n\
    gl_Position = a_position;                      \n\
//    v_fragmentColor = a_color;						\n\
//    v_texCoord = a_texCoord;						\n\
}													\n\
";