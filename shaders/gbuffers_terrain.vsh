#version 120

uniform float frameTimeCounter;
attribute vec3 mc_Entity;
attribute vec2 mc_midTexCoord;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

void main()
{
    vec4 position = gl_Vertex;
    //31：草；37：蒲公英；38：花
    if((mc_Entity.x == 31.0 || mc_Entity.x == 37.0 || mc_Entity.x == 38.0) && gl_MultiTexCoord0.t < mc_midTexCoord.t)
    {
        float offset = sin(frameTimeCounter * 3.0) * 0.2;
        vec3 dir = vec3(1.0, 0.0, 1.0);
        position.xyz = position.xyz + dir * offset;
    }
    position = gl_ModelViewMatrix * position; 
    gl_Position = gl_ProjectionMatrix * position;
    gl_FogFragCoord = length(position.xyz);
    color = gl_Color;
    texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
}