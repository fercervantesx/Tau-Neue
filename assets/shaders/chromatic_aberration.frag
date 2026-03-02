#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uIntensity;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / uSize;
  float offset = uIntensity * 0.01;

  // Sample RGB channels with offset
  // Red channel shifted left, Blue channel shifted right
  float r = texture(uTexture, vec2(uv.x - offset, uv.y)).r;
  float g = texture(uTexture, uv).g;
  float b = texture(uTexture, vec2(uv.x + offset, uv.y)).b;

  fragColor = vec4(r, g, b, 1.0);
}
