IMPLEMENTATION MODULE M2Random;

VAR state:CARDINAL;

PROCEDURE Seed(value:CARDINAL);

BEGIN state:=value;

IF state=0 THEN state:=2463534242 END END Seed;

PROCEDURE Next():CARDINAL;

BEGIN state:=state XOR (state*8192);

state:=state XOR (state DIV 131072);

state:=state XOR (state*32);

RETURN state END Next;

PROCEDURE NextRange(lo,hi:CARDINAL):CARDINAL;

BEGIN IF hi<=lo THEN RETURN lo END;

RETURN lo+Next()MOD(hi-lo+1)END NextRange;

PROCEDURE NextReal():REAL;

BEGIN RETURN FLOAT(Next())/FLOAT(MAX(CARDINAL))END NextReal;

BEGIN state:=2463534242 END M2Random.
