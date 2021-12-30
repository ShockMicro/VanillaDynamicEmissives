#version 150

// Checking for the exact alpha value breaks things, so I use this function to cut down on space while also making it work better.

bool check_alpha(float textureAlpha, float targetAlpha) {
	
	float targetLess = targetAlpha - 0.01;
	float targetMore = targetAlpha + 0.01;
	return (textureAlpha > targetLess && textureAlpha < targetMore);
	
}


// For cases in which you want something to have a lower light level, but still be bright when in light.

vec4 apply_partial_emissivity(vec4 inputColor, vec4 originalLightColor, vec3 minimumLightColor) {
	
	vec4 newLightColor = originalLightColor;
	newLightColor.r = max(originalLightColor.r, minimumLightColor.r);
	newLightColor.g = max(originalLightColor.g, minimumLightColor.g);
	newLightColor.b = max(originalLightColor.b, minimumLightColor.b);
	return inputColor * newLightColor;
	
}


// The meat and bones of the pack, does all the work for making things emissive.

vec4 make_emissive(vec4 inputColor, vec4 lightColor, vec4 maxLightColor, float vertexDistance, float inputAlpha) {
	
	if (vertexDistance > 800) return inputColor; // Vertex Distance > 800 generally means an object is in the UI, which we don't want to affect.
	
	if (check_alpha(inputAlpha, 252.0)) return inputColor; // Checks for alpha 252 and just returns the input color if it is. Used in the example pack for redstone ore and the zombie's eyes.
	else if (check_alpha(inputAlpha, 251.0)) return apply_partial_emissivity(inputColor, lightColor, vec3(0.411, 0.345, 0.388)); // You can copy & paste this line and change the function to add your own functionality. Used in the example pack for ice.
	
	else return inputColor * lightColor; // If none of the pixels are supposed to be emissive, then it adds the light.
	
}


// Makes sure transparent things don't become solid and vice versa.

float remap_alpha(float inputAlpha) {
	
	if (check_alpha(inputAlpha, 252.0)) return 255.0; // Checks for alpha 252 and converts all pixels of that to alpha 255. Used in the example pack for redstone ore and the zombie's eyes.
	else if (check_alpha(inputAlpha, 251.0)) return 190.0; // You can copy & paste this line and change the values to make any transparent block work with this pack. Used in the example pack for ice.
	
	else return inputAlpha; // If a pixel doesn't need to have its alpha changed then it simply does not change.
	
}

