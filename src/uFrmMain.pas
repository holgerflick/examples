unit uFrmMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,

  VCL.FlexCel.Core,
  FlexCel.XlsAdapter,
  FlexCel.Render,
  FlexCel.Preview,

  Vcl.StdCtrls
  ;

type
  TFrmMain = class(TForm)
    btnGenerate: TButton;
    Preview: TFlexCelPreviewer;
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FImgExport : TFlexCelImgExport;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  uReportGenerator
  ;

{$R *.dfm}

procedure TFrmMain.btnGenerateClick(Sender: TObject);
begin
  var LGenerator := TReportGenerator.Create(nil);
  try
    if LGenerator.HasReport then
    begin
      FImgExport.Free;

      FImgExport := TFlexCelImgExport.Create( LGenerator.Report );
      Preview.Document := FImgExport;
      Preview.InvalidatePreview;
    end;
  finally
    LGenerator.Free;
  end;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FImgExport := nil;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FImgExport.Free;
end;

end.
