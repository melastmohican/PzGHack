unit About;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, LMessages, Classes, Forms, Controls, StdCtrls,
  Buttons, Dialogs, ExtCtrls;

type
  TAboutBox = class(TForm)
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.lfm}

end.

