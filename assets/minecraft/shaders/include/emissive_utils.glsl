#version 150

float check_alpha(float textureAlpha, float targetAlpha) {
	float targetLess = targetAlpha - 0.01;
	float targetMore = targetAlpha + 0.01;
	if (textureAlpha > targetLess && textureAlpha < targetMore) return 1.0;
	else return 0.0;
}

vec4 make_emissive(vec4 inputColor, vec4 lightColor, float vertexDistance, float inputAlpha) {
	if (vertexDistance > 800) return inputColor;
	if (check_alpha(inputAlpha, 252.0) == 1.0) return inputColor; // Default case, checks for alpha 252 and just returns the input color if it is.
	else if (check_alpha(inputAlpha, 251.0) == 1.0) return inputColor; // Copypaste this and change the number to add a custom alpha value.
	else return inputColor * lightColor; // If none of the pixels are supposed to be emissive, then it adds the light.
}

float remap_alpha(float inputAlpha) {
	if (check_alpha(inputAlpha, 252.0) == 1.0) return 255.0; // Default case, checks for alpha 252 and converts all pixels of that to alpha 255.
	else if (check_alpha(inputAlpha, 251.0) == 1.0) return 190.0; // Copypaste this and change the numbers to add a custom alpha value.
	else return inputAlpha; // If none of the pixels are meant to be mapped then it just doesn't map.
}