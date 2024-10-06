shader_type canvas_item;

uniform sampler2D splatsource : filter_linear;
uniform vec2 uv;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = vec4(texture(splatsource, uv).rgb, texture_color.a/2.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
