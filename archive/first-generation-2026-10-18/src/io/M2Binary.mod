IMPLEMENTATION MODULE M2Binary;

PROCEDURE InitWriter (VAR w: Writer;
 data: POINTER TO ARRAY OF CHAR;
 capacity: CARDINAL);
 BEGIN w.data:=data;
 w.capacity:=capacity;
 w.used:=0 END InitWriter;

PROCEDURE InitReader (VAR r: Reader;
 data: POINTER TO ARRAY OF CHAR;
 length: CARDINAL);
 BEGIN r.data:=data;
 r.length:=length;
 r.position:=0 END InitReader;

PROCEDURE PutByte (VAR w: Writer;
 value: CARDINAL): BOOLEAN;
 BEGIN IF (w.data=NIL) OR (w.used>=w.capacity) THEN RETURN FALSE END;
 w.data^[w.used]:=CHR(value MOD 256);
 INC(w.used);
 RETURN TRUE END PutByte;

PROCEDURE PutU16BE (VAR w: Writer;
 value: CARDINAL): BOOLEAN;
 BEGIN IF w.capacity-w.used<2 THEN RETURN FALSE END;
 IF NOT PutByte(w,value DIV 256) THEN RETURN FALSE END;
 RETURN PutByte(w,value) END PutU16BE;

PROCEDURE PutU32BE (VAR w: Writer;
 value: CARDINAL): BOOLEAN;
 BEGIN IF w.capacity-w.used<4 THEN RETURN FALSE END;
 IF NOT PutByte(w,value DIV 16777216) THEN RETURN FALSE END;
 IF NOT PutByte(w,value DIV 65536) THEN RETURN FALSE END;
 IF NOT PutByte(w,value DIV 256) THEN RETURN FALSE END;
 RETURN PutByte(w,value) END PutU32BE;

PROCEDURE PutBytes (VAR w: Writer;
 source: ARRAY OF CHAR;
 length: CARDINAL): BOOLEAN;
 VAR i: CARDINAL;
 BEGIN IF (length>HIGH(source)+1) OR (w.data=NIL) OR (length>w.capacity-w.used) THEN RETURN FALSE END;
 FOR i:=0 TO length-1 DO w.data^[w.used+i]:=source[i] END;
 INC(w.used,length);
 RETURN TRUE END PutBytes;

PROCEDURE GetByte (VAR r: Reader;
 VAR value: CARDINAL): BOOLEAN;
 BEGIN IF (r.data=NIL) OR (r.position>=r.length) THEN RETURN FALSE END;
 value:=ORD(r.data^[r.position]);
 INC(r.position);
 RETURN TRUE END GetByte;

PROCEDURE GetU16BE (VAR r: Reader;
 VAR value: CARDINAL): BOOLEAN;
 VAR a,b: CARDINAL;
 BEGIN IF r.length-r.position<2 THEN RETURN FALSE END;
 IF NOT GetByte(r,a) OR NOT GetByte(r,b) THEN RETURN FALSE END;
 value:=a*256+b;
 RETURN TRUE END GetU16BE;

PROCEDURE GetU32BE (VAR r: Reader;
 VAR value: CARDINAL): BOOLEAN;
 VAR a,b,c,d: CARDINAL;
 BEGIN IF r.length-r.position<4 THEN RETURN FALSE END;
 IF NOT GetByte(r,a) OR NOT GetByte(r,b) OR NOT GetByte(r,c) OR NOT GetByte(r,d) THEN RETURN FALSE END;
 value:=a*16777216+b*65536+c*256+d;
 RETURN TRUE END GetU32BE;

PROCEDURE GetBytes (VAR r: Reader;
 VAR destination: ARRAY OF CHAR;
 length: CARDINAL): BOOLEAN;
 VAR i: CARDINAL;
 BEGIN IF (r.data=NIL) OR (length>HIGH(destination)+1) OR (length>r.length-r.position) THEN RETURN FALSE END;
 FOR i:=0 TO length-1 DO destination[i]:=r.data^[r.position+i] END;
 INC(r.position,length);
 RETURN TRUE END GetBytes;

PROCEDURE Position (r: Reader): CARDINAL;
 BEGIN RETURN r.position END Position;

PROCEDURE Remaining (r: Reader): CARDINAL;
 BEGIN IF r.position>r.length THEN RETURN 0 ELSE RETURN r.length-r.position END END Remaining;

END M2Binary.
