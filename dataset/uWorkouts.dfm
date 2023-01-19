object WorkoutsResource1: TWorkoutsResource1
  OnCreate = DataModuleCreate
  Height = 428
  Width = 284
  object Connection: TFDConnection
    Params.Strings = (
      'Database=workouts'
      'User_Name=root'
      'Password=masterkey'
      'Server=192.168.0.11'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object quInstructors: TFDQuery
    Connection = Connection
    FetchOptions.AssignedValues = [evRecordCountMode]
    FetchOptions.RecordCountMode = cmTotal
    SQL.Strings = (
      'select * from instructors'
      '{IF &SORT}'
      ' order by &SORT'
      '{FI}')
    Left = 64
    Top = 112
    MacroData = <
      item
        Value = Null
        Name = 'SORT'
        DataType = mdIdentifier
      end>
  end
  object dsInstructors: TEMSDataSetResource
    AllowedActions = [List, Get, Post, Put, Delete]
    DataSet = quInstructors
    KeyFields = 'ID'
    ValueFields = 'ID;NAME'
    Options = [roEnableParams, roEnablePaging, roEnableSorting, roReturnNewEntityKey]
    PageSize = 5
    Left = 64
    Top = 184
  end
end
