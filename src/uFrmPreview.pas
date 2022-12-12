unit uFrmPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.FlexCel.Core, FlexCel.XlsAdapter,
  FlexCel.Render, FlexCel.Preview,

  uReports, Vcl.BaseImageCollection, AdvTypes, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, AdvGlowButton, AdvToolBar, Vcl.ImageCollection;

type
  TFrmPreview = class(TForm)
    Preview: TFlexCelPreviewer;
    AdvSVGImageCollection1: TAdvSVGImageCollection;
    VirtualImageList1: TVirtualImageList;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btnPdf: TAdvGlowButton;
    btnHtml: TAdvGlowButton;
    btnXls: TAdvGlowButton;
    ImageCollection1: TImageCollection;
    DlgSave: TFileSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnXlsClick(Sender: TObject);
    procedure btnHtmlClick(Sender: TObject);
    procedure btnPdfClick(Sender: TObject);
  private
    FImgExport: TFlexCelImgExport;
    FReport: TReports;
    function GetXlsFile: TXlsFile;
    procedure SetReport(const Value: TReports);

    procedure ExportXls;
    procedure ExportPdf;
    procedure ExportHtml;


    { Private declarations }
  public
    { Public declarations }
    procedure Execute( AReport: TReports );

    property Report: TReports read FReport write SetReport;

    property XlsFile: TXlsFile read GetXlsFile;
  end;

var
  FrmPreview: TFrmPreview;

implementation

{$R *.dfm}

{ TFrmPreview }

procedure TFrmPreview.btnHtmlClick(Sender: TObject);
begin
  ExportHtml;
end;

procedure TFrmPreview.btnPdfClick(Sender: TObject);
begin
  ExportPdf;
end;

procedure TFrmPreview.btnXlsClick(Sender: TObject);
begin
  ExportXls;
end;

procedure TFrmPreview.Execute(AReport: TReports);
begin
  Report := AReport;
  self.ShowModal;
end;

procedure TFrmPreview.ExportHtml;
var
  LFileType: TFileTypeItem;

begin
  DlgSave.FileTypes.Clear;
  DlgSave.DefaultExtension := 'html';
  LFileType := DlgSave.FileTypes.Add;

  LFileType.DisplayName := 'Hypertext Markup Language Format (*.html)';
  LFileType.FileMask := '*.html';

  if DlgSave.Execute then
  begin
    Report.SaveToHtml( DlgSave.FileName );
  end;
end;

procedure TFrmPreview.ExportPdf;
var
  LFileType: TFileTypeItem;
  LStream: TFileStream;

begin
  DlgSave.FileTypes.Clear;
  DlgSave.DefaultExtension := 'pdf';
  LFileType := DlgSave.FileTypes.Add;

  LFileType.DisplayName := 'Adobe Portable Document Format  (*.pdf)';
  LFileType.FileMask := '*.pdf';

  if DlgSave.Execute then
  begin
    LStream := TFileStream.Create( DlgSave.FileName, fmCreate );
    try
      Report.GetPdfStream( LStream );
    finally
      LStream.Free;
    end;
  end;
end;

procedure TFrmPreview.ExportXls;
var
  LFileType: TFileTypeItem;
  LStream: TFileStream;

begin
  DlgSave.FileTypes.Clear;
  DlgSave.DefaultExtension := 'xlsx';
  LFileType := DlgSave.FileTypes.Add;

  LFileType.DisplayName := 'Microsoft Excel (*.xlsx)';
  LFileType.FileMask := '*.xlsx';

  if DlgSave.Execute then
  begin
    LStream := TFileStream.Create( DlgSave.FileName, fmCreate );
    try
      Report.GetExcelStream( LStream );
    finally
      LStream.Free;
    end;
  end;
end;

procedure TFrmPreview.FormCreate(Sender: TObject);
begin
  Report := nil;
end;

procedure TFrmPreview.FormDestroy(Sender: TObject);
begin
  FImgExport.Free;
end;

function TFrmPreview.GetXlsFile: TXlsFile;
begin
  Result := nil;

  if Assigned( Report ) then
  begin
    Result := Report.XlsFile
  end;
end;

procedure TFrmPreview.SetReport(const Value: TReports);
begin
  if Assigned( Value ) then
  begin
    FReport := Value;

    FImgExport.Free;

    // create an image export as import for preview
    FImgExport := TFlexCelImgExport.Create( Value.XlsFile );

    // assign the image export
    Preview.Document := FImgExport;

    // update the window
    Preview.InvalidatePreview;
  end;
end;

end.
