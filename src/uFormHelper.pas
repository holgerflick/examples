unit uFormHelper;

interface
uses
  StdCtrls,
  Forms;

type
  TFormHelper = class helper for TForm
  public
    procedure SetSameSizeAndPosTo( AnOtherForm: TForm );

  end;

implementation

{ TFormHelper }


procedure TFormHelper.SetSameSizeAndPosTo(AnOtherForm: TForm);
begin
  if Assigned( AnOtherForm ) then
  begin
    AnOtherForm.Left := Left;
    AnOtherForm.Top := Top;
    AnOtherForm.Width := Width;
    AnOtherForm.Height := Height;
  end;
end;

end.
