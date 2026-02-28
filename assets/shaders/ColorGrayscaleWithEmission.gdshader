shader_type canvas_item;
uniform sampler2D pilzkopf;
uniform sampler2D piltstiel;


uniform vec4 color_1: source_color = vec4(1.0,0.0,0.0,1.0);
uniform float base_color_emission_strenght: hint_range(0.0, 10.0, 0.001) = 1.0;
uniform vec4 color_2: source_color = vec4(0.0,1.0,0.0,1.0);
uniform float mix_step_color_2: hint_range(0.0, 1.0, 0.001) = 0.5;
uniform float tolerance: hint_range(0.0, 1.0, 0.001) = 0.09;


uniform vec2 light_dir = vec2(-0.5,-0.5);
uniform float normal_map_scale: hint_range(0.0, 3.0, 0.001) = 0.5;

void fragment() {
	ivec2 size = textureSize(pilzkopf, 0);
    ivec2 coord = ivec2(UV * vec2(size));
    vec4 base_col_kopf = texelFetch(pilzkopf, coord, 0);
	ivec2 size_2 = textureSize(piltstiel, 0);
    ivec2 coord_2 = ivec2(UV * vec2(size));

    vec4 base_col_stiel = texelFetch(piltstiel, coord, 0);
	vec4 final_col;
	if(base_col_kopf.a == 0.0){
		final_col = base_col_stiel * color_2 * base_color_emission_strenght;
	}
	else{
		final_col = base_col_kopf * color_1 * base_color_emission_strenght;
	}

	COLOR = final_col;
	//vec4 base_col = texture(TEXTURE, UV);
	//ivec2 size = textureSize(TEXTURE, 0);
    //ivec2 coord = ivec2(UV * vec2(size));
//
    //vec4 color_map = texelFetch(TEXTURE, coord, 0);
	//if(distance(color_map.rgb, vec3(0.0,0.0,0.0)) <tolerance){
		//color_map.rgb = color_1;
	//}
	//if(distance(color_map.rgb, vec3(1.0,1.0,1.0)) < tolerance){
		//color_map.rgb = color_2;
	//}
	//vec4 emission_map = texture(emission, UV);
	////&color_map.rgb *= emission_map.r * emission_strenght;
	//vec3 normal_sample = texture(normal_map, UV).rgb;
    //vec3 normal = normalize(normal_sample.rgb * 2.0 - 1.0);
	//float light = clamp(dot(normal.xy, normalize(light_dir)), 0.0, 1.0);
	//vec3 lit_color = color_map.rgb + color_map.rgb  * light;
	//vec4 final_color = vec4(lit_color * normal_map_scale, base_col.a);
	//COLOR = final_color;


}
