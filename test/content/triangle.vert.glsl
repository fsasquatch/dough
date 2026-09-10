#version 450

layout(location=0) in vec3 position;
layout(location=1) in vec4 inColor;
layout(location=2) in vec2 uv;

layout(location=0) out vec4 outColor;
layout(location=1) out vec2 outUV;

void main() {
    gl_Position = vec4(position, 1);
    outColor = inColor;
    outUV = uv;
}
