object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Example'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 21
  object Connection: TFDConnection
    Params.Strings = (
      'Database=G:\hurdat.db'
      'JournalMode=Off'
      'DriverID=SQLite')
    ConnectedStoredUsage = []
    Connected = True
    LoginPrompt = False
    Left = 80
    Top = 56
  end
  object FDQuery1: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from headers limit 100')
    Left = 184
    Top = 56
    object FDQuery1headerId: TFDAutoIncField
      FieldName = 'headerId'
      Origin = 'headerId'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQuery1basin: TStringField
      FieldName = 'basin'
      Origin = 'basin'
      Required = True
      FixedChar = True
      Size = 2
    end
    object FDQuery1cycloneNumber: TIntegerField
      FieldName = 'cycloneNumber'
      Origin = 'cycloneNumber'
      Required = True
    end
    object FDQuery1year: TIntegerField
      FieldName = 'year'
      Origin = 'year'
      Required = True
    end
    object FDQuery1name: TStringField
      FieldName = 'name'
      Origin = 'name'
      Size = 10
    end
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    DriverID = 'HolgerSQLite'
    EngineLinkage = slStatic
    Left = 88
    Top = 160
  end
end
