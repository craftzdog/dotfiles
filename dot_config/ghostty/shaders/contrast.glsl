// Boosts the contrast of text against whatever is behind it, so it stays
// readable under the glitch and CRT effects.
//
// Each pixel is pushed away from the average of its neighbourhood, so flat
// areas (the background, highlighted lines) are left untouched and only
// glyph edges change.

// Contrast multiplier
//  1.0 = unchanged
//  1.5 = recommended default
//  2.5 = harsh
#define CONTRAST 1.5

// Neighbourhood radius in screen pixels. Should be wider than a glyph
// stroke so the average is dominated by the background behind the text.
#define RADIUS 4.0

vec4 SampleOffset(vec2 fragCoord, vec2 offset) {
  return texture(iChannel0, (fragCoord + offset * RADIUS) / iResolution.xy);
}

vec3 NeighbourhoodMean(vec2 fragCoord) {
  vec3 sum = vec3(0.0);
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      sum += SampleOffset(fragCoord, vec2(x, y)).rgb;
    }
  }
  return sum / 9.0;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec4 source = texture(iChannel0, fragCoord / iResolution.xy);
  vec3 surroundings = NeighbourhoodMean(fragCoord);
  vec3 contrasted = surroundings + (source.rgb - surroundings) * CONTRAST;
  fragColor = vec4(clamp(contrasted, 0.0, 1.0), source.a);
}
