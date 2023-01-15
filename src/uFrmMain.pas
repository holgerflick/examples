unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Vcl.StdCtrls, FireDAC.Comp.DataSet, AdvEdit, Vcl.VirtualImage,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFrmMain = class(TForm)
    Connection: TFDConnection;
    Workouts: TFDQuery;
    CountWorkouts: TFDQuery;
    btnCompare: TButton;
    txtRecordCount: TAdvEdit;
    txtSqlCount: TAdvEdit;
    Assets: TImageCollection;
    imgHorror: TVirtualImage;
    btnFix: TButton;
    btnDefault: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnFixClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
  private
    { Private declarations }

    procedure Compare;
    procedure Fix;
    procedure DefaultFetch;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.btnCompareClick(Sender: TObject);
begin
  Compare;
end;

procedure TFrmMain.btnDefaultClick(Sender: TObject);
begin
  DefaultFetch;
end;

procedure TFrmMain.btnFixClick(Sender: TObject);
begin
  Fix;
end;

procedure TFrmMain.Compare;
var
  LSQL,
  LRec: Integer;
begin
  Workouts.Open;
  CountWorkouts.Open;

  try
    LRec := Workouts.RecordCount;
    LSQL := CountWorkouts.FieldByName('cnt').AsInteger;

    txtRecordCount.IntValue := LRec;
    txtSqlCount.IntValue := LSQL;

    if LSQL <> LRec then
    begin
      ImgHorror.ImageIndex := 0;
    end
    else
    begin
      ImgHorror.ImageIndex := 1;
    end;
    ImgHorror.Visible := True;
  finally
    Workouts.Close;
    CountWorkouts.Close;
  end;
end;

procedure TFrmMain.DefaultFetch;
begin
  Workouts.FetchOptions.RecordCountMode := cmFetched;
end;

procedure TFrmMain.Fix;
begin
  Workouts.FetchOptions.RecordCountMode := cmTotal;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ImgHorror.Visible := False;

  Connection.Params.Database := '$(RUN)\workouts.db';
end;

end.
