object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'ACE Tester'
  ClientHeight = 185
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bt50casuali: TButton
    Left = 8
    Top = 32
    Width = 129
    Height = 25
    Caption = '50 domande casuali'
    TabOrder = 0
    OnClick = bt50CasualiClick
  end
  object bt25Casuali: TButton
    Left = 8
    Top = 63
    Width = 129
    Height = 25
    Caption = '25 domande casuali'
    TabOrder = 1
    OnClick = bt25CasualiClick
  end
  object bt20Casuali: TButton
    Left = 8
    Top = 94
    Width = 129
    Height = 25
    Caption = '20 domande casuali'
    TabOrder = 2
    OnClick = bt20CasualiClick
  end
  object btNCasuali: TButton
    Left = 8
    Top = 125
    Width = 129
    Height = 25
    Caption = 'N domande casuali'
    TabOrder = 3
    OnClick = btNCasualiClick
  end
  object btCapitolo: TButton
    Left = 8
    Top = 156
    Width = 129
    Height = 25
    Caption = 'Domande sul Capitolo'
    TabOrder = 4
    OnClick = btCapitoloClick
  end
  object teCapitolo: TEdit
    Left = 167
    Top = 156
    Width = 26
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    NumbersOnly = True
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
    Text = '1'
  end
  object teNDomande: TEdit
    Left = 167
    Top = 125
    Width = 26
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    NumbersOnly = True
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 6
    Text = '10'
  end
  object btTutte: TButton
    Left = 8
    Top = 1
    Width = 129
    Height = 25
    Caption = 'TUTTE!'
    TabOrder = 7
    OnClick = btTutteClick
  end
end
