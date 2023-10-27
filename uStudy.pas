unit uStudy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmStudy = class(TForm)
    bbnBack: TBitBtn;
    cmbSet: TComboBox;
    pnlSetName: TPanel;
    pnlFlashcard: TPanel;
    bbnNo: TBitBtn;
    bbnYes: TBitBtn;
    btnLoad: TButton;
    bbnReset: TBitBtn;
    procedure bbnBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure bbnYesClick(Sender: TObject);
    procedure pnlFlashcardClick(Sender: TObject);
    procedure bbnNoClick(Sender: TObject);
    procedure bbnResetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStudy: TfrmStudy;

  terms, definitions: TStringList;
  unknownTerms, unknownDefinitions: TStringList;

  iSelectedTermIndex: Integer = 0;

  bShowingTerm, bTermsLoaded: Bool;

  sLoadedSetName: String;

implementation

uses
  uMainMenu;

{$R *.dfm}

procedure TfrmStudy.FormActivate(Sender: TObject);
var
  i: Integer;
  sFlashcardId: String;
begin
  terms := TStringList.Create;
  definitions := TStringList.Create;
  unknownTerms := TStringList.Create;
  unknownDefinitions := TStringList.Create;

  if not FileExists('flashcard_ids.txt') then
  begin
    ShowMessage('Error loading flashcards. Please re-open application.');
    frmMainMenu.Close;
  end;

  if cmbSet.Items.Count = 0 then
  begin
    for i := 0 to frmMainMenu.flashcardIds.Count - 1 do
    begin
      sFlashcardId := Copy(frmMainMenu.flashcardIds[i], 0,
        frmMainMenu.flashcardIds[i].IndexOf(','));
      cmbSet.Items.Add(sFlashcardId);
    end;
  end;
end;

procedure TfrmStudy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMainMenu.Close;
end;

procedure TfrmStudy.pnlFlashcardClick(Sender: TObject);
begin
  if not bTermsLoaded then
    Exit;

  if bShowingTerm then
    pnlFlashcard.Caption := definitions[iSelectedTermIndex]
  else
    pnlFlashcard.Caption := terms[iSelectedTermIndex];

  bShowingTerm := not bShowingTerm;
end;

procedure TfrmStudy.bbnBackClick(Sender: TObject);
begin
  frmStudy.Hide;
  frmMainMenu.Show;
end;

procedure TfrmStudy.bbnNoClick(Sender: TObject);
begin
  if not bTermsLoaded then
    Exit;

  unknownTerms.Add(terms[iSelectedTermIndex]);
  unknownDefinitions.Add(definitions[iSelectedTermIndex]);

  if iSelectedTermIndex = terms.Count - 1 then
  begin
    terms.Assign(unknownTerms);
    unknownTerms.Clear;

    definitions.Assign(unknownDefinitions);
    unknownDefinitions.Clear;

    iSelectedTermIndex := -1;
  end;

  Inc(iSelectedTermIndex);
  pnlFlashcard.Caption := terms[iSelectedTermIndex];

  bShowingTerm := true;
end;

procedure TfrmStudy.bbnResetClick(Sender: TObject);
begin
  cmbSet.Text := sLoadedSetName;
  btnLoadClick(Sender);
end;

procedure TfrmStudy.bbnYesClick(Sender: TObject);
begin
  if not bTermsLoaded then
    Exit;

  if iSelectedTermIndex = terms.Count - 1 then
  begin
    terms.Assign(unknownTerms);
    unknownTerms.Clear;

    definitions.Assign(unknownDefinitions);
    unknownDefinitions.Clear;

    if terms.Count = 0 then
    begin
      ShowMessage('You have successfully memorised all terms!');
      pnlFlashcard.Caption := 'Select a set';
      pnlSetName.Caption := 'Select a set';

      bTermsLoaded := false;

      btnLoad.SetFocus;
      Exit;
    end;

    iSelectedTermIndex := -1;
  end;

  Inc(iSelectedTermIndex);
  pnlFlashcard.Caption := terms[iSelectedTermIndex];

  bShowingTerm := true;
end;

procedure TfrmStudy.btnLoadClick(Sender: TObject);
var
  loadedTerms: TStringList;
begin
  if not FileExists('flashcards\' + cmbSet.Text) then
  begin
    ShowMessage('Could not find file with name "' + cmbSet.Text + '"');
    Exit;
  end;

  loadedTerms := TStringList.Create;
  loadedTerms.LoadFromFile('flashcards\' + cmbSet.Text);

  sLoadedSetName := cmbSet.Text;

  for var i := 0 to loadedTerms.Count - 1 do
  begin
    if i mod 2 = 0 then
      terms.Add(loadedTerms[i])
    else
      definitions.Add(loadedTerms[i]);
  end;

  pnlSetName.Caption := Copy(frmMainMenu.flashcardIds[cmbSet.ItemIndex],
    frmMainMenu.flashcardIds[cmbSet.ItemIndex].IndexOf(',') + 2);

  iSelectedTermIndex := 0;

  bShowingTerm := true;
  bTermsLoaded := true;

  pnlFlashcard.Caption := terms[iSelectedTermIndex];
end;

end.
