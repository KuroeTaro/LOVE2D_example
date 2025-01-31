extern vec2 light; // 光源位置
extern vec2 vertices[8]; // 顶点数组（最多支持 4 个顶点的多边形，调整顶点数以适应多边形数量）
extern int numVertices; // 顶点数量

vec4 effect(vec4 color, Image texture, vec2 texCoords, vec2 screenCoords) {
    vec2 shadowVertices[16]; // 用于存储阴影点
    int shadowIndex = 0;

    // 计算每条边的阴影
    for (int i = 0; i < numVertices; i++) {
        vec2 current = vertices[i];
        vec2 next = vertices[(i + 1) < numVertices ? (i + 1) : 0]; // 下一顶点，形成边（不使用 %）

        // 计算延长线上的点
        vec2 direction = normalize(current - light);
        vec2 extended = current + direction * 1000.0; // 延长线

        shadowVertices[shadowIndex++] = current;
        shadowVertices[shadowIndex++] = extended;

        direction = normalize(next - light);
        extended = next + direction * 1000.0;
        
        shadowVertices[shadowIndex++] = next;
        shadowVertices[shadowIndex++] = extended;
    }

    // 遍历阴影边界判断像素是否在阴影范围内
    bool isInShadow = false;
    for (int i = 0; i < shadowIndex; i += 2) {
        vec2 v1 = shadowVertices[i];
        vec2 v2 = shadowVertices[(i + 1) < shadowIndex ? (i + 1) : 0]; // 同样避免使用 %

        // 判断当前像素是否在边界内
        if (screenCoords.x > min(v1.x, v2.x) && screenCoords.x < max(v1.x, v2.x) &&
            screenCoords.y > min(v1.y, v2.y) && screenCoords.y < max(v1.y, v2.y)) {
            isInShadow = true;
            break;
        }
    }

    return isInShadow ? vec4(0.0, 0.0, 0.0, 0.5) : vec4(color.rgb, 1.0);
}
