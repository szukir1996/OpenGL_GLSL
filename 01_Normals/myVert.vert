#version 140

// VBO-b�l �rkez� v�ltoz�k
in vec3 vs_in_pos;
in vec3 vs_in_norm;

// a pipeline-ban tov�bb adand� �rt�kek
out vec3 vs_out_pos;
out vec3 vs_out_norm;

// shader k�ls� param�terei - most a h�rom transzform�ci�s m�trixot egyben vessz�k �t
uniform mat4 MVP;

uniform mat4 world;
uniform mat4 WorldIT;

vec3 pos;
vec3 norm;

vec3 GetPos(float u, float v){
	u *= 2*3.1415;
	v *= 2*3.1415;
	float r = 2;
	float tanh = (exp(2*(u-3.1415))-1)/(exp(2*(u-3.1415))+1);

	return vec3(r*(1 + cos(v))*cos(u), -tanh*r*sin(v), r*(1 + cos(v))*sin(u));
}

vec3 GetNorm(float u, float v){
	vec3 uv = GetPos(u, v);
	vec3 du = GetPos(u+0.01, v)-GetPos(u-0.01, v);
	vec3 dv = GetPos(u, v+0.01)-GetPos(u, v-0.01);

	return cross(du, dv);
}

void main()
{
	float u = vs_in_pos.x;
	float v = vs_in_pos.y;
	float r = 2;

	gl_Position = MVP * vec4( GetPos(u,v), 1 );
	vs_out_pos  = (world * vec4( GetPos(u,v), 1 )).xyz;
	vs_out_norm = (WorldIT * vec4( GetNorm(u,v), 0 )).xyz;
}
