shader_type canvas_item;

void fragment() {
	COLOR = vec4((vec3(1.0) - texture(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb), 
			abs((texture(TEXTURE, UV).a)));
}
