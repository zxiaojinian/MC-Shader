#version 120

uniform sampler2D texture;
uniform sampler2D lightmap;

varying vec4 color;
varying vec4 texcoord;

void main() 
{
    gl_FragData[0] = color * texture2D(texture, texcoord.st);
}