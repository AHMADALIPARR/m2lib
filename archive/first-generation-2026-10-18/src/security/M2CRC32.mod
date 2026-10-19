IMPLEMENTATION MODULE M2CRC32;

PROCEDURE Step (crc: CARDINAL): CARDINAL;

VAR i: CARDINAL;

BEGIN FOR i:=0 TO 7 DO IF crc MOD 2=1 THEN crc:=(crc DIV 2) XOR 16#EDB88320 ELSE crc:=crc DIV 2 END END;
 RETURN crc END Step;

PROCEDURE Init (): State;
 BEGIN RETURN 16#FFFFFFFF END Init;

PROCEDURE Update (state: State;
 data: ARRAY OF CHAR;
 length: CARDINAL): State;

VAR i: CARDINAL;
 crc: CARDINAL;

BEGIN crc:=state;
 IF length>HIGH(data)+1 THEN length:=HIGH(data)+1 END;
 FOR i:=0 TO length-1 DO crc:=crc XOR ORD(data[i]);
 crc:=Step(crc) END;
 RETURN crc END Update;

PROCEDURE Final (state: State): CARDINAL;
 BEGIN RETURN state XOR 16#FFFFFFFF END Final;

PROCEDURE Compute (data: ARRAY OF CHAR;
 length: CARDINAL): CARDINAL;
 BEGIN RETURN Final(Update(Init(),data,length)) END Compute;

END M2CRC32.
