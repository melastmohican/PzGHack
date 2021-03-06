
Unit PGUnit;

{$MODE Delphi}

Interface

Type 
{ Common data types}
  TUnitRec = Record
    cName:               Array[0..18] Of Char;      {  0 }
    bResv1:              Byte;                      { 19 }
    bCountry:            Byte;                      { 20 }
    wUnitType:           Word;                      { 21 }
    wTransportType:      Word;                      { 23 }
    wCarrierType :       Word;                      { 25 }
    wXPos:               Word;                      { 27 }
    wYPos:               Word;                      { 29 }
    bStrength:           Byte;                      { 31 }
    bResv2:              Byte;                      { 32 }
    lVisible:            ByteBool;                  { 33 }
    bMounted :           Byte;                      { 34 }
    bFuel:               Byte;                      { 35 }
    bAmmo:               Byte;                      { 36 }
    bEntrenchment:       Byte;                      { 37 }
    bResv3:              Byte;                      { 38 }
    wExperience:         Word;                      { 39 }   { Low + High*100 }
    bMove:               Byte;                      { 41 }
    lMoved:              ByteBool;                  { 42 }
    bResv4:              Byte;                      { 43 }
    bResv5:              Byte;                      { 44 }
    bResv6:              Byte;                      { 45 }
    wKills:              Word;                      { 46 }
    bSupressed:          Byte;                      { 48 }
    iOffset:             LongInt;                   { Offset of unit in file}
  End;
  PUnitRec = ^TUnitRec;

  TPrestigeRec = Record
    Axis:       Word;
    Allies:     Word;
  End;
  PPrestigeRec = ^TPrestigeRec;

Implementation

{End of file}
End.
