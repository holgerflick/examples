object ReportGenerator: TReportGenerator
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object Connection: TFDConnection
    Params.Strings = (
      'Database=F:\examples\db\workouts.db'
      'LockingMode=Normal'
      'JournalMode=Off'
      'DriverID=SQLite')
    ConnectedStoredUsage = []
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object QInstructors: TFDQuery
    Connection = Connection
    SQL.Strings = (
      
        'select id, name, count(w.id_instructor) as cnt from instructors ' +
        'i '
      '  left join items w on ( w.id_instructor = i.id )'
      '  group by w.id_instructor'
      '  having cnt > 10'
      '  order by cnt desc'
      ''
      '')
    Left = 88
    Top = 144
  end
  object QClasses: TFDQuery
    MasterSource = srcinstructors
    Connection = Connection
    SQL.Strings = (
      
        'select *, (total_output * 1.0)/duration as ratio from items     ' +
        '    '
      '  where id_instructor = :id'
      '  order by ratio desc, total_output desc, starttime desc'
      '  limit :maxCount'
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
        Name = 'MAXCOUNT'
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
