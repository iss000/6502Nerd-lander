#include "lib.h"

void gr_hplot(int x, int y, char *s);
void gr_tplot(int x, int y, char *s);
void gr_plot(int x, int y, char *s);
void gr_pixmode(int mode);
unsigned char kb_stick();

unsigned char plotShip();
extern unsigned char udgData[];

char t[40];
char a[5],b[5],floating[5],thrustUp[5],thrustLeft[5],thrustRight[5];
int padLeft,padTop;
int score,level,fuel,hiscore;
int ox,oy,x,y,dx,dy,s,p,xx,yy,oxx,oyy;
int g,sx,sy;
unsigned char state=0;

void main()
{
  gr_init();
  init();
  while(1)
  {
   if(state==0) attract();
   if(state==1) initGame();
   if(state==2) playGame();
  }
}

int init()
{
  unsigned char c,d;
  int i,j;

  paper(4);ink(3);
  hires();poke(0x26A,10);
  gr_hplot(6,0,"\14INITIALISING..PLEASE WAIT");
  i=0;
  // Set up character graphics
  while(udgData[i]!=0)
  {
    c=udgData[i++];
    for(j=0;j<8;j++)
    {
      d=udgData[i++];
      poke(0x9800+8*c+j,d);
    }
  }
  strcpy(floating,"\43\44");
  strcpy(thrustUp,"\45\46");
  strcpy(thrustLeft,"\50\51");
  strcpy(thrustRight,"\52\53");
  padLeft=220;
  padTop=188;
  score=0;level=0;fuel=0;hiscore=0;
} 

int attract()
{
  int r=0;

  hires();poke(0x26A,10);
  showStatus();
  gr_hplot(48,10, "\5Oric Lander in C-lang");
  gr_hplot(24,30, "Land your spacecraft on the base");
  gr_hplot(24,45, "bottom right avoid obstacles and");
  gr_hplot(24,60, "boundaries and be sure to make a");
  gr_hplot(24,75, "gentle landing!");
  gr_hplot(18,95, "\3Controls:");
  gr_hplot(30,110,"  \2Left\7arrow = Thrust Left");
  gr_hplot(30,125," \2Right\7arrow = Thrust Right");
  gr_hplot(30,140,"    \2Up\7arrow = Thrust Up");
  gr_hplot(30,170,"Press\2space\7start - Good Luck!");
  while(key()!=32) r++;
  srandom(r);
  level=1;
  score=0;
  state=1;
}

int initGame()
{
  hires();poke(0x26A,10);
  fuel=500;
  g=2;sx=2;sy=6;p=0;
  showStatus();
  drawObstacles();
  state=2;
}


int showStatus()
{
  sprintf(t,"\1FUEL:%d ",fuel); t[9]=0; gr_tplot(1,0,t);
  sprintf(t,"\3LEVEL:%d ",level); t[9]=0; gr_tplot(15,0,t);
  sprintf(t,"\2SCORE:%d ",score); t[10]=0; gr_tplot(28,0,t);
  sprintf(t,"\2SCORE:%d ",score); t[10]=0; gr_tplot(28,0,t);
  sprintf(t,"\5HI SCORE:%d ",hiscore); t[14]=0; gr_tplot(12,1,t);
}


int drawObstacles()
{
  int i,x,y;

  for(i=0;i<=3;i++)
  {
    curset(i,i,1);
    draw(239-i-i,0,1); draw(0,199-i-i,1);
    draw(-(239-i-i),0,1); draw(0,-(199-i-i),1);
  }

  curset(padLeft,padTop+7,1);
  draw(239-padLeft,0,1);

  gr_pixmode(-1);
  for(i=0;i<20+level*10;i++)
  {
    x=((unsigned int)rand())%210+15;y=((unsigned int)(rand()))%180+10;
    if ((x>25 || y>25) && (x<(padLeft-6) || y<(padTop-8)))
      gr_hplot(x,y,"/");
  }
}

int playGame()
{
  int delay;

  play(0,0,0,0);sound(0,16,0);sound(1,1,10);
  x=4<<6;y=4<<6;dx=0;dy=0;
  xx=x>>6;yy=y>>6;
  strcpy(a,floating); strcpy(b,a);
  gr_pixmode(-1); gr_hplot(xx,yy,a);
  do
  {
    ox=xx;oy=yy;
    dy=dy+g;
    if (dy>=128) dy=128;
    if (dy<=-128) dy=-128;
    if (dx>=128) dx=128;
    if (dx<=-128) dx=-128;
    y=y+dy;x=x+dx;
    s=kb_stick();
    if ((s&7)&&(fuel>0))
    {
      play(0,1,0,0);
      if (s&4) {
        dy=dy-sy; strcpy(b,thrustUp);fuel=fuel-2;
      }
      else if (s&1) {
        dx=dx-sx; strcpy(b,thrustLeft);fuel=fuel-1;
      }
      else if (s&2) {
        dx=dx+sx; strcpy(b,thrustRight);fuel=fuel-1;
      }
      if (fuel<0) fuel=0;
      sprintf(t,"%d   ",fuel);t[4]=0;
      gr_tplot(7,0,t);
    }
    else {
      strcpy(b,floating);
      play(0,0,0,0);
    }
    xx=x>>6;yy=y>>6;
    if((xx!=ox)||(yy!=oy)||(strcmp(a,b)))
      p=plotShip();
    wait(2);
  } while (!p);
  play(0,0,0,0);
  if ((xx>=padLeft)&&(yy>=padTop)&&(dx>=-18)&&(dx<=18)&&(dy<=22))
  {
    doWon();
    wait(100);
    state=1;
  } else
  {
    doCrash();
    wait(200);
    state=0;
  }
}


int doWon()
{
  ping();
  gr_tplot(13,2,"LANDED SAFELY!");
  level=level+1;
  score=score+fuel;
  showStatus();
}


int doCrash()
{
  int i;
  gr_tplot( 8,2,"YOU DESTROYED THE CRAFT");
  explode();
  curset(xx+5,yy+3,3);
  for(i=1;i<=6;i++) {
    circle(i,1);
    wait(5);
  }
  for(i=1;i<=6;i++) {
    circle(i,0);
    wait(5);
  }
  checkHighScore();
}

int checkHighScore()
{
  if(score>hiscore) {
    hiscore=score;
    showStatus();
    gr_tplot( 8,2,"    NEW HIGH SCORE!    ");
    zap();zap();zap();
  }
}

int wait(int n)
{
  int i;
  for(i=0;i<n*20;i++);
}
