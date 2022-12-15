unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, VCL.TMSFNCTypes,
  VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser, VCL.TMSFNCCustomWEBControl,
  VCL.TMSFNCMemo;

type
  TFrmMain = class(TForm)
    Tabs: TPageControl;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AddTab( AIndex: Integer );
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.AddTab(AIndex: Integer);
var
  LTabItem: TTabSheet;
  LMemo: TTMSFNCMemo;

begin
  LTabItem := TTabSheet.Create( Tabs );
  LTabItem.PageControl := Tabs;
  LTabItem.Caption := 'Editor ' + AIndex.ToString;
  LTabItem.Tag := AIndex;
  LMemo := TTMSFNCMemo.Create(LTabItem);
  LMemo.Parent := LTabItem;
  LMemo.Align := alClient;
  LMemo.Visible := True;
  LMemo.Language := mlMarkdown;
  LMemo.Font.Size := 11;
  LMemo.Lines.Add( '# Editor example ' + AIndex.ToString );
  LMemo.Lines.Add( 'This is a performance example using _Markdown_.' );
  LMemo.Lines.Add( 'You can also add inline code like `TCustomer.Receive()`.' );

  LMemo.Lines.Add( 'And code snippets...' );
  LMemo.Lines.Add( '```');
  LMemo.Lines.Add('procedure Something;');
  LMemo.Lines.Add( 'begin' );
  LMemo.Lines.Add( '  if PI > 5 then' );
  LMemo.Lines.Add( '  begin' );
  LMemo.Lines.Add( '    raise Exception.Create(''The world is gonna end. :-)'');');
  LMemo.Lines.Add( '  end;' );
  LMemo.Lines.Add( 'end;' );
  LMemo.Lines.Add( '```' );


end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  i: Integer;

begin
  for i := 1 to 5 do
  begin
    AddTab(i);
  end;
end;

end.
