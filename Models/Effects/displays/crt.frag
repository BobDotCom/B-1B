#version 120
// Original shader author - xcvb85
// Based heavily on CRT from Dornier 328, with parts of Tornado CRT shader

uniform float osg_SimulationTime;

uniform sampler2D BaseTex;
uniform sampler2D DirtTex;
uniform sampler2D Scanlines;
uniform samplerCube Environment;

uniform int display_enabled;
uniform float display_brt;
uniform float contrast;

float INTENSITY = 0.15;
float BRIGHTBOOST = 1;
float DISTORTION = -0;
float THRESHOLD = 0.2;

vec2 TextureSize = vec2(800, 950);

vec4 bloomTexture2D(sampler2D texture, vec2 texCoords)
{
	vec4 texel = vec4(0, 0, 0, 0);
	float blur = 0.3;
	int size = 3;

	for(int x = -size; x <= size; x++)
	{
		for(int y = -size; y <= size; y++)
		{
			texel += texture2D(texture, texCoords + vec2(x/TextureSize.x, y/TextureSize.y));
		}
	}
	return (blur*texel/pow((2*size)+1, 2) + (1.0-blur)*texture2D(texture, texCoords));
}

vec2 distort(vec2 position)
{
	position = vec2(2.0 * position - 1.0);
	position = position /(1.0 - DISTORTION * length(position));
	position =(position + 1.0) * 0.5;
	return position;
}

vec3 frame(vec2 position, vec3 color)
{
	// intersection between two ellipses and four circles
	position -= vec2(0.5);
	position *= vec2(2.0);

	float x2 = position.x * position.x;
	float y2 = position.y * position.y;

	if((x2/0.87) +(y2/20) > 1 ||
		(x2/40) +(y2/0.9) > 1) {
		color = vec3(0.0, 0.0, 0.0);
	}

	if( length(position) > 1.24 &&
		length(abs(position)-vec2(0.82, 0.84)) > 0.1) {
		color = vec3(0.0, 0.0, 0.0);
	}
	return color;
}

vec3 scanline(vec3 texel)
{
	vec3 scanlines = texture2D(Scanlines, vec2(300, 500)*gl_TexCoord[0].xy).rgb;
	texel *= 1.5*scanlines;
	return texel;
}

vec3 rdrNoise(vec2 position, vec3 texel)
{
	float offset = 0.0003*sin(10*position.y+100.0*osg_SimulationTime)*cos(100*position.y-100.0*osg_SimulationTime);
	texel.g += texture2D(BaseTex, vec2(position.x+offset, position.y)).b;
	texel.g = clamp(texel.g, 0.0, 1.0);
	return texel;
}

vec3 backlight(vec3 color)
{
	if(color.r < THRESHOLD && color.g < THRESHOLD && color.b < THRESHOLD) {
		color = vec3(THRESHOLD, THRESHOLD, THRESHOLD);
	}
	return color;
}

vec3 dispContrast(vec3 color, float contrast) {
    return ((color - 0.5) * contrast) + 0.5;
}

vec3 flickering(vec2 position, vec3 texel)
{
	texel *= 0.95+0.05*(1-mod(5*osg_SimulationTime+position.y, 1.0));
	return texel;
}

void main()
{
    vec3 texel = vec3(0.0, 0.0, 0.0);
    vec3 dirt = 0.1*texture2D(DirtTex, gl_TexCoord[0].xy).rgb;

    // crt-effect
    if(display_enabled > 0) {
        vec2 position = distort(gl_TexCoord[0].xy);

        if(position.x > 0.0 && position.y > 0.0 && position.x < 1.0 && position.y < 1.0) {
            texel = texture2D(BaseTex, position).rgb;
            texel = bloomTexture2D(BaseTex, position).rgb;
            texel = rdrNoise(position, texel);
            texel = backlight(texel);
            texel = scanline(texel);
            texel *= display_brt;
            texel = dispContrast(texel, contrast);
        }
        // texel = frame(position, texel);
    }

    texel = max(texel, vec3(dirt));
    texel = clamp(texel, 0.0, 1.0);

    gl_FragColor = vec4(texel, 1.0);
}