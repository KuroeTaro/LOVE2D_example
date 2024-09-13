extern Image mask;
extern float brightness;  // 新增亮度参数

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // 取出原图的颜色
    vec4 texColor = Texel(texture, texture_coords);

    // 取出alpha图层的颜色
    vec4 maskColor = Texel(mask, texture_coords);

    // 计算特效颜色
    vec4 effectColor = texColor;
    effectColor.rgb *= brightness;

    // 通过alpha值混合原图颜色和特效颜色
    texColor = mix(texColor, effectColor, maskColor.a);

    return texColor;
}
