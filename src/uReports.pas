unit uReports;

interface

uses
  System.Classes,

  Vcl.FlexCel.Core,
  FlexCel.Render,
  FlexCel.XlsAdapter,
  FlexCel.Report,
  FlexCel.Pdf,


  uAlbum,
  uTrack

  ;

type
  TReports = class
  private
    FXlsFile: TXlsFile;

    function GetHasReport: Boolean;
    function LoadTemplate( AName: String ): TStream;

  public
    constructor Create;
    destructor Destroy; override;

    procedure GenerateReportForAlbum( AAlbum: TAlbum );

    procedure GetExcelStream( AStream: TStream );
    procedure GetPdfStream( AStream: TStream );
    procedure SaveToHtml( AFilename: String );

    property XlsFile: TXlsFile read FXlsFile;
    property HasReport: Boolean read GetHasReport;
  end;


implementation

uses
  WinApi.Windows;

{ TReports }

constructor TReports.Create;
begin
  FXlsFile := nil;
end;

destructor TReports.Destroy;
begin
  FXlsFile.Free;

  inherited;
end;

procedure TReports.GenerateReportForAlbum(AAlbum: TAlbum);
var
  LTemplate: TStream;
  LReport: TFlexCelReport;
  LOutput: TMemoryStream;
  LBytes: TBytesStream;

begin

  LReport := nil;
  LOutput := nil;

  // load the template into a stream
  LTemplate := LoadTemplate('XLS_TRACKS');
  try
    // create a new report
    LReport := TFlexCelReport.Create(True);

    // set datasource for tracks - name needs to match template
    LReport.AddTable<TTrack>('Tracks', AAlbum.Tracks );

    // assign values for album data
    LReport.SetValue( 'AlbumTitle', AAlbum.Name );
    LReport.SetValue( 'AlbumArtistName', AAlbum.ArtistName );
    LReport.SetValue( 'AlbumNotes',AAlbum.Notes.Standard );

    // asssign album cover using stream
    LBytes := TBytesStream.Create;
    try
      AAlbum.Artwork.Image.SaveToStream(LBytes);
      LReport.SetValue( 'AlbumCover', LBytes.Bytes );
    finally
      LBytes.Free;
    end;

    // run the report using the template
    LTemplate.Position := 0;
    LOutput := TMemoryStream.Create;
    LReport.Run( LTemplate, LOutput );

    FXlsFile.Free;
    LOutput.Position := 0;
    // create a new Excel document based on the report
    FXlsFile := TXlsFile.Create( LOutput, True );

  finally
    LOutput.Free;
    LReport.Free;
    LTemplate.Free;
  end;
end;

procedure TReports.GetExcelStream(AStream: TStream);
begin
  if HasReport then
  begin
    // save Xls document to stream
    FXlsFile.Save( AStream );
  end;
end;

function TReports.GetHasReport: Boolean;
begin
  Result := Assigned( FXlsFile );
end;

procedure TReports.SaveToHtml(AFilename: String);
var
  LExport: TFlexCelHtmlExport;

begin
  if HasReport then
  begin
    LExport := TFlexCelHtmlExport.Create( FXlsFile );
    try
      LExport.Export( AFilename, 'images' );
    finally
      LExport.Free;
    end;
  end;
end;

procedure TReports.GetPdfStream(AStream: TStream);
var
  LExport: TFlexCelPdfExport;
begin
  if HasReport then
  begin
    // create export object based on Xls document
    LExport := TFlexCelPdfExport.Create( FXlsFile );
    try
      // export to stream as PDF
      LExport.Export(AStream);
    finally
      LExport.Free;
    end;
  end;
end;

function TReports.LoadTemplate(AName: String): TStream;
begin
  // current implementation only uses resources
  Result := TResourceStream.Create( HInstance, AName, RT_RCDATA );
end;

end.
