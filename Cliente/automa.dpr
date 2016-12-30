program automa;

uses
  Forms,
  ufrmAutomatizador in 'ufrmAutomatizador.pas' {frmPrincipal},
  ufrmManipula in 'ufrmManipula.pas' {frmManipulaDados},
  fpgGlobais in 'fpgGlobais.pas',
  ufrmBuild in 'ufrmBuild.pas' {frmBuild},
  ufrmSuit in 'ufrmSuit.pas' {frmSuit},
  ufrmUsuario in 'ufrmUsuario.pas' {frmUsuario};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
