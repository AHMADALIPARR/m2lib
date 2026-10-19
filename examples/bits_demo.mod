(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE bits_demo;
FROM M2BitSet IMPORT Bits, Empty, SetBit, ClearBit, TestBit, CountBits, Union, Intersection;
FROM M2Heap IMPORT HeapSort, IsHeap;
FROM M2Random IMPORT Seed, NextRange, NextReal;
VAR a, b, u, i: Bits; arr: ARRAY [0..4] OF CARDINAL; r: CARDINAL; x: REAL;
BEGIN
  a:=Empty();
  IF CountBits(a)#0 THEN HALT(1) END;
  SetBit(a,1); SetBit(a,2);
  IF NOT TestBit(a,1) THEN HALT(2) END;
  IF TestBit(a,3) THEN HALT(3) END;
  IF CountBits(a)#2 THEN HALT(4) END;
  ClearBit(a,1);
  IF TestBit(a,1) THEN HALT(5) END;
  IF CountBits(a)#1 THEN HALT(6) END;
  b:=Empty(); SetBit(b,2); SetBit(b,3);
  u:=Union(a,b);
  IF CountBits(u)#2 THEN HALT(7) END;
  i:=Intersection(a,b);
  IF CountBits(i)#1 THEN HALT(8) END;
  IF NOT TestBit(i,2) THEN HALT(9) END;
  arr[0]:=9; arr[1]:=5; arr[2]:=6; arr[3]:=1; arr[4]:=4;
  IF NOT IsHeap(arr) THEN HALT(10) END;
  arr[0]:=3; arr[1]:=1; arr[2]:=2; arr[3]:=0; arr[4]:=0;
  HeapSort(arr);
  IF (arr[0]#0) OR (arr[4]#3) THEN HALT(11) END;
  Seed(1);
  r:=NextRange(5,5);
  IF r#5 THEN HALT(12) END;
  r:=NextRange(10,20);
  IF (r<10) OR (r>20) THEN HALT(13) END;
  x:=NextReal();
  IF (x<0.0) OR (x>1.0) THEN HALT(14) END;
END bits_demo.
