unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.FlexCel.Core, FlexCel.XlsAdapter,
  FlexCel.Render, FlexCel.Preview, Vcl.StdCtrls;

type
  TFrmMain = class(TForm)
    btnGenerate: TButton;
    Preview: TFlexCelPreviewer;
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
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
    //
  finally
    LGenerator.Free;
  end;

end;

end.
