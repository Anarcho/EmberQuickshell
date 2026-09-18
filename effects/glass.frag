#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
  mat4 qt_Matrix;
  float qt_Opacity;
  vec2 surfaceSize;
  float cornerRadius;
  float edgeDepth;
  float refractionStrength;
};

layout(binding = 1) uniform sampler2D source;

float boundary(vec2 p) {
  float r = min(cornerRadius, min(surfaceSize.x, surfaceSize.y) * 0.5);
  vec2 q = abs(p) - (surfaceSize * 0.5 - vec2(r));
  return length(max(q, vec2(0))) + min(max(q.x, q.y), 0.0) - r;
}

void main() {
  vec2 p = (qt_TexCoord0 - 0.5) * surfaceSize;
  float d = boundary(p);
  float coverage = 1.0 - smoothstep(-0.8, 0.4, d);
  vec2 grad = vec2(boundary(p + vec2(0.5, 0)) - boundary(p - vec2(0.5, 0)),
      boundary(p + vec2(0, 0.5)) - boundary(p - vec2(0, 0.5)));
  vec2 normal = grad / max(length(grad), 0.0001);
  float t = clamp(-d / max(edgeDepth, 1.0), 0.0, 1.0);
  float lens = 12.20703125 * t * pow(1.0 - t, 4.0);
  vec2 uv = qt_TexCoord0 - normal * lens * refractionStrength / max(surfaceSize, vec2(1));
  vec4 transmitted = texture(source, clamp(uv, vec2(0.001), vec2(0.999)));
  fragColor = transmitted * coverage * qt_Opacity;
}
