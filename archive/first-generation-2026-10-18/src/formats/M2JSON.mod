IMPLEMENTATION MODULE M2JSON;

PROCEDURE Length (s: ARRAY OF CHAR): CARDINAL;
 VAR n: CARDINAL;
 BEGIN n:=0;
 WHILE (n<=HIGH(s)) AND (s[n]#0C) DO INC(n) END;
 RETURN n END Length;

PROCEDURE EscapeString (source: ARRAY OF CHAR;
 VAR destination: ARRAY OF CHAR): BOOLEAN;

VAR i,o,n: CARDINAL;
 c: CHAR;

BEGIN n:=Length(source);
 o:=0;
 FOR i:=0 TO n-1 DO c:=source[i];
 IF c='"' THEN IF o+2>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:='\';
 destination[o+1]:='"';
 INC(o,2)
 ELSIF c='\' THEN IF o+2>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:='\';
 destination[o+1]:='\';
 INC(o,2)
 ELSIF ORD(c)=8 THEN IF o+2>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:='\';
 destination[o+1]:='b';
 INC(o,2)
 ELSIF ORD(c)=12 THEN IF o+2>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:='\';
 destination[o+1]:='f';
 INC(o,2)
 ELSIF ORD(c)=10 THEN IF o+2>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:='\';
 destination[o+1]:='n';
 INC(o,2)
 ELSIF ORD(c)=13 THEN IF o+2>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:='\';
 destination[o+1]:='r';
 INC(o,2)
 ELSIF ORD(c)=9 THEN IF o+2>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:='\';
 destination[o+1]:='t';
 INC(o,2)
 ELSIF ORD(c)<32 THEN RETURN FALSE
 ELSE IF o>=HIGH(destination) THEN RETURN FALSE END;
 destination[o]:=c;
 INC(o) END END;
 IF o>HIGH(destination) THEN RETURN FALSE END;
 destination[o]:=0C;
 RETURN TRUE END EscapeString;

PROCEDURE UnescapeString (source: ARRAY OF CHAR;
 VAR destination: ARRAY OF CHAR): BOOLEAN;

VAR i,o,n: CARDINAL;
 c: CHAR;

BEGIN n:=Length(source);
 i:=0;
 o:=0;
 WHILE i<n DO c:=source[i];
 INC(i);
 IF c='\' THEN IF i>=n THEN RETURN FALSE END;
 c:=source[i];
 INC(i);
 IF c='"' THEN c:='"' ELSIF c='\' THEN c:='\' ELSIF c='/' THEN c:='/' ELSIF c='b' THEN c:=CHR(8) ELSIF c='f' THEN c:=CHR(12) ELSIF c='n' THEN c:=CHR(10) ELSIF c='r' THEN c:=CHR(13) ELSIF c='t' THEN c:=CHR(9) ELSE RETURN FALSE END END;
 IF o>=HIGH(destination) THEN RETURN FALSE END;
 destination[o]:=c;
 INC(o) END;
 destination[o]:=0C;
 RETURN TRUE END UnescapeString;

PROCEDURE IsNumber (source: ARRAY OF CHAR): BOOLEAN;

VAR i,n,digits: CARDINAL;
 hasDot,hasExp: BOOLEAN;

BEGIN n:=Length(source);
 IF n=0 THEN RETURN FALSE END;
 i:=0;
 IF (source[i]='-') OR (source[i]='+') THEN INC(i) END;
 digits:=0;
 WHILE (i<n) AND (source[i]>='0') AND (source[i]<='9') DO INC(i);
 INC(digits) END;
 hasDot:=FALSE;
 IF (i<n) AND (source[i]='.') THEN hasDot:=TRUE;
 INC(i);
 WHILE (i<n) AND (source[i]>='0') AND (source[i]<='9') DO INC(i);
 INC(digits) END END;
 IF digits=0 THEN RETURN FALSE END;
 hasExp:=FALSE;
 IF (i<n) AND ((source[i]='e') OR (source[i]='E')) THEN hasExp:=TRUE;
 INC(i);
 IF (i<n) AND ((source[i]='+') OR (source[i]='-')) THEN INC(i) END;
 digits:=0;
 WHILE (i<n) AND (source[i]>='0') AND (source[i]<='9') DO INC(i);
 INC(digits) END;
 IF digits=0 THEN RETURN FALSE END END;
 RETURN i=n END IsNumber;

END M2JSON.
