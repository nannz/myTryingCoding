float logoImgScale = 1.33;
ImgInfo[] saveLogo2ImgInfo() {

  ImgInfo[] logoImgInfo = new ImgInfo[1]; 
  logoParticleImg.loadPixels();
  float imgTempXoff = width/2 - logoParticleImg.width/2 * (logoImgScale);//800/600, because size is not matched. the peopleParticle of logo and the logo.png
  float imgTempYoff = height/2 - logoParticleImg.height/2 * (logoImgScale);//
  for (float angle = 0; angle < MAX_ANGLE; angle += angleOff) {
    imgX = sin(angle) * amp;
    imgY = cos(angle) * amp;
    imgX = imgX + logoParticleImg.width/2 ;
    imgY = imgY + logoParticleImg.height/2;
    if (imgX>=0 && imgX <= logoParticleImg.width && imgY >=0 && imgY <= logoParticleImg.height) {
      color cc = logoParticleImg.get(floor(imgX), floor(imgY));
      float imgBrightness = brightness(cc);
      float imgSize = map(imgBrightness, 0, 255, 7, 0.0001);
      //check if the particles are too dense.
      if (angle <= 200) {
        float sizeOff = map(angle, 0, 200, 0.01, 1);
        imgSize = imgSize * sizeOff;//map(amp, 0, 60,0,5);//0,51,
      } 
      float imgPPosX = imgX  * logoImgScale + imgTempXoff;
      float imgPPosY = imgY * logoImgScale + imgTempYoff;
      //push a particle.
      ImgInfo imgI = new ImgInfo( imgPPosX, imgPPosY, imgSize);
      if (logoImgInfo[0] == null) {
        logoImgInfo[0] = imgI;
      } else {
        logoImgInfo = (ImgInfo[])append(logoImgInfo, imgI);
      }
    }
    amp += ampOff;
  }
  
  return logoImgInfo;
}