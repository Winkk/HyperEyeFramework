precision highp float;

varying vec2 textureCoordinates[9];



uniform sampler2D inputImageTexture;

#define RG 0.299
#define GG 0.587
#define BG 0.114

void main()
{
    highp vec3 img3x3[9];
    
    img3x3[0] = texture2D(inputImageTexture, textureCoordinates[0]).rgb;
    img3x3[1] = texture2D(inputImageTexture, textureCoordinates[1]).rgb;
    img3x3[2] = texture2D(inputImageTexture, textureCoordinates[2]).rgb;
    img3x3[3] = texture2D(inputImageTexture, textureCoordinates[3]).rgb;
    img3x3[4] = texture2D(inputImageTexture, textureCoordinates[4]).rgb;
    img3x3[5] = texture2D(inputImageTexture, textureCoordinates[5]).rgb;
    img3x3[6] = texture2D(inputImageTexture, textureCoordinates[6]).rgb;
    img3x3[7] = texture2D(inputImageTexture, textureCoordinates[7]).rgb;
    img3x3[8] = texture2D(inputImageTexture, textureCoordinates[8]).rgb;
    
    /*
    highp float img3x3gray2[9];
    
    img3x3gray2[0] = (img3x3[0].r*img3x3[0].r+img3x3[0].g*img3x3[0].g+img3x3[0].b*img3x3[0].b);
    img3x3gray2[1] = (img3x3[1].r*img3x3[1].r+img3x3[1].g*img3x3[1].g+img3x3[1].b*img3x3[1].b);
    img3x3gray2[2] = (img3x3[2].r*img3x3[2].r+img3x3[2].g*img3x3[2].g+img3x3[2].b*img3x3[2].b);
    img3x3gray2[3] = (img3x3[3].r*img3x3[3].r+img3x3[3].g*img3x3[3].g+img3x3[3].b*img3x3[3].b);
    img3x3gray2[4] = (img3x3[4].r*img3x3[4].r+img3x3[4].g*img3x3[4].g+img3x3[4].b*img3x3[4].b);
    img3x3gray2[5] = (img3x3[5].r*img3x3[5].r+img3x3[5].g*img3x3[5].g+img3x3[5].b*img3x3[5].b);
    img3x3gray2[6] = (img3x3[6].r*img3x3[6].r+img3x3[6].g*img3x3[6].g+img3x3[6].b*img3x3[6].b);
    img3x3gray2[7] = (img3x3[7].r*img3x3[7].r+img3x3[7].g*img3x3[7].g+img3x3[7].b*img3x3[7].b);
    img3x3gray2[8] = (img3x3[8].r*img3x3[8].r+img3x3[8].g*img3x3[8].g+img3x3[8].b*img3x3[8].b);
    
    highp float img3x3gray[9];
    
    img3x3gray[0] = sqrt(img3x3gray2[0]);
    img3x3gray[1] = sqrt(img3x3gray2[1]);
    img3x3gray[2] = sqrt(img3x3gray2[2]);
    img3x3gray[3] = sqrt(img3x3gray2[3]);
    img3x3gray[4] = sqrt(img3x3gray2[4]);
    img3x3gray[5] = sqrt(img3x3gray2[5]);
    img3x3gray[6] = sqrt(img3x3gray2[6]);
    img3x3gray[7] = sqrt(img3x3gray2[7]);
    img3x3gray[8] = sqrt(img3x3gray2[8]);
    */
    
    highp float img3x3gray[9];

    img3x3gray[0] = (img3x3[0].b*BG + img3x3[0].g*GG + img3x3[0].r*RG);
    img3x3gray[1] = (img3x3[1].b*BG + img3x3[1].g*GG + img3x3[1].r*RG);
    img3x3gray[2] = (img3x3[2].b*BG + img3x3[2].g*GG + img3x3[2].r*RG);
    img3x3gray[3] = (img3x3[3].b*BG + img3x3[3].g*GG + img3x3[3].r*RG);
    img3x3gray[4] = (img3x3[4].b*BG + img3x3[4].g*GG + img3x3[4].r*RG);
    img3x3gray[5] = (img3x3[5].b*BG + img3x3[5].g*GG + img3x3[5].r*RG);
    img3x3gray[6] = (img3x3[6].b*BG + img3x3[6].g*GG + img3x3[6].r*RG);
    img3x3gray[7] = (img3x3[7].b*BG + img3x3[7].g*GG + img3x3[7].r*RG);
    img3x3gray[8] = (img3x3[8].b*BG + img3x3[8].g*GG + img3x3[8].r*RG);
    
    highp float img3x3gray2[9];

    img3x3gray2[0] = img3x3gray[0]*img3x3gray[0];
    img3x3gray2[1] = img3x3gray[1]*img3x3gray[1];
    img3x3gray2[2] = img3x3gray[2]*img3x3gray[2];
    img3x3gray2[3] = img3x3gray[3]*img3x3gray[3];
    img3x3gray2[4] = img3x3gray[4]*img3x3gray[4];
    img3x3gray2[5] = img3x3gray[5]*img3x3gray[5];
    img3x3gray2[6] = img3x3gray[6]*img3x3gray[6];
    img3x3gray2[7] = img3x3gray[7]*img3x3gray[7];
    img3x3gray2[8] = img3x3gray[8]*img3x3gray[8];

    
    // Variaton Map
    highp float mean = (img3x3gray[0]+img3x3gray[1]+img3x3gray[2]+img3x3gray[3]+img3x3gray[4]+img3x3gray[5]+img3x3gray[6]+img3x3gray[7]+img3x3gray[8])/9.0;
    highp float mean2 = mean*mean;
    highp float meanOfSquare = (img3x3gray2[0]+img3x3gray2[1]+img3x3gray2[2]+img3x3gray2[3]+img3x3gray2[4]+img3x3gray2[5]+img3x3gray2[6]+img3x3gray2[7]+img3x3gray2[8])/9.0;
    highp float variationMap = sqrt(meanOfSquare - mean2);
    
    
    // Green Mask
    highp vec3 pixel = img3x3[4];
    highp float pixel2 = (pixel.r*pixel.r + pixel.g*pixel.g + pixel.b*pixel.b);
    highp float db = pixel2;
    highp float dc = pixel.r*pixel.r + (pixel.g - 0.644)*(pixel.g - 0.644) + (pixel.b-0.09)*(pixel.b-0.09);
    highp float dw = (1.0-pixel.r)*(1.0-pixel.r) + (1.0-pixel.g)*(1.0-pixel.g) + (1.0-pixel.b)*(1.0-pixel.b);
    highp float greenMask = (dc<db) && (dc<dw) ? 1.0 : 0.0;
    
    
    
    highp vec4 result;
    result.b = greenMask;
    result.g = variationMap;
    result.r = img3x3gray[4];
    result.a = max(pixel.r,max(pixel.g,pixel.b));
    
    gl_FragColor = result;
}

