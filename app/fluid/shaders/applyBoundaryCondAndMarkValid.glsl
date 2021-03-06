//***     Globals     ***
attribute vec2 position;
uniform vec2 bufSize;
uniform int column;
uniform highp sampler2D vTexture;
uniform highp sampler2D cellTexture;

//***  Vertex Shader  ***
void main(void)
{
    gl_Position = vec4(position, 0.0, 1.0);
}

//*** Fragment Shader ***
void main(void)
{
    vec2 pos = gl_FragCoord.xy / bufSize;
    ivec2 ipos = ivec2(int(gl_FragCoord.x), int(gl_FragCoord.y));
    vec4 color = texture2D(vTexture, pos);
    if (column == 1) { // u
        if (ipos.x == 0 || ipos.x == int(bufSize.x) - 1) {
            color.x = 0.0;
            color.y = 1.0;
        } else {
            color.y = texture2D(cellTexture, vec2((gl_FragCoord.x - 0.5) / (bufSize.x - 1.0), pos.y)).x > 0.0 ? 1. : 0.;
        }
    } else { // v
        if (ipos.y == 0 || ipos.y == int(bufSize.y) - 1) {
            color.x = 0.0;
            color.y = 1.0;
        } else {
            color.y = texture2D(cellTexture, vec2(pos.x, (gl_FragCoord.y - 0.5) / (bufSize.y - 1.0))).x > 0.0 ? 1. : 0.;
        }
    }
    if (color.y == 0.0) {
        color.x = 0.0;
    }
    gl_FragColor = vec4(color);
}
