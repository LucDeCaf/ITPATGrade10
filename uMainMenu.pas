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

implementation

uses
  uStudy, uAdd;

{$R *.dfm}

procedure TfrmMainMenu.bbnExitClick(Sender: TObject);
begin
  frmMainMenu.Close;
end;

procedure TfrmMainMenu.bbnInfoClick(Sender: TObject);
var
  sUrl: String;
begin
  sUrl := 'https://flashcard-city.netlify.app/';
  sUrl := StringReplace(sUrl, '"', '%22', [rfReplaceAll]);
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
end;

end.
