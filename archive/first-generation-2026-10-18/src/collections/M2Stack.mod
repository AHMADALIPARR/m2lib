IMPLEMENTATION MODULE M2Stack;

FROM M2Vector IMPORT Create AS VCreate, Destroy AS VDestroy, Push AS VPush, Pop AS VPop, Get AS VGet, Size AS VSize, Clear AS VClear, IsEmpty AS VEmpty;

PROCEDURE Create (initialCapacity: CARDINAL): Stack;
 BEGIN RETURN VCreate(initialCapacity) END Create;

PROCEDURE Destroy (VAR s: Stack);
 BEGIN VDestroy(s) END Destroy;

PROCEDURE Push (s: Stack;
 value: CARDINAL): BOOLEAN;
 BEGIN RETURN VPush(s,value) END Push;

PROCEDURE Pop (s: Stack;
 VAR value: CARDINAL): BOOLEAN;
 BEGIN RETURN VPop(s,value) END Pop;

PROCEDURE Peek (s: Stack;
 VAR value: CARDINAL): BOOLEAN;

VAR n: CARDINAL;

BEGIN n:=VSize(s);
 IF n=0 THEN RETURN FALSE END;
 RETURN VGet(s,n-1,value) END Peek;

PROCEDURE Size (s: Stack): CARDINAL;
 BEGIN RETURN VSize(s) END Size;

PROCEDURE IsEmpty (s: Stack): BOOLEAN;
 BEGIN RETURN VEmpty(s) END IsEmpty;

PROCEDURE Clear (s: Stack);
 BEGIN VClear(s) END Clear;

END M2Stack.
