
{*******************************************************}
{                                                       }
{       Mordor Common Class                             }
{                                                       }
{       Copyright (c) 1997 Mordor                       }
{                                                       }
{*******************************************************}

unit VerInfo;

{$R-}

interface

uses Windows, Classes;

type
  TVerInfo = class(TObject)
  private
    FFileName: string;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function GetCompany(var compName: String): Boolean;
    function GetCopyright(var copyright: String): Boolean;
    function GetFileDescription(var fileDesc: String): Boolean;
    function GetFileVersion(var fileVer: String): Boolean;
    function GetInternalName(var intName: String): Boolean;
    function GetOriginalName(var orgName: String): Boolean;
    function GetProductName(var prodName: String): Boolean;
    function GetProductVersion(var prodVer: String): Boolean;
    function GetSpecial(var specialBuild: String): Boolean;
    property FileName: string read FFileName;
  protected
   TransBlock: Pointer;
   FVData: PByte;
   LangChar: DWORD;
  end;

const
  VER_TRANS    = '\\VarFileInfo\\Translation';
  VER_STRINF   = '\\StringFileInfo\\%8.8x\\%s';
  VER_COMPNAME = 'CompanyName';
  VER_FILEDES  = 'FileDescription';
  VER_FILEVER  = 'FileVersion';
  VER_INTNAME  = 'InternalName';
  VER_LEGAL    = 'LegalCopyright';
  VER_ORIGNAME = 'OriginalFilename';
  VER_PRODNAME = 'ProductName';
  VER_PRODVER  = 'ProductVersion';
  VER_SPECIAL  = 'SpecialBuild';


implementation
uses SysUtils, Forms, Consts;

constructor TVerInfo.Create(const FileName: string);
var
 filName,subBlockName: Array[0..255] of Char;
 fvHandle: DWORD;
 vSize: UINT;
 dwSize: DWORD;
begin
 if FileName <> '' then
  FFileName := FileName
 else
  FFileName := Application.ExeName;
 StrPCopy(filName,FFileName);
 dwSize := GetFileVersionInfoSize(filName,fvHandle);
 if dwSize > 0 then
  begin
   FVData := PByte(StrAlloc(dwSize));
   if GetFileVersionInfo(filName,fvHandle,dwSize,FVData) then
    begin
     StrCopy(subBlockName,VER_TRANS);
     //function VerQueryValue(pBlock: Pointer; lpSubBlock: PChar;
     //  var lplpBuffer: Pointer; var puLen: UINT): BOOL; stdcall;
     if not VerQueryValue(FVData, subBlockName, TransBlock, vSize) then
      begin
       StrDispose(PChar(FVData));
       FVData := nil;
      end
     else
      LangChar := MAKELONG(HIWORD(DWORD(TransBlock^)),LOWORD(DWORD(TransBlock^)));
    end;
  end;
end;

destructor TVerInfo.Destroy;
begin
  if Assigned(FVData) then
   begin
    StrDispose(PChar(FVData));
    FVData := nil;
   end;
  inherited;
end;

function TVerInfo.GetCompany(var compName: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_COMPNAME)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   compName := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

function TVerInfo.GetCopyright(var copyright: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_LEGAL)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   copyright := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

function TVerInfo.GetFileDescription(var fileDesc: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_FILEDES)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   fileDesc := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

function TVerInfo.GetFileVersion(var fileVer: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_FILEVER)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   fileVer := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

function TVerInfo.GetInternalName(var intName: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_INTNAME)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   intName := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;
function TVerInfo.GetOriginalName(var orgName: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_ORIGNAME)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   orgName := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

function TVerInfo.GetProductName(var prodName: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_PRODNAME)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   prodName := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

function TVerInfo.GetProductVersion(var prodVer: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_PRODVER)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   prodVer := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

function TVerInfo.GetSpecial(var specialBuild: String): Boolean;
var
 vSize: UINT;
 subBlockName: array[0..255] of Char;
 pname: Pointer;
begin
 StrFmt(subBlockName,VER_STRINF,[LangChar,PChar(VER_SPECIAL)]);
 if VerQueryValue(FVData, subBlockName, pname, vSize) then
  begin
   specialBuild := StrPas(PChar(pname));
   result := True;
  end
 else
  result := False;
end;

end.
