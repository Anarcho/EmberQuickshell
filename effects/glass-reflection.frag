#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
  mat4 qt_Matrix;
  float qt_Opacity;
  vec2 surfaceSize;
  float cornerRadius;
  float rimWidth;
  vec4 coolReflection;
  vec4 warmReflection;
  vec4 accent;
  vec2 reflectionPoint;
  float activeAmount;
  float elevation;
  float ambientAmount;
  float beveledAmount;
  float arcAmount;
  float emblemHighlightAmount;
};

float boundary(vec2 p, float radius) {
  vec2 q = abs(p - surfaceSize * 0.5) - (surfaceSize * 0.5 - radius);
  return length(max(q, vec2(0.0))) + min(max(q.x, q.y), 0.0) - radius;
}

float softLight(vec2 p, vec2 center, vec2 spread) {
  vec2 v = (p - center) / max(spread, vec2(1.0));
  return exp(-dot(v, v) * 2.0);
}

void main() {
  vec2 p = qt_TexCoord0 * surfaceSize;
  float h = surfaceSize.y;
  float w = surfaceSize.x;
  float r = clamp(cornerRadius, 0.0, min(w, h) * 0.5);
  // Match the body's half-pixel inset, antialiased at the output resolution.
  float d = boundary(p, r) + 0.5;
  float aa = max(fwidth(d), 0.5);
  float coverage = 1.0 - smoothstep(-aa * 0.5, aa * 0.5, d);
  float inward = max(-d, 0.0);

  // Unequal, softly lit patches; the upper and lower edges do not mirror
  // each other and there is no continuous bright contour around the pill.
  float left = softLight(p, vec2(r * 0.40, h * 0.84), vec2(h * 0.90, h * 0.62));
  float right = softLight(p, vec2(w - r * 0.25, h * 0.62), vec2(h * 0.78, h * 0.72));
  float upper = softLight(p, vec2(w * 0.27, -h * 0.20), vec2(w * 0.25, h * 0.62));
  float lower = softLight(p, vec2(w * 0.68, h * 1.12), vec2(w * 0.20, h * 0.65));
  float ends = max(left, right);

  // A single smooth profile carries the same reflection from the edge into
  // the body. No stacked rings, fixed-width bevel or separate inner line.
  float depth = max(rimWidth, 1.0) * mix(0.8, 2.8, ends);
  float diffuse = exp(-inward / depth);
  float edge = exp(-pow(inward / 0.85, 2.0));
  float strength = 0.012 + left * 0.17 + right * 0.14 + upper * 0.055 + lower * 0.045;
  float alpha = strength * diffuse + (0.025 + left * 0.10 + right * 0.085 + upper * 0.045) * edge;
  alpha *= (1.0 + elevation * 0.12) * (1.0 - beveledAmount);
  vec3 colour = mix(coolReflection.rgb, warmReflection.rgb,
      clamp(0.20 + upper * 0.35 + lower * 0.45, 0.0, 1.0));

  float activeLight = softLight(p, clamp(reflectionPoint, vec2(0.0), surfaceSize), vec2(h * 0.45));
  float activeAlpha = activeAmount * activeLight * 0.09 * diffuse;
  vec3 premultiplied = colour * alpha * (1.0 - activeAlpha) + accent.rgb * activeAlpha;
  alpha = alpha + activeAlpha * (1.0 - alpha);

  // Low, broad reflected warmth belongs to the glass, behind the content.
  float emblem = softLight(p, vec2(w * 0.08, h * 0.40), vec2(h * 1.05, h * 0.75));
  float meters = softLight(p, vec2(w * 0.65, h * 0.64), vec2(w * 0.13, h * 0.85));
  float apps = softLight(p, vec2(w * 0.95, h * 0.52), vec2(h * 0.90, h * 0.80));
  float ambientAlpha = ambientAmount * (emblem * 0.030 + meters * 0.020 + apps * 0.028);
  vec3 ambientColour = mix(accent.rgb, warmReflection.rgb, 0.30);
  premultiplied += ambientColour * ambientAlpha * (1.0 - alpha);
  alpha += ambientAlpha * (1.0 - alpha);

  // Beveled reflections stay close to the machined edge.
  float warmPatch = softLight(p, vec2(w * 0.84, h * 0.98), vec2(w * 0.36, h * 0.70));
  float compactWarm = beveledAmount * warmPatch * (0.004 + exp(-inward / 1.8) * 0.040);
  vec3 reddish = mix(accent.rgb, vec3(0.48, 0.22, 0.25), 0.65);
  premultiplied += reddish * compactWarm * (1.0 - alpha);
  alpha += compactWarm * (1.0 - alpha);

  // Arc light reaches the shell: a small ivory reflection at the hot crown,
  // surrounded by amber. Keep this local so the graphite face stays dark.
  float expanded = step(0.01, ambientAmount);
  vec2 logoHotspot = vec2(h * 0.60, h * 0.15);
  vec2 appsHotspot = vec2(w - h * 0.27, h * 0.70);
  float logoLight = emblemHighlightAmount * softLight(p, logoHotspot, vec2(h * 0.32, h * 0.24));
  float appsLight = expanded * 0.55 * softLight(p, appsHotspot, vec2(h * 0.23, h * 0.25));
  float hotLight = max(logoLight, appsLight);
  float shellLight = exp(-inward / 3.0);
  float ivoryAlpha = arcAmount * beveledAmount * hotLight * (0.16 + shellLight * 0.24);
  vec3 ivory = mix(vec3(1.0, 0.94, 0.84), warmReflection.rgb, 0.15);
  premultiplied = premultiplied * (1.0 - ivoryAlpha) + ivory * ivoryAlpha;
  alpha += ivoryAlpha * (1.0 - alpha);

  float amberHalo = emblemHighlightAmount * softLight(p, logoHotspot, vec2(h * 0.49, h * 0.36));
  amberHalo = max(amberHalo, expanded * 0.60 * softLight(p, appsHotspot, vec2(h * 0.32, h * 0.33)));
  float amberAlpha = arcAmount * beveledAmount * amberHalo * 0.045;
  premultiplied += accent.rgb * amberAlpha * (1.0 - alpha);
  alpha += amberAlpha * (1.0 - alpha);

  // A quiet inner shadow beneath the upper lip gives depth without a trench.
  float innerShadow = ambientAmount * 0.065 * exp(-pow((inward - 3.5) / 2.5, 2.0));
  innerShadow *= 1.0 - smoothstep(0.20, 0.65, qt_TexCoord0.y);
  alpha += innerShadow * (1.0 - alpha);
  fragColor = vec4(premultiplied, alpha) * coverage * qt_Opacity;
}
