IMPLEMENTATION MODULE M2CSV;

PROCEDURE ParseRecord (line: ARRAY OF CHAR;
 VAR fields: ARRAY OF ARRAY OF CHAR;
 VAR count: CARDINAL): BOOLEAN;

VAR i,j,n,k: CARDINAL;
 quoted: BOOLEAN;
 closed: BOOLEAN;

BEGIN
 count:=0;
 n:=0;
 WHILE (n<=HIGH(line)) AND (line[n]#0C) DO INC(n) END;

 i:=0;
 WHILE (i<n) OR ((i=0) AND (n=0)) DO
   IF count>HIGH(fields) THEN RETURN FALSE END;
 j:=0;
 quoted:=FALSE;
 closed:=FALSE;

   IF (i<n) AND (line[i]='"') THEN quoted:=TRUE;
 INC(i) END;

   WHILE i<n DO
     IF quoted THEN
       IF line[i]='"' THEN
         IF (i+1<n) AND (line[i+1]='"') THEN IF j>=HIGH(fields[count]) THEN RETURN FALSE END;
 fields[count][j]:='"';
 INC(j);
 INC(i,2)
         ELSE quoted:=FALSE;
 closed:=TRUE;
 INC(i);
 IF (i<n) AND (line[i]#',') THEN RETURN FALSE END
         END
       ELSE IF j>=HIGH(fields[count]) THEN RETURN FALSE END;
 fields[count][j]:=line[i];
 INC(j);
 INC(i) END;

     ELSE IF line[i]=',' THEN EXIT END;
 IF j>=HIGH(fields[count]) THEN RETURN FALSE END;
 fields[count][j]:=line[i];
 INC(j);
 INC(i) END
   END;

   IF quoted THEN RETURN FALSE END;
 fields[count][j]:=0C;
 INC(count);

   IF i<n THEN INC(i) ELSIF i=n THEN EXIT END;

   IF (i=n) AND (line[n-1]=',') THEN IF count>HIGH(fields) THEN RETURN FALSE END;
 fields[count][0]:=0C;
 INC(count);
 EXIT END;

 END;

 RETURN TRUE;

END ParseRecord;

PROCEDURE WriteField (value: ARRAY OF CHAR;
 VAR output: ARRAY OF CHAR;
 VAR used: CARDINAL): BOOLEAN;

VAR i,n: CARDINAL;
 quote: BOOLEAN;

BEGIN n:=0;
 WHILE (n<=HIGH(value)) AND (value[n]#0C) DO INC(n) END;
 quote:=FALSE;
 FOR i:=0 TO n-1 DO IF (value[i]=',') OR (value[i]='"') OR (value[i]=10C) OR (value[i]=15C) THEN quote:=TRUE END END;

 IF quote THEN IF used+1>HIGH(output) THEN RETURN FALSE END;
 output[used]:='"';
 INC(used) END;

 FOR i:=0 TO n-1 DO IF value[i]='"' THEN IF used+2>HIGH(output) THEN RETURN FALSE END;
 output[used]:='"';
 INC(used);
 output[used]:='"';
 INC(used) ELSE IF used+1>HIGH(output) THEN RETURN FALSE END;
 output[used]:=value[i];
 INC(used) END END;

 IF quote THEN IF used+1>HIGH(output) THEN RETURN FALSE END;
 output[used]:='"';
 INC(used) END;
 IF used<=HIGH(output) THEN output[used]:=0C END;
 RETURN TRUE END WriteField;

END M2CSV.
