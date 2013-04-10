//
//  glwDefaultFragment.h
//  pacman
//
//  Created by JohnPoison on 3/13/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

"											\n\
precision lowp float;						\n\
                                            \n\
varying vec4 v_fragmentColor;				\n\
varying vec2 v_texCoord;					\n\
uniform sampler2D u_texture;				\n\
                                            \n\
void main()									\n\
{											\n\
    //vec4 texColor = texture2D(u_texture, vec2(1,1));			\n\
    gl_FragColor = texture2D(u_texture, v_texCoord);			\n\
    //gl_FragColor = texColor;			\n\
    //gl_FragColor = v_fragmentColor;			\n\
}											\n\
";
