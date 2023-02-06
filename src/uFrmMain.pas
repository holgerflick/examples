unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmMain = class(TForm)
    Connection: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1headerId: TFDAutoIncField;
    FDQuery1basin: TStringField;
    FDQuery1cycloneNumber: TIntegerField;
    FDQuery1year: TIntegerField;
    FDQuery1name: TStringField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  System.IOUtils
  ;

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Connection.Params.Database :=
    TPath.Combine(
      TPath.GetLibraryPath ,
      'db\hurdat.db'
      );


end;

end.
