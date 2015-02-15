
varying vec3 p1;
varying vec3 p2;
varying vec3 fragViewPos;

uniform float radius;
uniform sampler2D gradientTexture;
uniform int isTexture;

/*
	http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline3d/
	Calculate the line segment PaPb that is the shortest route between
	two lines P1P2 and P3P4. Calculate also the values of mua and mub where
	  Pa = P1 + mua (P2 - P1)
	  Pb = P3 + mub (P4 - P3)
*/
vec2 LineLineIntersect(vec3 p1,vec3 p2,vec3 p3,vec3 p4)
{
	vec3 p13,p43,p21;
	float d1343,d4321,d1321,d4343,d2121;
	float numer,denom;
	float mua;

	p13 = p1-p3;
	p43 = p4-p3;
	p21 = p2-p1;

	d1343 = dot(p13,p43);
	d4321 = dot(p43,p21);
	d1321 = dot(p13,p21);
	d4343 = dot(p43,p43);
	d2121 = dot(p21,p21);

	denom = d2121 * d4343 - d4321 * d4321;
	//if (abs(denom) < 0.0000001)//almost impossible: view ray perfectly aligned with line direction (and it would only affect one pixel)
	//	return vec2(0.0,0.0);
	numer = d1343 * d4321 - d1321 * d4343;

	mua = numer/denom;
	mua = clamp(mua,0.0,1.0);
	return vec2(mua, (d1343 + d4321*mua)/d4343); //return (mua,mub)
}

void main()
{
	vec3 P1 = p1;
	vec3 P2 = p2;
	vec3 P3 = fragViewPos;
	vec3 P4 = fragViewPos+fragViewPos;

	//compute the two closest points on the volumetric line and current view ray
	vec2 muab = LineLineIntersect(P1,P2,P3,P4);

	//pa and pb, the two closest points
	vec3 pa = P1 + muab.x*(P2-P1);
	vec3 pb = P3 + muab.y*(P4-P3);

	//texture sample coordinate
	float sample = length(pa-pb)/radius;

	//final color
    if(isTexture == 0)gl_FragColor = gl_Color;
    else gl_FragColor = texture2D(gradientTexture,vec2(sample,0.5) + vec2(0.5,0.0))*step(sample,1.0) * gl_Color;		//step is only required if you use mipmap or gradient texture with rgb!=0 at texCoord.t=1.0
}

