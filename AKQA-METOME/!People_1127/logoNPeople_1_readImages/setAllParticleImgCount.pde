void setAllParticleImgCount(int c) {
  for (int i = 0; i < peopleParticles.length; i ++) {
    PeopleParticle p = peopleParticles[i];
    p.setImgNo(c);
  }
}