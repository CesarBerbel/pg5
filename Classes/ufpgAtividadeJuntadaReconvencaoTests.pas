unit ufpgAtividadeJuntadaReconvencaoTests;

interface

uses
  SysUtils, ufpgAtividadeJuntadaReconvencao, DB, DBClient, uspTestCase,
  ufpgParametrosAtividadesFluxo, uspExcecao;

type
  TCasoTeste = (ctDistNaoReferencia, ctClassesDiferentes);

  TfpgAtividadeJuntadaReconvencaoFake = class(TfpgAtividadeJuntadaReconvencao)
  protected
    function PegarClasseProcessoReferencia: integer; override;
    procedure TratarExcecaoRegraNegocio(pEExcecao: EspRegraNegocio); override;
    procedure FecharJanelaProcessamento; override;
    procedure ExibirJanelaProcessamento; override;
    procedure ValidarMovimentacaoProcesso; override;
    function TestarProcessoCancelado: boolean; override;
  end;

  TfpgAtividadeJuntadaReconvencaoTests = class(TSpTestCase)
  private
    FoAtividadeJuntadaReconvencao: TfpgAtividadeJuntadaReconvencaoFake;

    function CriarDataSetFluxo: tclientDataSet;
    function CriarParametrosAtividade: TfpgParametrosAtividadesFluxo;
    procedure AdicionarDadosSelecaoFluxo(pcdsSelecaoFluxo: TClientDataSet);
    procedure CriarEstruturaDataSet(pcdsSelecao: TClientDataSet);
    procedure AlterarDadosParaTesteAtual(pcdsSelecao: TClientDataSet);
    procedure ModificarDadosTesteClassesDiferentes(pcdsSelecao: TClientDataset);
    procedure ModificarDadosTesteProcessoApartado(pcdsSelecao: TClientDataSet);
    procedure ModificarDadosTesteSemProcessoRefer(pcdsSelecao: TClientDataSet);
    procedure TestExcJuntarComClassesDiferentes;
    procedure TestExcJuntarSemProcessoReferencia;
    procedure TestExcJuntarProcessoApartado;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestJuntarComClassesDiferentes;
    procedure TestJuntarSemProcessoReferencia;
    procedure TestJuntarProcessoApartado;

  end;

implementation

uses
  ufpgCamposHistObjeto, uSajConstante, uspClientDataSet, TestFrameWork, ufpgMensagem2;

const
  nCLASSE_TESTE_OK = 714;
  sCLASSE_TESTE_ERRO = 802;
  sPROCESSO_REFER_OK = '000X508797979';
  sNMTESTE_CLASSE = 'TestJuntarComClassesDiferentes';
  sNMTESTE_SEM_REFERENCIA = 'TestJuntarSemProcessoReferencia';
  sNMTESTE_APARTADO = 'TestJuntarProcessoApartado';

function TfpgAtividadeJuntadaReconvencaoTests.CriarDataSetFluxo: TClientDataSet;
begin
  result := TClientDataset.Create(nil); //PC_OK
  CriarEstruturaDataSet(result);
  AdicionarDadosSelecaoFluxo(result);
  AlterarDadosParaTesteAtual(result);
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.TestExcJuntarComClassesDiferentes;
begin
  FoAtividadeJuntadaReconvencao.ExecutarAtividade;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.TestExcJuntarSemProcessoReferencia;
begin
  FoAtividadeJuntadaReconvencao.ExecutarAtividade;
end;

function TfpgAtividadeJuntadaReconvencaoTests.CriarParametrosAtividade: TfpgParametrosAtividadesFluxo;
var
  cdsTemporario: TClientDataSet;
begin
  result := TfpgParametrosAtividadesFluxo.Create;//PC_OK
  cdsTemporario := CriarDataSetFluxo;
  try
    result.fpgSpDb := null;
    result.fpgObjsSelecionados.Data := cdsTemporario.Data;
    result.fpgDescricaoAtividadeAlternativa := 'Juntada de reconvenção';
    result.fpgDadosUsuarioFluxo.Data := null;
    result.fpgVersaoFluxo := 1;
    result.fpgFormPai := nil;
  finally
    FreeAndNil(cdsTemporario); //PC_OK
  end;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.AdicionarDadosSelecaoFluxo(
  pcdsSelecaoFluxo: TClientDataSet);
begin
  pcdsSelecaoFluxo.insert;
  pcdsSelecaoFluxo.FieldByName('flSelecionado').AsString := 'S';
  pcdsSelecaoFluxo.FieldByName('cdObjeto').AsString := '0N0000000DIC8';
  pcdsSelecaoFluxo.FieldByName('cdTipoObjeto').AsString := '1';
  pcdsSelecaoFluxo.FieldByName('cdTipoObjetoPai').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuSeqHist').AsString := '1';
  pcdsSelecaoFluxo.FieldByName('cdProcesso').AsString := '0N00520WQ1PQF';
  pcdsSelecaoFluxo.FieldByName('nuProcesso').AsString := '00008522820128120023';
  pcdsSelecaoFluxo.FieldByName('cdGrupoFluxoTrab').AsString := '7';
  pcdsSelecaoFluxo.FieldByName('cdFluxoTrabalho').AsString := '213';
  pcdsSelecaoFluxo.FieldByName('cdFila').AsString := '9001';
  pcdsSelecaoFluxo.FieldByName('cdPasta').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdForo').AsString := '23';
  pcdsSelecaoFluxo.FieldByName('cdVara').AsString := '93';
  pcdsSelecaoFluxo.FieldByName('cdCentral').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdClasseExt').AsString := '30714';
  pcdsSelecaoFluxo.FieldByName('deClasse').AsString := 'Outros';
  pcdsSelecaoFluxo.FieldByName('cdClasse').AsInteger := nCLASSE_TESTE_OK;
  pcdsSelecaoFluxo.FieldByName('flTipoClasse').AsString := '5';
  pcdsSelecaoFluxo.FieldByName('nmParteAtiva').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nmPartePassiva').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nmUsuarioCheckout').AsString := 'Softplan Poligraph';
  pcdsSelecaoFluxo.FieldByName('deObservacao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuDiasPrazoEnc').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nmDocumento').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdDocumento').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuSeqDocumentoAto').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdModelo').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdModeloAto').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdCategoria').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdCategoriaAto').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuDiasPrazoAto').AsString := '';
  pcdsSelecaoFluxo.FieldByName('sFiltroSelecaoPessoa').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdObjetoPai').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuSeqHistPai').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdFluxoTrabalhoPai').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdFilaPai').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdDocDig').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdProcessoPrinc').AsString := '0N00520WQ0000';
  pcdsSelecaoFluxo.FieldByName('cdObjetoProcesso').AsString := '0N0000000DIC8';
  pcdsSelecaoFluxo.FieldByName('cdProcessoRefer').AsString := '000X508797979';
  pcdsSelecaoFluxo.FieldByName('cdClasseProcesso').AsInteger := nCLASSE_TESTE_OK;
  pcdsSelecaoFluxo.FieldByName('CDASSUNTO').AsString := '';
  pcdsSelecaoFluxo.FieldByName('CDPARTEATIVAPRINC').AsString := '';
  pcdsSelecaoFluxo.FieldByName('CDVINCPESSOAATIVAPRINC').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuProcessoForm').AsString := '0000852-28.2012.8.12.0023/80007';
  pcdsSelecaoFluxo.FieldByName('cdAR').AsString := '';
  pcdsSelecaoFluxo.FieldByName('flEmiteAR').AsString := '';
  pcdsSelecaoFluxo.FieldByName('flProcVirtual').AsString := 'S';
  pcdsSelecaoFluxo.FieldByName('CDPESSOACALCULO').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuSeqPendencia').AsString := '';
  pcdsSelecaoFluxo.FieldByName('flTemDependentes').AsString := 'N';
  pcdsSelecaoFluxo.FieldByName('nuFluxoParalelo').AsString := '0';
  pcdsSelecaoFluxo.FieldByName('cdUsuarioCheckout').AsString := 'SOFTPLAN';
  pcdsSelecaoFluxo.FieldByName('flPossuiRestricao').AsString := 'N';
  pcdsSelecaoFluxo.FieldByName('cdImagem').AsString := '';
  pcdsSelecaoFluxo.FieldByName('flSomenteLeitura').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdUsuarioCriacao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdGrupo').AsString := '';
  pcdsSelecaoFluxo.FieldByName('flAssinaTDigital').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_OrdemSelecaoUsuario').AsString := '1';
  pcdsSelecaoFluxo.FieldByName('cc_cdPessoaAto').AsString := '';
  pcdsSelecaoFluxo.FieldByName('deListaTarja').AsString := '#7#;';
  pcdsSelecaoFluxo.FieldByName('CDPROCESSOMASTER').AsString := '0N00520WQ0000';
  pcdsSelecaoFluxo.FieldByName('FLCONFIDENCIAL').AsString := '';
  pcdsSelecaoFluxo.FieldByName('FLMODOFINALIZACAO').AsString := '';
  pcdsSelecaoFluxo.FieldByName('flJuntadaDigital').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdDocBinarioPDF').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdDocBinario').AsString := '';
  pcdsSelecaoFluxo.FieldByName('nuMandado').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdMandado').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdTipoServico').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdTipoEstadoAR').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cdTipoCartorio').AsString := '2';
  pcdsSelecaoFluxo.FieldByName('tpFormaTramita').AsString := 'P';
  pcdsSelecaoFluxo.FieldByName('cc_deRegimePrisao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_dtValidadeMandPrisao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_deSituacaoMandPrisao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_cdMandadoPrisao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_deTipoPrisao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_deTipoPena').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_flPossuiPecaDig').AsString := 'S';
  pcdsSelecaoFluxo.FieldByName('CC_FLAREAPROCESSO').AsString := 'Cível';
  pcdsSelecaoFluxo.FieldByName('cc_deSituacaoMandado').AsString := '';
  pcdsSelecaoFluxo.FieldByName('cc_dtValidadeMandado').AsString := '';
  pcdsSelecaoFluxo.FieldByName('flAudienciaPendente').AsString := '';
  pcdsSelecaoFluxo.FieldByName('CC_CDPESSOAPRESCRICAO').AsString := '';
  pcdsSelecaoFluxo.FieldByName('CC_cdVincPessoaPrescricao').AsString := '';
  pcdsSelecaoFluxo.FieldByName('CC_nmAlias').AsString := 'PG5ISC';
  pcdsSelecaoFluxo.FieldByName('CDJUIZ').AsString := '31691';
  pcdsSelecaoFluxo.FieldByName('flProcHibrido').AsString := 'N';
  pcdsSelecaoFluxo.FieldByName('tpControleTramita').AsString := 'D';
  pcdsSelecaoFluxo.post;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.CriarEstruturaDataSet(pcdsSelecao: TClientDataSet);
begin
  pcdsSelecao.FieldDefs.Add('flSelecionado', ftString, 1);
  pcdsSelecao.FieldDefs.Add('cdObjeto', ftString, 13);
  pcdsSelecao.FieldDefs.Add('cdTipoObjeto', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('cdTipoObjetoPai', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('nuSeqHist', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('cdProcesso', ftString, 30);
  pcdsSelecao.FieldDefs.Add('nuProcesso', ftString, 30);
  pcdsSelecao.FieldDefs.Add('cdGrupoFluxoTrab', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdFluxoTrabalho', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdFila', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdPasta', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdForo', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdVara', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdCentral', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdClasseExt', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('deClasse', ftString, 100);
  pcdsSelecao.FieldDefs.Add('cdClasse', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('flTipoClasse', ftString, 1);
  pcdsSelecao.FieldDefs.Add('nmParteAtiva', ftString, 100);
  pcdsSelecao.FieldDefs.Add('nmPartePassiva', ftString, 100);
  pcdsSelecao.FieldDefs.Add('nmUsuarioCheckout', ftString, 100);
  pcdsSelecao.FieldDefs.Add('deObservacao', ftString, 255);
  pcdsSelecao.FieldDefs.Add('nuDiasPrazoEnc', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('nmDocumento', ftString, 200);
  pcdsSelecao.FieldDefs.Add('cdDocumento', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('nuSeqDocumentoAto', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdModelo', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdModeloAto', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdCategoria', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdCategoriaAto', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('nuDiasPrazoAto', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('sFiltroSelecaoPessoa', ftString, 200);
  pcdsSelecao.FieldDefs.Add('cdObjetoPai', ftString, 13);
  pcdsSelecao.FieldDefs.Add('nuSeqHistPai', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('cdFluxoTrabalhoPai', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdFilaPai', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdDocDig', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdProcessoPrinc', ftString, 30);
  pcdsSelecao.FieldDefs.Add('cdObjetoProcesso', ftString, 13);
  pcdsSelecao.FieldDefs.Add('cdProcessoRefer', ftString, 13);
  pcdsSelecao.FieldDefs.Add('cdClasseProcesso', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('CDASSUNTO', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('CDPARTEATIVAPRINC', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('CDVINCPESSOAATIVAPRINC', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('nuProcessoForm', ftString, 50);
  pcdsSelecao.FieldDefs.Add('cdAR', ftString, 13);
  pcdsSelecao.FieldDefs.Add('flEmiteAR', ftString, 1);
  pcdsSelecao.FieldDefs.Add('flProcVirtual', ftString, 1);
  pcdsSelecao.FieldDefs.Add('CDPESSOACALCULO', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('nuSeqPendencia', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('flTemDependentes', ftString, 1);
  pcdsSelecao.FieldDefs.Add('nuFluxoParalelo', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('cdUsuarioCheckout', ftString, 100);
  pcdsSelecao.FieldDefs.Add('flPossuiRestricao', ftString, 1);
  pcdsSelecao.FieldDefs.Add('cdImagem', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('flSomenteLeitura', ftString, 1);
  pcdsSelecao.FieldDefs.Add('cdUsuarioCriacao', ftString, 30);
  pcdsSelecao.FieldDefs.Add('cdGrupo', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('flAssinaTDigital', ftString, 1);
  pcdsSelecao.FieldDefs.Add('cc_OrdemSelecaoUsuario', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('cc_cdPessoaAto', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('deListaTarja', ftString, 100);
  pcdsSelecao.FieldDefs.Add('CDPROCESSOMASTER', ftString, 30);
  pcdsSelecao.FieldDefs.Add('FLCONFIDENCIAL', ftString, 1);
  pcdsSelecao.FieldDefs.Add('FLMODOFINALIZACAO', ftString, 1);
  pcdsSelecao.FieldDefs.Add('flJuntadaDigital', ftString, 1);
  pcdsSelecao.FieldDefs.Add('cdDocBinarioPDF', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('cdDocBinario', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('nuMandado', ftString, 30);
  pcdsSelecao.FieldDefs.Add('cdMandado', ftString, 20);
  pcdsSelecao.FieldDefs.Add('cdTipoServico', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('cdTipoEstadoAR', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('cdTipoCartorio', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('tpFormaTramita', ftString, 1);
  pcdsSelecao.FieldDefs.Add('cc_deRegimePrisao', ftString, 15);
  pcdsSelecao.FieldDefs.Add('cc_dtValidadeMandPrisao', ftDateTime, 0);
  pcdsSelecao.FieldDefs.Add('cc_deSituacaoMandPrisao', ftString, 60);
  pcdsSelecao.FieldDefs.Add('cc_cdMandadoPrisao', ftString, 8);
  pcdsSelecao.FieldDefs.Add('cc_deTipoPrisao', ftString, 40);
  pcdsSelecao.FieldDefs.Add('cc_deTipoPena', ftString, 20);
  pcdsSelecao.FieldDefs.Add('cc_flPossuiPecaDig', ftString, 1);
  pcdsSelecao.FieldDefs.Add('CC_FLAREAPROCESSO', ftString, 10);
  pcdsSelecao.FieldDefs.Add('cc_deSituacaoMandado', ftString, 60);
  pcdsSelecao.FieldDefs.Add('cc_dtValidadeMandado', ftDateTime, 0);
  pcdsSelecao.FieldDefs.Add('flAudienciaPendente', ftString, 1);
  pcdsSelecao.FieldDefs.Add('CC_CDPESSOAPRESCRICAO', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('CC_cdVincPessoaPrescricao', ftFloat, 0);
  pcdsSelecao.FieldDefs.Add('CC_nmAlias', ftString, 20);
  pcdsSelecao.FieldDefs.Add('CDJUIZ', ftInteger, 0);
  pcdsSelecao.FieldDefs.Add('flProcHibrido', ftString, 1);
  pcdsSelecao.FieldDefs.Add('tpControleTramita', ftString, 1);
  pcdsSelecao.CreateDataSet;
  pcdsSelecao.Active := True;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.AlterarDadosParaTesteAtual(
  pcdsSelecao: TClientDataSet);
begin
  if FTestName = sNMTESTE_CLASSE then
  begin
    ModificarDadosTesteClassesDiferentes(pcdsSelecao);
    exit;
  end;

  if FTestName = sNMTESTE_SEM_REFERENCIA then
  begin
    ModificarDadosTesteSemProcessoRefer(pcdsSelecao);
    Exit;
  end;

  if FTestName = sNMTESTE_APARTADO then
  begin
    ModificarDadosTesteProcessoApartado(pcdsSelecao);
    Exit;
  end;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.ModificarDadosTesteClassesDiferentes(
  pcdsSelecao: TClientDataset);
begin
  pcdsSelecao.edit;
  pcdsSelecao.FieldByName('cdClasseProcesso').AsInteger := sCLASSE_TESTE_ERRO;
  pcdsSelecao.post;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.ModificarDadosTesteProcessoApartado(
  pcdsSelecao: TClientDataSet);
begin
  pcdsSelecao.edit;
  pcdsSelecao.FieldByName('tpFormaTramita').AsString := sTpFormaTramitaApartado;
  pcdsSelecao.post;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.ModificarDadosTesteSemProcessoRefer(
  pcdsSelecao: TClientDataSet);
begin
  pcdsSelecao.edit;
  pcdsSelecao.FieldByName('cdProcessoRefer').AsString := STRING_INDEFINIDO;
  pcdsSelecao.post;
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.SetUp;
var
  oParamsAtividade: TfpgParametrosAtividadesFluxo;
begin
  oParamsAtividade := CriarParametrosAtividade;
  FoAtividadeJuntadaReconvencao := TfpgAtividadeJuntadaReconvencaoFake.Create(oParamsAtividade);//PC_OK
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.TearDown;
begin
  FreeAndNil(FoAtividadeJuntadaReconvencao); //PC_OK 
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.TestJuntarComClassesDiferentes;
begin
  CheckException(TestExcJuntarComClassesDiferentes, EspRegraNegocio);
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.TestJuntarSemProcessoReferencia;
begin
  CheckException(TestExcJuntarSemProcessoReferencia, EspRegraNegocio);
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.TestJuntarProcessoApartado;
begin
  CheckException(TestExcJuntarProcessoApartado, EspRegraNegocio);
end;

procedure TfpgAtividadeJuntadaReconvencaoTests.TestExcJuntarProcessoApartado;
begin
  FoAtividadeJuntadaReconvencao.ExecutarAtividade;
end;

procedure TfpgAtividadeJuntadaReconvencaoFake.ExibirJanelaProcessamento;
begin
  Exit;
end;

procedure TfpgAtividadeJuntadaReconvencaoFake.FecharJanelaProcessamento;
begin
  Exit;
end;

function TfpgAtividadeJuntadaReconvencaoFake.PegarClasseProcessoReferencia: integer;
begin
  result := nCLASSE_TESTE_OK;
end;

function TfpgAtividadeJuntadaReconvencaoFake.TestarProcessoCancelado: boolean;
begin
  result := False;
end;

procedure TfpgAtividadeJuntadaReconvencaoFake.TratarExcecaoRegraNegocio(
  pEExcecao: EspRegraNegocio);
begin
  TspExcecao.EmitirExcecaoRegraNegocio(pEExcecao.spCodigo, pEExcecao.message);
end;

procedure TfpgAtividadeJuntadaReconvencaoFake.ValidarMovimentacaoProcesso;
begin
  exit;
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Classes\ufpgAtividadeJuntadaReconvencaoTests',
    TfpgAtividadeJuntadaReconvencaoTests.Suite);

end.

