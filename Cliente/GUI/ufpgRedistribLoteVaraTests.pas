unit ufpgRedistribLoteVaraTests;

interface

uses
  ufpgRedistribLoteVara, ufpgGUITestCase, ufpgRedistribLoteVaraModelTests,
  ufpgDataModelTests, ufpgFuncoesGUITestes;

type
  TffpgRedistribLoteVaraTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRedistribLoteVara;
    FoDados: TffpgRedistribLoteVaraModelTests;
    procedure RedistribuicaoEntreVara;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRedistribuicaoEntreVara;
  end;

implementation

uses
  TestFrameWork, uspInterface, FutureWindows, usajConstante, ufpgVariaveisTestesGUI, SysUtils;

Const
  CN_DIST_SORTEIO = 1;
  CN_DIST_DIRECIONADA = 3;

{ TffpgRedistribLoteVaraTests }

function TffpgRedistribLoteVaraTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRedistribLoteVaraModelTests;
end;

procedure TffpgRedistribLoteVaraTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  FoTela.cbTipoDistribuicao.KeyValue := StrToInt(FoDados.fpgTipoDistribuicao);

  // Tipos de Distribuição
  // 1 - Sorteio
  // 2 - Dependência
  // 3 - Direcionada
  if FoTela.cbTipoDistribuicao.KeyValue = CN_DIST_SORTEIO then
    EnterTextInto(FoTela.csCompetenciaAutomatica.dfCdTipoCartorio, FoDados.fpgCdTipoCartorio)
  else
  if FoTela.cbTipoDistribuicao.KeyValue = CN_DIST_DIRECIONADA then
  begin
    EnterTextInto(FoTela.csVara.dfcdVara, FoDados.fpgNovaVara);
    EnterTextInto(FoTela.csCompetencia.dfCdTipoCartorio, FoDados.fpgCdTipoCartorio);
  end
  else
  begin
    FoDados.fpgProcessoReferencia := usarProcessoArray;
    EnterTextInto(FoTela.edNuProcessoRefer.FdfNumeroProcessoExterno, FoDados.fpgProcessoReferencia);
  end;

  EnterTextInto(FoTela.dfdeMotivo.spMemo, FoDados.fpgDeMotivo);

  TFutureWindows.Expect('TfsajAssistente').ExecProc(FecharJanelaModal);
  EnterTextInto(FoTela.edNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
end;

procedure TffpgRedistribLoteVaraTests.RedistribuicaoEntreVara;
begin
  AbrirTela;
  FoTela := TffpgRedistribLoteVara(spTela);
  FoDados := TffpgRedistribLoteVaraModelTests(spDataModelTests);

  PreencherDados;

  FoTela.ccCadastro.Execute(acSalvar);

  Check(FoDados.VerificarVaraProcesso(FoDados.fpgVaraOriginal, gsCdProcesso),
    'O processo não foi redistribuido');
end;

procedure TffpgRedistribLoteVaraTests.TearDown;
begin
  FecharTela;
  inherited;
end;

procedure TffpgRedistribLoteVaraTests.TestarRedistribuicaoEntreVara;
begin
  ExecutarRoteiroTestes(RedistribuicaoEntreVara);
end;

end.

