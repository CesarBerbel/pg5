unit ufpgRetificacaoProcessoTests;

interface

uses
  ufpgRetificacaoProcesso, ufpgGUITestCase, ufpgRetificacaoProcessoModelTests, ufpgDataModelTests;

type
  TffpgRetificacaoProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRetificacaoProcesso;
    FoDados: TffpgRetificacaoProcessoModelTests;
    procedure RetificarProcesso;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarRetificarProcesso;
  end;

implementation

uses
  TestFrameWork, uspInterface, usajConstante, ufpgFuncoesGUITestes;

procedure TffpgRetificacaoProcessoTests.RetificarProcesso;
begin
  AbrirTela;
  FoTela := TffpgRetificacaoProcesso(spTela);
  FoDados := TffpgRetificacaoProcessoModelTests(spDataModelTests);

  spVerificadorTelas.RegistrarMensagem('O processo foi retificado*', 'OK');
  PreencherDados;
  FoTela.ccCadastro.Execute(acSalvar);
  FecharTela;
end;

function TffpgRetificacaoProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := tffpgRetificacaoProcessoModelTests;
end;

procedure TffpgRetificacaoProcessoTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse);
  EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCompetencia);
end;

procedure TffpgRetificacaoProcessoTests.TestarRetificarProcesso;
begin
  ExecutarRoteiroTestes(RetificarProcesso);
end;

end.

