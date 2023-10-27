object frmMainMenu: TfrmMainMenu
  Left = 0
  Top = 0
  Caption = 'Flashcard City'
  ClientHeight = 461
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'JetBrains Mono'
  Font.Style = [fsBold]
  OnActivate = FormActivate
  TextHeight = 16
  object btnStudy: TButton
    Left = 225
    Top = 191
    Width = 150
    Height = 50
    Caption = 'Study'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'JetBrains Mono'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnStudyClick
  end
  object btnAdd: TButton
    Left = 225
    Top = 290
    Width = 150
    Height = 50
    Caption = 'Add/Edit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'JetBrains Mono'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnAddClick
  end
  object pnlTitle: TPanel
    Left = 150
    Top = 50
    Width = 300
    Height = 80
    Caption = 'Flashcard City'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'JetBrains Mono'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object bbnExit: TBitBtn
    Left = 260
    Top = 404
    Width = 75
    Height = 25
    Caption = 'Exit'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 3
    OnClick = bbnExitClick
  end
  object bbnInfo: TBitBtn
    Left = 15
    Top = 15
    Width = 70
    Height = 35
    Caption = 'Info '
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 4
    OnClick = bbnInfoClick
  end
end
