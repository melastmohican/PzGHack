unit About;

interface

uses Windows, Classes, Forms, Controls, StdCtrls,
  Buttons, Dialogs, ExtCtrls, VerInfo;

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

{$R *.DFM}
uses Mapi;

procedure TAboutBox.FormCreate(Sender: TObject);
var
 vi: TVerInfo;
 temp: string;
begin
 vi := TVerInfo.Create('');
 vi.GetProductName(temp);
 ProductName.Caption := temp;
 ProductNameHighlight.Caption := temp;
 ProductNameShadow.Caption := temp;
 vi.GetFileDescription(temp);
 FileDescription.Caption := temp;
 vi.GetProductVersion(temp);
 Version.Caption := temp;
 vi.GetCopyright(temp);
 Copyright.Caption := temp;
 vi.Destroy;
end;

end.

