unit ufpgConsCargaTests;

interface

uses
  ufpgConsCarga, ufpgGUITestCase, ufpgConsCargaModelTests, ufpgDataModelTests;

type
  TffpgConsCargaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsCarga;
    FoDados: TffpgConsCargaModelTests;
    procedure ConsultaCarga;
    procedure PreencheDados;
    procedure RealizarChecks;
    function VerificaGridVazia: boolean;
//    function VerificaNumeroLote: boolean;
//    function VerificaLocaldeorigem: boolean;
//    function VerificaDataRemessa: boolean;
//    function VerificaLocalDestino: boolean;
//    function VerificaDataRecebimento: boolean;
    function VerificaInformacoesAbaDetalhes: boolean;
    function VerificaLabelStatusLote: boolean;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConsultarCarga;
  end;

implementation

uses
  TestFrameWork, uspInterface, usajConstante, ufpgFuncoesGUITestes, SysUtils,
  ufpgVariaveisTestesGUI, ufpgConstanteGUITests;

{ TffpgConsCargaTests }

function TffpgConsCargaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsCargaModelTests;
end;

procedure TffpgConsCargaTests.TestarConsultarCarga;
begin
  ExecutarRoteiroTestes(ConsultaCarga);
end;

procedure TffpgConsCargaTests.ConsultaCarga;
begin
  AbrirTela;
  FoTela := TffpgConsCarga(spTela);
  FoDados := TffpgConsCargaModelTests(spDataModelTests);

  PreencheDados;

  FoTela.ccCadastro.Execute(acConsultar);

  RealizarChecks;
  FecharTela;
end;

procedure TffpgConsCargaTests.PreencheDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  if FoDados.fpgDataInicio = STRING_INDEFINIDO then
    FoDados.fpgDataInicio := FormatDateTime(CS_MASCARA_DATA_CURTA, now);

  if FoDados.fpgDataFim = STRING_INDEFINIDO then
    FoDados.fpgDataFim := FormatDateTime(CS_MASCARA_DATA_CURTA, now);

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  EnterTextInto(FoTela.sajPeriodo.FdfDataInicial, FoDados.fpgDataInicio);
  EnterTextInto(FoTela.sajPeriodo.FdfDataFinal, FoDados.fpgDataFim);
end;

function TffpgConsCargaTests.VerificaInformacoesAbaDetalhes: boolean;
begin
  result := True;
  if (FoTela.dfnulote.AsString = STRING_INDEFINIDO) and (FoTela.dfdtRemessa.Value = now) and
    (FoTela.dfdeLocalOrigem.AsString = STRING_INDEFINIDO) and
    (FoTela.dfnmUsuarioRemessa.AsString = STRING_INDEFINIDO) and
    (FoTela.dfdeMovimentacaoRemessa.AsString = STRING_INDEFINIDO) and
    (FoTela.dfdeLocalDestino.AsString = STRING_INDEFINIDO) then
  begin
    result := False;
  end;
end;

function TffpgConsCargaTests.VerificaLabelStatusLote: boolean;
begin
  result := True;
  if FoTela.lbStatusLote.Caption = '' then
  begin
    result := False;
  end;
end;

function TffpgConsCargaTests.VerificaGridVazia: boolean;
begin
  result := True;
  if FoTela.ecgoCarga.IsEmpty then
  begin
    result := False;
  end;
end;

//function TffpgConsCargaTests.VerificaNumeroLote: boolean;
//begin
//  result := True;
//  MudarAba(FoTela.PageControl, '&Detalhes');
//  if SomenteNumeros(FoTela.dfnulote.AsString) <> gsNuLote then
//  begin
//    result := False;
//  end;
//end;
//
//function TffpgConsCargaTests.VerificaLocaldeorigem: boolean;
//begin
//  result := True;
//  MudarAba(FoTela.PageControl, '&Detalhes');
//  if FoTela.dfdeLocalOrigem.AsString <> gsLocalOrigem then
//  begin
//    result := False;
//  end;
//end;
//
//function TffpgConsCargaTests.VerificaDataRemessa: boolean;
//begin
//  result := True;
//  MudarAba(FoTela.PageControl, '&Detalhes');
//  if FoTela.dfdtRemessa.Value <> StrToDate(gsDataRemessa) then
//  begin
//    result := False;
//  end;
//end;
//
//function TffpgConsCargaTests.VerificaLocalDestino: boolean;
//begin
//  result := True;
//  MudarAba(FoTela.PageControl, '&Detalhes');
//  if FoTela.dfdeLocalDestino.AsString <> gsLocalDestino then
//  begin
//    result := False;
//  end;
//end;
//
//function TffpgConsCargaTests.VerificaDataRecebimento: boolean;
//begin
//  result := True;
//  MudarAba(FoTela.PageControl, '&Detalhes');
//  if FoTela.dfdtRecebimento.Value <> StrToDate(gsDataRecebimento) then
//  begin
//    result := False;
//  end;
//end;

procedure TffpgConsCargaTests.RealizarChecks;
begin
  check(VerificaGridVazia, 'A consulta não retornou nenhuma informação');
  check(VerificaInformacoesAbaDetalhes, 'Esta faltando informação na aba detalhes');
  check(VerificaLabelStatusLote, 'A label não esta informando o status do lote');
end;

end.

