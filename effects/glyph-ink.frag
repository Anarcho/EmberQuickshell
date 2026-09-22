#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
  mat4 qt_Matrix;
  float qt_Opacity;
  vec4 highlight;
  vec4 warmth;
};
layout(binding = 1) uniform sampler2D source;

void main() {
  float coverage = texture(source, qt_TexCoord0).a;
  float blend = smoothstep(0.15, 0.85, qt_TexCoord0.y);
  vec4 ink = mix(highlight, warmth, blend);
  fragColor = ink * coverage * qt_Opacity;
}
