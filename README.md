# VanillaDynamicEmissives
Allows for dynamic emissive textures in vanilla Minecraft.

### How to Use
If you want to make a solid texture emissive, just set the translucency value to 252 in your favorite image editor. 
You can see an example of this with diamond ore. Translucent textures are a bit more tricky, but it's still fairly simple. Go to the `emissive_utils.glsl` file
and open it up. You'll see a commented line of code saying to copy/paste it. The left value is the value you're checking for to make emissive, the right is
the value that you want it to look like. You can see it in action on the ice texture, it retains the vanilla translucency but is still emissive.
