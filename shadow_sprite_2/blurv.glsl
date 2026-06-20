extern number radius;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
    vec4 sum = vec4(0.0);
    number blurSize = radius / love_ScreenSize.y;

    for (int i = -4; i <= 4; i++) {
        sum += Texel(tex, tc + vec2(0, i) * blurSize) * 0.111;
    }
    return sum * color;
}
