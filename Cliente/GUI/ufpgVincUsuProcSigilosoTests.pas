unit ufpgVincUsuProcSigilosoTests;

interface

uses
  ufpgVincUsuProcSigiloso, ufpgGUITestCase, ufpgVincUsuProcSigilosoModelTests, ufpgDataModelTests;

type
  TffpgVincUsuProcSigilosoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgVincUsuProcSigiloso;
    FoDados: TffpgVincUsuProcSigilosoModelTests;
    procedure VincularUsuario;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;

  published
    procedure TestarVincularUsuario;

  end;

implementation

uses
  Windows, Forms, uspInterface, SysUtils, ufpgFuncoesGUITestes, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI;

{ TffpgVincUsuProcSigilosoTests }

function TffpgVincUsuProcSigilosoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgVincUsuProcSigilosoModelTests;
end;

procedure TffpgVincUsuProcSigilosoTests.TestarVincularUsuario;
begin
  ExecutarRoteiroTestes(VincularUsuario);
end;

procedure TffpgVincUsuProcSigilosoTests.VincularUsuario;
begin
  AbrirTela;
  FoTela := TffpgVincUsuProcSigiloso(spTela);
  FoDados := TffpgVincUsuProcSigilosoModelTests(spDataModelTests);

  if (FoDados.fpgNuProcesso = STRING_INDEFINIDO) then
  begin
    FoDados.fpgNuProcesso := usarProcessoArray;
    checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO,
      'Número de Processo principal não encontrado');
    EnterTextInto(FoTela.sajNumeroProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
  end;
  Application.ProcessMessages;

  if FoDados.fpgVincularUsuario then
    PreencherDados;

  FoTela.ccCadastro.Execute(acSalvar);

  Check(FoDados.VerificaProcessoSigiloAbsoluto(FoDados.fpgNuProcesso, FoDados.fpgUsuarioVinc),
    'O usuário não está vinculado com o processo');

  FecharTela;
end;

procedure TffpgVincUsuProcSigilosoTests.PreencherDados;
begin
  EnterTextGrid(FoTela.grdados, FoDados.fpgUsuarioVinc, 0);
  Application.ProcessMessages;
end;

end.

