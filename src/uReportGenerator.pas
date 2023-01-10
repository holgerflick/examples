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
    function GetHasReport: Boolean;
  public
    { Public declarations }
    procedure LoadTemplate( AStream: TStream );

    procedure SavePdfToStream( AStream: TStream );

    property Report: TXlsFile read GetReport;
    property HasReport: Boolean read GetHasReport;
  end;


implementation

uses
  System.IOUtils
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TReportGenerator.DataModuleCreate(Sender: TObject);
begin
  Connection.Params.Database := '$(RUN)\..\db\workouts.db';
  FReport := nil;

  GenerateReport;
end;

procedure TReportGenerator.GenerateReport;
var
  LReport: TFlexCelReport;

  LTemplate: TMemoryStream;
  LOutput: TMemoryStream;

begin
  QInstructors.Open;

  QClasses.ParamByName('cnt').AsInteger := 5;
  QClasses.Open;

  LTemplate := nil;
  LOutput := nil;

  LReport := TFlexCelReport.Create( true );
  try
    QInstructors.DisableControls;
    QClasses.DisableControls;

    LReport.AddTable( 'i', QInstructors );
    LReport.AddTable( 'c', QClasses );

    LOutput := TMemoryStream.Create;
    LTemplate := TMemoryStream.Create;

    LoadTemplate( LTemplate );
    LTemplate.Position := 0;

    LReport.Run( LTemplate, LOutput );

    FReport.Free;

    LOutput.Position := 0;
    FReport := TXlsFile.Create( LOutput, true );
  finally

    QClasses.Close;
    QInstructors.Close;

    LReport.Free;
    LOutput.Free;
    LTemplate.Free;
  end;
end;

function TReportGenerator.GetHasReport: Boolean;
begin
  Result := Assigned( FReport );
end;

function TReportGenerator.GetReport: TXlsFile;
begin
  Result := FReport;
end;

procedure TReportGenerator.LoadTemplate(AStream: TStream);
var
  LFile: TFileStream;

begin
  var LFilename := TPath.Combine(
    TPath.GetLibraryPath,
    '..\assets\template.xlsx' );

  if not TFile.Exists( LFilename ) then
  begin
    raise EFileNotFoundException.CreateFmt(
     'Report template not found (%s)',
     [ LFilename ]);
  end;

  LFile := TFileStream.Create( LFileName, fmOpenRead );
  try
    AStream.CopyFrom( LFile );
  finally
    LFile.Free;
  end;
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
