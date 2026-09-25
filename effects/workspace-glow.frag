#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

void main() {
  vec2 p = qt_TexCoord0;
  vec2 center = vec2(0.5, 0.5);
  float distanceFromCenter= distance(p, center);
  float glow = 1.0 - smoothstep(
      0.05,
      0.25, 
      distanceFromCenter
      );

  vec3 glowColor= vec3(1.0,0.45,0.1);
  fragColor = vec4(glowColor, glow);
}
