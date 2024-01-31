#pragma header

uniform float Directions;
uniform float Quality; 
uniform float Size;
uniform float dim;

#define uv openfl_TextureCoordv.xy
#define Pi 6.28318530718

void main(void) {
	vec4 Color = flixel_texture2D(bitmap, uv);
		
	for (float d=0.0; d<Pi; d+=Pi/Directions) {
		for (float i=1.0/Quality; i<=1.0; i+=1.0/Quality) {
			float ex = (cos(d)*Size*i)/openfl_TextureSize.x;
			float why = (sin(d)*Size*i)/openfl_TextureSize.y;
			Color += flixel_texture2D(bitmap, uv+vec2(ex,why));	
		}
	}
		
	Color /= (dim * Quality) * Directions - 15.0;
	gl_FragColor = (flixel_texture2D(bitmap, uv) / dim) + Color;
}