
uniform float radius;
uniform sampler2D gradientTexture;

void main()
{
    gl_FrontColor = gl_Color;
	gl_Position = gl_ModelViewMatrix * vec4(gl_Vertex.xyz, 1.0);
}
