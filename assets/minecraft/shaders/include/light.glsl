#version 150

#define MINECRAFT_LIGHT_POWER   (0.6)
#define MINECRAFT_AMBIENT_LIGHT (0.4)

vec4 minecraft_mix_light(vec3 lightDir0, vec3 lightDir1, vec3 normal, vec4 color) {
    lightDir0 = normalize(lightDir0);
    lightDir1 = normalize(lightDir1);
    float light0 = max(0.0, dot(lightDir0, normal));
    float light1 = max(0.0, dot(lightDir1, normal));
    float lightAccum = min(1.0, (light0 + light1) * MINECRAFT_LIGHT_POWER + MINECRAFT_AMBIENT_LIGHT);
    return vec4(color.rgb * lightAccum, color.a);
}

vec4 minecraft_sample_lightmap(sampler2D lightMap, ivec2 uv) {
	float blockLight = uv.x / 16.0; // Doesn't do anything on its own but it's useful to have an easy reference for this
	float skyLight = uv.y / 16.0;
    return texture(lightMap, clamp(uv / 256.0, vec2(0.5 / 16.0), vec2(15.5 / 16.0)));
}

float check_alpha(float textureAlpha, float targetAlpha) {
	float targetLess = targetAlpha - 0.01;
	float targetMore = targetAlpha + 0.01;
	if (textureAlpha > targetLess && textureAlpha < targetMore) return 1.0;
	else return 0.0;
}

vec4 make_emissive(vec4 inputColor, vec4 lightColor, float vertexDistance, float inputAlpha) {
	if (check_alpha(inputAlpha, 252.0) == 1.0) return inputColor; // Default case, checks for alpha 252 and just returns the input color if it is.
	
	// Examples
	else if (check_alpha(inputAlpha, 251.0) == 1.0) return inputColor; // Copypaste this and change the number to add a custom alpha value.
	else if (check_alpha(inputAlpha, 250.0) == 1.0 && vertexDistance < 8.0) return inputColor; // Checks for alpha 250 and if it's near the player.
	else if (check_alpha(inputAlpha, 250.0) == 1.0 && lightColor.r > 0.4) return inputColor; // Checks for alpha 250 and if it's above a certain light color, which is about light level 10.
	
	else return inputColor * lightColor; // Fallback case, if none of the pixels are supposed to be emissive, then it adds the light.
}

float remap_alpha(float inputAlpha) {
	if (check_alpha(inputAlpha, 252.0) == 1.0) return 255.0; // Default case, checks for alpha 252 and converts all pixels of that to alpha 255.
	else if (check_alpha(inputAlpha, 251.0) == 1.0) return 190.0; // Copypaste this and change the numbers to add a custom alpha value.
	else return inputAlpha; // Fallback case, if none of the pixels are meant to be mapped then 
}