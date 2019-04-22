MOVE(
 TEMP t101,
 ESEQ(
  MOVE(
   TEMP t110,
   ESEQ(
    SEQ(
     MOVE(
      TEMP t112,
      BINOP(MUL,
       CONST 10,
       CONST 4)),
     SEQ(
      MOVE(
       TEMP t111,
       CALL(
        NAME initArray,
         BINOP(PLUS,
          TEMP t112,
          CONST 4),
         CONST 0)),
      MOVE(
       MEM(
        TEMP t111),
       TEMP t112))),
    BINOP(PLUS,
     TEMP t111,
     CONST 4))),
  ESEQ(
   SEQ(
    CJUMP(LT,
     CONST 5,
     MEM(
      BINOP(MINUS,
       TEMP t110,
       CONST 4)),
     L12,L14),
    SEQ(
     LABEL L12,
     SEQ(
      CJUMP(GE,
       CONST 5,
       CONST 0,
       L13,L14),
      SEQ(
       LABEL L13,
       SEQ(
        MOVE(
         TEMP t113,
         MEM(
          BINOP(PLUS,
           TEMP t110,
           BINOP(MUL,
            CONST 5,
            CONST 4)))),
        SEQ(
         JUMP(
          NAME L15),
         SEQ(
          LABEL L14,
          SEQ(
           MOVE(
            TEMP t113,
            CALL(
             NAME arrayOutOfBounds)),
           LABEL L15)))))))),
   TEMP t113)))
MOVE(
 TEMP t112,
 BINOP(MUL,
  CONST 10,
  CONST 4))
MOVE(
 TEMP t111,
 CALL(
  NAME initArray,
   BINOP(PLUS,
    TEMP t112,
    CONST 4),
   CONST 0))
MOVE(
 MEM(
  TEMP t111),
 TEMP t112)
MOVE(
 TEMP t110,
 BINOP(PLUS,
  TEMP t111,
  CONST 4))
CJUMP(LT,
 CONST 5,
 MEM(
  BINOP(MINUS,
   TEMP t110,
   CONST 4)),
 L12,L14)
LABEL L12
CJUMP(GE,
 CONST 5,
 CONST 0,
 L13,L14)
LABEL L13
MOVE(
 TEMP t113,
 MEM(
  BINOP(PLUS,
   TEMP t110,
   BINOP(MUL,
    CONST 5,
    CONST 4))))
JUMP(
 NAME L15)
LABEL L14
MOVE(
 TEMP t113,
 CALL(
  NAME arrayOutOfBounds))
LABEL L15
MOVE(
 TEMP t101,
 TEMP t113)
