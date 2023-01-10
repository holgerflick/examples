program FlexCelMasterDetail;

uses
  Vcl.Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uReportGenerator in 'uReportGenerator.pas' {ReportGenerator: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
