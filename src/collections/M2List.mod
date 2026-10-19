IMPLEMENTATION MODULE M2List;

FROM M2Errors IMPORT ReportError,ErrOutOfMemory,ErrUnderflow;

PROCEDURE Create():List;

BEGIN RETURN NIL END Create;

PROCEDURE Destroy(VAR l:List);

VAR p:List;

BEGIN WHILE l#NIL DO p:=l;

l:=l^.next;

DISPOSE(p)END END Destroy;

PROCEDURE Prepend(VAR l:List;

value:CARDINAL):BOOLEAN;

VAR p:List;

BEGIN NEW(p);

IF p=NIL THEN ReportError(ErrOutOfMemory,"List.Prepend");

RETURN FALSE END;

p^.value:=value;

p^.next:=l;

l:=p;

RETURN TRUE END Prepend;

PROCEDURE Append(VAR l:List;

value:CARDINAL):BOOLEAN;

VAR p,q:List;

BEGIN NEW(p);

IF p=NIL THEN ReportError(ErrOutOfMemory,"List.Append");

RETURN FALSE END;

p^.value:=value;

p^.next:=NIL;

IF l=NIL THEN l:=p ELSE q:=l;

WHILE q^.next#NIL DO q:=q^.next END;

q^.next:=p END;

RETURN TRUE END Append;

PROCEDURE RemoveFirst(VAR l:List;

VAR value:CARDINAL):BOOLEAN;

VAR p:List;

BEGIN IF l=NIL THEN ReportError(ErrUnderflow,"List.RemoveFirst");

RETURN FALSE END;

p:=l;

value:=p^.value;

l:=p^.next;

DISPOSE(p);

RETURN TRUE END RemoveFirst;

PROCEDURE Length(l:List):CARDINAL;

VAR n:CARDINAL;

BEGIN n:=0;

WHILE l#NIL DO INC(n);

l:=l^.next END;

RETURN n END Length;

PROCEDURE Contains(l:List;

value:CARDINAL):BOOLEAN;

BEGIN WHILE l#NIL DO IF l^.value=value THEN RETURN TRUE END;

l:=l^.next END;

RETURN FALSE END Contains;

END M2List.
