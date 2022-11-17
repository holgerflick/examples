unit uMain;

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
  Vcl.StdCtrls,
  Vcl.ComCtrls,

  Spring

  // several alternatives:
  // - TMS BIZ Core Library, tmssoftware.com
  // - JOSE Frameworks, Paolo Rossi
  // - ...

  ;

type
  TFrmMain = class(TForm)
    dtFinished: TDateTimePicker;
    cbFinished: TCheckBox;
    btnGetDate: TButton;
    procedure cbFinishedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGetDateClick(Sender: TObject);
  private

    function GetIsFinished: Boolean;
    procedure SetIsFinished(const Value: Boolean);
    { Private declarations }

    procedure ShowDate;

    procedure UpdateUI;
    function GetFinishedDate: Nullable<TDate>;
  public
    { Public declarations }
    property IsFinished: Boolean read GetIsFinished write SetIsFinished;
    property FinishedDate: Nullable<TDate> read GetFinishedDate;

  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.btnGetDateClick(Sender: TObject);
begin
  ShowDate;
end;

procedure TFrmMain.cbFinishedClick(Sender: TObject);
begin
  IsFinished := cbFinished.Checked;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  IsFinished := False;
end;

function TFrmMain.GetFinishedDate: Nullable<TDate>;
begin
  Result := nil;
  if IsFinished then
  begin
    Result := dtFinished.Date;
  end;
end;

function TFrmMain.GetIsFinished: Boolean;
begin
  Result := cbFinished.Checked;
end;

procedure TFrmMain.SetIsFinished(const Value: Boolean);
begin
  cbFinished.Checked := Value;

  UpdateUI;
end;

procedure TFrmMain.ShowDate;
begin

  // ShowMessage( FinishedDate.ToString );

  // or:
  if FinishedDate.HasValue then
  begin
    ShowMessage( FinishedDate.ToString );
  end
  else
  begin
    ShowMessage( 'Project not finished.' );
  end;
end;

procedure TFrmMain.UpdateUI;
begin
  dtFinished.Enabled := IsFinished;
end;

end.
