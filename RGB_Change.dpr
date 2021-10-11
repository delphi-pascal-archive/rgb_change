program RGB_Change;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  about in 'about.pas' {AboutForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TRGBForm, RGBForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
