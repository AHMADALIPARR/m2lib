IMPLEMENTATION MODULE M2Heap;

PROCEDURE SiftDown (VAR a: ARRAY OF CARDINAL;
 root,n: CARDINAL);

VAR c,t: CARDINAL;

BEGIN WHILE root<n DIV 2 DO c:=root*2+1;
 IF (c+1<n) AND (a[c+1]>a[c]) THEN INC(c) END;
 IF a[root]>=a[c] THEN RETURN END;
 t:=a[root];
 a[root]:=a[c];
 a[c]:=t;
 root:=c END END SiftDown;

PROCEDURE PushMax (VAR a: ARRAY OF CARDINAL;
 VAR n: CARDINAL;
 capacity,value: CARDINAL): BOOLEAN;

VAR i,p: CARDINAL;
 t: CARDINAL;

BEGIN IF (n>=capacity) OR (n>HIGH(a)) OR (capacity>HIGH(a)+1) THEN RETURN FALSE END;
 i:=n;
 a[i]:=value;
 INC(n);
 WHILE i>0 DO p:=(i-1) DIV 2;
 IF a[p]>=a[i] THEN RETURN TRUE END;
 t:=a[p];
 a[p]:=a[i];
 a[i]:=t;
 i:=p END;
 RETURN TRUE END PushMax;

PROCEDURE PopMax (VAR a: ARRAY OF CARDINAL;
 VAR n: CARDINAL;
 VAR value: CARDINAL): BOOLEAN;

BEGIN IF n=0 THEN RETURN FALSE END;
 value:=a[0];
 DEC(n);
 IF n>0 THEN a[0]:=a[n];
 SiftDown(a,0,n) END;
 RETURN TRUE END PopMax;

PROCEDURE Heapify (VAR a: ARRAY OF CARDINAL;
 n: CARDINAL);

VAR i: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 i:=n DIV 2;
 WHILE i>0 DO DEC(i);
 SiftDown(a,i,n) END END Heapify;

PROCEDURE IsMaxHeap (a: ARRAY OF CARDINAL;
 n: CARDINAL): BOOLEAN;

VAR i: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN RETURN FALSE END;
 FOR i:=1 TO n-1 DO IF a[(i-1) DIV 2]<a[i] THEN RETURN FALSE END END;
 RETURN TRUE END IsMaxHeap;

END M2Heap.
