.zero
#ifdef __CC65__
#define tmp0 atmp0
#define tmp1 atmp1
#define tmp2 atmp2
#define tmp3 atmp3
#define tmp4 atmp4
atmp0         .dsb  2
atmp1         .dsb  2
atmp2         .dsb  2
atmp3         .dsb  2
atmp4         .dsb  2
#endif

#ifdef __VBCC__
#define tmp0 atmp0
atmp0         .dsb  2
#endif

#ifdef __LLVM_MOS__
#define tmp0 atmp0
atmp0         .dsb  2
#endif

.data

__mgr_m       .dsb  2
__mgr_x       .dsb  2
__mgr_y       .dsb  2
__mgr_s       .dsb  2

#define _gr_pixmode __gr_pixmode
#define _gr_hplot   __gr_hplot
#define _gr_tplot   __gr_tplot
#define _gr_plot   __gr_plot

#include "dflat_library.s"

.text

_plotShip
;           @ plot ox,oy,a$
              ldx   _ox
              ldy   _oy
              lda   _a
              jsr   gr_hchar
              lda   _ox
              clc
              adc   #6
              tax
              ldy   _oy
              lda   _a+1
              jsr   gr_hchar
;           @
;           @ Collision check
;           @ pixel(xx+5,yy)
              lda   _xx
              clc
              adc   #5
              tax
              ldy   _yy
              jsr   gr_pixel
              sta   tmpP
;           @ pixel(xx+2,yy+3)
              lda   _xx
              clc
              adc   #2
              tax
              lda   _yy
              adc   #3
              tay
              jsr   gr_pixel
              clc
              adc   tmpP
              sta   tmpP
;           @ pixel(xx,yy+7)
              ldx   _xx
              lda   _yy
              adc   #7
              tay
              jsr   gr_pixel
              clc
              adc   tmpP
              sta   tmpP
;           @ pixel(xx+2,yy+7)
              lda   _xx
              adc   #2
              tax
              lda   _yy
              adc   #7
              tay
              jsr   gr_pixel
              clc
              adc   tmpP
              sta   tmpP
;           @ pixel(xx+6,yy)
              lda   _xx
              adc   #6
              tax
              ldy   _yy
              jsr   gr_pixel
              clc
              adc   tmpP
              sta   tmpP
;           @ pixel(xx+9,yy+3)
              lda   _xx
              adc   #9
              tax
              lda   _yy
              adc   #3
              tay
              jsr   gr_pixel
              clc
              adc   tmpP
              sta   tmpP
;           @ pixel(xx+11,yy+7)
              lda   _xx
              adc   #11
              tax
              lda   _yy
              adc   #7
              tay
              jsr   gr_pixel
              clc
              adc   tmpP
              sta   tmpP
;           @ pixel(xx+9,yy+7)
              lda   _xx
              adc   #9
              tax
              lda   _yy
              adc   #7
              tay
              jsr   gr_pixel
              clc
              adc   tmpP
              pha
;           @
;           @ a$=b$
              lda   _b
              sta   _a
              lda   _b+1
              sta   _a+1
;           @
;           @ plot xx,yy,a$
              ldx   _xx
              ldy   _yy
              lda   _a
              jsr   gr_hchar
              lda   _xx
              clc:adc #6
              tax
              ldy   _yy
              lda   _a+1
              jsr   gr_hchar
;           @
;           @ return int - low = X, high = A
              pla
              tax
              lda   #0
              rts

.data

tmpP
              .byt  1

;           @
;           @ Graphics data - char number followed by 8 bytes of data
;           @ char number -1 terminates
_udgData
              .byt  35
              .byt  %000001
              .byt  %000111
              .byt  %001101
              .byt  %001111
              .byt  %001111
              .byt  %000111
              .byt  %001000
              .byt  %111000
              .byt  36
              .byt  %100000
              .byt  %111000
              .byt  %101100
              .byt  %111100
              .byt  %111100
              .byt  %111000
              .byt  %000100
              .byt  %000111
              .byt  37
              .byt  %000001
              .byt  %000111
              .byt  %001101
              .byt  %001111
              .byt  %001111
              .byt  %000111
              .byt  %001001
              .byt  %111011
              .byt  38
              .byt  %100000
              .byt  %111000
              .byt  %101100
              .byt  %111100
              .byt  %111100
              .byt  %111000
              .byt  %100100
              .byt  %110111
              .byt  40
              .byt  %000001
              .byt  %000111
              .byt  %001101
              .byt  %001111
              .byt  %001111
              .byt  %000111
              .byt  %001000
              .byt  %111000
              .byt  41
              .byt  %100000
              .byt  %111000
              .byt  %101101
              .byt  %111111
              .byt  %111101
              .byt  %111000
              .byt  %000100
              .byt  %000111
              .byt  42
              .byt  %000001
              .byt  %000111
              .byt  %101101
              .byt  %111111
              .byt  %101111
              .byt  %000111
              .byt  %001000
              .byt  %111000
              .byt  43
              .byt  %100000
              .byt  %111000
              .byt  %101100
              .byt  %111100
              .byt  %111100
              .byt  %111000
              .byt  %000100
              .byt  %000111
              .byt  47
              .byt  %001100
              .byt  %110111
              .byt  %011011
              .byt  %110110
              .byt  %111011
              .byt  %110110
              .byt  %011100
              .byt  %000000
              .byt  0
