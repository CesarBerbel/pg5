  {*************************************************
  **************************************************
  * 15/04/2016 - Carlos.Gaspar - SALT: 186660/25/1 *
  **************************************************
  * Unit uspjFuncoesSQLTests criada para reunir as *
  * fun��es para validar em banco de dados os      *
  * testes automatizados.                          *
  **************************************************
  * �ndice:                                        *
  * - Atualiza��o                                  *
  * - Convers�o                                    *
  * - Gera��o                                      *
  * - Sele��o                                      *
  * - Data                                         *
  * - Limpeza                                      *
  * - Executar                                     *
  * - Processo                                     *
  * - Cria��o                                      *
  *                                                *
  **************************************************
  *************************************************}
unit ufpgFuncoesGUISQLTests;

interface

uses
  Classes;

function RetornarProcessoCanceladoSQL(psNuProcesso: string): WideString;

function VerificarProcessoCadastradoSQL(psNuProcesso, psCdProcesso: string): WideString;

function VerificarArmasEBensCadastradoSQL(psCategoriaBem, psLocalizacaoBem,
  psNuProcesso: string): WideString;

function VerificarOutrosNumerosObservacaoSQL(psOutroNumero, psDescricao,
  psObservacao, psNuProcesso: string): WideString;

function VerificarOutroAssuntoSQL(psAssunto, psFlPrincipal, psFlEtiqueta,
  psNuProcesso: string): WideString;

function VerificarCadastroPautaAudienciaSQL(psVara, psTipoAudiencia, psNuProcesso: string): WideString;

function RetornaVerificacaoSentenca(psTipoMvProcesso: string; psNuProcesso: string): WideString;

function VerificaCancelamentoProcesso(psCDprocesso: string): WideString;

function ValidarRemessaLote(psNuLote, psNuForo, psCdTipoLocalDestino,
  psLocalDestino: string): WideString;

function RetornaCdUsuarioAgente(psNomeAgente: string): WideString;

function RetornarUltimaMovimentacaoFluxo(psNuMandado: string): WideString;

function RetornarSituacaoMandadoAtualizadoNaoDistribuido(psNuMandado: string): WideString;

function RetornarSituacaoMandadoAtualizado(psNuMandado: string): WideString;

function ValidaRecebimentoLote(psNuLote: string; psCdForo: string): WideString;

function RetornarGRJ(psCdForo: string; psNuGrjEmitida: string): WideString;

function RetornarProcessoSql(psSituacao: string): WideString;

function RetornarMudouVaraSql(psCdVara, psCDProcesso: string): WideString;

function RetornarCadastroContatoSql(psNuCPF: string): WideString;

function VerificarCadastroParteSql(psNuPessoa: string; psNuprocesso: string): WideString;

function RetornarMudouVagaSql(psCdVara, psCdVaga, psCDprocesso: string): WideString;

function VerificaEncaminhouOutroForo(psNuprocesso, psCdForoDestino: string): WideString;

function VerificaCancelouEncaminhaOutroForo(psCDProcesso: string): WideString;

function VerificarCadastroBemSql(psNuprocesso: string): WideString;

function VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso: string): WideString;

function VerificarSituacaoProcesso(psNuProcesso: string): WideString;

function VerificarDesvincularDocumentoDoc(psNuProcesso: string): WideString;

function VerificarApensamentoSql(psCdProcesso: string): WideString;

function VerifcarMovimetacoesLoteSql(psCdProcesso: string): WideString;

function VerifcarRecadoInseridoSql(psCdUsuarioDestino, psDeRecado: string): WideString;

function VerifcarAutoTextoSql(psCdUsuario, psNmAbrevAutoTexto, psCdGrupo: string): WideString;

function RetornarDocEmitidoSql(psCategoria, psModelo, psNuProcesso: string): WideString;

function RetornarCorrecaoClasseSql(psNuProcesso: string): WideString;

function RetornarProcessoSimplesSql: WideString;

function RetornarDocumentoProcessoSql(psNuProcesso: string): WideString;

function RetornarProcessoDistribuidoSemPendenciaSql: WideString;

function RetornarProcessoVirtualizadoSql(psCdProcesso: string): WideString;

function RetornarProcessoMaterializado(psCdProcesso: string): WideString;

function VerificarProcessoRemetidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;

function VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;

function RetornaProcessoDemonsDistribSql(pscdForo: string): WideString;

function RetornarVerificarHistoricoParte(psNuProcesso: string): WideString;

function RetornarVerificarParteIndiciado(psNmPessoa: string; psNuProcesso: string): WideString;

function RetornarVerificarObservacaoProcessoFluxoTrabalho(psNuProcesso: string): WideString;

function RetornarVerificarDevolucaoAR(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;

function RetornarVerificarARAguardandoJuntada(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

function RetornarVerificarARJuntadaProcesso(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

function RetornarVerificarParcelasMulta(psNuProcesso: string): WideString;

function RetornarVerificarARRemetido(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;

function RetornarRecebidoNoCartorio(psNuLote: string; psCdARTJ: string): WideString;

function RetornarVerificarNumeroDocumentoAlterado(psCdARTJ: string;
  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;

function RetornarSituacaoMandado(psCdSituacaoMandado: string; psNuMandado: string): WideString;

function RetornarVerificarARGerada(psCdARTJ: string): WideString;

function RetornarGerarGuiaPostagemAR(psCdForo: string; psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

function RetornarCopiaFila(psCdFila: string; psNuprocesso: string): WideString;

function RetornarVerificarLocalProcessoFisico(psCdProcesso: string): WideString;

function RetornarVerificarProcessoRegSentenca(psCdTipoMvProcesso: string;
  psNuProcesso: string): WideString;

function RetornarProcessoRegistroSentenca(psCdCategoria: string;
  pnQtdeLinhas: integer): WideString;

function RetornarProcessoConsProcBasica(pnQtdeLinhas: integer): WideString;

function RetornarVerificarMandadoDevolvidoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;

function RetornarVerificarDevolvicaoMandadoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;

function VerificarMandadoRemetidoCMSql(psNuLote, psCDTipoLocalOrigemSQL,
  psCDTipoLocalDestinoSQL: string): WideString;

function VerificarMandadoDistribuidoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarMandadoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarMandadoDistribuidoCentralSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarSituacaoMandadoSql(psNuprocesso, psSituacao, psOficialJustica,
  psCDTipoOperacaoSQL2: string): WideString;

function VerficarProcessoReativadoSQL(psCDProcesso: string): WideString;

function VerificarForoProcessoSql(psCDprocesso: string; psCdForo: string): WideString;

function VerificarProcessoCadastradoSigiloAbsolutoSQL(psNuProcesso, psCdUsuario: string): WideString;

function RetornaDescricaoFluxoSQL(psNuFluxo: string): WideString;

function GetEsquema: WideString;

function VerifcarAlteracaoDadosPessoaSql(psNmPessoa, psDeOrgaoExp: string): WideString;

function VerificaCadastroPessoaSql(psNmPessoa, psCPFPessoa: string): WideString;

function VerificarMovimentacaoLoteSQL(psNuProcesso: string): WideString;

function VerificarPendenciaProcesso(psCDProcesso, psUsuario, psDescPendencia: string): WideString;

function VerifcarExclusaoMovimetacaoSql(psCdProcesso: string): WideString;

function RetornaDadosParaTeste(psSequencia, psCampo: string): string;

procedure InserirDadosParaTeste(psSeq, psCampo, psValor: string);

function VerificarDistribuicaoProcessosSql(psNuProcesso: string): WideString;

function VerificarFeriadoSql(psCdForo: string; psData: string): WideString;

function RetornaForoProcessoSQL(psNuProcesso: string): WideString;

//20/10/2016 - Shirleano.Junior - Task: 66973
function RetornarSenhaGeradaSQL(psCdProcesso, psNuSeqSenha: string): WideString;

function VerificarAdvogadoUnificado2(psNuFormatado, psCDPessoa: string): WideString;

function VerificarPecCadastradoSQL(psCdProcesso: string): WideString;

function RetornarVerificarJuizVaga(psCdProcesso, psCdJuiz, psCdVaga, psCdVara,
  psCdForo: string): WideString;

function RetornarVerificarDadosDistProcesso(psCdProcesso: string): WideString;
//01/11/2016 - Shirleano.Junior - Task: 67016
function RetornarFilaObjetoSQL(psObjeto: string): WideString;

function VerificarFuncaoSeguranca(psUsuario: string): WideString;

procedure ExecutarLimparVariaveisExternas;

function SQLRetornarQtdeForosUsuario(psUsuario, psAlias: string): WideString;

function SQLRetornarQtdeProcessosFilaUsuario(psForos: string;
  psCdFluxoTrabalho, psCdFilaTrabalho: string): WideString;

function VerificarEvolucaoClasseCompetencia(psCdProcesso, psClasse, psCompetencia,
  psUltDistribuicao: string): WideString;

function VerificarSigiloExternoMandadoSQL(psSigiloExterno, psNuMandado: string): WideString;

function VerificarPublicacaoIntimacaoSQL(psCdForo, psCdVara, psCdProcesso,
  psNuRelacao, psTpMvProcesso: string): WideString;

function VerificarGeraIntimacaoSQL(psCdForo, psCdProcesso, psCdVara, psPessoa,
  psNuRelacao: string): WideString;

function RetornarListaCertidoesSQL(psForo: string): WideString;

function ValidaPriorizaProcesSQL(psPedido: string): WideString;

function PegaSequencialPedidoSQL: WideString;

function RetornarVerficarAlteracaoFormaPgto(psCDMandado, psCdFormaPagto: string): WideString;

function RetornarVerficarAlteracaoPrazo(psCDMandado, psCdClassificacao: string): WideString;

function RetornarVerficarCancelamentoMandado(psCDMandado, psCDSituacao: string): WideString;

function ValidarInsercaoPedidoCompletoSQL(psNuPedido, psCdModelo, psTpPessoa,
  psGenero, psCdNacionalidade, psCdEstadoCivil, psNaturalidade, psDtNasc, psRg,
  psProfissao, psNmPessoa, psNomeVariado, psNmPai, psNmMae, psNmSolicitante, psRgSolicitante,
  psCpfSolicitante, psEndSolicitante, psComplSolicitante, psBairroSolicitante,
  pspsCepSolicitante, psMunicipioSolicitante, psTelSolicitante, psEmailSolicitante,
  psEndPesq, psComplPesq, psBairroPesq, psCepPesq, psMunicipioPesq: string): WideString;
  
function VerificarConsultaPedidosSQL(psNomePessoa, psDataMovto: string): WideString;

function ValidarAlteracaoPedidoSQL(psCdUsuario, psNuPedido, psDeSituacao: string): WideString;

function VerificaSituacaoPedidoSQL(psNuPedido, psCdSituacao: string): WideString;

function VerificaExclusaoPedidoSQL(psNuPedido: string): WideString;

implementation

uses
  uspFuncoesSQL, uspAplicacao, uspDatabase, ufpgConstanteGUISQLTests, SysUtils,
  ADODB, uspConnectionSQLite;

function RetornarProcessoSql(psSituacao: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_RETORNA_PROCESSO, [GetEsquema, GetEsquema, psSituacao,
      FoFuncoesSQL.dthr('01/01/2015')]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarMudouVaraSql(psCdVara, psCDProcesso: string): WideString;
begin
  result := Format(SQL_RETORNA_MUDOU_VARA, [GetEsquema, psCdVara, quotedstr(psCDprocesso)]);
end;

function RetornarCadastroContatoSql(psNuCPF: string): WideString;
begin
  result := Format(SQL_RETORNA_CADASTRO_CONTATO, [GetEsquema, quotedstr(psNuCPF)]);
end;

function VerificarCadastroParteSql(psNuPessoa: string; psNuprocesso: string): WideString;
begin
  result := Format(SQL_VERIFICA_CADASTRO_PARTE, [GetEsquema, GetEsquema,
    quotedstr(psNuPessoa), GetEsquema, quotedstr(psNuprocesso + '%')]);
end;

function RetornarMudouVagaSql(psCdVara, psCdVaga, psCDprocesso: string): WideString;
begin
  result := Format(SQL_RETORNA_MUDOU_VAGA, [GetEsquema, psCdVara, psCdVaga,
    quotedstr(psCDprocesso)]);
end;

function VerificaEncaminhouOutroForo(psNuprocesso, psCdForoDestino: string): WideString;
begin
  result := Format(SQL_VERIFICA_ENCAMINHOU_OUTRO_FORO,
    [GetEsquema, quotedstr(psNuprocesso), psCdForoDestino]);
end;

function VerificaCancelouEncaminhaOutroForo(psCDProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICA_CANCELOU_ENCAMINHA_OUTRO_FORO,
    [GetEsquema, quotedstr(psCDProcesso)]);
end;

function VerificarCadastroBemSql(psNuprocesso: string): WideString;
begin
  result := Format(SQL_VERIFICA_CADASTRO_BEM, [GetEsquema, GetEsquema, GetEsquema,
    quotedstr(psNuprocesso)]);
end;

function VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_MOV_UNITARIA, [GetEsquema, GetEsquema,
    quotedstr(psTpMovimentacao), quotedstr(psTpMovimentacao), GetEsquema,
    quotedstr(psNuProcesso)]);

end;

function VerificarSituacaoProcesso(psNuProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_SITUACAO_PROCESSO, [GetEsquema, quotedstr(psNuProcesso)]);
end;

function VerificarDesvincularDocumentoDoc(psNuProcesso: string): WideString;
begin
  result := Format(VERIFICAR_DESVINCULAR_DOCUMENTO, [GetEsquema, quotedstr(psNuProcesso)]);
end;

function VerificarApensamentoSql(psCdProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_APENSAMENTO, [GetEsquema, quotedstr(psCdProcesso), GetEsquema]);
end;

function VerifcarMovimetacoesLoteSql(psCdProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_VERIFICA_EXCLUSAO_MOVIMENTACAO,
      [GetEsquema, QuotedStr(psCdProcesso), FoFuncoesSQL.DateTimeToDate('EPM.DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, GetEsquema, FoFuncoesSQL.DateTimeToDate('DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarRecadoInseridoSql(psCdUsuarioDestino, psDeRecado: string): WideString;
begin
  result := Format(SQL_VERIFICA_RECADO_INSERIDO, [GetEsquema, quotedstr(psCdUsuarioDestino),
    quotedstr(psDeRecado)]);
end;

function VerifcarAutoTextoSql(psCdUsuario, psNmAbrevAutoTexto, psCdGrupo: string): WideString;
begin
  result := Format(SQL_VERIFICA_AUTOTEXTO, [GetEsquema, GetEsquema,
    quotedstr(psCdUsuario), quotedstr(psNmAbrevAutoTexto), psCdGrupo]);
end;

function RetornarDocEmitidoSql(psCategoria, psModelo, psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_RETORNA_DOC_EMITIDO,
      [GetEsquema, FoFuncoesSQL.DateTimeToDate('EDOC.DTFINALIZACAO'),
      FoFuncoesSQL.DataAtualTruncada, quotedstr(psCategoria), quotedstr(psModelo),
      GetEsquema, quotedstr(psNuProcesso)]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarCorrecaoClasseSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_RETORNA_CORRECAO_CLASSE, [GetEsquema, GetEsquema, GetEsquema,
      Quotedstr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('EHC1.DTMUDANCA'),
      FoFuncoesSQL.DataAtualTruncada]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoSimplesSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_SIMPLES,
      [GetEsquema, GetEsquema, GetEsquema]), 1);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarDocumentoProcessoSql(psNuProcesso: string): WideString;
begin
  result := Format(SQL_EXISTE_DOCUMENTO_PROCESSO, [GetEsquema, GetEsquema,
    GetEsquema, quotedstr(psNuProcesso)]);
end;

function RetornarProcessoDistribuidoSemPendenciaSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DISTRIBUIDO_SEM_PENDENCIA,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), GetEsquema, GetEsquema, GetEsquema]), 1);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoVirtualizadoSql(psCdProcesso: string): WideString;
begin
  result := Format(SQL_RETORNAR_PROCESSO_VIRTUALIZADO, [GetEsquema, quotedstr(psCdProcesso)]);
end;

function RetornarProcessoMaterializado(psCdProcesso: string): WideString;
begin
  result := Format(SQL_RETORNAR_PROCESSO_MATERIALIZADO, [GetEsquema, quotedstr(psCdProcesso)]);
end;

function VerificarProcessoRemetidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;
begin
  result := Format(SQL_VERIFICA_PROCESSO_REMETIDO, [GetEsquema, GetEsquema,
    GetEsquema, quotedstr(psNuLote), quotedstr(psNuProcesso + '%'), quotedstr(psTpLocalDestino)]);
end;

function VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_VERIFICA_PROCESSO_RECEBIDO, [GetEsquema, GetEsquema,
      GetEsquema, FoFuncoesSQL.DateTimeToDate('EC.DTRECEBIMENTO'), FoFuncoesSQL.DataAtualTruncada,
      quotedstr(psNuLote), quotedstr(psNuProcesso + '%'), quotedstr(psTpLocalDestino)]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornaProcessoDemonsDistribSql(pscdForo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try

    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DEMONS_DISTRIB,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), GetEsquema, GetEsquema,
      GetEsquema, pscdForo]), 1);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoRemetidoCMSql(psNuLote, psCDTipoLocalOrigemSQL,
  psCDTipoLocalDestinoSQL: string): WideString;
begin
  result := Format(SQL_VERIFICA_MANDANDO_REMETIDO_CM, [GetEsquema, GetEsquema,
    GetEsquema, GetEsquema, GetEsquema, quotedstr(psNuLote), quotedstr(psCDTipoLocalOrigemSQL),
    quotedstr(psCDTipoLocalDestinoSQL)]);
end;

function VerificarMandadoDistribuidoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_VERIFICAR_MANDADO_DISTRIBUIDO_AGENTE,
      [GetEsquema, GetEsquema, GetEsquema, GetEsquema, quotedstr(psNuProcesso + '%'),
      quotedstr(psCDSituacaoMandadoSQL), quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL), GetEsquema]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_VERIFICA_MANDADO_AGENTE, [GetEsquema, GetEsquema, GetEsquema,
      GetEsquema, quotedstr(psNuProcesso + '%'), quotedstr(psCDSituacaoMandadoSQL),
      quotedstr(psOficialJustica), FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'),
      FoFuncoesSQL.DateTimeToDate('DTOPERACAO'), quotedstr(psCDTipoOperacaoSQL), GetEsquema]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoDistribuidoCentralSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_VERIFICA_MANDADO_DISTRIBUIDO_CENTRAL,
      [GetEsquema, GetEsquema, GetEsquema, GetEsquema, quotedstr(psNuProcesso + '%'),
      quotedstr(psCDSituacaoMandadoSQL), quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL), GetEsquema]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarSituacaoMandadoSql(psNuprocesso, psSituacao, psOficialJustica,
  psCDTipoOperacaoSQL2: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  GetEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try


    result := Format(SQL_VERIFICA_SITUACAO_MANDADO, [GetEsquema, GetEsquema,
      GetEsquema, GetEsquema, quotedstr(psNuProcesso + '%'), psSituacao,
      quotedstr(psOficialJustica), FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'),
      FoFuncoesSQL.DateTimeToDate('DTOPERACAO'), quotedstr(psCDTipoOperacaoSQL2),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DataAtualTruncada,
      GetEsquema]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificaCancelamentoProcesso(psCDprocesso: string): WideString;
begin
  result := Format(SQL_VERIFICA_CANCELAMENTO_PROCESSO, [GetEsquema, QuotedStr(psCDprocesso)]);
end;

function ValidarRemessaLote(psNuLote, psNuForo, psCdTipoLocalDestino,
  psLocalDestino: string): WideString;
begin
  result := Format(SQL_VALIDA_LOCAL_REMESSA_PENDENTE, [GetEsquema, QuotedStr(psNuLote),
    psNuForo, psCdTipoLocalDestino, psLocalDestino]);
end;

function RetornaCdUsuarioAgente(psNomeAgente: string): WideString;
begin
  result := Format(SQL_RETORNA_USUARIO_AGENTE, [GetEsquema, quotedstr(psNomeAgente + '%')]);
end;

function RetornarUltimaMovimentacaoFluxo(psNuMandado: string): WideString;
begin
  result := Format(SQL_RETORNA_ULTIMA_MOV_FLUXO, [GetEsquema, GetEsquema, quotedstr(psNuMandado)]);
end;

function RetornarSituacaoMandadoAtualizadoNaoDistribuido(psNuMandado: string): WideString;
begin
  result := Format(SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO_NAO_DIST,
    [GetEsquema, quotedstr(psNuMandado)]);
end;

function RetornarSituacaoMandadoAtualizado(psNuMandado: string): WideString;
begin
  result := Format(SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO,
    [GetEsquema, GetEsquema, quotedstr(psNuMandado)]);
end;

function ValidaRecebimentoLote(psNuLote: string; psCdForo: string): WideString;
begin
  result := Format(SQL_VERIFICA_RECEBIMENTO_NULOTE, [GetEsquema, quotedstr(psNuLote), psCdForo]);
end;

function RetornarGRJ(psCdForo: string; psNuGrjEmitida: string): WideString;
begin
  result := Format(SQL_RETORNA_GRJ, [GetEsquema, psCdForo, quotedstr(psNuGrjEmitida)]);
end;

function RetornarVerificarHistoricoParte(psNuProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_HISTORICO_PARTE, [GetEsquema, GetEsquema,
    GetEsquema, QuotedStr(psNuProcesso)]);
end;

function RetornarVerificarParteIndiciado(psNmPessoa: string; psNuProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_PARTE_INDICIADO, [GetEsquema, GetEsquema,
    GetEsquema, QuotedStr(psNmPessoa + '%'), QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarObservacaoProcessoFluxoTrabalho(psNuProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICA_OBSERVACAO_PROCESSO_FLUXO_TRABALHO,
    [GetEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarDevolucaoAR(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;
begin
  result := Format(SQL_VERIFICA_DEVOLUCAO_AR, [GetEsquema, GetEsquema,
    QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarVerificarARAguardandoJuntada(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
begin
  result := Format(SQL_VERIFICA_AR_AGUARDANDO_JUNTADA, [GetEsquema, GetEsquema,
    QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarVerificarARJuntadaProcesso(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
begin
  result := Format(SQL_VERIFICAR_AR_JUNTADA_PROCESSO, [GetEsquema, GetEsquema,
    QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarVerificarParcelasMulta(psNuProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_PARCELAS_MULTA, [GetEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarNumeroDocumentoAlterado(psCdARTJ: string;
  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;
begin
  result := Format(SQL_VERIFICAR_NUMERO_DOCUMENTO_ALTERADO,
    [GetEsquema, GetEsquema, QuotedStr(psCdARTJ), QuotedStr(psCdTipoEstadoAR),
    QuotedStr(psNuDocRecebedor)]);
end;

function RetornarRecebidoNoCartorio(psNuLote: string; psCdARTJ: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sDados := FoFuncoesSQL.DateTimeToDate('EC.DTRECEBIMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally
    result := Format(SQL_RECEBIDO_NO_CARTORIO, [GetEsquema, GetEsquema, GetEsquema,
      sDados, QuotedStr(psNuLote), QuotedStr(psCdARTJ)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarARRemetido(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;
begin
  result := Format(SQL_VERIFICA_AR_REMETIDO, [GetEsquema, GetEsquema,
    QuotedStr(psCdARTJ), QuotedStr(psCdTipoEstadoAR)]);
end;

function RetornarGerarGuiaPostagemAR(psCdForo: string; psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
begin
  result := Format(SQL_GERA_GUIA_POSTAGEM_AR, [GetEsquema, GetEsquema, GetEsquema,
    psCdForo, GetEsquema, GetEsquema, QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarCopiaFila(psCdFila: string; psNuprocesso: string): WideString;
begin
  result := Format(SQL_RETORNA_COPIA_FILA, [GetEsquema, GetEsquema, psCdFila,
    GetEsquema, QuotedStr(psNuProcesso + '%'), GetEsquema, GetEsquema]);
end;

function RetornarVerificarLocalProcessoFisico(psCdProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_LOCAL_PROCESSO_FISICO, [GetEsquema, GetEsquema,
    GetEsquema, psCdProcesso, GetEsquema]);
end;

function RetornarVerificarProcessoRegSentenca(psCdTipoMvProcesso: string;
  psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sSQL: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sDados := FoFuncoesSQL.DateTimeToDate('EPM.DTMOVIMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
    sSQL := Format(SQL_VERFICA_PROCESSO_REG_SENTENCA, [GetEsquema, GetEsquema,
      sDados, psCdTipoMvProcesso, QuotedStr(psNuProcesso + '%')]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoRegistroSentenca(psCdCategoria: string;
  pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sSQL := Format(SQL_RETORNA_PROCESSO_REG_SENTENCA,
      [FoFuncoesSQL.substring('P.NUPROCESSO', 1, 13), GetEsquema, GetEsquema,
      GetEsquema, GetEsquema, GetEsquema, GetEsquema, GetEsquema, psCdCategoria,
      GetEsquema, GetEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoConsProcBasica(pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sSQL := Format(SQL_RETORNA_PROCESSO_CONSPROCBASICA,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), GetEsquema, GetEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarMandadoDevolvidoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;
begin
  result := Format(SQL_VERIFICAR_MANDADO_DEVOLVIDO_CARTORIO,
    [GetEsquema, GetEsquema, GetEsquema, GetEsquema, GetEsquema, QuotedStr(psNuLote),
    QuotedStr(psCdTipoLocalOrigem), QuotedStr(psCdTipoLocalDestino)]);
end;

function RetornarVerificarDevolvicaoMandadoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;
begin
  result := Format(SQL_VERIFICAR_DEVOLUCAO_MANDADO_CARTORIO,
    [GetEsquema, GetEsquema, GetEsquema, GetEsquema, GetEsquema, QuotedStr(psNuLote),
    QuotedStr(psCdTipoLocalOrigem), QuotedStr(psCdTipoLocalDestino)]);
end;

function RetornaVerificacaoSentenca(psTipoMvProcesso: string; psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
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
    sSQL := Format(SQL_VERIFICAR_SENTENCA, [GetEsquema, GetEsquema, sDataUltAlteracao,
      GetEsquema, sDataRegistro, psTipoMvProcesso, sDataMovimento, GetEsquema,
      QuotedStr(psNuProcesso + '%'), GetEsquema, GetEsquema]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarSituacaoMandado(psCdSituacaoMandado: string; psNuMandado: string): WideString;
begin
  result := Format(SQL_RETORNA_SITUACAO_MANDADO, [GetEsquema, GetEsquema,
    psCdSituacaoMandado, QuotedStr(psNuMandado)]);
end;

function RetornarVerificarARGerada(psCdARTJ: string): WideString;
begin
  result := Format(SQL_VERIFICA_AR_GERADA, [GetEsquema, QuotedStr(psCdARTJ)]);
end;

function VerficarProcessoReativadoSQL(psCDProcesso: string): WideString;
begin
  result := Format(SQL_RETORNA_PROCESSO_REATIVADO, [GetEsquema, QuotedStr(psCDProcesso)]);
end;

function VerificarForoProcessoSql(psCDprocesso: string; psCdForo: string): WideString;
begin
  result := Format(SQL_VERIFICA_FORO_DESTINO, [GetEsquema, QuotedStr(psCDprocesso), psCdForo]);
end;

function VerificarProcessoCadastradoSQL(psNuProcesso, psCdProcesso: string): WideString;
begin
  result := Format(VERIFICAR_PROCESSO_CADASTRADO, [GetEsquema, QuotedStr(psNuprocesso),
    QuotedStr(psCdProcesso)]);
end;

function VerificarArmasEBensCadastradoSQL(psCategoriaBem, psLocalizacaoBem,
  psNuProcesso: string): WideString;
begin
  result := Format(VERIFICAR_ARMAS_BENS_CADASTRADO, [GetEsquema, GetEsquema,
    QuotedStr(psCategoriaBem), QuotedStr(psLocalizacaoBem), QuotedStr(psNuProcesso)]);
end;

function VerificarOutrosNumerosObservacaoSQL(psOutroNumero, psDescricao,
  psObservacao, psNuProcesso: string): WideString;
begin
  result := Format(VERIFICAR_OUTROS_NUMEROS_OBSERVACAO_CADASTRADO,
    [GetEsquema, GetEsquema, QuotedStr(psOutroNumero), QuotedStr(psDescricao),
    QuotedStr(psObservacao), QuotedStr(psNuProcesso)]);
end;

function VerificarOutroAssuntoSQL(psAssunto, psFlPrincipal, psFlEtiqueta,
  psNuProcesso: string): WideString;
begin
  result := Format(VERIFICAR_OUTRO_ASSUNTO_CADASTRADO, [GetEsquema, GetEsquema,
    QuotedStr(psAssunto), QuotedStr(psFlPrincipal), QuotedStr(psFlEtiqueta),
    QuotedStr(psNuProcesso)]);
end;

function VerificarCadastroPautaAudienciaSQL(psVara, psTipoAudiencia, psNuProcesso: string): WideString;
begin
  result := Format(SQL_VERIFICAR_CADASTRO_PAUTA_AUDIENCIA, [GetEsquema, GetEsquema,
    QuotedStr(psVara), QuotedStr(psTipoAudiencia), QuotedStr(psNuProcesso)]);
end;

function RetornarProcessoCanceladoSQL(psNuProcesso: string): WideString;
begin
  result := Format(RETORNA_PROCESSO_RETIFICACAO, [GetEsquema, QuotedStr(psNuProcesso)]);
end;

function VerifcarAlteracaoDadosPessoaSql(psNmPessoa, psDeOrgaoExp: string): WideString;
begin
  result := Format(SQL_VERIFICA_ALTERACAO_DADOS_PESSOA, [GetEsquema, psNmPessoa, psDeOrgaoExp]);
end;

function VerificaCadastroPessoaSql(psNmPessoa, psCPFPessoa: string): WideString;
begin
  result := Format(SQL_VERIFICA_CADASTRO_PESSOA, [GetEsquema, psNmPessoa, psCPFPessoa]);
end;

function VerificarProcessoCadastradoSigiloAbsolutoSQL(psNuProcesso, psCdUsuario: string): WideString;
begin
  result := Format(VERIFICAR_PROCESSO_CADASTRADO_SIGILO_ABSOLUTO,
    [GetEsquema, GetEsquema, QuotedStr(psNuprocesso), QuotedStr(psCdUsuario)]);
end;

function RetornaDescricaoFluxoSQL(psNuFluxo: string): WideString;
begin
  result := Format(SQL_RETORNA_DESCRICAO_FLUXO, [GetEsquema, QuotedStr(psNuFluxo)]);
end;

function VerificarPendenciaProcesso(psCDProcesso, psUsuario, psDescPendencia: string): WideString;
begin
  result := Format(SQL_VERIFICA_PENDENCIA, [GetEsquema, QuotedStr(psCDProcesso),
    QuotedStr(psUsuario), QuotedStr(psDescPendencia)]);
end;

function VerifcarExclusaoMovimetacaoSql(psCdProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_VERIFICA_EXCLUSAO_MOVIMENTACAO,
      [GetEsquema, QuotedStr(psCdProcesso), FoFuncoesSQL.DateTimeToDate('EPM.DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, GetEsquema, FoFuncoesSQL.DateTimeToDate('DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMovimentacaoLoteSQL(psNuProcesso: string): WideString;
begin
  result := Format(SQL_CHECAR_MOVIMENTACOES_LANCADAS_EM_LOTE,
    [GetEsquema, GetEsquema, QuotedStr(psNuProcesso)]);
end;

function RetornaDadosParaTeste(psSequencia, psCampo: string): string;
var
  qRetornaDados: TADOQuery;
  oConnection: TspConnectionSQLite;
begin
  qRetornaDados := TADOQuery.Create(nil); //PC_OK
  oConnection := TspConnectionSQLite.Create; //PC_OK
  try
    qRetornaDados.Connection := oConnection.ObterConnectionSQLite;
    qRetornaDados.Close;
    qRetornaDados.SQL.Clear;
    qRetornaDados.SQL.Add(Format(SQL_RETORNA_DADOS_TESTE, [QuotedStr(psCampo), psSequencia]));
    qRetornaDados.Open;
    result := qRetornaDados.FieldByName('VALOR').AsString;
  finally
    qRetornaDados.Close;
    qRetornaDados.SQL.Clear;
    qRetornaDados.SQL.Add(Format(SQL_DELETAR_DADOS_TESTE, [psSequencia, QuotedStr(psCampo)]));
    qRetornaDados.ExecSQL;

    if Assigned(oConnection) then
      FreeAndNil(oConnection); //PC_OK
    FreeAndNil(qRetornaDados); //PC_OK
  end;
end;

procedure InserirDadosParaTeste(psSeq, psCampo, psValor: string);
var
  qInsereDados: TADOQuery;
  oConnection: TspConnectionSQLite;
begin
  qInsereDados := TADOQuery.Create(nil); //PC_OK
  oConnection := TspConnectionSQLite.Create; //PC_OK 
  try
    qInsereDados.Connection := oConnection.ObterConnectionSQLite;
    qInsereDados.Close;
    qInsereDados.SQL.Clear;
    qInsereDados.SQL.Add(Format(SQL_INSERIR_DADOS_SQLITE, [psSeq, QuotedStr(psCampo),
      QuotedStr(psValor)]));
    qInsereDados.ExecSQL;
  finally
    FreeAndNil(oConnection); //PC_OK
    FreeAndNil(qInsereDados); //PC_OK
  end;
end;

function VerificarDistribuicaoProcessosSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_DISTRIBUICAO_PROCESSOS,
      [sEsquema, FoFuncoesSQL.DateTimeToDate('EPM.DTMOVIMENTO'), FoFuncoesSQL.DataAtualTruncada,
      sEsquema, psNuProcesso]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function GetEsquema: WideString;
begin
  result := spDB.GetEsquema + '.';
end;

function VerificarFeriadoSql(psCdForo: string; psData: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    result := Format(SQL_VERIFICAR_FERIADO, [GetEsquema, QuotedStr(psCdForo), QuotedStr(psData)]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornaForoProcessoSQL(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNAR_FORO, [sEsquema, QuotedStr(psNuProcesso)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

//20/10/2016 - Shirleano.Junior - Task: 66973
function RetornarSenhaGeradaSQL(psCdProcesso, psNuSeqSenha: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNAR_SENHA_GERADA, [sEsquema, QuotedStr(psCdProcesso),
      QuotedStr(psNuSeqSenha)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarAdvogadoUnificado2(psNuFormatado, psCDPessoa: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_ADVOGADO_UNIFICADO, [sEsquema, sEsquema,
      QuotedStr(psCDPessoa), QuotedStr(psNuFormatado)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarPecCadastradoSQL(psCdProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PEC_CRIADO, [sEsquema, QuotedStr(psCdProcesso)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarJuizVaga(psCdProcesso, psCdJuiz, psCdVaga, psCdVara,
  psCdForo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_JUIZ_VAGA, [sEsquema, sEsquema, sEsquema,
      QuotedStr(psCdProcesso), QuotedStr(psCdJuiz), QuotedStr(psCdVaga),
      QuotedStr(psCdVara), QuotedStr(psCdForo)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarDadosDistProcesso(psCdProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_DADOS_DIST_PROCESSO, [sEsquema, QuotedStr(psCdProcesso)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

//01/11/2016 - Shirleano.Junior - Task: 67016
function RetornarFilaObjetoSQL(psObjeto: string): WideString;
begin
  result := Format(RETORNAR_FILA_OBJETO, [GetEsquema, GetEsquema, QuotedStr(psObjeto)]);
end;

function VerificarFuncaoSeguranca(psUsuario: string): WideString;
var
  sUsuario: string;
begin
  sUsuario := quotedStr(psUsuario);
  result := Format(VERIFICAR_FUNCAO_SEGURANCA, [sUsuario, sUsuario, sUsuario,
    sUsuario, sUsuario, sUsuario]);
end;

procedure ExecutarLimparVariaveisExternas;
var
  qLimpaVariaveis: TADOQuery;
  oConnection: TspConnectionSQLite;
begin
  qLimpaVariaveis := TADOQuery.Create(nil); //PC_OK
  oConnection := TspConnectionSQLite.Create; //PC_OK
  try
    qLimpaVariaveis.Connection := oConnection.ObterConnectionSQLite;
    qLimpaVariaveis.Close;
    qLimpaVariaveis.SQL.Clear;
    qLimpaVariaveis.SQL.Add(Format(SQL_DELETAR_VARIAVEIS_EXTERNAS_TESTE, []));
    qLimpaVariaveis.ExecSQL;
  finally
    if Assigned(oConnection) then
      FreeAndNil(oConnection); //PC_OK
    FreeAndNil(qLimpaVariaveis); //PC_OK
  end;
end;

function SQLRetornarQtdeForosUsuario(psUsuario, psAlias: string): WideString;
begin
  result := Format(VERIFICAR_QTDE_FOROS_USUARIO, [GetEsquema, GetEsquema, GetEsquema,
    QuotedStr(psUsuario), QuotedStr(psAlias)]);
end;

function SQLRetornarQtdeProcessosFilaUsuario(psForos: string;
  psCdFluxoTrabalho, psCdFilaTrabalho: string): WideString;
begin
  result := Format(VERIFICAR_QTDE_PROCESSOS_FILA_USUARIO,
    [psForos, psCdFluxoTrabalho, psCdFilaTrabalho]);
end;

function VerificarEvolucaoClasseCompetencia(psCdProcesso, psClasse, psCompetencia,
  psUltDistribuicao: string): WideString;
begin
  result := Format(VERIFICAR_CLASSE_COMPETENCIA_EVOLUCAO, [QuotedStr(psCdProcesso),
    psClasse, psCompetencia, QuotedStr(psUltDistribuicao)]);
end;


function VerificarSigiloExternoMandadoSQL(psSigiloExterno, psNuMandado: string): WideString;
begin
  result := Format(VERIFICAR_SIGILO_EXTERNO_MANDADO,
    [GetEsquema, QuotedStr(psSigiloExterno), QuotedStr(psNuMandado)]);
end;

function VerificarPublicacaoIntimacaoSQL(psCdForo, psCdVara, psCdProcesso,
  psNuRelacao, psTpMvProcesso: string): WideString;
begin
  result := Format(VERIFICAR_PUBLICA_INTIMACAO, [GetEsquema, GetEsquema, GetEsquema,
    QuotedStr(psCdForo), QuotedStr(psCdVara), QuotedStr(psCdProcesso),
    QuotedStr(psNuRelacao), QuotedStr(psTpMvProcesso)]);
end;

function VerificarGeraIntimacaoSQL(psCdForo, psCdProcesso, psCdVara, psPessoa,
  psNuRelacao: string): WideString;
begin
  result := Format(VERIFICAR_GERA_PUBLICACAO, [GetEsquema, GetEsquema, GetEsquema,
    QuotedStr(psCdForo), QuotedStr(psCdProcesso), QuotedStr(psCdVara),
    QuotedStr(psPessoa), QuotedStr(psNuRelacao)]);
end;

function RetornarVerficarAlteracaoFormaPgto(psCDMandado, psCdFormaPagto: string): WideString;
begin
  result := Format(VERFICAR_ALTERACAO_FORMA_PGTO, [GetEsquema, QuotedStr(psCDMandado),
    psCdFormaPagto]);
end;

function RetornarVerficarAlteracaoPrazo(psCDMandado, psCdClassificacao: string): WideString;
begin
  result := Format(VERFICAR_ALTERACAO_PRAZO, [GetEsquema, QuotedStr(psCDMandado),
    psCdClassificacao]);
end;

function RetornarListaCertidoesSQL(psForo: string): WideString;
begin
  result := Format(VERIFICAR_LISTA_CERTIDOES_UNICA, [GetEsquema, GetEsquema,
    GetEsquema, GetEsquema, GetEsquema, psForo]);
end;

function RetornarVerficarCancelamentoMandado(psCDMandado, psCDSituacao: string): WideString;
begin
  result := Format(VERFICAR_CANCELAMENTO_MANDADO, [GetEsquema, QuotedStr(psCDMandado),
    psCDSituacao]);
end;

function ValidaPriorizaProcesSQL(psPedido: string): WideString;
begin
  result := Format(VALIDA_PRIORIZA_PROCES_SQL, [GetEsquema, QuotedStr(psPedido)]);
end;

function PegaSequencialPedidoSQL: WideString;
begin
  result := Format(PEGA_SEQUENCIAL_PEDIDO, [GetEsquema]);
end;

function ValidarInsercaoPedidoCompletoSQL(psNuPedido, psCdModelo, psTpPessoa,
  psGenero, psCdNacionalidade, psCdEstadoCivil, psNaturalidade, psDtNasc, psRg,
  psProfissao, psNmPessoa, psNomeVariado, psNmPai, psNmMae, psNmSolicitante, psRgSolicitante,
  psCpfSolicitante, psEndSolicitante, psComplSolicitante, psBairroSolicitante,
  pspsCepSolicitante, psMunicipioSolicitante, psTelSolicitante, psEmailSolicitante,
  psEndPesq, psComplPesq, psBairroPesq, psCepPesq, psMunicipioPesq: string): WideString;
begin
  result := Format(VALIDAR_INSERCAO_PEDIDO_COMPLETO, [GetEsquema, GetEsquema,
    GetEsquema, GetEsquema, GetEsquema, GetEsquema, GetEsquema, psNuPedido,
    psCdModelo, QuotedStr(psTpPessoa), QuotedStr(psGenero), psCdNacionalidade,
    psCdEstadoCivil, psNaturalidade, QuotedStr(psDtNasc), QuotedStr(psRg),
    QuotedStr(psProfissao), QuotedStr(psNmPessoa), QuotedStr(psNomeVariado), QuotedStr(psNmPai),
    QuotedStr(psNmMae), QuotedStr(psNmSolicitante), QuotedStr(psRgSolicitante),
    QuotedStr(psCpfSolicitante), QuotedStr(psEndSolicitante), QuotedStr(psComplSolicitante),
    QuotedStr(psBairroSolicitante), QuotedStr(pspsCepSolicitante), psMunicipioSolicitante,
    QuotedStr(psTelSolicitante), QuotedStr(psEmailSolicitante), QuotedStr(psEndPesq),
    QuotedStr(psComplPesq), QuotedStr(psBairroPesq), QuotedStr(psCepPesq), psMunicipioPesq]);
end;

function VerificarConsultaPedidosSQL(psNomePessoa, psDataMovto: string): WideString;
begin
  result := Format(VERIFICAR_CONSULTA_PEDIDOS, [GetEsquema, GetEsquema, GetEsquema,
    GetEsquema, GetEsquema, QuotedStr(psNomePessoa), QuotedStr(psDataMovto)]);
end;

function ValidarAlteracaoPedidoSQL(psCdUsuario, psNuPedido, psDeSituacao: string): WideString;
begin
  result := Format(VALIDAR_ALTERACAO_PEDIDO, [GetEsquema, GetEsquema, GetEsquema, QuotedStr(psCdUsuario), psNuPedido, QuotedStr(psDeSituacao)]);
end;


function VerificaSituacaoPedidoSQL(psNuPedido, psCdSituacao: string): WideString;
begin
  result := Format(VERIFICAR_SITUACAO_PEDIDO, [GetEsquema, psNuPedido, psCdSituacao]);
end;

function VerificaExclusaoPedidoSQL(psNuPedido: string): WideString;   
begin
  result := Format(VERIFICAR_EXCLUSAO_PEDIDO, [GetEsquema, psNuPedido]);
end;

end.

