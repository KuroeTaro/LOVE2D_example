extern float scaleY;
extern float alpha;

vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 screenCoord) {
    // 将Y坐标压缩：产生投影效果
    vec2 uv = texCoord;
    uv.y *= scaleY;

    vec4 texColor = Texel(tex, uv);

    // 设置为黑色阴影，保留透明度
    texColor.rgb = vec3(0.0);
    texColor.a *= alpha;

    return texColor;
}
