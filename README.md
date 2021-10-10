# VanillaDynamicEmissives
Allows for dynamic emissive textures in vanilla Minecraft.

### How to Use
If you want to make a solid texture emissive, just set the alpha value to 252 in your favorite image editor. You can see an example of this in the redstone ore texture. 

Translucent textures are a bit more tricky, but it's still fairly simple. Go to the `light.glsl` file and open it up. There are two functions you want 
to look at there, the ones that tell you to copy/paste. If it's inside a `check_alpha()` function, that's the alpha value you're checking for. If it's right 
after `return`, that's the one that it will actually be ingame. See the ice, it checks for 251 and makes it look like 190.

### NOTICE
This pack probably won't work with Optifine! If it does, good for you! This pack is supposed to be installed in the __resource packs__ folder, using vanilla Minecraft, because it is a __resource pack__. If there's still a bug after doing everything correctly, report it in the [issues tab](https://github.com/ShockMicro/VanillaDynamicEmissives/issues).
