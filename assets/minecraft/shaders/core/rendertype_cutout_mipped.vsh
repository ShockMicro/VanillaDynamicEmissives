#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <emissive_utils.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform vec3 ChunkOffset;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightColor;
out vec4 faceLightColor;
out vec2 texCoord0;

void main() {
    vec3 pos = Position + ChunkOffset;
    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);

    vertexDistance = fog_distance(pos, FogShape);
    lightColor = minecraft_sample_lightmap(Sampler2, UV2);
    faceLightColor = get_block_face_lighting(Normal, get_dimension(minecraft_sample_lightmap(Sampler2, ivec2(0.0, 0.0))));
    vertexColor = Color / faceLightColor;
    texCoord0 = UV0;
}
