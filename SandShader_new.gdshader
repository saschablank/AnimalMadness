shader_type canvas_item;
uniform sampler2D noise: repeat_enable;
uniform vec3 sand_color_dark: source_color;
uniform vec3 sand_color_mid: source_color;
uniform vec3 sand_color_bright: source_color;
uniform float mix_threashold_dark: hint_range(0.0, 1.0, 0.0001) = 0.5;
uniform float mix_threashold_mid: hint_range(0.0, 1.0, 0.0001) = 0.5;
uniform float mix_threashold_bright: hint_range(0.0, 1.0, 0.0001) = 0.5;
uniform float final_mix: hint_range(0.1,1.0,0.0001) = 0.5;
void fragment() {
	
	vec4 noise_color = texture(noise, UV);
	float step_color_mix = smoothstep(0.0, mix_threashold_dark,final_mix);
	
	vec3 out_color = vec3(1.0);
	
	//out_color = mix(sand_color_bright*noise_color.r,sand_color_dark * noise_color.r,sand_color_mid * noise_color.r,step_color_mix);
	out_color = mix(sand_color_bright*noise_color.r,sand_color_mid * noise_color.r,step_color_mix); 
	COLOR = vec4(out_color,1.0);
}
