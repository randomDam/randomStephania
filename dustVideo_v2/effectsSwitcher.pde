/*
  Cette partie permet de switcher d'un effet a l'autre.
 suivant le temps max random(0,100);
 */
int effectsNum=4;
int timer=0;
int timerEnd=int(random(0, 100));
int de=3;

void effects(PGraphics pg) {

  if (de==0) {
    effect0(pg);
  }
  if (de==1) {
    effect1(pg);
  }
  if (de==2) {
    effect2(pg);
  }
  if (de==3) {
    effect3(pg);
  }

  timer++;
  if (timer>timerEnd) {
    de = int(random(effectsNum));
    timer=0;
    timerEnd=int(random(0, 100));
  }
}
