unit uReportGenerator;

interface

uses
  System.SysUtils,
  System.Classes,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  Data.DB,

  Vcl.FlexCel.Core,
  FlexCel.XlsAdapter,
  FlexCel.Report,
  FlexCel.Render

  ;

type
  TReportGenerator = class(TDataModule)
    Connection: TFDConnection;
    QInstructors: TFDQuery;
    QClasses: TFDQuery;
    srcinstructors: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FReport: TXlsFile;
    function GetReport: TXlsFile;
    procedure GenerateReport;
  public
    { Public declarations }

    procedure SavePdfToStream( AStream: TStream );

    property Report: TXlsFile read GetReport;
  end;


implementation

uses
  System.IOUtils
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TReportGenerator.DataModuleCreate(Sender: TObject);
begin
  // Connection.Params.Database := 'workouts.db';
  FReport := nil;

  GenerateReport;
end;

procedure TReportGenerator.GenerateReport;
var
  LReport: TFlexCelReport;

begin
  QInstructors.Open;
  QClasses.Open;

  LReport := TFlexCelReport.Create( true );

  LReport.AddTable( 'i', QInstructors );
  LReport.AddTable( 'c', QClasses );

  LReport.Run( 'f:\template.xlsx', 'f:\output.xlsx' );

  LReport.Free;

end;

function TReportGenerator.GetReport: TXlsFile;
begin
  Result := FReport;
end;

procedure TReportGenerator.SavePdfToStream(AStream: TStream);
var
  LExport: TFlexCelPdfExport;

begin
  if Assigned( Report ) then
  begin
    LExport := TFlexCelPdfExport.Create( Report );
    try
      LExport.Export( AStream );
    finally
      LExport.Free;
    end;
  end;
end;

end.
