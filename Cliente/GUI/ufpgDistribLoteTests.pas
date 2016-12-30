unit ufpgDistribLoteTests;

interface

uses
  ufpgGUITestCase, ufpgDistribLoteModelTests, ufpgDistribLote, ufpgDataModelTests;

type
  TffpgDistribLoteTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgDistribLote;
    FoDados: TffpgDistribLoteModelTests;
    procedure Distribuir;
    procedure PreencherDados;
    procedure SerializarProcessosParaConsulta;
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarDistribuicao;
  end;

implementation

uses
  uspInterface, TestFramework, ufpgFuncoesGUITestes, usajConstante, SysUtils, ufpgConstanteGUITests;

{ TffpgDistribLoteTests }

procedure TffpgDistribLoteTests.TestarDistribuicao;
begin
  ExecutarRoteiroTestes(Distribuir);
end;

procedure TffpgDistribLoteTests.Distribuir;
var
  nQtdProcesso: integer;
begin
  AbrirTela;
  FoTela := TffpgDistribLote(spTela);
  FoDados := (Self.spDataModelTests) as TffpgDistribLoteModelTests;


  PreencherDados;

  FoTela.pbPesquisar.Click;
  checkFalse(FoTela.cdsDados.IsEmpty, 'A pesquisa não trouxe nenhum resultado');

  SerializarProcessosParaConsulta;

  nQtdProcesso := FoTela.cdsDados.RecordCount;


  spVerificadorTelas.RegistrarMensagem(
    'A distribuição do(s) processo(s) foi concluída com sucesso.', 'OK');
  FoTela.ccCadastro.Execute(acSalvar);
  FecharTela;
  check(FoDados.VerificarDistribuicaoProcessos(FoDados.fpgNuProcesso, nQtdProcesso),
    'Os ' + IntToStr(nQtdProcesso) + ' processos não foram distribuidos');
end;

function TffpgDistribLoteTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgDistribLoteModelTests;
end;

procedure TffpgDistribLoteTests.PreencherDados;
begin
  if FoDados.fpgDtInicial = CS_HOJE then
    EnterTextInto(FoTela.spPeriodoPesq.FdfDataInicial, DateToStr(Now), False);

  if FoDados.fpgDtFinal = CS_HOJE then
    EnterTextInto(FoTela.spPeriodoPesq.FdfDataFinal, DateToStr(Now), False);

  if FoDados.fpgDtFinal = CS_AGORA then
    EnterTextInto(FoTela.spPeriodoPesq.FdfHoraInicial, TimeToStr(incMinute(Time, -2)), False);

  if FoDados.fpgDtFinal = CS_AGORA then
    EnterTextInto(FoTela.spPeriodoPesq.FdfHoraFinal, TimeToStr(Time), False);

    EnterTextInto(FoTela.csTipoCartorioCons.dfCdTipoCartorio, FoDados.fpgCompetencia, False);
    EnterTextCheckBox(FoTela.cbImpEtiq, FoDados.fpgImpEtiqueta);
end;

procedure TffpgDistribLoteTests.SerializarProcessosParaConsulta;
var
  sNuProcesso: string;
begin
  FoTela.cdsDados.First;
  while not FoTela.cdsDados.EOF do
  begin
    sNuProcesso := quotedStr(SomenteNumeros(FoTela.cdsDados.FieldByName(
      'CC_nuProcessoFmt').AsString));
    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := sNuProcesso
    else
      FoDados.fpgNuProcesso := FoDados.fpgNuProcesso + ',' + sNuProcesso;
    FoTela.cdsDados.Next;
  end;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

end;

end.

