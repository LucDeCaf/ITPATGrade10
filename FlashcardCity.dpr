program FlashcardCity;

uses
  Vcl.Forms,
  uMainMenu in 'uMainMenu.pas' {frmMainMenu},
  uStudy in 'uStudy.pas' {frmStudy},
  uAdd in 'uAdd.pas' {frmAdd},
  uInfo in 'uInfo.pas' {frmInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmStudy, frmStudy);
  Application.CreateForm(TfrmAdd, frmAdd);
  Application.CreateForm(TfrmInfo, frmInfo);
  Application.Run;
end.
