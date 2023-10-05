#version 150

// Checking for the exact alpha value breaks things, so I use this function to cut down on space while also making it work better.

bool compare_floats(float a, float b) {
	
	float targetLess = a - 0.01;
	float targetMore = a + 0.01;
	return (b > targetLess && b < targetMore);
	
}

// For cases in which you want something to have a lower light level, but still be bright when in light.

vec4 apply_partial_emissivity(vec4 inputColor, vec4 originalLightColor, vec3 minimumLightColor) {
    
    vec4 newLightColor = originalLightColor;
    newLightColor.r = max(originalLightColor.r, minimumLightColor.r);
    newLightColor.g = max(originalLightColor.g, minimumLightColor.g);
    newLightColor.b = max(originalLightColor.b, minimumLightColor.b);
    return inputColor * newLightColor;
    
}


// Gets the dimension that an object is in, -1 for The Nether, 0 for The Overworld, 1 for The End.

float get_dimension(vec4 minLightColor) {
    
    if (minLightColor.r == minLightColor.g && minLightColor.g == minLightColor.b) return 0.0; // Shadows are grayscale in The Overworld
    if (minLightColor.r > minLightColor.g) return -1.0; // Shadows are more red in The Nether
    
    return 1.0; // Shadows are slightly green in The End
}

// Gets the face lighting of a block. Credits to Venaxsys for the original function.

vec4 get_block_face_lighting(vec3 normal, float dimension) { 
    
    vec4 faceLighting = vec4(1.0, 1.0, 1.0, 1.0);
    vec3 absNormal = abs(normal);
    float top = 229.0 / 255.0;
    float bottom = 127.0 / 255.0;
    float east = 153.0 / 255.0;
    float north = 204.0 / 255.0;
    
    // Top (only required in the Nether)
    if (normal.y > normal.z && normal.y > normal.x && compare_floats(dimension, -1.0)) faceLighting = vec4(top, top, top, 1.0); // It's not really checking the alpha but I'm too stubborn to change the function name
    
    // Bottom
    if (normal.y < normal.z && normal.y < normal.x && !compare_floats(dimension, -1.0)) faceLighting = vec4(bottom, bottom, bottom, 1.0);
    else if (normal.y < normal.z && normal.y < normal.x && compare_floats(dimension, -1.0)) faceLighting = vec4(top, top, top, 1.0);

    // East-West
    if (absNormal.x > absNormal.z && absNormal.x > absNormal.y) faceLighting = vec4(east, east, east, 1.0);

    // North-South
    if (absNormal.z > absNormal.x && absNormal.z > absNormal.y) faceLighting = vec4(north, north, north, 1.0);

    return faceLighting;
}


// Checks if the face should have lighting.

bool face_lighting_check(int inputAlpha) {

    if (inputAlpha == 252) return false; // Checks for alpha 252, and returns that this face should not be lit. Used in the example pack for redstone ore and the zombie's eyes.
    if (inputAlpha == 250) return false; // Used in the example pack for lime concrete.

    return true; // A face should be lit by default
}


// Makes sure transparent things don't become solid and vice versa.

float remap_alpha(int inputAlpha) {
    
    if (inputAlpha == 252) return 255.0; // Checks for alpha 252 and converts all pixels of that to alpha 255. Used in the example pack for redstone ore and the zombie's eyes.
    if (inputAlpha == 251) return 190.0; // You can copy & paste this line and change the values to make any transparent block work with this pack. Used in the example pack for ice.
    if (inputAlpha == 250) return 255.0; // Used in the example pack for lime concrete.
    
    return inputAlpha; // If a pixel doesn't need to have its alpha changed then it simply does not change.
}


// The meat and bones of the pack, does all the work for making things emissive.

vec4 make_emissive(vec4 inputColor, vec4 lightColor, vec4 faceLightColor, int inputAlpha) {

    if(face_lighting_check(inputAlpha)) inputColor *= faceLightColor; // Applies the face lighting if the face should be lit
    inputColor.a = remap_alpha(inputAlpha) / 255.0; // Remap the alpha value

    if (inputAlpha == 252) return inputColor; // Checks for alpha 252 and just returns the input color if it is. Used in the example pack for redstone ore and the zombie's eyes.
    if (inputAlpha == 251) return apply_partial_emissivity(inputColor, lightColor, vec3(0.411, 0.345, 0.388)); // Used in the example pack for ice.
    
    return inputColor * lightColor; // If none of the pixels are supposed to be emissive, then it adds the light.
}