object DbController: TDbController
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object Connection: TFDConnection
    Params.Strings = (
      'Database=F:\examples\db\workouts.db'
      'LockingMode=Normal'
      'JournalMode=Off'
      'DriverID=SQLite')
    Connected = True
    Left = 88
    Top = 56
  end
  object QInstructors: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from instructors '
      '  order by name')
    Left = 88
    Top = 144
  end
  object QClasses: TFDQuery
    MasterSource = srcinstructors
    Connection = Connection
    SQL.Strings = (
      'select * from items         '
      '  where id_instructor = :id'
      '  order by total_output/duration desc, starttime desc'
      '  limit :cnt'
      '')
    Left = 176
    Top = 144
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'CNT'
        DataType = ftString
        ParamType = ptInput
        Value = '5'
      end>
  end
  object srcinstructors: TDataSource
    DataSet = QInstructors
    Left = 96
    Top = 224
  end
end
