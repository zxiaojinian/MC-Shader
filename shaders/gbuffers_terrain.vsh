#version 120

attribute vec3 mc_Entity;
attribute vec2 mc_midTexCoord;

uniform float frameTimeCounter;
uniform float rainStrength;
uniform sampler2D noisetex;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

void main()
{
    vec4 position = gl_Vertex;
    //31：草；37：蒲公英；38：花
    if((mc_Entity.x == 31.0 || mc_Entity.x == 37.0 || mc_Entity.x == 38.0) && gl_MultiTexCoord0.t < mc_midTexCoord.t)
    {
        vec3 noise = texture2D(noisetex, fract(position.xz / 256.0)).rgb;
        float time = frameTimeCounter * 3.0;
        float strength = 1.0 + rainStrength * 0.5;
        float randomStrength = pow(cos(noise.z * 10.0 + time * 0.1), 2);
        strength = max(max(0.1, randomStrength), rainStrength) * 0.2 * strength;
        float xoffset = sin(time + noise.x * 10.0) * strength;
        float zoffset = sin(time + noise.y * 10.0) * strength;
        position.xz += vec2(xoffset, zoffset);
    }
    else if(mc_Entity.x == 18.0 || mc_Entity.x == 106.0 || mc_Entity.x == 161.0 || mc_Entity.x == 175.0)
    {
        vec3 noise = texture2D(noisetex, (position.xz + 0.5) / 16.0).rgb; //一个mesh为16X16X16个方块，一个方块长1单位。noisetex为四方连续
        float time = frameTimeCounter * 3.0;
        float strength = 1.0 + rainStrength * 0.5;
        float randomStrength = pow(cos(noise.z * 10.0 + time * 0.1), 2);
        strength = max(max(0.1, randomStrength), rainStrength) * 0.07 * strength;
        float xoffset = sin(time + noise.x * 10.0) * strength;
        float zoffset = sin(time + noise.y * 10.0) * strength;
        position.xz += vec2(xoffset, zoffset);
    }
    position = gl_ModelViewMatrix * position; 
    gl_Position = gl_ProjectionMatrix * position;
    gl_FogFragCoord = length(position.xyz);
    color = gl_Color;
    texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
}