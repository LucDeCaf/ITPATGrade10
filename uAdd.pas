unit uAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmAdd = class(TForm)
    bbnBack: TBitBtn;
    lblTerms: TLabel;
    lblSetName: TLabel;
    lblTerm: TLabel;
    edtTerm: TEdit;
    lblTermDefinition: TLabel;
    edtDefinition: TEdit;
    btnAddTerm: TButton;
    lblEdit: TLabel;
    bbnDelete: TBitBtn;
    bbnModify: TBitBtn;
    bbnSave: TBitBtn;
    bbnDeleteAll: TBitBtn;
    lsbSampleTerms: TListBox;
    cmbSelectedTerm: TComboBox;
    btnLoad: TButton;
    cmbSetName: TComboBox;
    lblSetNameHelper: TLabel;
    procedure bbnBackClick(Sender: TObject);
    procedure AddTerm(term, definition: String);
    procedure btnAddTermClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbnModifyClick(Sender: TObject);
    procedure bbnDeleteClick(Sender: TObject);
    procedure bbnDeleteAllClick(Sender: TObject);
    procedure bbnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure cmbSetNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdd: TfrmAdd;
  termDict: TDictionary<String, String>;

implementation

uses
  uMainMenu, uStudy;

{$R *.dfm}

function ConvertToValidFileName(name: String): String;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to name.Length do
  begin
    if name[i] = ' ' then
    begin
      Result := Result + '_';
    end

    else if CharInSet(name[i], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_', '-'])
    then
    begin
      Result := Result + name[i];
    end;
  end;

  Result := Result.ToLower;
  Result := Result + '.txt';
end;

procedure TfrmAdd.AddTerm(term, definition: String);
var
  sSampleTerm, sSampleDefinition: String;

begin
  termDict.Add(term, definition);
  cmbSelectedTerm.Items.Add(term);

  sSampleTerm := term;
  sSampleDefinition := '- ' + definition;

  if sSampleTerm.Length > 25 then
  begin
    SetLength(sSampleTerm, 22);
    sSampleTerm := sSampleTerm + '...';
  end;

  if sSampleDefinition.Length > 25 then
  begin
    SetLength(sSampleDefinition, 22);
    sSampleDefinition := sSampleDefinition + '...';
  end;

  lsbSampleTerms.Items.Add(sSampleTerm);
  lsbSampleTerms.Items.Add(sSampleDefinition);
end;

procedure TfrmAdd.bbnBackClick(Sender: TObject);
begin
  frmAdd.Hide;
  frmMainMenu.Show;
end;

procedure TfrmAdd.bbnDeleteAllClick(Sender: TObject);
begin
  edtTerm.Text := '';
  edtDefinition.Text := '';
  lsbSampleTerms.Items.Clear;
  cmbSelectedTerm.Items.Clear;
  cmbSelectedTerm.Text := '';

  termDict := TDictionary<string, string>.Create;

  edtTerm.SetFocus;
end;

procedure TfrmAdd.bbnDeleteClick(Sender: TObject);
var
  sTerm: String;
  iSampleTermIndex: Integer;
begin
  sTerm := cmbSelectedTerm.Text;

  if termDict.ContainsKey(sTerm) then
  begin
    termDict.Remove(sTerm);

    iSampleTermIndex := lsbSampleTerms.Items.IndexOf(sTerm);

    lsbSampleTerms.Items.Delete(iSampleTermIndex);
    lsbSampleTerms.Items.Delete(iSampleTermIndex);

    cmbSelectedTerm.Items.Delete(cmbSelectedTerm.Items.IndexOf(sTerm));

    edtTerm.SetFocus;
  end;
end;

procedure TfrmAdd.bbnModifyClick(Sender: TObject);
var
  sTerm: String;
  sNewDefinition: String;
begin
  sTerm := cmbSelectedTerm.Text;
  sTerm := sTerm.Trim;

  if termDict.ContainsKey(sTerm) then
  begin
    sNewDefinition := InputBox('Modify a term',
      'Enter the new term definition: ' + sLineBreak + 'Old definition: ' +
      termDict[sTerm], '');
    sNewDefinition := sNewDefinition.Trim;

    if sNewDefinition.Length <= 200 then
    begin
      termDict[sTerm] := sNewDefinition;
      lsbSampleTerms.Items[lsbSampleTerms.Items.IndexOf(sTerm) + 1] :=
        '- ' + sNewDefinition;
    end

    else
    begin
      ShowMessage('Invalid input: Too long');
    end;
  end;
end;

procedure TfrmAdd.bbnSaveClick(Sender: TObject);
var
  sSetName, sBackendSetName: String;
  i: Integer;
  terms: TStringList;
  sFlashcardId: String;

begin
  sSetName := cmbSetName.Text;
  sSetName := sSetName.Trim;

  // Validation
  if sSetName.Length > 250 then
  begin
    ShowMessage('Set name too long');
    Exit;
  end;

  // Convert to valid standardised file name
  sBackendSetName := ConvertToValidFileName(sSetName);

  // Save file
  terms := TStringList.Create;

  for var pair in termDict do
  begin
    terms.Add(pair.Key);
    terms.Add(pair.Value);
  end;

  // Handle empty termDict
  if (terms.Count = 0) then
  begin

    if FileExists('flashcards\' + sBackendSetName) then
    begin
      if not(cmbSetName.Items.IndexOf(sSetName) <> -1) then
      begin
        Exit;
      end;

      DeleteFile('flashcards\' + sBackendSetName);

      terms.Free;

      // Note: Using cmbSetName.Items[cmbSetName.ItemIndex] instead of sSetName
      // to ensure correct capitalisation
      frmMainMenu.flashcardIds.Delete
        (frmMainMenu.flashcardIds.IndexOf(sBackendSetName + ',' +
        cmbSetName.Items[cmbSetName.ItemIndex]));

      frmMainMenu.flashcardIds.SaveToFile('flashcard_ids.txt');

      ShowMessage('Successfully deleted set "' + sBackendSetName + '"');

      // Clean up
      bbnDeleteAllClick(Sender);
      FormActivate(Sender);
      bbnBackClick(Sender);
      lblSetNameHelper.Visible := false;
      cmbSetName.Text := '';

      Exit;
    end

    else
    begin
      ShowMessage
        ('Cannot save an empty set. If you are trying to delete a flashcard set, please select the set from the combo box first.');
    end;
  end

  else
  begin
    try
      terms.SaveToFile('flashcards\' + sBackendSetName);
    finally
      terms.Free;
    end;

    // Update flashcardIds and flashcard_ids.txt
    if FileExists('flashcards\' + sBackendSetName) then
    begin
      frmStudy.cmbSet.Items.Clear;

      for i := 0 to frmMainMenu.flashcardIds.Count - 1 do
      begin
        sFlashcardId := Copy(frmMainMenu.flashcardIds[i], 0,
          frmMainMenu.flashcardIds[i].IndexOf(','));
        frmStudy.cmbSet.Items.Add(sFlashcardId);
      end;
    end
    else
    begin
      frmMainMenu.flashcardIds.Add(sBackendSetName + ',' + sSetName);
    end;
  end;

  try
    frmMainMenu.flashcardIds.SaveToFile('flashcard_ids.txt');
    ShowMessage('Set successfully saved.');
  finally
    bbnDeleteAllClick(Sender);
    bbnBackClick(Sender);
  end;
end;

procedure TfrmAdd.btnAddTermClick(Sender: TObject);
var
  bIsValid: Bool;
  sTerm, sDefinition: String;
  sSampleTerm, sSampleDefinition: String;
begin
  sTerm := edtTerm.Text;
  sDefinition := edtDefinition.Text;

  sTerm := sTerm.Trim;
  sDefinition := sDefinition.Trim;

  // Validation
  if termDict.ContainsKey(sTerm) then
  begin
    Exit;
  end

  else if (sTerm = '') or (sDefinition = '') then
  begin
    Exit;
  end

  else if (sTerm.Length > 50) or (sDefinition.Length > 200) then
  begin
    Exit;
  end;

  AddTerm(sTerm, sDefinition);

  edtTerm.Text := '';
  edtDefinition.Text := '';
  edtTerm.SetFocus;
end;

procedure TfrmAdd.btnLoadClick(Sender: TObject);
var
  sSetName, sBackendSetName: String;
  loadedTerms: TStringList;
  sTerm: String;
  i: Integer;
begin
  sSetName := cmbSetName.Text;
  sBackendSetName := ConvertToValidFileName(sSetName);

  if not FileExists('flashcards\' + sBackendSetName) then
  begin
    ShowMessage('Could not locate flashcard set with name "' + sSetName +
      '" - please ensure you spelled the set name correctly.');
    Exit;
  end;

  loadedTerms := TStringList.Create;

  try
    loadedTerms.LoadFromFile('flashcards\' + sBackendSetName);

    termDict.Clear;

    for i := 0 to loadedTerms.Count - 1 do
    begin
      // Store term name
      if i mod 2 = 0 then
      begin
        sTerm := loadedTerms[i];
      end

      // Save term name w/ definition
      else
      begin
        AddTerm(sTerm, loadedTerms[i]);
      end;
    end;
  finally
    loadedTerms.Free
  end;

  edtTerm.SetFocus;
end;

procedure TfrmAdd.cmbSetNameChange(Sender: TObject);
begin
  lblSetNameHelper.Visible :=
    FileExists('flashcards\' + ConvertToValidFileName(cmbSetName.Text));
end;

procedure TfrmAdd.FormActivate(Sender: TObject);
var
  loadedSetNames: TStringList;
  sName: String;
begin
  termDict := TDictionary<String, String>.Create;
  loadedSetNames := TStringList.Create;
  cmbSetName.Items.Clear;

  try
    loadedSetNames.LoadFromFile('flashcard_ids.txt');

    for var item in loadedSetNames do
    begin
      sName := item.Remove(0, item.IndexOf(',') + 1);
      cmbSetName.Items.Add(sName);
    end;
  finally
    loadedSetNames.Free;
  end;
end;

procedure TfrmAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMainMenu.Close;
end;

end.
