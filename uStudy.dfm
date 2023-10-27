object frmStudy: TfrmStudy
  Left = 0
  Top = 0
  Caption = 'Flashcard City'
  ClientHeight = 441
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'JetBrains Mono'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 16
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
  object cmbSet: TComboBox
    Left = 175
    Top = 101
    Width = 150
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'Select a set...'
  end
  object pnlSetName: TPanel
    Left = 162
    Top = 30
    Width = 275
    Height = 51
    Caption = 'Select a set'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'JetBrains Mono'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object pnlFlashcard: TPanel
    Left = 128
    Top = 152
    Width = 350
    Height = 150
    Caption = 'Select a set'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = pnlFlashcardClick
  end
  object bbnNo: TBitBtn
    Left = 170
    Top = 350
    Width = 55
    Height = 50
    Caption = 'No'
    Kind = bkAbort
    NumGlyphs = 2
    TabOrder = 4
    OnClick = bbnNoClick
  end
  object bbnYes: TBitBtn
    Left = 375
    Top = 350
    Width = 55
    Height = 50
    Caption = 'Yes'
    Kind = bkYes
    NumGlyphs = 2
    TabOrder = 5
    OnClick = bbnYesClick
  end
  object btnLoad: TButton
    Left = 345
    Top = 101
    Width = 80
    Height = 25
    Caption = 'Load...'
    TabOrder = 6
    OnClick = btnLoadClick
  end
  object bbnReset: TBitBtn
    Left = 260
    Top = 409
    Width = 80
    Height = 25
    Caption = 'Retry'
    Kind = bkRetry
    NumGlyphs = 2
    TabOrder = 7
    OnClick = bbnResetClick
  end
  object redStats: TRichEdit
    Left = 480
    Top = 157
    Width = 96
    Height = 145
    Alignment = taCenter
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'JetBrains Mono'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
end
