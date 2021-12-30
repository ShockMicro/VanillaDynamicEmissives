# VanillaDynamicEmissives
Allows for dynamic emissive textures in vanilla Minecraft.

### How to Use
If you want to make a solid texture emissive, just set the alpha value to 252 in your favorite image editor. You can see an example of this with redstone ore. 
Translucent textures require a bit more work. Check the example for ice to get a general idea of how this works.

### Functions
`return inputColor;` means you're returning the color of the texture without any lighting applied. This is used for making something fully emissive.
`return apply_partial_emissivity();` means the blocks with that alpha are only partially emissive, tinting it with a specific color of light. You can find a handy link to a table of light colors [here](https://minecraft.fandom.com/wiki/Light?file=1.9_lighting_curves_%2528gamma%253D0%2529.png). Remember, colors in OpenGL are formatted as RGB values from 0 to 1!
`return inputColor * lightColor;` means you're simply returning the texture with its proper lighting. This is the default case.
You can do `return inputColor * maxLightColor;` if you change the lightmap in any way in order to make emissives emit the max light color instead of just not having lighting.

### NOTICE
This pack probably won't work with Optifine! If it does, good for you! This pack is supposed to be installed in the __resource packs__ folder, using vanilla Minecraft on 1.18.1, because it is a __resource pack__. If there's still a bug after doing everything correctly, report it in the [issues tab](https://github.com/ShockMicro/VanillaDynamicEmissives/issues).