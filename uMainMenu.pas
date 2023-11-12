unit uMainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellAPI,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmMainMenu = class(TForm)
    btnStudy: TButton;
    btnAdd: TButton;
    pnlTitle: TPanel;
    bbnExit: TBitBtn;
    bbnInfo: TBitBtn;
    procedure btnStudyClick(Sender: TObject);
    procedure bbnExitClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CreateEmptyTextFile(sName: String);
    procedure bbnInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    flashcardIds: TStringList;
  end;

var
  frmMainMenu: TfrmMainMenu;
  clPrimary, clSecondary, clLight, clDark: TColor;

implementation

uses
  uStudy, uAdd;

{$R *.dfm}

procedure TfrmMainMenu.bbnExitClick(Sender: TObject);
var
  bConfirmed: Bool;
begin
  // frmMainMenu.Close;

  bConfirmed := MessageDlg('Are you sure you would like to exit?', mtWarning,
    mbOKCancel, 0) = mrOK;

  if bConfirmed then
    Exit;
end;

procedure TfrmMainMenu.bbnInfoClick(Sender: TObject);
var
  sUrl: String;
begin
  sUrl := 'https://flashcard-city.netlify.app/';
  ShellExecute(0, 'open', PChar(sUrl), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMainMenu.btnAddClick(Sender: TObject);
begin
  frmAdd.Show;
  frmMainMenu.Hide;
end;

procedure TfrmMainMenu.btnStudyClick(Sender: TObject);
begin
  frmStudy.Show;
  frmMainMenu.Hide;
end;

procedure TfrmMainMenu.CreateEmptyTextFile(sName: String);
var
  emptyList: TStringList;
begin
  emptyList := TStringList.Create;

  try
    emptyList.SaveToFile(sName);
  finally
    emptyList.Free;
  end;
end;

procedure TfrmMainMenu.FormActivate(Sender: TObject);
begin
  // Load flashcard IDs from file
  flashcardIds := TStringList.Create;

  if FileExists('flashcard_ids.txt') then
  begin
    flashcardIds.LoadFromFile('flashcard_ids.txt');
  end
  else
  begin
    CreateEmptyTextFile('flashcard_ids.txt');
  end;

  // Create flashcards folder
  if not DirectoryExists('flashcards') then
  begin
    CreateDir('flashcards');
  end;

  // Load colours
  clPrimary := RGB(91, 133, 170);
  clSecondary := RGB(165, 190, 0);
  clLight := RGB(235, 242, 250);
  clDark := RGB(0, 5, 0);

  frmMainMenu.Color := clPrimary;
  uAdd.frmAdd.Color := clPrimary;
  uStudy.frmStudy.Color := clPrimary;

  pnlTitle.Color := clLight;
  uStudy.frmStudy.pnlSetName.Color := clLight;
  uStudy.frmStudy.pnlFlashcard.Color := clLight;

  pnlTitle.ParentBackground := False;
  uStudy.frmStudy.pnlSetName.ParentBackground := False;
  uStudy.frmStudy.pnlFlashcard.ParentBackground := False;
end;

end.
