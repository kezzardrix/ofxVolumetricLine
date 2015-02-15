
varying vec3 p1;
varying vec3 p2;
varying vec3 fragViewPos;

uniform float radius;
uniform sampler2D gradientTexture;

void main()
{	
	vec3 tmp;
	const vec3 _Y_ = vec3(0.0,1.0,0.0);
	const vec3 _X_ = vec3(1.0,0.0,0.0);
	
	//read line vertices
	vec3 v1 = gl_PositionIn[0].xyz;
	vec3 v2 = gl_PositionIn[1].xyz;

	//
	p1=v1;						//view space line point1 to FP
	p2=v2;						//view space line point2 to FP
	vec3 lineDir = v2-v1;
	float lineLength=length(v1-v2);	//line length to FP
	vec3 normLineDir = lineDir/lineLength;

	//construction of the hortonormal basis of the line
	vec3 d2=cross(normLineDir,_Y_);
	if(abs(normLineDir.y)>0.999)
		d2=cross(normLineDir,_X_);
	d2=normalize(d2);
	vec3 d3=cross(normLineDir,d2);//don't need to normalize here
	vec3 d2norm=d2;
	vec3 d3norm=d3;
	d2*=radius;
	d3*=radius;

	vec3 lineDirOffsetM = radius*normLineDir;
	vec3 lineDirOffsetP = lineDir + lineDirOffsetM;

	//precompute all vertices position
	vec4 viewPos000 = vec4( v1 -d2-d3 -lineDirOffsetM, 1.0);
	vec4 viewPos001 = vec4( v1 -d2+d3 -lineDirOffsetM, 1.0);
	vec4 viewPos010 = vec4( v1 +d2-d3 -lineDirOffsetM, 1.0);
	vec4 viewPos011 = vec4( v1 +d2+d3 -lineDirOffsetM, 1.0);
	vec4 viewPos110 = vec4( v1 +d2-d3 +lineDirOffsetP, 1.0);
	vec4 viewPos111 = vec4( v1 +d2+d3 +lineDirOffsetP, 1.0);
	vec4 viewPos100 = vec4( v1 -d2-d3 +lineDirOffsetP, 1.0);
	vec4 viewPos101 = vec4( v1 -d2+d3 +lineDirOffsetP, 1.0);
	//... and their projection
	vec4 viewPos000proj = gl_ProjectionMatrix * viewPos000;
	vec4 viewPos001proj = gl_ProjectionMatrix * viewPos001;
	vec4 viewPos011proj = gl_ProjectionMatrix * viewPos011;
	vec4 viewPos010proj = gl_ProjectionMatrix * viewPos010;
	vec4 viewPos100proj = gl_ProjectionMatrix * viewPos100;
	vec4 viewPos101proj = gl_ProjectionMatrix * viewPos101;
	vec4 viewPos111proj = gl_ProjectionMatrix * viewPos111;
	vec4 viewPos110proj = gl_ProjectionMatrix * viewPos110;

    gl_FrontColor = gl_FrontColorIn[0];
    
	fragViewPos = viewPos001.xyz;
	gl_Position = viewPos001proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos000.xyz;
	gl_Position = viewPos000proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos101.xyz;
	gl_Position = viewPos101proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos100.xyz;
	gl_Position = viewPos100proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos111.xyz;
	gl_Position = viewPos111proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos110.xyz;
	gl_Position = viewPos110proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos011.xyz;
	gl_Position = viewPos011proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos010.xyz;
	gl_Position = viewPos010proj;
	EmitVertex();/////////////////////////////////////
    EndPrimitive();//////////////////////////////////////////////////////////////////////////
	
	fragViewPos = viewPos101.xyz;
	gl_Position = viewPos101proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos111.xyz;
	gl_Position = viewPos111proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos001.xyz;
	gl_Position = viewPos001proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos011.xyz;
	gl_Position = viewPos011proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos000.xyz;
	gl_Position = viewPos000proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos010.xyz;
	gl_Position = viewPos010proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos100.xyz;
	gl_Position = viewPos100proj;
	EmitVertex();/////////////////////////////////////
	fragViewPos = viewPos110.xyz;
	gl_Position = viewPos110proj;
	EmitVertex();/////////////////////////////////////
    EndPrimitive();//////////////////////////////////////////////////////////////////////////

}

