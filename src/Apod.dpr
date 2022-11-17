program Apod;

uses
  Vcl.Forms,
  WEBLib.Forms,
  uMain in 'uMain.pas' {FrmMain: TWebForm} {*.html},
  uNasaApodService in 'uNasaApodService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
