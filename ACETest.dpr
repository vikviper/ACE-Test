program ACETest;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fMain},
  fDomande in 'fDomande.pas' {fDomanda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfDomanda, fDomanda);
  Application.Run;
end.
