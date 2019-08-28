object fDomanda: TfDomanda
  Left = 0
  Top = 0
  Caption = 'Quiz'
  ClientHeight = 697
  ClientWidth = 1200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbIntestazioneDomanda: TLabel
    Left = 8
    Top = 5
    Width = 228
    Height = 19
    Caption = 'Intestazione della domanda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbEsatte: TLabel
    Left = 711
    Top = 601
    Width = 162
    Height = 19
    Alignment = taRightJustify
    Caption = 'Risposte Esatte 361'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbContatore: TLabel
    Left = 1118
    Top = 5
    Width = 74
    Height = 19
    Alignment = taRightJustify
    Caption = 'Dom/Tot'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTimer: TLabel
    Left = 808
    Top = 415
    Width = 66
    Height = 19
    Alignment = taRightJustify
    Caption = '00:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    WordWrap = True
    OnClick = lbTimerClick
  end
  object Label1: TLabel
    Left = 762
    Top = 394
    Width = 112
    Height = 19
    Caption = 'Tempo Rimasto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object rgRisposte: TRadioGroup
    Left = 8
    Top = 394
    Width = 697
    Height = 289
    Caption = 'Risposte'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object memoTestoDomanda: TMemo
    Left = 8
    Top = 24
    Width = 865
    Height = 185
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Testo della domanda')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object btDaiRisposta: TButton
    Left = 711
    Top = 626
    Width = 164
    Height = 57
    Caption = 'RISPONDI'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btDaiRispostaClick
  end
  object memoNoteRispostaEsatta: TMemo
    Left = 8
    Top = 215
    Width = 865
    Height = 173
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Note sulla risposta esatta')
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object clbRisultato: TCheckListBox
    Left = 880
    Top = 24
    Width = 313
    Height = 659
    ItemHeight = 13
    TabOrder = 4
  end
  object dbConnection: TSQLConnection
    DriverName = 'Sqlite'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxSqlite'
      
        'DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver260.bp' +
        'l'
      
        'MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqlite' +
        'Driver260.bpl'
      'FailIfMissing=True'
      'Database=.\ACETest.db')
    TableScope = [tsTable]
    Left = 840
    Top = 449
  end
  object qDomanda: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftUnknown
        Name = 'capitolo'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'numeroDomanda'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT'
      '  Testo_Domanda,'
      '  Num_Risp_Err,'
      '  Num_Risp_Esatte,'
      '  Risposta_Esatta,'
      '  Nota_Risposta_Esatta'
      'FROM'
      '  Domande'
      'WHERE '
      '  Capitolo = :capitolo AND'
      '  Numero_Domanda = :numeroDomanda')
    SQLConnection = dbConnection
    Left = 840
    Top = 497
  end
  object qRisposte: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftUnknown
        Name = 'capitolo'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'numeroDomanda'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT'
      '  Risposta,'
      '  Testo_Risposta,'
      '  N_Volte_Data'
      'FROM'
      '  Risposte'
      'WHERE'
      '  Capitolo = :capitolo  AND'
      '  Numero_Domanda = :numeroDomanda')
    SQLConnection = dbConnection
    Left = 840
    Top = 545
  end
  object uDomanda: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftUnknown
        Name = 'numRispErr'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'numRispEsatte'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'capitolo'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'numeroDomanda'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'UPDATE'
      '  Domande'
      'SET'
      '  Num_Risp_Err =:numRispErr,'
      '  Num_Risp_Esatte =:numRispEsatte'
      'WHERE'
      '  Capitolo= :capitolo AND'
      '  Numero_Domanda = :numeroDomanda')
    SQLConnection = dbConnection
    Left = 776
    Top = 497
  end
  object uRisposta: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftUnknown
        Name = 'nVolteData'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'capitolo'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'numeroDomanda'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'risposta'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'UPDATE'
      '  Risposte'
      'SET'
      '  N_Volte_Data = :nVolteData'
      'WHERE'
      '  Capitolo= :capitolo AND'
      '  Numero_Domanda = :numeroDomanda AND'
      '  Risposta = :risposta')
    SQLConnection = dbConnection
    Left = 776
    Top = 545
  end
  object qRisposta: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftUnknown
        Name = 'capitolo'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'numeroDomanda'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'rispostaData'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT'
      '  N_Volte_Data'
      'FROM'
      '  Risposte'
      'WHERE'
      '  Capitolo = :capitolo  AND'
      '  Numero_Domanda = :numeroDomanda AND'
      '  Risposta = :rispostaData')
    SQLConnection = dbConnection
    Left = 776
    Top = 449
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 712
    Top = 393
  end
end
