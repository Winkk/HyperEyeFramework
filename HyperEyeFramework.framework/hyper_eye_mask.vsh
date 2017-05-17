attribute vec4 position;
attribute vec4 inputTextureCoordinate;

uniform float texelWidth;
uniform float texelHeight;

varying vec2 textureCoordinates[9];



void main()
{
    gl_Position = position;
   
    int i = 0;
    for (int x=-1;x<=1;x++) {
        for (int y=-1;y<=1;y++) {
            textureCoordinates[i] = inputTextureCoordinate.xy + vec2(texelWidth*float(x), texelHeight*float(y));
            i++;
        }
    }

}
