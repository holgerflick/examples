object Form1: TForm1
  Width = 640
  Height = 518
  Caption = 'WebDataSource1'
  object Grid: TWebDBGrid
    Left = 24
    Top = 32
    Width = 585
    Height = 425
    Columns = <
      item
        DataField = 'ID'
        Title = 'ID'
      end
      item
        DataField = 'NAME'
        Title = 'ID'
        Width = 300
      end>
    DataSource = Datasource
    FixedCols = 1
    TabOrder = 0
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ColWidths = (
      24
      64
      300)
  end
  object WebButton1: TWebButton
    Left = 32
    Top = 472
    Width = 96
    Height = 25
    Caption = 'Open'
    ChildOrder = 1
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = WebButton1Click
  end
  object Dataset: TWebRadServerClientDataset
    Params = <>
    RadServerURL = 'http://localhost:8080'
    TableName = 'Workouts'
    KeyFieldName = 'ID'
    Left = 104
    Top = 64
    object DatasetID: TIntegerField
      FieldName = 'ID'
    end
    object DatasetNAME: TStringField
      FieldName = 'NAME'
      Size = 500
    end
  end
  object Datasource: TWebDataSource
    DataSet = Dataset
    Left = 104
    Top = 136
  end
end
