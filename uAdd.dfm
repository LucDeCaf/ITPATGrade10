object frmAdd: TfrmAdd
  Left = 0
  Top = 0
  Caption = 'Flashcard City'
  ClientHeight = 462
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'JetBrains Mono'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 16
  object lblTerms: TLabel
    Left = 345
    Top = 16
    Width = 55
    Height = 25
    Caption = 'Terms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'JetBrains Mono'
    Font.Style = []
    ParentFont = False
  end
  object lblSetName: TLabel
    Left = 20
    Top = 116
    Width = 126
    Height = 16
    Caption = 'Enter the set name'
  end
  object lblTerm: TLabel
    Left = 20
    Top = 216
    Width = 28
    Height = 16
    Caption = 'Term'
  end
  object lblTermDefinition: TLabel
    Left = 160
    Top = 216
    Width = 70
    Height = 16
    Caption = 'Definition'
  end
  object lblEdit: TLabel
    Left = 20
    Top = 320
    Width = 91
    Height = 16
    Caption = 'Modify a term'
  end
  object lblSetNameHelper: TLabel
    Left = 20
    Top = 160
    Width = 133
    Height = 14
    Caption = 'Existing file found'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'JetBrains Mono'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object bbnBack: TBitBtn
    Left = 20
    Top = 20
    Width = 75
    Height = 40
    Caption = 'Back'
    Kind = bkIgnore
    NumGlyphs = 2
    TabOrder = 0
    OnClick = bbnBackClick
  end
  object edtTerm: TEdit
    Left = 20
    Top = 236
    Width = 121
    Height = 24
    ImeName = 'US'
    TabOrder = 1
  end
  object edtDefinition: TEdit
    Left = 160
    Top = 236
    Width = 121
    Height = 24
    TabOrder = 2
  end
  object btnAddTerm: TButton
    Left = 112
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Add Term'
    TabOrder = 3
    OnClick = btnAddTermClick
  end
  object bbnDelete: TBitBtn
    Left = 20
    Top = 380
    Width = 75
    Height = 25
    Caption = 'Delete'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
    OnClick = bbnDeleteClick
  end
  object bbnModify: TBitBtn
    Left = 112
    Top = 380
    Width = 75
    Height = 25
    Caption = 'Modify'
    Kind = bkRetry
    NumGlyphs = 2
    TabOrder = 5
    OnClick = bbnModifyClick
  end
  object bbnSave: TBitBtn
    Left = 385
    Top = 395
    Width = 100
    Height = 25
    Caption = 'Save'
    Kind = bkAll
    NumGlyphs = 2
    TabOrder = 6
    OnClick = bbnSaveClick
  end
  object bbnDeleteAll: TBitBtn
    Left = 385
    Top = 430
    Width = 100
    Height = 25
    Caption = 'Delete All'
    Kind = bkNo
    NumGlyphs = 2
    TabOrder = 7
    OnClick = bbnDeleteAllClick
  end
  object lsbSampleTerms: TListBox
    Left = 345
    Top = 48
    Width = 185
    Height = 337
    Enabled = False
    ExtendedSelect = False
    TabOrder = 8
  end
  object cmbSelectedTerm: TComboBox
    Left = 20
    Top = 340
    Width = 145
    Height = 24
    TabOrder = 9
  end
  object btnLoad: TButton
    Left = 210
    Top = 136
    Width = 70
    Height = 25
    Caption = 'Load...'
    TabOrder = 10
    OnClick = btnLoadClick
  end
  object cmbSetName: TComboBox
    Left = 20
    Top = 136
    Width = 180
    Height = 24
    TabOrder = 11
    OnChange = cmbSetNameChange
  end
end
