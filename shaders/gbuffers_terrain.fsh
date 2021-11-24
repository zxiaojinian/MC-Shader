#version 120

const int noiseTextureResolution = 256;

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform int fogMode;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

void main() 
{
    gl_FragData[0] = color * texture2D(texture, texcoord.st) * texture2D(lightmap, lmcoord.st);
    //linear fog
    vec3 linearFog = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp((gl_Fog.end - gl_FogFragCoord)/(gl_Fog.end - gl_Fog.start), 0.0, 1.0));
    //exp fog
    vec3 expFog = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp(exp(-gl_FogFragCoord * gl_Fog.density), 0.0, 1.0));
    //exp squar
    vec3 exp_squarFog = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp(exp(-pow((gl_Fog.density - gl_FogFragCoord), 2.0)), 0.0, 1.0));

    if(fogMode == 9729)
        gl_FragData[0].rgb = linearFog;
    else if(fogMode == 2048)
        gl_FragData[0].rgb = expFog;
    //Test
    //gl_FragData[0].rgb = exp_squarFog;
}