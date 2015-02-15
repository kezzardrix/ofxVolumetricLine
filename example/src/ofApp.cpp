#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
   
    mVolumetricLine.setup("textures/gradation.png");
    mVolumetricLine.setRadius(5.0);
    //mVolumetricLine.disableTexture();
    
    mCam.setPosition(ofGetWidth() * 0.5, ofGetHeight() * 0.5, 600);
    mCam.setTarget(ofPoint(ofGetWidth() * 0.5, ofGetHeight() * 0.5, 0));
    
    for(int i = 0; i < NUM; i++){
        mVerts[i].set(ofPoint(ofRandomWidth(),
                             ofRandomHeight(),
                             ofRandom(-600,600)));
    }
    
    mVbo.setVertexData(mVerts, NUM, GL_STATIC_DRAW);
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0,0,0,0);
    
    ofEnableBlendMode(OF_BLENDMODE_ADD);
    ofDisableDepthTest();
    
    mCam.begin();
    
    mVolumetricLine.begin();
    ofSetColor(200,100,50);
    mVbo.draw(GL_LINE_STRIP, 0, 100); // use ofLine or ofVbo or ofPolyline. ofMesh does not work due to oF implementation.
    mVolumetricLine.end();
    
    mCam.end();

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
