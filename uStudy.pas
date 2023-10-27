unit uStudy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls;

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
    redStats: TRichEdit;
    procedure updateStatsheet;
    procedure resetAll;
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
  iTermsKnown, iTermsUnknown, iRounds: Integer;

implementation

uses
  uMainMenu, uAdd;

{$R *.dfm}

procedure TfrmStudy.FormActivate(Sender: TObject);
var
  i: Integer;
  sFlashcardId: String;
begin
  // Re-initialise everything
  resetAll;

  if not FileExists('flashcard_ids.txt') then
  begin
    ShowMessage('Error loading flashcards. Please re-open application.');
    frmMainMenu.Close;
  end;

  cmbSet.Items.Clear;
  for i := 0 to frmMainMenu.flashcardIds.Count - 1 do
  begin
    sFlashcardId := Copy(frmMainMenu.flashcardIds[i],
      frmMainMenu.flashcardIds[i].IndexOf(',') + 2,
      frmMainMenu.flashcardIds[i].Length);
    cmbSet.Items.Add(sFlashcardId);
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
var
  bConfirmed: Bool;
begin
  bConfirmed := MessageDlg
    ('Warning: If you leave now, all unsaved changes will be deleted. Continue exiting?',
    mtWarning, mbOKCancel, 0) = mrOK;

  if bConfirmed then
  begin
    frmStudy.Hide;
    frmMainMenu.Show;
  end;
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

    Inc(iRounds);
  end;

  updateStatsheet;

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

    Inc(iRounds);

    if terms.Count = 0 then
    begin
      ShowMessage('You have successfully memorised all terms!' + sLineBreak +
        'Rounds taken: ' + IntToStr(iRounds));

      resetAll;

      Exit;
    end;

    iSelectedTermIndex := -1;
  end;

  Inc(iTermsKnown);
  Dec(iTermsUnknown);

  updateStatsheet;

  Inc(iSelectedTermIndex);
  pnlFlashcard.Caption := terms[iSelectedTermIndex];

  bShowingTerm := true;
end;

procedure TfrmStudy.btnLoadClick(Sender: TObject);
var
  sBackendSetName: String;
  loadedTerms: TStringList;
begin
  sBackendSetName := frmAdd.ConvertToValidFileName(cmbSet.Text);

  if not FileExists('flashcards\' + sBackendSetName) then
  begin
    ShowMessage('Could not find file with name "' + cmbSet.Text + '"');
    Exit;
  end;

  loadedTerms := TStringList.Create;
  loadedTerms.LoadFromFile('flashcards\' + sBackendSetName);

  sLoadedSetName := cmbSet.Text;

  for var i := 0 to loadedTerms.Count - 1 do
  begin
    if i mod 2 = 0 then
      terms.Add(loadedTerms[i])
    else
      definitions.Add(loadedTerms[i]);
  end;

  iRounds := 0;
  iTermsKnown := 0;
  iTermsUnknown := terms.Count;

  pnlSetName.Caption := Copy(frmMainMenu.flashcardIds[cmbSet.ItemIndex],
    frmMainMenu.flashcardIds[cmbSet.ItemIndex].IndexOf(',') + 2);

  iSelectedTermIndex := 0;

  bShowingTerm := true;
  bTermsLoaded := true;

  pnlFlashcard.Caption := terms[iSelectedTermIndex];
end;

procedure TfrmStudy.updateStatsheet;
begin
  redStats.Lines.Clear;
  redStats.Lines.Add(sLineBreak);
  redStats.Lines.Add('-- Stats --');
  redStats.Lines.Add('Rounds: ' + IntToStr(iRounds));
  redStats.Lines.Add('Known: ' + IntToStr(iTermsKnown));
  redStats.Lines.Add('Unknown: ' + IntToStr(iTermsUnknown));
end;

procedure TfrmStudy.resetAll;
begin
  terms := TStringList.Create;
  definitions := TStringList.Create;
  unknownTerms := TStringList.Create;
  unknownDefinitions := TStringList.Create;
  sLoadedSetName := '';
  iSelectedTermIndex := 0;
  bShowingTerm := true;
  bTermsLoaded := false;
  pnlFlashcard.Caption := 'Select a set';
  pnlSetName.Caption := 'Select a set';
  cmbSet.Text := 'Select a set...';
  redStats.Lines.Clear;
  redStats.Lines.AddStrings([sLineBreak, '-- Stats --', 'Rounds: N/A',
    'Known: N/A', 'Unknown: N/A']);
  cmbSet.SetFocus;
end;

end.
