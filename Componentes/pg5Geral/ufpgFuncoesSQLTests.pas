  {*************************************************
  **************************************************
  * 15/04/2016 - Carlos.Gaspar - SALT: 186660/25/1 *
  **************************************************
  * Unit uspjFuncoesSQLTests criada para reunir as *
  * funções para validar em banco de dados os      *
  * testes automatizados.                          *
  **************************************************
  * Índice:                                        *
  * - Atualização                                  *
  * - Conversão                                    *
  * - Geração                                      *
  * - Seleção                                      *
  * - Data                                         *
  * - Limpeza                                      *
  * - Executar                                     *
  * - Processo                                     *
  * - Criação                                      *
  *                                                *
  **************************************************
  *************************************************}
unit ufpgFuncoesSQLTests;

interface

uses
  uspFuncoesSQL, uspAplicacao, uspDatabase, ufpgConstanteSQLTests, SysUtils,
  ufpgConstanteGUISQLTests;


// 20/11/2015  - Carlos.Gaspar - SALT: 186660/23/7
function RetornaVerificacaoSentenca(psTipoMvProcesso: string; psNuProcesso: string): WideString;

function RetronaLotacaoUsuario(psCdAgente: string): WideString;

function RetornaPublicaPessoa(psNuProcesso: string): WideString;

function RetornaVerificaVincrecolMand(psNuProcesso, psNuMandado, psCdCalculoGRJ: string): WideString;

function RetornaSiglaClienteSQL: WideString;

function RetornaVerificaCancelamentoProcesso(psNuProcesso: string): WideString;

function RetornaValidarLocalRemessaPendente(psNuLote: string; psNuForo: string;
  psCdTipoLocalDestino: string): WideString;

function RetornaVerificarStatusSigilo(psNuProcesso: string): WideString;

function RetornaVerificarExistenciaLote(psNuLote: string): WideString;

function RetornaDigDocumento(psNuProcesso: string): WideString;

function RetornaCdMandado(psNuProcesso: string): WideString;

function RetornaVerificarDadosMandadoRedistribuido(psNuProcesso: string): WideString;

function RetornaVerificarAgenteMandadoDistribuido(psNuProcesso: string): WideString;

function RetornaAgenteDocEmitido(pscdDocumento: string; psCdProcesso: string): WideString;

function RetornaVerificarTransferenciaMandado(psNuProcesso: string;
  psCdAgente: string): WideString;

function RetornaCdUsuarioAgente(psNomeAgente: string): WideString;

function RetornarIncluirAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;

function RetornarAfastarAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;

function RetornarIncluirAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;

function RetornarAfastarAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;

function RetornarUltimaMovimentacaoFluxo(psNuMandado: string): WideString;

function RetornarSituacaoMandadoAtualizadoNaoDistribuido(psNuMandado: string): WideString;

function RetornarSituacaoMandadoAtualizado(psNuMandado: string): WideString;

function RetornarVerificarRecebimentoNumeroLote(psNuLote: string; psCdForo: string;
  psNuProcesso: string): WideString;

function RetornarVerificarCargaRemetidaLote(psNuLote: string;
  psCdTipoLocalDestino: string): WideString;

function RetornarGRJ(psCdForo: string; psNuGrjEmitida: string): WideString;

function RetornarDistribuicaoMandado(psCdTipoDistMand: string; psCdAgente: string;
  psNuMandado: string): WideString;

//César fez aqui
function RetornarFilaProcessoSql(psNuprocesso: string; psFila: string): WideString;

function RetornarProcessoSql(psSituacao: string): WideString;

function RetornarAudienciaMarcadaSql(psNuprocesso: string): WideString;

function RetornarDocumentoEmitidoSql(psNuprocesso: string): WideString;

function RetornarMudouVaraSql(psNuprocesso: string; psUnicaVara: boolean): WideString;

function RetornarCadastroContatoSql(psNuCPF: string): WideString;

function RetornarCdProcessoSql(psNuprocesso: string): WideString;

function VerificarCadastroParteSql(psNuPessoa: string; psNuprocesso: string): WideString;

function RetornarMudouVagaSql(psCdVaga: string; psNuprocesso: string): WideString;

function RetornarRealmenteEncaminhouSql(psNuprocesso: string): WideString;

function VerificarCadastroBemSql(psNuprocesso: string): WideString;

//function VerificarPeticaoExcepcionalInicialSql(psNuProtocolo: string): WideString;

function VerificarPeticaoCadastradaSql(psNuprocesso, psNuClasseProcesso: string): WideString;

function RetornarNumeroProcessoSql: WideString;

//function SqlChecarProtocoloDocumento(psNuprocesso: string; psNuProtocolo: string): WideString;

//function ChecarProtocoloSql(psNuProtocolo: string): WideString;

function RetornarDataAudienciaSql(psCDVara, psCDSala: string): WideString;

function PropriedadesDocumentoSql(psNuProcesso: string; psCdDocumento: string): WideString;

function VerificarPeticaoInicialSql(psNuProcesso: string; psTpSigilo: string): WideString;

function RetornarProcessoMovUnitariaSql(psNomePessoa: string): WideString;

function VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso: string): WideString;

function VerificarAssuntoInseridoSql(psNuProcesso: string): WideString;

function VerificarApensamentoSql(psCdProcesso: string): WideString;

function VerificarNuProcessoSql(psNuProcesso: string): WideString;

function RetornarProcessosMovimentacoesLoteSql: WideString;

function VerifcarMovimetacoesLoteSql(psNuProcessos: string): WideString;

function VerifcarExclusaoMovimetacaoSql(psCdProcesso: string): WideString;

function RetornarProcessoEmissaoDocDtAlteradaSql: WideString;

function VerificarDtMovDocumentoSql(psNuprocesso: string): WideString;

function VerificarPeticaoIntermdiariaSql(psNuprocesso: string): WideString;

function RetornarProcessoNaoFinalizadoSql: WideString;

function VerifcarRecadoInseridoSql(psCdUsuarioDestino, psDeRecado: string): WideString;

function VerifcarAutoTextoSql(psCdUsuario, psNmAbrevAutoTexto, psCdGrupo: string): WideString;

function RetornarProcessoApreensaoSql: WideString;

function VerificarProcessoFisicoApreensaoSql(psNuProcesso, psCdCategoriaBem: string): WideString;

function RetornarProcessoEdicaoDocSql: WideString;

function VerifcarpeticaoDiversaSql(psNuProcesso: string): WideString;

function RetornarDocEmitidoSql(psCategoria, psModelo, psNuProcesso: string): WideString;

function VerifcarCadastroProcessoProtocoloSql(psNuProcesso: string): WideString;

function RetornarProcessoBemSql(psNuProcesso: string): WideString;

function RetornarProcessoAlteracaoSql: WideString;

function RetornarNomeDocSql(psNuProcesso, psCategoria, psModelo: string): WideString;

function RetornarProcessoExpedienteFinalSql: WideString;

function VerificarProcessoLiberadoAutosSql(psNuProcesso, psCdCategoria, psCdModelo: string): WideString;

function RetornarCorrecaoClasseSql(psNuProcesso: string): WideString;

function RetornarProcessoSimplesSql: WideString;

function RetornarProcessoDocumentoCompartilharSql: WideString;

function VerificarExisteProcessoDistribuicaoSql(psData, psCDForo, psCDTipoCartorio: string): WideString;

function VerificarEncaminhamentoSql(psNuProcesso: string): WideString;

function RetornarDocumentoProcessoSql(psNuProcesso: string): WideString;

function RetornarProcessoDistribuidoSemPendenciaSql: WideString;

function RetornarProcessoLocalFisicoSql(psCdForo: string): WideString;

function RetornarProcessoVisualizaDocSql: WideString;

function RetornarProcessoVirtualizadoSql(psNuProcesso: string): WideString;

function VerificarProcessoDependenteSql(psNuProcesso: string): WideString;

function VerificarPeticaoIntermediariaSql(psNuProcesso: string): WideString;

function VerificarDistribuicaoProcessoSql(psNuProcesso: string): WideString;

function VerificarProcessoFisicoSql(psNuProcesso: string): WideString;

function VerificarProcessoRemetidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;

function VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;

function VerificarMovimentacaoProcessoSql(psNuProcesso, psCDTipoMVProcesso: string): WideString;

function VerificarMandadoEmetidoSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;

function VerificarMandadoCriadoSql(psCDModelo, psNuprocesso: string): WideString;

function VerificarIntimacaoEmitidaSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;

function VerificarIntimacaoCriadaSql(psCDModelo, psNuprocesso: string): WideString;

function RetornaProcessoDemonsDistribSql(pscdForo: string): WideString;

function RetornarAtualizarDtCumprimentoDtVenctoPrazo(psDataVenctoPrazo: string;
  psNuProcesso: string): WideString;

function RetornarVerificarProcessoNovoDesmembrado(psNuProcesso, psNome, psSituacao: string): WideString;

function RetornarVerificarProcessoUnificado(psNuProcesso: string): WideString;

function RetornarVerificarEmailRecebido(psNmParte: string): WideString;

function RetornarVerificarOficioImpresso(psDeOperacao: string): WideString;

//function RetornarVerificarProcessoUnificado(psCdProcesso: string;
//  psNmOutroInteressado: string): WideString;

function RetornarVerificarTesteConsultaAutos(psNuProcesso: string; psAnotacao: string): WideString;

function RetornarVerificarCancelamentoJuntada(psCdProcessoApenso: string): WideString;

function RetornarPeticaoSalva(psNuProcesso: string; psDeClasse: string): WideString;

function RetornarVerificarCopiaPartes(psNuProcesso: string; psDeClasse: string): WideString;

function RetornarJuntadaProcessoDependente(psNuProcesso: string;
  psCdTipoMvProcesso: string): WideString;

function RetornarVerificarCertidaoEmitida(psCdSituacao: string; psNuPedido: string): WideString;

function RetornarVaraDoProcesso(psNuProcesso: string): WideString;

function RetornarLiberouDocumentoAutos(psCdDocumentoEdt: string): WideString;

function RetornarNuProcessoCompleto(psNuProcesso: string): WideString;

function RetornarDocumentoEmitdoGGP(psCdDocumento: string): WideString;

function RetornarDocumentoEmitdo2(psCdDocumento: string): WideString;

function RetornarVerificarHistoricoParte(psNuProcesso: string; psQtde: string): WideString;

function RetornarVerificarParteIndiciado(psNmPessoa: string; psNuProcesso: string): WideString;

function RetornarVerificarObservacaoDocumento(psCdDocumnento: string): WideString;

function RetornarVerificarObservacaoProcessoFluxoTrabalho(psNuProcesso: string): WideString;

function RetornarVerificarDevolucaoAR(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;

function RetornarVerificarARAguardandoJuntada(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

function RetornarVerificarARJuntadaProcesso(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

//  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;

function RetornarVerificarParcelasMulta(psNuProcesso: string): WideString;

function RetornarMovimentacaoCategoria(psCdCategoria: string;
  psCdTipoMvProcesso: string): WideString;

function RetornarVerificarARRemetido(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;

function RetornarRecebidoNoCartorio(psNuLote: string; psCdARTJ: string): WideString;

function RetornarVerificarNumeroDocumentoAlterado(psCdARTJ: string;
  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;

function RetornarVerificarSituacaoAR(psCdARTJ: string): WideString;

function RetornarSituacaoMandado(psCdSituacaoMandado: string; psNuMandado: string): WideString;

function RetornarVerificarVinculacaoAgenteVara(psCdForo: string; psCdLocal: string;
  psCdAgente: string): WideString;

function RetornarVerificarEntranhamento(psCdTipoMvProcesso: string; psData: string;
  psCdProcesso: string; psCdProcessoApenso: string): WideString;

function RetornarParteUsuarioNet(psCdUsuarioNet: string; psDados: string): WideString;

function RetornarVerificarMandadoExcepcional(psCdModelo: string; psNuProcesso: string): WideString;

function RetornarProcessoDocumentoAssinado: WideString;

function RetornarProcessoRelAnaliticoSql(psCdForo, psCDVara, psCdUltimMv: string): WideString;

function RetornarPeticaoMarcadaSigiloConsulta(psNuProcesso: string): WideString;

function RetornarVerificarARGerada(psCdARTJ: string): WideString;

function RetornarAlteraTipoEstadoAR(psCdARTJ: string): WideString;

function RetornarArquivoMultiMidia(psNuProcesso: string; psNmArqMultiMidia: string): WideString;

function RetornarGerarGuiaPostagemAR(psCdForo: string; psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

function RetornarARRemetidoNaoRecebido(psNuLote: string; psCdARTJ: string): WideString;

function RetornarCopiaFila(psCdFila: string; psNuprocesso: string): WideString;

function RetornarNuProcessoSemPendencia(pnQtdeLinhas: integer): WideString;

function RetornarVerificarLocalProcessoFisico(psCdProcesso: string): WideString;

function RetornarEnderecoCPF(psNuDocumento: string): WideString;

function RetornarVerificarProcessoCancelado(psNuProcesso: string): WideString;

function RetornarVerificarProcessoRegSentenca(psCdTipoMvProcesso: string;
  psNuProcesso: string): WideString;

function RetornarProcessoRegistroSentenca(psCdCategoria: string;
  pnQtdeLinhas: integer): WideString;

function RetornarProcessoConsProcBasica(pnQtdeLinhas: integer): WideString;

function RetornarIncluirUsuarioNet(psCdPessoa: string; psCdUsuarioNet: string): WideString;

function RetornarProcessoRelExtrato(pnQtdeLinhas: integer;
  psCdForo, psCDVara, psCdUltimMv: string): WideString;

function RetornarRelCalculoIdade(psCdVara: string; pnQtdeLinhas: integer): WideString;

function RetornarVerificarMandadoDevolvidoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;

function RetornarVerificarDevolvicaoMandadoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;

function RetornarSenhaGerada(psCdProcesso: string; psNmOutroInteressado: string): WideString;

function RetornarVerificarAlteracaoPautaAudienciaBloco(psCdSala: string;
  psCdVara: string; psCdTipoAudiencia: string; psNuProcesso: string): WideString;

function RetornarVerificarAudienciaCancelada(psCdAudiencia: string;
  psCdSituacaoAudi: string): WideString;

function VerificarMandadoRemetidoCMSql(psNuLote, psCDTipoLocalOrigemSQL,
  psCDTipoLocalDestinoSQL: string): WideString;

function RetornarVerficarSituacaoProcesso(psSituacaoProcesso: string;
  psNuProcesso: string): WideString;

function RetornarVerficarSigiloProcessoSQL(psNuProcesso: string; psTipoSigilo: string): WideString;

function VerificarMandadoDistribuidoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarMandadoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarMandadoDistribuidoCentralSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarSituacaoMandadoSql(psNuprocesso, psSituacao, psOficialJustica,
  psCDTipoOperacaoSQL2: string): WideString;

function RetornarVerficarProcessoReativadoSQL(psNuProcesso: string): WideString;

function VerificarJuntadaSql(psNuprocesso: string): WideString;

function VerificarForoProcessoSql(psNuprocesso: string; psCdForo: string): WideString;

function RetornarEsquema: string;

// 26/10/2016  - Carlos.Gaspar - TASK: 66977
function ValidarHorarioAtendimento(psCdForo: string; psCdVara: string;
  psNmAlias: string; psHorario: string): WideString;

function VerificaRegistroSentencaSQL(psNuProcesso: string): WideString;

implementation

//César fez isso aqui

function RetornarFilaProcessoSql(psNuprocesso: string; psFila: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_FILA_PROCESSO, [sEsquema, sEsquema, psFila,
    sEsquema, quotedstr(psNuprocesso + '%'), sEsquema]);
end;

function RetornarProcessoSql(psSituacao: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_PROCESSO, [sEsquema, sEsquema, psSituacao,
      FoFuncoesSQL.dthr('01/01/2015')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarAudienciaMarcadaSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_AUDIENCIA_MARCADA, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuprocesso)]);
end;

function RetornarDocumentoEmitidoSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DOCUMENTO_EMITIDO, [sEsquema, sEsquema, quotedstr(psNuprocesso)]);
end;

function RetornarMudouVaraSql(psNuprocesso: string; psUnicaVara: boolean): WideString;
var
  sEsquema: string;
  sSelect: string;
  sCondicao: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  if psUnicaVara then
  begin
    sSelect := 'SELECT CASE WHEN EDP1.CDVARA <> EDP.CDVARA      ' + #13 +
      '       THEN 1                                   ' + #13 +
      '       ELSE 0 END ENCONTROU                     ';
    sCondicao := '    AND EDP.NUSEQDISTRIB = (EDP1.NUSEQDISTRIB-1)';
  end
  else
  begin
    sSelect := ' SELECT COUNT(1) TOTAL                          ';
    sCondicao := ' ';
  end;

  result := Format(SQL_RETORNA_MUDOU_VARA, [sSelect, sEsquema, sEsquema,
    quotedstr(psNuprocesso), sCondicao]);
end;

function RetornarCadastroContatoSql(psNuCPF: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_CADASTRO_CONTATO, [sEsquema, quotedstr(psNuCPF)]);
end;

function RetornarCdProcessoSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_CDPROCESSO, [sEsquema, quotedstr(psNuprocesso + '%')]);
end;

function VerificarCadastroParteSql(psNuPessoa: string; psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CADASTRO_PARTE, [sEsquema, sEsquema,
    quotedstr(psNuPessoa), sEsquema, quotedstr(psNuprocesso + '%')]);
end;

function RetornarMudouVagaSql(psCdVaga: string; psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_MUDOU_VAGA, [psCdVaga, sEsquema, sEsquema,
    quotedstr(psNuprocesso + '%')]);
end;

function RetornarRealmenteEncaminhouSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_REALMENTE_ENCAMINHOU, [sEsquema, quotedstr(psNuprocesso + '%')]);
end;

function VerificarCadastroBemSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CADASTRO_BEM, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuprocesso)]);
end;

//function VerificarPeticaoExcepcionalInicialSql(psNuProtocolo: string): WideString;
//var
//  FospAplicacao: TspAplicacao;
//  sEsquema: string;
//begin
//  FospAplicacao := TspAplicacao.Create;
//  try
//    sEsquema := FospAplicacao.spEsquema + '.';
//  finally
//    result := Format(SQL_VERIFICA_PETICAO_EXCEPCIONAL_INICIAL,
//      [sEsquema, quotedstr(psNuProtocolo)]);
//    FreeAndNil(FospAplicacao);
//  end;
//end;

function VerificarPeticaoCadastradaSql(psNuprocesso, psNuClasseProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    result := Format(SQL_VERIFICA_PETICAO_CADASTRADA, [sEsquema, sEsquema,
      quotedstr(psNuprocesso), FoFuncoesSQL.DateTimeToDate('DTUSUINCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, psNuClasseProcesso]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarNumeroProcessoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUMERO_PROCESSO,
      [sEsquema, FoFuncoesSQL.dthr('01/01/2015')]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

//function SqlChecarProtocoloDocumento(psNuprocesso: string; psNuProtocolo: string): WideString;
//var
//  FospAplicacao: TspAplicacao;
//  sEsquema: string;
//begin
//  FospAplicacao := TspAplicacao.Create;
//  try
//    sEsquema := FospAplicacao.spEsquema + '.';
//  finally
//    result := Format(SQL_CHECAR_PROTOCOLO_DOCUMENTO, [sEsquema, sEsquema,
//      quotedstr(psNuprocesso + '%'), psNuProtocolo]);
//    FreeAndNil(FospAplicacao);
//  end;
//end;

//function ChecarProtocoloSql(psNuProtocolo: string): WideString;
//var
//  FospAplicacao: TspAplicacao;
//  sEsquema: string;
//begin
//  FospAplicacao := TspAplicacao.Create;
//  try
//    sEsquema := FospAplicacao.spEsquema + '.';
//  finally
//    result := Format(SQL_CHECAR_PROTOCOLO, [sEsquema, quotedstr(psNuProtocolo)]);
//    FreeAndNil(FospAplicacao);
//  end;
//end;

function PropriedadesDocumentoSql(psNuProcesso: string; psCdDocumento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_PROPRIEDADES_DOCUMENTO, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuProcesso), quotedstr(psCdDocumento)]);
end;

function VerificarPeticaoInicialSql(psNuProcesso: string; psTpSigilo: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERICAR_PETICAO_INICIAL, [sEsquema, quotedstr(psNuProcesso + '%'),
    quotedstr(psTpSigilo)]);
end;

{
Esse Aqui tem que ver como fazer
Não está sendo usado em nenhuma UNIT
verificar quem fez este SQL
function RETORNAR_NOME_PARTE_EXISTE(psNomePessoa: string): WideString;
var
  FospAplicacao: TspAplicacao;
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FospAplicacao := TspAplicacao.Create;
  try
    sEsquema := FospAplicacao.spEsquema + '.';
  finally
    result := Format(SQL_RETORNAR_NOME_PARTE_EXISTE, [sEsquema, quotedstr(psNuProcesso + '%'), quotedstr(psTpSigilo)]);
    FreeAndNil(FospAplicacao);
    FreeAndNil(FoFuncoesSQL);
  end;
end;


}

function RetornarProcessoMovUnitariaSql(psNomePessoa: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNAR_PROCESSO_MOV_UNITARIA,
      [sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_MOV_UNITARIA, [sEsquema, sEsquema,
    quotedstr(psTpMovimentacao), quotedstr(psTpMovimentacao), sEsquema,
    quotedstr(psNuProcesso + '%')]);
end;

// 26/05/2015 - MURILO.CRISTIANO - SALT: 186660/2/2
//SQL_RETORNA_QTDE_REGISTRO_PAUTA_AUD_TABELADO =
//  'SELECT COUNT(1) QTDE                                                                                              ' + #13 +      Esse SQL não foi localizado
//  '  FROM EGGPAUDIENCIA EPA                                                                                          ' + #13 +      em lugar nenhum
//  ' WHERE TO_DATE(EPA.DTINICIO, ''DD/MM/YYYY'') BETWEEN TO_DATE(%S, ''DD/MM/YYYY'') AND TO_DATE(%S, ''DD/MM/YYYY'')  ';

function VerificarAssuntoInseridoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_ASSUNTO_INSERIDO, [sEsquema, sEsquema,
    quotedstr(psNuProcesso + '%')]);
end;

function VerificarApensamentoSql(psCdProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_APENSAMENTO, [sEsquema, quotedstr(psCdProcesso), sEsquema]);
end;

function VerificarNuProcessoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_NUPROCESSO, [sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function RetornarProcessosMovimentacoesLoteSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNAR_PROCESSOS_MOVIMENTACOES_LOTE,
      [sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarMovimetacoesLoteSql(psNuProcessos: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_CHECAR_MOVIMENTACOES_LANCADAS_EM_LOTE, [sEsquema, sEsquema, psNuProcessos]);
end;

//05/12/2015 - leandro.humbert
function VerifcarExclusaoMovimetacaoSql(psCdProcesso: string): WideString;
var
  sEsquema: string;
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_EXCLUSAO_MOVIMENTACAO,
      [sEsquema, QuotedStr(psCdProcesso), FoFuncoesSQL.DateTimeToDate('EPM.DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, sEsquema, FoFuncoesSQL.DateTimeToDate('DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoEmissaoDocDtAlteradaSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_EMISSAO_DOC_DTALTERADA,
      [sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarDtMovDocumentoSql(psNuprocesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_DTMOV_DOCUMENTO, [sEsquema, sEsquema,
      quotedstr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('PROMV.DTULTALTERACAO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarPeticaoIntermdiariaSql(psNuprocesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PETICAO_INTERMEDIARIA,
      [sEsquema, quotedstr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('DTRECEBIMENTO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoNaoFinalizadoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_NAOFINALIZADO,
      [sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarRecadoInseridoSql(psCdUsuarioDestino, psDeRecado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_RECADO_INSERIDO, [sEsquema, quotedstr(psCdUsuarioDestino),
    quotedstr(psDeRecado)]);
end;

function VerifcarAutoTextoSql(psCdUsuario, psNmAbrevAutoTexto, psCdGrupo: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AUTOTEXTO, [sEsquema, sEsquema, quotedstr(psCdUsuario),
    quotedstr(psNmAbrevAutoTexto), psCdGrupo]);
end;

function RetornarProcessoApreensaoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_FISICO_APREENSAO,
      [sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarProcessoFisicoApreensaoSql(psNuProcesso, psCdCategoriaBem: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_NUPROCESSO_FISICO_APREENSAO,
      [sEsquema, sEsquema, quotedstr(psNuProcesso + '%'),
      FoFuncoesSQL.DateTimeToDate('EB.DTENTRADA'),
      FoFuncoesSQL.DataAtualTruncada, psCdCategoriaBem]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoEdicaoDocSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_EDICAO_DOC,
      [FoFuncoesSQL.substring('NUPROCESSO', 1, 13), sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarpeticaoDiversaSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_PETICAO_DIVERSA, [sEsquema, sEsquema, sEsquema,
    sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function RetornarProcessoBemSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_PROCESSO_BEM, [sEsquema, sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function RetornarDocEmitidoSql(psCategoria, psModelo, psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_DOC_EMITIDO,
      [sEsquema, FoFuncoesSQL.DateTimeToDate('EDOC.DTFINALIZACAO'),
      FoFuncoesSQL.DataAtualTruncada, quotedstr(psCategoria), quotedstr(psModelo),
      sEsquema, quotedstr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarCadastroProcessoProtocoloSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CADASTRO_PROCESSO_PROTOCOLO, [sEsquema, psNuProcesso, sEsquema]);
end;

function RetornarProcessoAlteracaoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_ALTERACAO, [sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarNomeDocSql(psNuProcesso, psCategoria, psModelo: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_NOME_DOC, [sEsquema, quotedstr(psNuProcesso),
    quotedstr(psCategoria), quotedstr(psModelo)]);
end;

function RetornarProcessoExpedienteFinalSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_VIRTUAL_EXPEDIENTE_FINAL,
      [sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarProcessoLiberadoAutosSql(psNuProcesso, psCdCategoria, psCdModelo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PROCESSO_LIBERADO_AUTOS, [sEsquema, sEsquema,
      Quotedstr(psNuProcesso), FoFuncoesSQL.DateTimeToDate('DTFINALIZACAO'),
      FoFuncoesSQL.DataAtualTruncada, Quotedstr(psCdCategoria), Quotedstr(psCdModelo)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarCorrecaoClasseSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_CORRECAO_CLASSE, [sEsquema, sEsquema, sEsquema,
      Quotedstr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('EHC1.DTMUDANCA'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoSimplesSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_SIMPLES,
      [sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoDocumentoCompartilharSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DOCUMENTO_COMPARTILHAR,
      [FoFuncoesSQL.substring('PRO.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarExisteProcessoDistribuicaoSql(psData, psCDForo, psCDTipoCartorio: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_EXISTE_PROCESSO_DISTRIBUICAO,
      [sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, sEsquema,
      FoFuncoesSQL.DtHr(psData), FoFuncoesSQL.DtHr(psData), QuotedStr(psCDForo),
      QuotedStr(psCDTipoCartorio)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarEncaminhamentoSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_ENCAMINHAMENTO, [sEsquema, QuotedStr(psNuProcesso + '%'),
      FoFuncoesSQL.DateTimeToDate('DTMOVIMENTO'), FoFuncoesSQL.DataAtualTruncada,
      sEsquema, QuotedStr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('DTMOVIMENTO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarDocumentoProcessoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_EXISTE_DOCUMENTO_PROCESSO, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuProcesso)]);
end;

function RetornarProcessoDistribuidoSemPendenciaSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DISTRIBUIDO_SEM_PENDENCIA,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoLocalFisicoSql(psCdForo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUMERO_PROCESSO_LOCAL_FISICO,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, psCdForo]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;


function RetornarProcessoVisualizaDocSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_VISUALIZA_DOCUMENTO,
      [FoFuncoesSQL.substring('P.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoVirtualizadoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNAR_PROCESSO_VIRTUALIZADO, [sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function VerificarProcessoDependenteSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_PROCESSO_DEPENDENTE, [sEsquema, quotedstr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarPeticaoIntermediariaSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_PROCESSO_DEPENDENTE, [sEsquema, quotedstr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarDistribuicaoProcessoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_DISTRIBUICAO_PROCESSO, [sEsquema, sEsquema,
    sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function VerificarProcessoFisicoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_FISICO, [sEsquema, sEsquema,
    quotedstr(psNuProcesso + '%')]);
end;

function VerificarProcessoRemetidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_REMETIDO, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuLote), quotedstr(psNuProcesso + '%'), quotedstr(psTpLocalDestino)]);
end;

function VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PROCESSO_RECEBIDO, [sEsquema, sEsquema, sEsquema,
      FoFuncoesSQL.DateTimeToDate('EC.DTRECEBIMENTO'), FoFuncoesSQL.DataAtualTruncada,
      quotedstr(psNuLote), quotedstr(psNuProcesso + '%'), quotedstr(psTpLocalDestino)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMovimentacaoProcessoSql(psNuProcesso, psCDTipoMVProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_MOVIMENTACAO_PROCESSO, [sEsquema, sEsquema,
      sEsquema, quotedstr(psNuProcesso + '%'), quotedstr(psCDTipoMVProcesso),
      FoFuncoesSQL.DateTimeToDate('EPM.DTMOVIMENTO'), FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoEmetidoSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDADO_EMITIDO, [sEsquema, sEsquema,
    quotedstr(psCDCategoria), quotedstr(psCDModelo), quotedstr(psNuProcesso + '%'),
    quotedstr(psCDAssuntoPrinc)]);
end;

function VerificarMandadoCriadoSql(psCDModelo, psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDADO_CRIADO, [sEsquema, sEsquema,
    quotedstr(psCDModelo), quotedstr(psNuProcesso + '%')]);
end;

function VerificarIntimacaoEmitidaSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_INTIMACAO_EMITIDA, [sEsquema, sEsquema,
    quotedstr(psCDCategoria), quotedstr(psCDModelo), quotedstr(psNuProcesso + '%'),
    quotedstr(psCDAssuntoPrinc)]);
end;

function VerificarIntimacaoCriadaSql(psCDModelo, psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_INTIMACAO_CRIADA, [sEsquema, sEsquema,
    quotedstr(psCDModelo), quotedstr(psNuProcesso + '%')]);
end;

function RetornaProcessoDemonsDistribSql(pscdForo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DEMONS_DISTRIB,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, pscdForo]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarDataAudienciaSql(psCDVara, psCDSala: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_DATA_AUDIENCIA,
      [FoFuncoesSQL.DateFormatToStr('DTINICIO', 'DD/MM/YYYY') + ' DTAUDIENCIA',
      sEsquema, psCDVara, psCDSala]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoRemetidoCMSql(psNuLote, psCDTipoLocalOrigemSQL,
  psCDTipoLocalDestinoSQL: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDANDO_REMETIDO_CM, [sEsquema, sEsquema,
    sEsquema, sEsquema, sEsquema, quotedstr(psNuLote), quotedstr(psCDTipoLocalOrigemSQL),
    quotedstr(psCDTipoLocalDestinoSQL)]);
end;

function VerificarMandadoDistribuidoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_MANDADO_DISTRIBUIDO_AGENTE,
      [sEsquema, sEsquema, sEsquema, sEsquema, quotedstr(psNuProcesso + '%'),
      quotedstr(psCDSituacaoMandadoSQL), quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL), sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_MANDADO_AGENTE, [sEsquema, sEsquema, sEsquema,
      sEsquema, quotedstr(psNuProcesso + '%'), quotedstr(psCDSituacaoMandadoSQL),
      quotedstr(psOficialJustica), FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'),
      FoFuncoesSQL.DateTimeToDate('DTOPERACAO'), quotedstr(psCDTipoOperacaoSQL), sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoDistribuidoCentralSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_MANDADO_DISTRIBUIDO_CENTRAL,
      [sEsquema, sEsquema, sEsquema, sEsquema, quotedstr(psNuProcesso + '%'),
      quotedstr(psCDSituacaoMandadoSQL), quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL), sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarSituacaoMandadoSql(psNuprocesso, psSituacao, psOficialJustica,
  psCDTipoOperacaoSQL2: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_SITUACAO_MANDADO, [sEsquema, sEsquema, sEsquema,
      sEsquema, quotedstr(psNuProcesso + '%'), psSituacao, quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL2), FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

//888888888888888888888888888888888888888888888888888888888888888888

function RetornaPublicaPessoa(psNuProcesso: string): WideString;  //Inserir modeltests
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PUBLICAPESSOA, [sEsquema, QuotedStr(psNuProcesso),
      FoFuncoesSQL.DateTimeToDate('DTMOVIMENTO'), FoFuncoesSQL.DtHr(DateToStr(now))]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornaVerificaVincrecolMand(psNuProcesso, psNuMandado, psCdCalculoGRJ: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDatas: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDatas := ' and ' + FoFuncoesSQL.DateTimeToDate('DTUSUVINCVALOR') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally

    result := Format(SQL_VERIFICA_VINCRECOLMAND, [sEsquema, sEsquema,
      QuotedStr(psNuProcesso), sEsquema, QuotedStr(psNuMandado), psCdCalculoGRJ, sDatas]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornaVerificaCancelamentoProcesso(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CANCELAMENTO_PROCESSO, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornaValidarLocalRemessaPendente(psNuLote: string; psNuForo: string;
  psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VALIDA_LOCAL_REMESSA_PENDENTE, [sEsquema, QuotedStr(psNuLote),
    psNuForo, psCdTipoLocalDestino]);
end;

function RetornaVerificarStatusSigilo(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_STATUS_SIGILO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNuProcesso)]);
end;

function RetornaVerificarExistenciaLote(psNuLote: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_EXISTENCIA_LOTE, [sEsquema, QuotedStr(psNuLote)]);
end;

function RetornaDigDocumento(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DIGDOCUMENTO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNuProcesso)]);
end;

function RetornaCdMandado(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_CDMANDADO, [sEsquema, sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornaVerificarDadosMandadoRedistribuido(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_DADOS_MANDADO_REDISTRIBUIDO,
    [sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornaVerificarAgenteMandadoDistribuido(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_AGENTE_MANDADO_DISTRIBUIDO,
    [sEsquema, sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'), sEsquema]);
end;

function RetornaAgenteDocEmitido(pscdDocumento: string; psCdProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_AGENTE_DOC_EMITIDO, [sEsquema, sEsquema,
    QuotedStr(pScdDocumento), QuotedStr(psCdProcesso)]);
end;

function RetornaVerificarTransferenciaMandado(psNuProcesso: string;
  psCdAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_TRANFERENCIA_MANDADO, [sEsquema, sEsquema,
    QuotedStr(psNuProcesso + '%'), psCdAgente]);
end;

function RetornaCdUsuarioAgente(psNomeAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_USUARIO_AGENTE, [sEsquema, quotedstr(psNomeAgente + '%')]);
end;

function RetornarIncluirAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_INCLUIR_AGENTE_2, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdForo), quotedstr(psCdZona), quotedstr(psNuVaga), quotedstr(psCdAgente)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarAfastarAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_AFASTAR_AGENTE_2, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdForo), quotedstr(psCdZona), quotedstr(psNuVaga), quotedstr(psCdAgente)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarIncluirAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_INCLUIR_AGENTE, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdAgente), quotedstr(psNuVaga)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarAfastarAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_AFASTAR_AGENTE, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdAgente), quotedstr(psNuVaga)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarUltimaMovimentacaoFluxo(psNuMandado: string): WideString;
var
  FospAplicacao: TspAplicacao;
  sEsquema: string;
begin
  FospAplicacao := TspAplicacao.Create;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_ULTIMA_MOV_FLUXO, [sEsquema, sEsquema, quotedstr(psNuMandado)]);
    FreeAndNil(FospAplicacao);
  end;
end;

function RetornarSituacaoMandadoAtualizadoNaoDistribuido(psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO_NAO_DIST,
    [sEsquema, quotedstr(psNuMandado)]);
end;

function RetornarSituacaoMandadoAtualizado(psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO, [sEsquema, sEsquema,
    quotedstr(psNuMandado)]);
end;

function RetornarVerificarRecebimentoNumeroLote(psNuLote: string; psCdForo: string;
  psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_RECEBIMENTO_NULOTE, [sEsquema, quotedstr(psNuLote),
    psCdForo, sEsquema, QuotedStr(psNuProcesso + '%')]);
end;


function RetornarVerificarCargaRemetidaLote(psNuLote: string;
  psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_CARGA_REMETIDA_LOTE, [sEsquema, sEsquema,
    quotedstr(psNuLote), psCdTipoLocalDestino]);
end;

function RetornarGRJ(psCdForo: string; psNuGrjEmitida: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_GRJ, [sEsquema, psCdForo, quotedstr(psNuGrjEmitida)]);
end;

function RetornarDistribuicaoMandado(psCdTipoDistMand: string; psCdAgente: string;
  psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DISTRIBUICAO_MANDADO, [sEsquema, sEsquema,
    psCdTipoDistMand, psCdAgente, QuotedStr(psNuMandado)]);
end;

function RetornarAtualizarDtCumprimentoDtVenctoPrazo(psDataVenctoPrazo: string;
  psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_ALTERA_DTCUMPRIMENTO_DTVENCTOPRAZO,
      [sEsquema, FoFuncoesSQL.DtHr(psDataVenctoPrazo), QuotedStr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

//25/10/2016 - Raphael.Whitlock - Task: 67003
function RetornarVerificarProcessoNovoDesmembrado(psNuProcesso, psNome, psSituacao: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_NOVO_DESMEMBRADO, [sEsquema, sEsquema,
    sEsquema, sEsquema, QuotedStr(psNome + '%'), QuotedStr(psSituacao),
    QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarEmailRecebido(psNmParte: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_EMAIL_RECEBIDO, [sEsquema, QuotedStr(psNmParte)]);
end;

function RetornarVerificarOficioImpresso(psDeOperacao: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_OFICIO_IMPRESSO, [sEsquema, QuotedStr(psDeOperacao + '%')]);
end;

function RetornarVerificarProcessoUnificado(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EPA.DTAPENSAMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally
    result := Format(SQL_VERIFICA_PROCESSO_UNIFICADO, [sEsquema, sEsquema, sEsquema,
      sDados, QuotedStr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarTesteConsultaAutos(psNuProcesso: string; psAnotacao: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    //30/11/2015 - Shirleano.Junior - SALT: 186660/23/4
    sDados := FoFuncoesSQL.posicao('UPPER(' + QuotedStr(psAnotacao) + ')',
      'UPPER(EAP.DEANOTACAO)');
  finally
    result := Format(SQL_VERIFICACAO_TESTE_CONSULTA_AUTOS, [sEsquema, sEsquema,
      sEsquema, sEsquema, sDados, sEsquema, sEsquema, sEsquema, sEsquema,
      QuotedStr(psNuProcesso)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarCancelamentoJuntada(psCdProcessoApenso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CANCELAMENTO_JUNTADA,
    [sEsquema, QuotedStr(psCdProcessoApenso), sEsquema]);
end;

function RetornarPeticaoSalva(psNuProcesso: string; psDeClasse: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_PETICAO_SALVA, [sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'),
    QuotedStr(psDeClasse)]);
end;

function RetornarVerificarCopiaPartes(psNuProcesso: string; psDeClasse: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.Decode('SUM(PTATIVACONTESTACAO)', ['SUM(PTATIVA)', '1', '0']) +
      ' + ' + FoFuncoesSQL.Decode('SUM(PTPASSIVACONTESTACAO)', ['SUM(PTPASSIVA)', '1', '0']);
  finally
    result := Format(SQL_VERICAR_COPIA_PARTES, [sDados, sEsquema, sEsquema,
      QuotedStr(psNuProcesso + '%'), QuotedStr(psDeClasse), sEsquema, sEsquema,
      QuotedStr(psNuProcesso + '%'), QuotedStr(psDeClasse)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarJuntadaProcessoDependente(psNuProcesso: string;
  psCdTipoMvProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNAR_JUNTADA_PROCESSO_DEPENDENTE,
    [sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'), sEsquema, psCdTipoMvProcesso]);
end;

function RetornarVerificarCertidaoEmitida(psCdSituacao: string; psNuPedido: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EPL.DTCERTIDAO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally
    result := Format(SQL_VERIFICAR_CERTIDAO_EMITIDA, [sEsquema, sEsquema, sDados,
      psCdSituacao, psNuPedido]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVaraDoProcesso(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_VARA_PROCESSO, [sEsquema, QuotedStr(psNuProcesso)]);
end;

function RetornarLiberouDocumentoAutos(psCdDocumentoEdt: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_LIBEROU_DOCUMENTO_AUTOS, [sEsquema, sEsquema, QuotedStr(psCdDocumentoEdt)]);
end;

function RetornarNuProcessoCompleto(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_NUPROCESSO_COMPLETO, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarDocumentoEmitdoGGP(psCdDocumento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DOC_EMITIDO_GGP, [sEsquema, QuotedStr(psCdDocumento)]);
end;

function RetornarDocumentoEmitdo2(psCdDocumento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DOC_EMITIDO_2, [sEsquema, QuotedStr(psCdDocumento)]);
end;

function RetornarVerificarHistoricoParte(psNuProcesso: string; psQtde: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_VERIFICAR_HISTORICO_PARTE, [sEsquema, sEsquema, sEsquema,
      QuotedStr(psNuProcesso)]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, StrToInt(psQtde), '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarParteIndiciado(psNmPessoa: string; psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_PARTE_INDICIADO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNmPessoa + '%'), QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarObservacaoDocumento(psCdDocumnento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_OBSERVACAO_DOCUMENTO, [sEsquema, QuotedStr(psCdDocumnento)]);
end;

function RetornarVerificarObservacaoProcessoFluxoTrabalho(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_OBSERVACAO_PROCESSO_FLUXO_TRABALHO,
    [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarDevolucaoAR(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_DEVOLUCAO_AR, [sEsquema, sEsquema, QuotedStr(psCdARTJ),
    psCdTipoEstadoAR]);
end;

function RetornarVerificarARAguardandoJuntada(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AR_AGUARDANDO_JUNTADA, [sEsquema, sEsquema,
    QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarVerificarARJuntadaProcesso(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_AR_JUNTADA_PROCESSO, [sEsquema, sEsquema,
    QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarPeticaoMarcadaSigiloConsulta(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_PETICAO_MARCADA_SIGILO_CONSULTA,
      [sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'),
      FoFuncoesSQL.DateTimeToDate('EPA.DTAPENSAMENTO'), FoFuncoesSQL.DataAtualTruncada, sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;


function RetornarVerificarParcelasMulta(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_PARCELAS_MULTA, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarMovimentacaoCategoria(psCdCategoria: string;
  psCdTipoMvProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_MOVIMENTCAOCATEGORIA,
    [sEsquema, QuotedStr(psCdCategoria), QuotedStr(psCdTipoMvProcesso)]);
end;

function RetornarVerificarNumeroDocumentoAlterado(psCdARTJ: string;
  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_NUMERO_DOCUMENTO_ALTERADO, [sEsquema, sEsquema,
    QuotedStr(psCdARTJ), QuotedStr(psCdTipoEstadoAR), QuotedStr(psNuDocRecebedor)]);
end;

function RetornarRecebidoNoCartorio(psNuLote: string; psCdARTJ: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EC.DTRECEBIMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally
    result := Format(SQL_RECEBIDO_NO_CARTORIO, [sEsquema, sEsquema, sEsquema, sDados,
      QuotedStr(psNuLote), QuotedStr(psCdARTJ)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarARRemetido(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AR_REMETIDO, [sEsquema, sEsquema, QuotedStr(psCdARTJ),
    QuotedStr(psCdTipoEstadoAR)]);
end;

function RetornarVerificarSituacaoAR(psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_SITUACAO_AR, [sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetornarAlteraTipoEstadoAR(psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_ALTERA_TIPO_ESTADO_AR, [sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetornarArquivoMultiMidia(psNuProcesso: string; psNmArqMultiMidia: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_ARQUIVO_MULTIMIDIA, [sEsquema, sEsquema,
    QuotedStr(psNuProcesso), QuotedStr(psNmArqMultiMidia)]);
end;

function RetornarGerarGuiaPostagemAR(psCdForo: string; psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_GERA_GUIA_POSTAGEM_AR, [sEsquema, sEsquema, sEsquema,
    psCdForo, sEsquema, sEsquema, QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarARRemetidoNaoRecebido(psNuLote: string; psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_AR_REMETIDO_NAO_RECEBIDO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNuLote), sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetornarCopiaFila(psCdFila: string; psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_COPIA_FILA, [sEsquema, sEsquema, psCdFila, sEsquema,
    QuotedStr(psNuProcesso + '%'), sEsquema, sEsquema]);
end;

function RetornarVerificarAudienciaCancelada(psCdAudiencia: string;
  psCdSituacaoAudi: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AUDIENCIA_CANCELADA, [sEsquema, psCdAudiencia, psCdSituacaoAudi]);
end;


function RetornarVerificarAlteracaoPautaAudienciaBloco(psCdSala: string;
  psCdVara: string; psCdTipoAudiencia: string; psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDataInicio: string;
  sDataFim: string;
  sHorarioInicio: string;
  sHorarioFim: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDataInicio := FoFuncoesSQL.DateFormatToStr('AUD.DTINICIO', 'DDMMYYYY');
    sDataFim := FoFuncoesSQL.DateFormatToStr('AUD.DTFIM', 'DDMMYYYY');
    sHorarioInicio := FoFuncoesSQL.DateTimeToTime('AUD.DTINICIO');
    sHorarioFim := FoFuncoesSQL.DateTimeToTime('AUD.DTFIM');
  finally
    result := Format(SELECT_VERIFICA_ALTERACAO_PAUTA_AUDIENCIA_BLOCO,
      [sDataInicio, sDataFim, sHorarioInicio, sHorarioFim, sEsquema, sEsquema,
      psCdSala, psCdVara, psCdTipoAudiencia, QuotedStr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarNuProcessoSemPendencia(pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_NUPROCESSO_SEM_PENDENCIA, [sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarLocalProcessoFisico(psCdProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_LOCAL_PROCESSO_FISICO, [sEsquema, sEsquema,
    sEsquema, psCdProcesso, sEsquema]);
end;

function RetornarEnderecoCPF(psNuDocumento: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    if spDB.GetTipoBanco = uspDataBase.tbOracle then
      sDados := ' LPAD(PD.NUDOCUMENTO,11,''0'')';
    if spDB.GetTipoBanco = uspDataBase.tbDB2 then
      sDados := ' RIGHT(REPEAT(''0'', 11) || LTRIM(CHAR(PD.NUDOCUMENTO)), 11)';
    sSQL := Format(SQL_RETORNA_ENDERECO_CPF, [sEsquema, sEsquema, sDados,
      QuotedStr(psNuDocumento)]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarProcessoCancelado(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_CANCELADO, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;


function RetornarVerificarProcessoRegSentenca(psCdTipoMvProcesso: string;
  psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EPM.DTMOVIMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
    sSQL := Format(SQL_VERFICA_PROCESSO_REG_SENTENCA, [sEsquema, sEsquema, sDados,
      psCdTipoMvProcesso, QuotedStr(psNuProcesso + '%')]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;


function RetornarProcessoRegistroSentenca(psCdCategoria: string;
  pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PROCESSO_REG_SENTENCA,
      [FoFuncoesSQL.substring('P.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema,
      sEsquema, sEsquema, sEsquema, sEsquema, psCdCategoria, sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoConsProcBasica(pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PROCESSO_CONSPROCBASICA,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarIncluirUsuarioNet(psCdPessoa: string; psCdUsuarioNet: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_INCLUI_USUARIO_NET, [sEsquema, psCdPessoa, psCdUsuarioNet]);
end;

function RetornarRelCalculoIdade(psCdVara: string; pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_REL_CALCULO_IDADE,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, psCdVara, sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoRelExtrato(pnQtdeLinhas: integer;
  psCdForo, psCDVara, psCdUltimMv: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PROCESSO_REL_EXTRATO,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, psCdForo, psCDVara, psCdUltimMv]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarMandadoDevolvidoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_MANDADO_DEVOLVIDO_CARTORIO,
    [sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuLote),
    QuotedStr(psCdTipoLocalOrigem), QuotedStr(psCdTipoLocalDestino)]);
end;

function RetornarVerificarDevolvicaoMandadoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_DEVOLUCAO_MANDADO_CARTORIO,
    [sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuLote),
    QuotedStr(psCdTipoLocalOrigem), QuotedStr(psCdTipoLocalDestino)]);
end;

function RetornarSenhaGerada(psCdProcesso: string; psNmOutroInteressado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SENHA_GERADA, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psCdProcesso), QuotedStr(psNmOutroInteressado)]);
end;


function RetornaVerificacaoSentenca(psTipoMvProcesso: string; psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDataUltAlteracao: string;
  sDataRegistro: string;
  sDataMovimento: string;
  sSQL: string;
  oData: TDateTime;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  oData := spDB.DataAtual;
  try
    sEsquema := spDB.GetEsquema + '.';
    if spDB.GetTipoBanco = uspDataBase.tbOracle then
    begin
      sDataUltAlteracao := FoFuncoesSQL.DateTimeToDate('EDE.DTULTALTERACAO') + ' = ' +
        FoFuncoesSQL.DtHr(DateToStr(oData)) + ')';
      sDataRegistro := FoFuncoesSQL.DateTimeToDate('ERS.DTREGISTRO') + ' = ' +
        FoFuncoesSQL.DtHr(DateToStr(oData)) + ')';
      sDataMovimento := FoFuncoesSQL.DateTimeToDate('EPA.DTMOVIMENTO') + ' = ' +
        FoFuncoesSQL.DtHr(DateToStr(oData));
    end;


    if spDB.GetTipoBanco = uspDataBase.tbDB2 then
    begin
      sDataUltAlteracao := ' Date(EDE.DTULTALTERACAO) = DATE(CURRENT_DATE))';
      sDataRegistro := ' Date(ERS.DTREGISTRO) = DATE(CURRENT_DATE))';
      sDataMovimento := ' Date(EPA.DTMOVIMENTO) = DATE(CURRENT_DATE)';
    end;
    sSQL := Format(SQL_VERIFICAR_SENTENCA, [sEsquema, sEsquema, sDataUltAlteracao,
      sEsquema, sDataRegistro, psTipoMvProcesso, sDataMovimento, sEsquema,
      QuotedStr(psNuProcesso + '%'), sEsquema, sEsquema]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarSituacaoMandado(psCdSituacaoMandado: string; psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SITUACAO_MANDADO, [sEsquema, sEsquema,
    psCdSituacaoMandado, QuotedStr(psNuMandado)]);
end;

function RetornarVerificarVinculacaoAgenteVara(psCdForo: string; psCdLocal: string;
  psCdAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_VICULACAO_AGENTE_VARA, [sEsquema, psCdForo,
    psCdLocal, psCdAgente]);
end;

function RetornarVerificarEntranhamento(psCdTipoMvProcesso: string; psData: string;
  psCdProcesso: string; psCdProcessoApenso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_ENTRANHAMENTO, [sEsquema, sEsquema, sEsquema,
      QuotedStr(psCdTipoMvProcesso), psData, FoFuncoesSQL.DtHr(DateToStr(now)),
      QuotedStr(psCdProcesso), QuotedStr(psCdProcessoApenso)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarParteUsuarioNet(psCdUsuarioNet: string; psDados: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PARTE_USUARIO_NET, [sEsquema, sEsquema, psCdUsuarioNet, psDados]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, 1, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarMandadoExcepcional(psCdModelo: string; psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDADO_EXCEPCIONAL, [sEsquema, sEsquema,
    QuotedStr(psCdModelo), QuotedStr(psNuProcesso + '%')]);
end;

function RetornarProcessoDocumentoAssinado: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    sSQL := Format(SQL_RETORNA_PROCESSO_DOCUMENTO_ASSINADO, [sEsquema, sEsquema, sDados]);
    result := FoFuncoesSQL.FetchFirst(sSQL, 1, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoRelAnaliticoSql(psCdForo, psCDVara, psCdUltimMv: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_REL_ANALITICO,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, psCdForo, psCDVara, psCdUltimMv]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarARGerada(psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AR_GERADA, [sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetronaLotacaoUsuario(psCdAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_LOTACAO_USUARIO, [sEsquema, QuotedStr(psCdAgente)]);
end;

//07/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
function RetornarVerficarSituacaoProcesso(psSituacaoProcesso: string;
  psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_SITUACAO_PROCESSO, [sEsquema, QuotedStr(psSituacaoProcesso),
    QuotedStr(psNuProcesso)]);
end;

//09/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
function RetornarVerficarSigiloProcessoSQL(psNuProcesso: string; psTipoSigilo: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_TIPO_SIGILO_PROCESSO_DEPENDENTE,
      [sEsquema, sEsquema, QuotedStr(psNuProcesso), QuotedStr(psTipoSigilo)]);
  end;
end;

//29/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
function RetornarVerficarProcessoReativadoSQL(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_PROCESSO_REATIVADO, [sEsquema, QuotedStr(psNuProcesso)]);
  end;
end;

//28/01/2016 - ANTONIO.SOUSA - SALT: 186660/23/1
function VerificarJuntadaSql(psNuprocesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_JUNTADA, [RetornarEsquema, RetornarEsquema,
    QuotedStr(psNuprocesso)]);
end;

function VerificarForoProcessoSql(psNuprocesso: string; psCdForo: string): WideString;
begin
  result := Format(SQL_VERIFICA_FORO_DESTINO, [RetornarEsquema,
    QuotedStr(psNuprocesso), psCdForo]);
end;

function RetornaSiglaClienteSQL: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  try
    FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
    sSQL := Format(SQL_RETORNA_SIGLA_CLIENTE, [FoFuncoesSQL.substring('VLPARAMETRO', 4, 2),
      RetornarEsquema]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;

end;

function RetornarEsquema: string;
begin
  result := spDB.GetEsquema + '.';
end;

// 26/10/2016  - Carlos.Gaspar - TASK: 66977
function ValidarHorarioAtendimento(psCdForo: string; psCdVara: string;
  psNmAlias: string; psHorario: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  try
    FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
    sSQL := Format(SQL_VALIDAR_HORARIO_ATENCIMENTO, [psCdForo, psCdVara,
      QuotedStr(psNmAlias), QuotedStr(psHorario), psCdForo, psCdVara, QuotedStr(psNmAlias),
      QuotedStr(psHorario), psCdForo, psCdVara, QuotedStr(psNmAlias), QuotedStr(psHorario)]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificaRegistroSentencaSQL(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(VERIFICA_SQL_REGISTRO_SENTENCA, [QuotedStr(psNuProcesso)]);
  end;
end;

end.

