IMPLEMENTATION MODULE M2Queue;

FROM M2Errors IMPORT ReportError,ErrOutOfMemory,ErrUnderflow,ErrOverflow;

PROCEDURE Create(capacity:CARDINAL):Queue;

VAR q:Queue;

BEGIN IF capacity=0 THEN capacity:=16 END;

NEW(q);

IF q=NIL THEN ReportError(ErrOutOfMemory,"Queue");

RETURN NIL END;

NEW(q^.data,capacity);

IF q^.data=NIL THEN DISPOSE(q);

ReportError(ErrOutOfMemory,"Queue data");

RETURN NIL END;

q^.cap:=capacity;

q^.head:=0;

q^.len:=0;

RETURN q END Create;

PROCEDURE Destroy(VAR q:Queue);

BEGIN IF q#NIL THEN IF q^.data#NIL THEN DISPOSE(q^.data)END;

DISPOSE(q);

q:=NIL END END Destroy;

PROCEDURE Enqueue(q:Queue;

value:CARDINAL):BOOLEAN;

VAR t:CARDINAL;

BEGIN IF q=NIL THEN RETURN FALSE END;

IF q^.len=q^.cap THEN ReportError(ErrOverflow,"Queue full");

RETURN FALSE END;

t:=(q^.head+q^.len)MOD q^.cap;

q^.data^[t]:=value;

INC(q^.len);

RETURN TRUE END Enqueue;

PROCEDURE Dequeue(q:Queue;

VAR value:CARDINAL):BOOLEAN;

BEGIN IF(q=NIL)OR(q^.len=0)THEN ReportError(ErrUnderflow,"Queue.Dequeue");

RETURN FALSE END;

value:=q^.data^[q^.head];

q^.head:=(q^.head+1)MOD q^.cap;

DEC(q^.len);

RETURN TRUE END Dequeue;

PROCEDURE Front(q:Queue;

VAR value:CARDINAL):BOOLEAN;

BEGIN IF(q=NIL)OR(q^.len=0)THEN RETURN FALSE END;

value:=q^.data^[q^.head];

RETURN TRUE END Front;

PROCEDURE Size(q:Queue):CARDINAL;

BEGIN IF q=NIL THEN RETURN 0 ELSE RETURN q^.len END END Size;

PROCEDURE IsEmpty(q:Queue):BOOLEAN;

BEGIN RETURN(q=NIL)OR(q^.len=0)END IsEmpty;

PROCEDURE Clear(q:Queue);

BEGIN IF q#NIL THEN q^.head:=0;

q^.len:=0 END END Clear;

END M2Queue.
