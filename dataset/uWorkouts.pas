unit uWorkouts;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, EMS.DataSetResource, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait;

type
  [ResourceName('Workouts')]
  TWorkoutsResource1 = class(TDataModule)
    Connection: TFDConnection;
    quInstructors: TFDQuery;

    [ResourceSuffix('list', '/')]
    [ResourceSuffix('get','/{ID}')]
    [ResourceSuffix('put', '/{ID}')]
    [ResourceSuffix('delete', '/{ID}')]
    [ResourceSuffix('post', '/')]
    dsInstructors: TEMSDataSetResource;
    procedure DataModuleCreate(Sender: TObject);
  private
    function GetCountInstructors: Integer;
    function GetPagesInstructors: Integer;

  published

    [ResourceSuffix('./count')]
    procedure GetCount(const AContext: TEndpointContext;
        const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [ResourceSuffix('./maxpage')]
    procedure GetMaxPage(const AContext: TEndpointContext;
        const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);


  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  System.Math
  ;


procedure Register;
begin
  RegisterResource(TypeInfo(TWorkoutsResource1));
end;

{ TWorkoutsResource1 }

procedure TWorkoutsResource1.DataModuleCreate(Sender: TObject);
begin
  quInstructors.FetchOptions.RecordCountMode := cmTotal;
end;

procedure TWorkoutsResource1.GetCount(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  AResponse.Body.JSONWriter.WriteValue( GetCountInstructors );
end;

function TWorkoutsResource1.GetCountInstructors: Integer;
begin
  quInstructors.Open;
  try
    Result := quinstructors.RecordCount;
  finally
    quInstructors.Close;
  end;
end;

procedure TWorkoutsResource1.GetMaxPage(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  AResponse.Body.JSONWriter.WriteValue( GetPagesInstructors );
end;

function TWorkoutsResource1.GetPagesInstructors: Integer;
begin
  Result := CEIL( GetCountInstructors/ dsInstructors.PageSize );
end;

initialization
  Register;
end.


