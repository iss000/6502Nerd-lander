//
// TEST_4
//
// This is a "HELLO WORLD" sample using
// an assembly code routine to display
// the message
//


// Declare the assembly code function
void AdvancedPrint(char x_pos,char y_pos,const char* ptr_message);


void main()
{
  int i, j;
  int x, y;
  int dx, dy;

  char message[20] = " Hello World ! ";
  char blank[20]   = "               ";

  message[0]=1;     // Red text

  x=13;
  y=7;
  dx=1;
  dy=1;
  while(1)
  {
    AdvancedPrint(x,y,blank);
    x=x+dx;
    y=y+dy;
    if(x<=2)
    {
      x=2;
      dx=1;
    }
    if(x>=23)
    {
      x=23;
      dx=-1;
    }
    if(y<=1)
    {
      y=1;
      dy=1;
    }
    if(y>=27)
    {
      y=27;
      dy=-1;
    }
    AdvancedPrint(x,y,message);
    for(j=0; j<1000; j++);  // Delay
  }
}
