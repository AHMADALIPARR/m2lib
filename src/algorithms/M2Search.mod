IMPLEMENTATION MODULE M2Search;

PROCEDURE Linear(a:ARRAY OF CARDINAL;

key:CARDINAL):INTEGER;

VAR i:CARDINAL;

BEGIN FOR i:=0 TO HIGH(a)DO IF a[i]=key THEN RETURN VAL(INTEGER,i)END END;

RETURN -1 END Linear;

PROCEDURE LowerBound(a:ARRAY OF CARDINAL;

key:CARDINAL):CARDINAL;

VAR lo,hi,mid:CARDINAL;

BEGIN lo:=0;

hi:=HIGH(a)+1;

WHILE lo<hi DO mid:=lo+(hi-lo)DIV 2;

IF a[mid]<key THEN lo:=mid+1 ELSE hi:=mid END END;

RETURN lo END LowerBound;

PROCEDURE UpperBound(a:ARRAY OF CARDINAL;

key:CARDINAL):CARDINAL;

VAR lo,hi,mid:CARDINAL;

BEGIN lo:=0;

hi:=HIGH(a)+1;

WHILE lo<hi DO mid:=lo+(hi-lo)DIV 2;

IF a[mid]<=key THEN lo:=mid+1 ELSE hi:=mid END END;

RETURN lo END UpperBound;

PROCEDURE Binary(a:ARRAY OF CARDINAL;

key:CARDINAL):INTEGER;

VAR p:CARDINAL;

BEGIN p:=LowerBound(a,key);

IF(p<=HIGH(a))AND(a[p]=key)THEN RETURN VAL(INTEGER,p)END;

RETURN -1 END Binary;

END M2Search.
