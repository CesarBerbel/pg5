unit ufpgConsRelacaoTodasTests;

interface

uses
  TestFrameWork, ufpgConsRelacaoTodas, ufpgGUITestCase, ufpgConsRelacaoTodasModelTests,
  ufpgDataModelTests, ufpgConfigIntimaAdv, Windows, FutureWindows;

type
  TffpgConsRelacaoTodasTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsRelacaoTodas;
    FoDados: TffpgConsRelacaoTodasModelTests;
    procedure PreencherDados;
    procedure CheckResultado;
    procedure ConsRelacaoTodas;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConsRelacaoTodas;
  end;

implementation

{ TffpgConsRelacaoTodasTests }

uses
  usajConstante, ufpgFuncoesGUITestes, Forms, uspInterface, uspEntidade;

procedure TffpgConsRelacaoTodasTests.TestarConsRelacaoTodas;
begin
  ExecutarRoteiroTestes(ConsRelacaoTodas);
end;

procedure TffpgConsRelacaoTodasTests.ConsRelacaoTodas;
begin
  FoDados := TffpgConsRelacaoTodasModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgConsRelacaoTodas');

  FoTela := TffpgConsRelacaoTodas(spTela);

  PreencherDados;

  FoTela.ccPublicaDiario.Execute(acConsultar);

  FoTela.pbRelacao.Click;

  CheckResultado;

  if FoDados.fpgFecharTela then
    FecharTela;
end;

function TffpgConsRelacaoTodasTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsRelacaoTodasModelTests;
end;

procedure TffpgConsRelacaoTodasTests.CheckResultado;
var
  oTela: TffpgConfigIntimaAdv;
begin
  oTela := PegarTela('ffpgConfigIntimaAdv') as TffpgConfigIntimaAdv;

  check(FoTela.dgOutros.DataSource.DataSet.FieldByName('NURELACAO').AsString
    = (oTela.nuRelacao.edRelAno.PegaTexto + oTela.nuRelacao.edRelSeq.PegaTexto),
    'Relação consultada não confere com dados da consulta.');

  oTela.ccPartes.Execute(acFecharForm);
end;

procedure TffpgConsRelacaoTodasTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
end;

end.

