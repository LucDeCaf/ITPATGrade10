unit uInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmInfo = class(TForm)
    bbnBack: TBitBtn;
    procedure bbnBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfo: TfrmInfo;

implementation

uses
  uMainMenu;

{$R *.dfm}

procedure TfrmInfo.bbnBackClick(Sender: TObject);
begin
  frmInfo.Hide;
  frmMainMenu.Show;
end;

procedure TfrmInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMainMenu.Close;
end;

end.
