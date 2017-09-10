
Unit About;

{$MODE Delphi}

Interface

Uses LCLIntf, LCLType, LMessages, Classes, Forms, Controls, StdCtrls,
Buttons, Dialogs, ExtCtrls;

Type 
  TAboutBox = Class(TForm)
    Panel1: TPanel;
    OKButton: TButton;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    Label1: TLabel;
    FileDescription: TLabel;
    ProductName: TLabel;
    ProductNameShadow: TLabel;
    ProductNameHighlight: TLabel;

    Private 
    { Private declarations }
    Public 
    { Public declarations }
  End;

Var 
  AboutBox: TAboutBox;

Implementation

{$R *.lfm}

End.
