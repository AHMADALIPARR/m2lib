IMPLEMENTATION MODULE M2Vector;

FROM Storage IMPORT ALLOCATE,DEALLOCATE;

FROM SYSTEM IMPORT TSIZE,ADDRESS;

FROM M2Errors IMPORT ReportError,ErrOutOfMemory,ErrIndexOutOfBounds,ErrUnderflow,ErrOverflow;

PROCEDURE Slot(data:ADDRESS;

idx:CARDINAL):POINTER TO CARDINAL;

VAR p:POINTER TO CARDINAL;

BEGIN p:=CAST(POINTER TO CARDINAL,data+idx*TSIZE(CARDINAL));

RETURN p END Slot;

PROCEDURE Create(initCap:CARDINAL):Vector;

VAR v:Vector;

BEGIN IF initCap=0 THEN initCap:=8 END;

NEW(v);

IF v=NIL THEN ReportError(ErrOutOfMemory,"Vector descriptor");

RETURN NIL END;

ALLOCATE(v^.data,initCap*TSIZE(CARDINAL));

IF v^.data=NIL THEN DISPOSE(v);

ReportError(ErrOutOfMemory,"Vector data");

RETURN NIL END;

v^.len:=0;

v^.cap:=initCap;

RETURN v END Create;

PROCEDURE Destroy(VAR v:Vector);

BEGIN IF v#NIL THEN IF v^.data#NIL THEN DEALLOCATE(v^.data,v^.cap*TSIZE(CARDINAL))END;

DISPOSE(v);

v:=NIL END END Destroy;

PROCEDURE Reserve(v:Vector;

newCap:CARDINAL):BOOLEAN;

VAR nd:ADDRESS;

i:CARDINAL;

p,q:POINTER TO CARDINAL;

BEGIN IF v=NIL THEN RETURN FALSE END;

IF newCap<=v^.cap THEN RETURN TRUE END;

IF newCap>MAX(CARDINAL)DIV TSIZE(CARDINAL)THEN ReportError(ErrOverflow,"Vector.Reserve");

RETURN FALSE END;

ALLOCATE(nd,newCap*TSIZE(CARDINAL));

IF nd=NIL THEN ReportError(ErrOutOfMemory,"Vector.Reserve");

RETURN FALSE END;

i:=0;

WHILE i<v^.len DO p:=Slot(v^.data,i);

q:=Slot(nd,i);

q^:=p^;

INC(i)END;

IF v^.data#NIL THEN DEALLOCATE(v^.data,v^.cap*TSIZE(CARDINAL))END;

v^.data:=nd;

v^.cap:=newCap;

RETURN TRUE END Reserve;

PROCEDURE Push(v:Vector;

val:CARDINAL):BOOLEAN;

VAR p:POINTER TO CARDINAL;

n:CARDINAL;

BEGIN IF v=NIL THEN RETURN FALSE END;

IF v^.len=v^.cap THEN IF v^.cap>MAX(CARDINAL)DIV 2 THEN ReportError(ErrOverflow,"Vector.Push");

RETURN FALSE END;

n:=v^.cap*2;

IF n=0 THEN n:=8 END;

IF NOT Reserve(v,n)THEN RETURN FALSE END END;

p:=Slot(v^.data,v^.len);

p^:=val;

INC(v^.len);

RETURN TRUE END Push;

PROCEDURE Pop(v:Vector;

VAR val:CARDINAL):BOOLEAN;

VAR p:POINTER TO CARDINAL;

BEGIN IF(v=NIL)OR(v^.len=0)THEN ReportError(ErrUnderflow,"Vector.Pop");

RETURN FALSE END;

DEC(v^.len);

p:=Slot(v^.data,v^.len);

val:=p^;

RETURN TRUE END Pop;

PROCEDURE Get(v:Vector;

idx:CARDINAL;

VAR val:CARDINAL):BOOLEAN;

VAR p:POINTER TO CARDINAL;

BEGIN IF(v=NIL)OR(idx>=v^.len)THEN ReportError(ErrIndexOutOfBounds,"Vector.Get");

RETURN FALSE END;

p:=Slot(v^.data,idx);

val:=p^;

RETURN TRUE END Get;

PROCEDURE Set(v:Vector;

idx,val:CARDINAL):BOOLEAN;

VAR p:POINTER TO CARDINAL;

BEGIN IF(v=NIL)OR(idx>=v^.len)THEN ReportError(ErrIndexOutOfBounds,"Vector.Set");

RETURN FALSE END;

p:=Slot(v^.data,idx);

p^:=val;

RETURN TRUE END Set;

PROCEDURE Size(v:Vector):CARDINAL;

BEGIN IF v=NIL THEN RETURN 0 ELSE RETURN v^.len END END Size;

PROCEDURE Capacity(v:Vector):CARDINAL;

BEGIN IF v=NIL THEN RETURN 0 ELSE RETURN v^.cap END END Capacity;

PROCEDURE Clear(v:Vector);

BEGIN IF v#NIL THEN v^.len:=0 END END Clear;

PROCEDURE IsEmpty(v:Vector):BOOLEAN;

BEGIN RETURN(v=NIL)OR(v^.len=0)END IsEmpty;

END M2Vector.
