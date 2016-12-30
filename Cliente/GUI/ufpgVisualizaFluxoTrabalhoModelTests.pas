unit ufpgVisualizaFluxoTrabalhoModelTests;

interface

uses
  SysUtils, ufpgModelTests, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, Classes;

type
  TffpgVisualizaFluxoTrabalhoModelTests = class(TfpgModelTests)
  private
    FsFluxoTrabalho: string;
    FsSubFluxoTrabalho: string;
    FsFilaTrabalho: string;
    FsNuProcesso: string;
    FbProcessoInvalido: boolean;
    FbSemParametros: boolean;
    FsAssunto: string;
    FsNomePessoa: string;
    FsClasse: string;
    FsCompetencia: string;
    FsObservacao: string;
    FsObservacao2: string;
    FsSemCustaInicial: boolean;
    FsSelecionado: string;
    FsCopiarFila: string;
    FsDescricao: string;
    FsDias: string;
    FsFilaProcesso: string;
    FsLotacao: string;
    FsModelo: string;
    FsCategoria: string;
    FsVariosProcessos: boolean;
    FsnmFila: string;
    FsnmNoPai: string;
    FsCodVaraDirecionada: string;
    FsTipoDistribuicao: string;
    FsnmFila2: string;
    fsCodDistribuicao: string;
    fsOficialJustica: string;
    fsJustificativaDistribuicao: string;
    fsBotaoAtividade: string;
    FsSituacaoMandado: string;
    FsCodZona: string;
    FsCDFilaSQL: string;
    FsfpgCdAgente: string;
    FbEditarObservacao: boolean;
    FbConsultarProcesso: boolean;
    FbExecutarAtividadeFilaMenu: boolean;
    FbFecharTela: boolean;
    FsNuProcesso3: string;
    FsNuProcesso2: string;
    FsCampo: string;
    FbTextoParcial: boolean;
    FbVerificarRecebimentoMandadoFila: boolean;
    FsNuMandado: string;
    FbDistribuirMandado: boolean;
    FbVerificarProcesso: boolean;
    FbImprimirMandado: boolean;
    FbGerarCertidao: boolean;
    FbVerificarFiltroForo: boolean;
    FbSelecionarProcessoGrid: boolean;
    FbAbrirDoMenu: boolean;
    FbTestarImpressaoVisualizacao: boolean;
    FbAcionarBotaoAtividade: boolean;
    FbVerificarOrdemTarja: boolean;
    FbEmitirAtoOrdinatorio: boolean;
    FbEmitirAtoOrdinatorioVistaMP: boolean;
    FbSegundoTeste: boolean;
    FbTerceiroTeste: boolean;
    FsCertificado: string;
    FbPrimeiroTeste: boolean;
    FbPesquisarProcesso: boolean;
    FbVerificaForosUsuario: boolean;
    FbVerDependenciasObjeto: boolean;
    FsFormaAto: string;
    FsTipoAto: string;
    FsConvenio: string;
    FsCategoriaModelo: string;
    FsDiasPrazo: string;
  public
    class function VerificaObservacaoProcessoFluxo(psNuProcesso, psObservacao,
      psObservacao1: string): boolean;
    class function RetornaDescricaoFluxo(psNuFluxo: string): string;
    class function VerificarSituacaoMandado(psSituacao, psNuMandado: string): boolean;
    class procedure PegarDadosMandado(psNuMandado: string; pbDistribuido: boolean);
    class function VerificarUltimaMovimentacaoFluxo(psNuMandado, psDeFila: string): boolean;
    class function RetornarNomeFilaObjeto(psObjeto: string): string;
    class function RetornarQtdeForosUsuario(psUsuario: string): integer;
    class function RetornarQtdeProcessosFilaUsuario(psForos: String;
      psCdFluxoTrabalho, psCdFilaTrabalho: string): integer;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuProcesso2: string read FsNuProcesso2 write FsNuProcesso2;
    property fpgNuProcesso3: string read FsNuProcesso3 write FsNuProcesso3;
    property fpgProcessoInvalido: boolean read FbProcessoInvalido write FbProcessoInvalido;
    property fpgSemParametros: boolean read FbSemParametros write FbSemParametros;
    property fpgFluxoTrabalho: string read FsFluxoTrabalho write FsFluxoTrabalho;
    property fpgSubFluxoTrabalho: string read FsSubFluxoTrabalho write FsSubFluxoTrabalho;
    property fpgFilaTrabalho: string read FsFilaTrabalho write FsFilaTrabalho;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgAssunto: string read FsAssunto write FsAssunto;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgNomePessoa: string read FsNomePessoa write FsNomePessoa;
    property fpgObservacao: string read FsObservacao write FsObservacao;
    property fpgObservacao2: string read FsObservacao2 write FsObservacao2;
    property fpgSemCustaInicial: boolean read FsSemCustaInicial write FsSemCustaInicial;
    property fpgSelecionado: string read FsSelecionado write FsSelecionado;
    property fpgCopiarFila: string read FsCopiarFila write FsCopiarFila;
    property fpgDescricao: string read FsDescricao write FsDescricao;
    property fpgDias: string read FsDias write FsDias;
    property fpgFilaProcesso: string read FsFilaProcesso write FsFilaProcesso;
    property fpgCategoria: string read FsCategoria write FsCategoria;
    property fpgModelo: string read FsModelo write FsModelo;
    property fpgVariosProcessos: boolean read FsVariosProcessos write FsVariosProcessos;
    property fpgLotacao: string read FsLotacao write FsLotacao;
    property fpgnmNoPai: string read FsnmNoPai write FsnmNoPai;
    property fpgnmFila: string read FsnmFila write FsnmFila;
    property fpgnmFila2: string read FsnmFila2 write FsnmFila2;
    property fpgCodVaraDirecionada: string read FsCodVaraDirecionada write FsCodVaraDirecionada;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgCodDistribuicao: string read fsCodDistribuicao write fsCodDistribuicao;
    property fpgOficialJustica: string read fsOficialJustica write fsOficialJustica;
    property fpgJustificativaDistribuicao: string 
      read fsJustificativaDistribuicao   write fsJustificativaDistribuicao;
    property fpgBotaoAtividade: string read fsBotaoAtividade write fsBotaoAtividade;
    property fpgSituacaoMandado: string read FsSituacaoMandado write FsSituacaoMandado;
    property fpgCodZona: string read FsCodZona write FsCodZona;
    property fpgCDFilaSQL: string read FsCDFilaSQL write FsCDFilaSQL;
    property fpgCdAgente: string read FsfpgCdAgente write FsfpgCdAgente;
    property fpgEditarObservacao: boolean read FbEditarObservacao write FbEditarObservacao;
    property fpgConsultarProcesso: boolean read FbConsultarProcesso write FbConsultarProcesso;
    property fpgExecutarAtividadeFilaMenu: boolean 
      read FbExecutarAtividadeFilaMenu   write FbExecutarAtividadeFilaMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgCampo: string read FsCampo write FsCampo;
    property fpgTextoParcial: boolean read FbTextoParcial write FbTextoParcial;
    property fpgVerificarRecebimentoMandadoFila: boolean   
      read FbVerificarRecebimentoMandadoFila write FbVerificarRecebimentoMandadoFila;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
    property fpgDistribuirMandado: boolean read FbDistribuirMandado write FbDistribuirMandado;
    property fpgImprimirMandado: boolean read FbImprimirMandado write FbImprimirMandado;
    property fpgVerificarProcesso: boolean read FbVerificarProcesso write FbVerificarProcesso;
    property fpgGerarCertidao: boolean read FbGerarCertidao write FbGerarCertidao;
    property fpgVerificarFiltroForo: boolean read FbVerificarFiltroForo 
      write FbVerificarFiltroForo;
    property fpgVerificarOrdemTarja: boolean read FbVerificarOrdemTarja 
      write FbVerificarOrdemTarja;
    property fpgSelecionarProcessoGrid: boolean read FbSelecionarProcessoGrid   
      write FbSelecionarProcessoGrid;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgTestarImpressaoVisualizacao: boolean   
      read FbTestarImpressaoVisualizacao write FbTestarImpressaoVisualizacao;
    property fpgAcionarBotaoAtividade: boolean read FbAcionarBotaoAtividade   
      write FbAcionarBotaoAtividade;
    property fpgEmitirAtoOrdinatorio: boolean read FbEmitirAtoOrdinatorio 
      write FbEmitirAtoOrdinatorio;
    property fpgEmitirAtoOrdinatorioVistaMP: boolean   
      read FbEmitirAtoOrdinatorioVistaMP write FbEmitirAtoOrdinatorioVistaMP;
    property fpgSegundoTeste: boolean read FbSegundoTeste write FbSegundoTeste;
    property fpgTerceiroTeste: boolean read FbTerceiroTeste write FbTerceiroTeste;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgPrimeiroTeste: boolean read FbPrimeiroTeste write FbPrimeiroTeste;
    property fpgPesquisarProcesso: boolean read FbPesquisarProcesso write FbPesquisarProcesso;
    property fpgVerificaForosUsuario: boolean read FbVerificaForosUsuario
      write FbVerificaForosUsuario;
    property fpgVerDependenciasObjeto: boolean read FbVerDependenciasObjeto
      write FbVerDependenciasObjeto;
    property fpgTipoAto: string read FsTipoAto write FsTipoAto;
    property fpgFormaAto: string read FsFormaAto write FsFormaAto;
    property fpgConvenio: string read FsConvenio write FsConvenio;
    property fpgDiasPrazo: string read FsDiasPrazo write FsDiasPrazo;
    property fpgCategoriaModelo: string read FsCategoriaModelo write FsCategoriaModelo;
  end;

implementation

uses
  usegRepositorio, ufpgVariaveisTestes, ufpgFuncoesTestes;


class function TffpgVisualizaFluxoTrabalhoModelTests.VerificaObservacaoProcessoFluxo(
  psNuProcesso, psObservacao, psObservacao1: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarObservacaoProcessoFluxoTrabalho(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := (psObservacao = '') or (Pos(psObservacao, oSegRepositorio.FieldByName(
      'OBSERVACAO').AsString) >= 0) and ((psObservacao1 = '') or
      (Pos(psObservacao1, oSegRepositorio.FieldByName('OBSERVACAO1').AsString) >= 0));
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgVisualizaFluxoTrabalhoModelTests.RetornaDescricaoFluxo(
  psNuFluxo: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornaDescricaoFluxoSQL(psNuFluxo);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('DEGRUPOFLUXOTRAB').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgVisualizaFluxoTrabalhoModelTests.VerificarSituacaoMandado(
  psSituacao, psNuMandado: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarSituacaoMandado(psSituacao, psNuMandado);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class procedure TffpgVisualizaFluxoTrabalhoModelTests.PegarDadosMandado(psNuMandado: string;
  pbDistribuido: boolean);
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    if pbDistribuido then
      sSQL := RetornarSituacaoMandadoAtualizado(psNuMandado)
    else
      sSQL := RetornarSituacaoMandadoAtualizadoNaoDistribuido(psNuMandado);

    oSegRepositorio.SQLOpen(sSQL);
    oSegRepositorio.Last;
    gsCdMandado := oSegRepositorio.FieldByName('CDMANDADO').AsString;
    gsCdCentral := oSegRepositorio.FieldByName('CDCENTRAL').AsString;
    gsZona := oSegRepositorio.FieldByName('CDZONA').AsString;
    gsSituacaoMandado := oSegRepositorio.FieldByName('CDSITUACAOMAND').AsString;

    if pbDistribuido then
    begin
      gsCdAgente := oSegRepositorio.FieldByName('CDAGENTE').AsString;
      gscdTipoDistMand := oSegRepositorio.FieldByName('CDTIPODISTMAND').AsString;
    end;

  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgVisualizaFluxoTrabalhoModelTests.VerificarUltimaMovimentacaoFluxo(
  psNuMandado, psDeFila: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarUltimaMovimentacaoFluxo(psNuMandado);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('DEFILA').AsString = psDeFila;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;


class function TffpgVisualizaFluxoTrabalhoModelTests.RetornarNomeFilaObjeto(
  psObjeto: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarFilaObjetoSQL(psObjeto);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('DEFILA').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgVisualizaFluxoTrabalhoModelTests.RetornarQtdeForosUsuario(
  psUsuario: string): integer;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := SQLRetornarQtdeForosUsuario(psUsuario, GetAliasBase);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('QTDE').AsInteger;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgVisualizaFluxoTrabalhoModelTests.RetornarQtdeProcessosFilaUsuario(
  psForos: String; psCdFluxoTrabalho, psCdFilaTrabalho: string): integer;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := SQLRetornarQtdeProcessosFilaUsuario(psForos, psCdFluxoTrabalho, psCdFilaTrabalho);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('QTDE').AsInteger;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

