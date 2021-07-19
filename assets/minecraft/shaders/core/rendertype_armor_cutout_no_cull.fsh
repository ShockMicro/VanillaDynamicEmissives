#version 150

#moj_import <fog.glsl>
#moj_import <emissive_utils.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;
in vec4 lightColor;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
	float translucency = color.a * 255.0;
    color = makeEmissive(color, lightColor, translucency);
	color.a = translucencyMap(translucency) / 255.0;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
