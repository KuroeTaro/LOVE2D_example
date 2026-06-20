extern vec2 center;      // 模糊中心（通常为精灵中心）
extern float strength;   // 模糊强度
extern float samples;    // 采样次数（精度）

vec4 effect(vec4 color, Image texture, vec2 texCoords, vec2 screenCoords) {
    vec4 finalColor = vec4(0.0);
    vec2 dir = texCoords - center;

    for (float i = 0.0; i < samples; i++) {
        float t = i / samples;
        vec2 offset = center + dir * t * strength;
        finalColor += Texel(texture, offset);
    }

    finalColor /= samples;
    finalColor.a *= color.a; // 保持透明度混合
    return finalColor * color;
}
