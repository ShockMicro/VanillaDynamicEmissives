#version 150

float checkTranslucency(float textureTranslucency, float targetTranslucency) {
	float targetLess = targetTranslucency - 0.01;
	float targetMore = targetTranslucency + 0.01;
	if(textureTranslucency > targetLess && textureTranslucency < targetMore) return 1.0;
	else return 0.0;
}

vec4 makeEmissive(vec4 inputColor, vec4 lightColor, float inputTranslucency) {
	if (checkTranslucency(inputTranslucency, 252.0) == 1.0) return inputColor;
	else if (checkTranslucency(inputTranslucency, 251.0) == 1.0) return inputColor; //copypaste this and change the number to add a custom translucency
	else return inputColor * lightColor;
}

float translucencyMap(float inputTranslucency) {
	if (checkTranslucency(inputTranslucency, 252.0) == 1.0) return 255.0;
	else if (checkTranslucency(inputTranslucency, 251.0) == 1.0) return 190.0; //copypaste this and change the numbers to add a custom translucency
	else return inputTranslucency;
}