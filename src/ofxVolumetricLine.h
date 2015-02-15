//
//  ofxVolumetricLine.h
//  
//
//  Created by kezzardrix2 on 2015/02/15.
//
//  original algorithm by HILLAIRE SÈbastien

/**********************************************************************\
 * AUTHOR : HILLAIRE SÈbastien
 *
 * MAIL   : hillaire_sebastien@yahoo.fr
 * SITE   : sebastien.hillaire.free.fr
 *
 *	You are free to totally or partially use this file/code.
 * If you do, please credit me in your software or demo and leave this
 * note.
 *	Share your work and your ideas as much as possible!
 \*********************************************************************/

#ifndef Kezzar_ofxVolumetricLine_h
#define Kezzar_ofxVolumetricLine_h

class ofxVolumetricLine{
public:
    
    void setup(){
        mShader.setGeometryInputType(GL_LINES);
        mShader.setGeometryOutputType(GL_TRIANGLE_STRIP);
        mShader.setGeometryOutputCount(16);
        mShader.load("shaders/geometryLine.vert", "shaders/geometryLine.frag", "shaders/geometryLine.geom");
    }
    
    void setup(string str){
        
        ofDisableArbTex();
        mTexture.loadImage(str);
        ofEnableArbTex();
        
        setup();
    }
    
    void enableTexture(){
        isTexture = true;
    }
    
    void disableTexture(){
        isTexture = false;
    }
    
    void setRadius(float rad){
        mRad = rad;
    }
    
    void begin(){
        
        mShader.begin();
        mShader.setUniform1f("radius", mRad);
        mShader.setUniformTexture("gradientTexture", mTexture.getTextureReference(), 0);
        mShader.setUniform1i("isTexture", isTexture);
        //enable back face culling to avoid paying for back face shading
        glEnable(GL_CULL_FACE);
        glCullFace(GL_BACK);
        glFrontFace(GL_CCW);

    }
    
    void end(){
        
        glDisable(GL_CULL_FACE);
        mShader.end();
        
    }
    
private:
    
    ofImage mTexture;
    ofShader mShader;
    
    float mRad = 10.0;
    
    bool isTexture = true;
};

#endif
