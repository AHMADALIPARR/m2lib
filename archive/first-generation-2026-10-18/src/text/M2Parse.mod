IMPLEMENTATION MODULE M2Parse;

FROM M2Char IMPORT IsDigit, ToLower, HexValue;

PROCEDURE ParseCardinal (s: ARRAY OF CHAR;
 VAR value: CARDINAL): BOOLEAN;

VAR i,n,d,v: CARDINAL;

BEGIN n:=0;
 WHILE (n<=HIGH(s)) AND (s[n]#0C) DO INC(n) END;
 IF n=0 THEN RETURN FALSE END;
 v:=0;
 FOR i:=0 TO n-1 DO IF NOT IsDigit(s[i]) THEN RETURN FALSE END;
 d:=ORD(s[i])-ORD('0');
 IF v>(MAX(CARDINAL)-d) DIV 10 THEN RETURN FALSE END;
 v:=v*10+d END;
 value:=v;
 RETURN TRUE END ParseCardinal;

PROCEDURE ParseInteger (s: ARRAY OF CHAR;
 VAR value: INTEGER): BOOLEAN;

VAR i,n: CARDINAL;
 negative: BOOLEAN;
 mag: CARDINAL;
 limit: CARDINAL;
 c: CHAR;
 d: CARDINAL;

BEGIN n:=0;
 WHILE (n<=HIGH(s)) AND (s[n]#0C) DO INC(n) END;
 IF n=0 THEN RETURN FALSE END;
 i:=0;
 negative:=FALSE;
 IF (s[0]='-') OR (s[0]='+') THEN negative:=s[0]='-';
 i:=1;
 IF i=n THEN RETURN FALSE END END;

 IF negative THEN limit:=CARDINAL(MAX(INTEGER))+1 ELSE limit:=CARDINAL(MAX(INTEGER)) END;
 mag:=0;

 WHILE i<n DO c:=s[i];
 IF NOT IsDigit(c) THEN RETURN FALSE END;
 d:=ORD(c)-ORD('0');
 IF mag>(limit-d) DIV 10 THEN RETURN FALSE END;
 mag:=mag*10+d;
 INC(i) END;

 IF negative THEN IF mag=CARDINAL(MAX(INTEGER))+1 THEN value:=MIN(INTEGER) ELSE value:=-INTEGER(mag) END ELSE value:=INTEGER(mag) END;
 RETURN TRUE END ParseInteger;

PROCEDURE ParseHex (s: ARRAY OF CHAR;
 VAR value: CARDINAL): BOOLEAN;

VAR i,n,d,v: CARDINAL;

BEGIN n:=0;
 WHILE (n<=HIGH(s)) AND (s[n]#0C) DO INC(n) END;
 i:=0;
 IF (n>=2) AND (s[0]='0') AND (ToLower(s[1])='x') THEN i:=2 END;
 IF i=n THEN RETURN FALSE END;
 v:=0;
 WHILE i<n DO IF NOT HexValue(s[i],d) THEN RETURN FALSE END;
 IF v>(MAX(CARDINAL)-d) DIV 16 THEN RETURN FALSE END;
 v:=v*16+d;
 INC(i) END;
 value:=v;
 RETURN TRUE END ParseHex;

PROCEDURE ParseBoolean (s: ARRAY OF CHAR;
 VAR value: BOOLEAN): BOOLEAN;

VAR n: CARDINAL;
 a,b,c,d,e: CHAR;

BEGIN n:=0;
 WHILE (n<=HIGH(s)) AND (s[n]#0C) DO INC(n) END;
 IF n=4 THEN a:=ToLower(s[0]);
 b:=ToLower(s[1]);
 c:=ToLower(s[2]);
 d:=ToLower(s[3]);
 IF (a='t') AND (b='r') AND (c='u') AND (d='e') THEN value:=TRUE;
 RETURN TRUE END;
 IF (a='f') AND (b='a') AND (c='l') AND (d='s') THEN RETURN FALSE END END;
 IF n=5 THEN a:=ToLower(s[0]);
 b:=ToLower(s[1]);
 c:=ToLower(s[2]);
 d:=ToLower(s[3]);
 e:=ToLower(s[4]);
 IF (a='f') AND (b='a') AND (c='l') AND (d='s') AND (e='e') THEN value:=FALSE;
 RETURN TRUE END END;
 IF n=1 THEN IF s[0]='1' THEN value:=TRUE;
 RETURN TRUE ELSIF s[0]='0' THEN value:=FALSE;
 RETURN TRUE END END;
 RETURN FALSE END ParseBoolean;

END M2Parse.
