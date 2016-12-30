unit ufpgVincRecolMandItemRecolhimentoTests;

interface

uses
  ufpgVincRecolMandItemRecolhimento, ufpgVincRecolMandItemMandado, ufpgVincRecolMandItemGuia,
  ufpgPainelInformoItemVincGuiaRecolMand, TestFrameWork, contnrs, usajConstante,
  ufpgConstante, ufpgVincRecolMandItens, ufpgObservadorIntf, ufpgVincRecolMandItemBasico,
  DB, DBClient;

type
  TMetodoObterTextoObjetoMandQtdRecolhimentos = function(
    const pnQtdRecolhimentos: integer): string of object;

  TDadoApoioMontagemTextoAgupador = record
    oClass: TfpgVincRecolMandItemBasicoClass;
    sTextPrefixo: string;
    sTextoItemNil: string;
    sTextSufixo: string;
    oFuncTextRelAgrupador: TMetodoObterTextoObjetoMandQtdRecolhimentos;
  end;

  TOpcaoInfoGuia = (oigOmitirInfoGuia, oigMostrarInfoGuia);
  TOpcaoInfoMandado = (oigmmitirInfoMand, oimMostrarInfoMand);
  TOpcaoInfoRecolhimento = (oirOmitirInfoRecol, oirMostrarInfoRecol);

  //herança para retirar montagem de controles visuais do painel
  TfpgPainelInformoItemVincGuiaRecolMandFake = class(TfpgPainelInformoItemVincGuiaRecolMand)
  private
    //apenas para os métodos fazerem algo
    FContadorFake: integer;
  protected
    procedure RemoverItens(pnQtdItensManter: integer = 0); override;
    procedure MontarItensDoDataSet; override;
    procedure AdicionarItem(const psValorRotulo, psValorInformacao: string); override;
  public
    FbChamouAtualizar: boolean;
    procedure Atualizar; override;
  end;

  TfpgVincRecolMandItemRecolhimentoFake = class(TfpgVincRecolMandItemRecolhimento)
  public
    FoObjetoEsperadoOrigemAtualizacao: TfpgVincRecolMandItens;
    FbChamouAtualizarObservador: boolean;
    procedure AtualizarObservador(poObservavel: IfpgObservavel); override;
  end;

  TfpgVincRecolMandItemRecolhimentoTests = class(TTestCase)
  private
    FoItem: TfpgVincRecolMandItemRecolhimentoFake;
    FoListaObjetos: TObjectList;

    procedure AdicListaObjeto(poObj: TObject);
    procedure AtribuirValoresDefault;
    function ObterStrDateTime(const pdtValor: TDateTime;
      const psFormatString: string = 'dd/mm/yyyy hh:mm:ss:zzz'): string;
    function FormataDadosRecl(const pdtfpgDtFechamento, pdtfpgDtUsuVincValor: TDateTime;
      const psfpgCdUsuVincValor: string; const pnfpgNuSeqVincRecolMand: integer;
      const psfpgTpVincValor: string; const pnfpgVlRecolGrj: double;
      const psfpgDeTipoRecol: string; const pnfpgCdForoCalculo, pnfpgCdCalculo,
      pnfpgCdTipoRecol, pnfpgNuSeqRecol: double;
      const pnfpgNuSeqDivisao, pnfpgNuSeqVincPrincipal: integer;
      const psfpgMandado, psfpgGuia: string): string;

    function ObterTextoObjetoReclDefault: string;
    function ObterTextoObjeto(poItemRecolhimento: TfpgVincRecolMandItemRecolhimento;
      poOpcaoInfoGuia: TOpcaoInfoGuia = oigMostrarInfoGuia;
      poOpcaoInfoMandado: TOpcaoInfoMandado = oimMostrarInfoMand): string; overload;

    function ObterTextoObjetoAgrupador(const poClasse: TfpgVincRecolMandItemBasicoClass;
      poItemAgrupador: TfpgVincRecolMandItens;
      const poOpInfoRecol: TOpcaoInfoRecolhimento): string;

    function ObterTextoObjetoMand(poItemMandado: TfpgVincRecolMandItemMandado;
      const poOpInfoRecol: TOpcaoInfoRecolhimento): string;
    function ObterTextoObjetoGuia(poItemGuia: TfpgVincRecolMandItemGuia;
      const poOpInfoRecol: TOpcaoInfoRecolhimento): string;

    function AdicionarMandado: TfpgVincRecolMandItemMandado;
    function AlterarValorNoTextoQtdRecolhimentos(const psTexto, psTagRecolhimentos: string;
      const pnQtdRecolhimentosAtual, pnQtdRecolhimentosNova: integer): string;
    procedure AtribuirValoresDivisao;

    function CriarGuiaDoRecolhimento: TfpgVincRecolMandItemGuia;
    function RetornarDescRecolComGuia: string;
    //18/01/2013 - maxback - SALT 125613/7/1 - Retirado pois o método TestCopiar foi Tranferido para
    //o projeto de débito técnico até que o erro
    //encontrado neste método seja corrigido...
    //function CopiarRecolhimento: TfpgVincRecolMandItemRecolhimento;

    procedure AppendStringList(poDataset: TClientDataSet; const psValores: string);
    function CriarDadosPainelEsperados: TClientDataSet;
    function CriarObjetoGuiaComDadosDefault: TfpgVincRecolMandItemGuia;
    function CriarObjetoMandComDadosDefault: TfpgVincRecolMandItemMandado;

    procedure AdicionarAgrupadorEIncluirRecolhimento(poObjAgrupador: TfpgVincRecolMandItens);
    procedure ApagarObjRelListaSeAdicionandoGuia(poObjAgrupador: TfpgVincRecolMandItens);

    procedure ExecutarOperacaoAdicionarAgupadorEItemComObservador(
      poObjAgrupador: TfpgVincRecolMandItens; var psEsperado, psObtido: string);
    procedure ExecutarOperacaoAdicionarMandadoComObservador; overload;
    procedure ExecutarOperacaoAdicionarGuiaComObservador;
    procedure ExecutarOperacaoRemoverAgrupadorComObservador(poObjAgrupador: TfpgVincRecolMandItens;
      var psEsperado, psObtido: string);
    procedure ExecutarOperacaoRemoverMandadoComObservador;
    procedure ExecutarOperacaoRemoverGuiaComObservador;

    function ObterStringDescricaoDataSet(poDataSet: TClientDataSet): string;
    function ObterTextoObjetoMandDefault: string;
    function ObterTextoObjetoMandQtdRecolhimentos(const pnQtdRecolhimentos: integer): string;
    function ObterTextoObjetoGuiaDefault: string;
    function ObterTextoObjetoGuiaQtdRecolhimentos(const pnQtdRecolhimentos: integer): string;
    function RetornarDadosAuxiliares(poObjAgrupador: TfpgVincRecolMandItens): TDadoApoioMontagemTextoAgupador;
    function RetornaRefAgrupadorDoItem(poObjAgrupador: TfpgVincRecolMandItens): TfpgVincRecolMandItens;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Test methods
    procedure TestarAtribuir;
    procedure TestarPegarDescricaoComMandadoVinculado;
    procedure TestarPegarDescricaoSemMandadoVinculado;

    //18/01/2013 - maxback - SALT 125613/7/1 - Tranferido para o projeto de débito técnico até qeu o erro
    //encontrado neste método seja corrigido...
    //procedure TestCopiar;

    procedure TestarTestarDisponivelParaVincularDesvincularComMandadoDisponivel;
    procedure TestarTestarDisponivelParaVincularDesvincularSemMandadoDisponivel;
    procedure TestarTestarDisponivelParaVincularDesvincularComMandadoNaoDisponivel;
    procedure TestarTestarDisponivelParaVincularDesvincularSemMandadoNaoDisponivel;
    procedure TestarfpgMandadoOriginalDefinido;
    procedure TestarfpgMandadoOriginalIndefinido;
    procedure TestarfpgRecolhimentoEmEdicaoEstandoEmEdicao;
    procedure TestarfpgRecolhimentoEmEdicaoNaoEstandoEmEdicao;
    //é adicionado a lista de recol. do mandado passado
    procedure TestarfpgMandadoSetandoPelaPrimeiraVez;
    //é limpo e assim tira da lista de recol. do mandado anterior
    procedure TestarfpgMandadoDesmarcandoESaindoDaListaRel;
    //Mistura dos dois anteriores
    procedure TestarfpgMandadoTrocandoMandado;

    //é adicionado a lista de recol. da guia passada
    procedure TestarfpgGuiaSetandoPelaPrimeiraVez;
    procedure TestarfpgGuiaDesmarcandoESaindoDaListaRel;
    //é limpo e assim tira da lista de recol. da guia anterior
    procedure TestarfpgGuiaTrocandoGuia;

    procedure TestarfpgDtFechamento;
    procedure TestarfpgDtUsuVincValor;
    procedure TestarfpgCdUsuVincValor;
    procedure TestarfpgNuSeqVincRecolMand;
    procedure TestarfpgTpVincValorAoAtribuir;
    procedure TestarfpgTpVincValorAlterandoHouveAlteracaoDePropriedades;
    procedure TestarfpgVlRecolGrj;
    procedure TestarfpgDeTipoRecol;
    procedure TestarfpgCdForoCalculo;
    procedure TestarfpgCdCalculo;
    procedure TestarfpgCdTipoRecol;
    procedure TestarfpgNuSeqRecol;
    procedure TestarfpgHouveAlteracaoDePropriedadesValorIniFalso;

    procedure TestarfpgIndexImagemNenhumaDefinida;
    procedure TestarfpgIndexImagemParaTpVincValorReserva;
    procedure TestarfpgIndexImagemParaTpVincValorConfirmacaoSemDataFechamento;
    procedure TestarfpgIndexImagemParaTpVincValorConfirmacaoComDataFechamento;
    procedure TestarfpgIndexImagemParaTpVincValorDevolucao;

    procedure TestarfpgNuSeqDivisao;
    procedure TestarfpgNuSeqVincPrincipal;

    procedure TestarDefinirInformacoesPainelChamouAtualizar;
    procedure TestarDefinirInformacoesPainelMudouDataset;

    procedure TestarAtualizarObservadorChamadoAoAdicionarVinculoComMandado;
    procedure TestarAtualizarObservadorAdicionaVinculoComMandadoDados;
    procedure TestarAtualizarObservadorChamadoAoRemoverVinculoComMandado;
    procedure TestarAtualizarObservadorRemoveVinculoComMandadoDados;

    procedure TestarAtualizarObservadorChamadoAoAdicionarVinculoComGuia;
    procedure TestarAtualizarObservadorAdicionaVinculoComGuiaDados;
    procedure TestarAtualizarObservadorChamadoAoRemoverVinculoComGuiaDados;
    procedure TestarAtualizarObservadorRemoveVinculoComGuiaDados;
  end;

implementation

uses
  SysUtils, Classes, uccpGeral;

const
  nINDEX_MAND = 0;
  nINDEX_GUIA = 1;

  sTEXTO_OBJ_NIL = 'nil';

  sMASCARA_DESC_RECOL_COM_MANDADO = 'Guia %s (%s)';
  sITEMGUIA_NMINTERESSADO_DEFAULT = 'Nome do interessado';
  sITEMGUIA_DETIPOCUSTA_DEFAULT = 'Tipo custa paga';
  nITEMGUIA_NUGUIAEMITIDA_DEFAULT = 123456789;
  nITEMGUIA_CDFOROGRJ_DEFAULT = 10;
  nITEMGUIA_DTPAGAMENTO_DEFAULT = 41141.234;  //20/08/2012

  sSEP_PROP_TXT = ', ';
  sMASCARA_STR_CORPO_GUIA = 'fpgDtPagamento:%s' + sSEP_PROP_TXT + 'fpgCdForoGrj:%s' +
    sSEP_PROP_TXT + 'fpgNuGrjEmitida:%s' + sSEP_PROP_TXT + 'fpgDeTipoCusta:%s' +
    sSEP_PROP_TXT + 'fpgNmInteressado:%s' + sSEP_PROP_TXT + 'fpgQtdadeRecolhimentos:%s';

  sCAB_GUIA = 'TfpgVincRecolMandItemGuia{' + #13#10;
  sFIM_GUIA = #13#10 + '}';

  sMASCARA_STR_COMPLETA_GUIA = sCAB_GUIA + sMASCARA_STR_CORPO_GUIA +
    sFIM_GUIA;

  nITEMRECOL_DTFECHAMENTO = nITEMGUIA_DTPAGAMENTO_DEFAULT + 2;
  nITEMRECOL_DTUSUVINCVALOR = nITEMGUIA_DTPAGAMENTO_DEFAULT + 1;
  sITEMRECOL_CDUSUVINCVALOR = 'USUARIO';
  nITEMRECOL_NUSEQVINCRECOLMAND = 10;
  sITEMRECOL_TPVINCVALOR = '2';
  nITEMRECOL_VLRECOLGRJ: double = 123.45;
  sITEMRECOL_DETIPORECOL = '[TipoRecol]';
  nITEMRECOL_CDFOROCALCULO = nITEMGUIA_CDFOROGRJ_DEFAULT;
  nITEMRECOL_CDCALCULO: double = 2;
  nITEMRECOL_CDTIPORECOL: double = 123;
  nITEMRECOL_NUSEQRECOL: double = 1;
  nITEMRECOL_NUSEQDIVISAO = -999;
  nITEMRECOL_NUSEQVINCPRINCIPAL = -999;

  nITEMRECOL_NUSEQDIVISAO_ALTERNATIVO = 23;
  nITEMRECOL_NUSEQVINCPRINCIPAL_ALTERNATIVO = 32;

  sCAB_RECOL = 'TfpgVincRecolMandItemRecolhimento{' + #13#10;
  sFIM_RECOL = #13#10 + '}';

  bITEMMAND_EMELABORACAO_DEFAULT = False;
  nITEMMAND_NUSEQDISTMANDADO_DEFAULT = 1;
  nITEMMAND_CDSITUACAOMAND_DEFAULT = 3;
  nITEMMAND_DTEMISSAO_DEFAULT = 41141.234;  //20/08/2012;
  nITEMMAND_DTDISTRIBUICAO_DEFAULT = nITEMMAND_DTEMISSAO_DEFAULT + 1;
  nITEMMAND_DTUSUVINCVALOR_DEFAULT = nITEMMAND_DTEMISSAO_DEFAULT + 3;
  sITEMMAND_NUMANDADO_DEFAULT = '01020120000013';
  sITEMMAND_DEFORMAPGTO_DEFAULT = 'Forma. pag';
  nITEMMAND_DTRECEBPELACM_DEFAULT = nITEMMAND_DTEMISSAO_DEFAULT + 2;
  sITEMMAND_CDMANDADO_DEFAULT = '0A000001';
  sITEMMAND_DESITUACAOMAND_DEFAULT = 'Aguardando Cumprimento';
  sITEMMAND_NMAGENTE_DEFAULT = 'Nome do agente do mandado';
  sITEMMAND_FLCUMPRIDOOFICIAL_DEFAULT = 'S';

  sTEXTO_QTDRECOLVINC = 'fpgQtdadeRecolhimentosVinculados';
  sTEXTO_QTDRECOL = 'fpgQtdadeRecolhimentos';

  sMASCARA_STR_CORPO_MANDADO = 'integer(fpgEmElaboracao):%s' + sSEP_PROP_TXT +
    'fpgNuSeqDistMandado:%s' + sSEP_PROP_TXT + 'fpgCdSituacaoMand:%s' + sSEP_PROP_TXT +
    'fpgDtUsuVincValor:%s' + sSEP_PROP_TXT + 'fpgNuMandado:%s' + sSEP_PROP_TXT +
    'fpgDeFormaPgto:%s' + sSEP_PROP_TXT + 'fpgDtDistribuicao:%s' + sSEP_PROP_TXT +
    'fpgDtEmissao:%s' + sSEP_PROP_TXT + 'fpgDtRecebPelaCM:%s' + sSEP_PROP_TXT +
    'fpgCdMandado:%s' + sSEP_PROP_TXT + 'fpgDeSituacaoMand:%s' + sSEP_PROP_TXT +
    'fpgNmAgente:%s' + sSEP_PROP_TXT + 'fpgFlCumpridoOficial:%s' + sSEP_PROP_TXT +
    sTEXTO_QTDRECOLVINC + ':%s' + sSEP_PROP_TXT + sTEXTO_QTDRECOL + ':%s';

  sCAB_MANDADO = 'TfpgVincRecolMandItemMandado{' + #13#10;
  sFIM_MANDADO = #13#10 + '}';

  sMASCARA_STR_COMPLETA_MANDADO = sCAB_MANDADO + sMASCARA_STR_CORPO_MANDADO +
    sFIM_MANDADO;

  sPREFIXO_ANTES_ITEMMAND = '{antes}FoItem.fpgMandado:';
  sPREFIXO_DEPOIS_ITEMMAND = '=>{depois}FoItem.fpgMandado:';

  sPREFIXO_ANTES_ITEMGUIA = '{antes}FoItem.fpgGuia:';
  sPREFIXO_DEPOIS_ITEMGUIA = '=>{depois}FoItem.fpgGuia:';

{ TfpgVincRecolMandItemRecolhimentoTests }

procedure TfpgVincRecolMandItemRecolhimentoTests.AdicListaObjeto(poObj: TObject);
begin
  if not Assigned(poObj) then
    Exit;
  FoListaObjetos.Add(poObj);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjeto(
  poItemRecolhimento: TfpgVincRecolMandItemRecolhimento;
  poOpcaoInfoGuia: TOpcaoInfoGuia = oigMostrarInfoGuia;
  poOpcaoInfoMandado: TOpcaoInfoMandado = oimMostrarInfoMand): string;
var
  sGuia, sMand: string;
begin
  if not Assigned(poItemRecolhimento) then
  begin
    result := sCAB_RECOL + sTEXTO_OBJ_NIL + sFIM_RECOL;
    Exit;
  end;
  sGuia := STRING_INDEFINIDO;
  if poOpcaoInfoGuia = oigMostrarInfoGuia then
    sGuia := ObterTextoObjetoGuia(poItemRecolhimento.fpgGuia, oirOmitirInfoRecol);

  sMand := STRING_INDEFINIDO;
  if poOpcaoInfoMandado = oimMostrarInfoMand then
    sMand := ObterTextoObjetoMand(poItemRecolhimento.fpgMandado, oirOmitirInfoRecol);

  //jcf:format=off
  Result :=
    FormataDadosRecl(poItemRecolhimento.fpgDtFechamento,
      poItemRecolhimento.fpgDtUsuVincValor,
      poItemRecolhimento.fpgCdUsuVincValor,
      poItemRecolhimento.fpgNuSeqVincRecolMand,
      poItemRecolhimento.fpgTpVincValor,
      poItemRecolhimento.fpgVlRecolGrj,
      poItemRecolhimento.fpgDeTipoRecol,
      poItemRecolhimento.fpgCdForoCalculo,
      poItemRecolhimento.fpgCdCalculo,
      poItemRecolhimento.fpgCdTipoRecol,
      poItemRecolhimento.fpgNuSeqRecol,
      poItemRecolhimento.fpgNuSeqDivisao,
      poItemRecolhimento.fpgNuSeqVincPrincipal,
      sMand, sGuia);
  //jcf:format=on
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoMand(
  poItemMandado: TfpgVincRecolMandItemMandado;
  const poOpInfoRecol: TOpcaoInfoRecolhimento): string;
var
  i: integer;
begin
  if not Assigned(poItemMandado) then
  begin
    result := sCAB_MANDADO + sTEXTO_OBJ_NIL + sFIM_MANDADO;
    Exit;
  end;

  //jcf:format=off
  Result :=
    Format(sCAB_MANDADO+sMASCARA_STR_CORPO_MANDADO, [
    IntToStr(Integer(poItemMandado.fpgEmElaboracao)),
    IntToStr(poItemMandado.fpgNuSeqDistMandado),
    IntToStr(poItemMandado.fpgCdSituacaoMand),
    ObterStrDateTime(poItemMandado.fpgDtUsuVincValor),
    poItemMandado.fpgNuMandado,
    poItemMandado.fpgDeFormaPgto,
    ObterStrDateTime(poItemMandado.fpgDtDistribuicao),
    ObterStrDateTime(poItemMandado.fpgDtEmissao),
    ObterStrDateTime(poItemMandado.fpgDtRecebPelaCM),
    poItemMandado.fpgCdMandado,
    poItemMandado.fpgDeSituacaoMand,
    poItemMandado.fpgNmAgente,
    poItemMandado.fpgFlCumpridoOficial,
    InttoStr(poItemMandado.fpgQtdadeRecolhimentosVinculados),
    InttoStr(poItemMandado.fpgQtdadeRecolhimentos)]);
  //jcf:format=on

  if poOpInfoRecol = oirMostrarInfoRecol then
  begin
    for i := 0 to poItemMandado.fpgQtdadeRecolhimentos - 1 do
    begin
      result := result + #13#10;
      result := result + 'fpgRecolhimento[' + IntToStr(i) + ']:' +
        ObterTextoObjeto(TfpgVincRecolMandItemRecolhimento(poItemMandado.fpgRecolhimento[i])) +
        #13#10;
    end;
  end;
  result := result + sFIM_MANDADO;
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterStrDateTime(const pdtValor: TDateTime;
  const psFormatString: string): string;
begin
  result := FormatDateTime(psFormatString, pdtValor);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoGuia(
  poItemGuia: TfpgVincRecolMandItemGuia; const poOpInfoRecol: TOpcaoInfoRecolhimento): string;
var
  i: integer;
begin
  if not Assigned(poItemGuia) then
  begin
    result := sCAB_GUIA + sTEXTO_OBJ_NIL + sFIM_GUIA;
    Exit;
  end;
  //jcf:format=off
  Result :=
    Format(sCAB_GUIA+sMASCARA_STR_CORPO_GUIA, [
      ObterStrDateTime(poItemGuia.fpgDtPagamento),
      FloatToStr(poItemGuia.fpgCdForoGrj),
      FloatToStr(poItemGuia.fpgNuGrjEmitida),
      poItemGuia.fpgDeTipoCusta,
      poItemGuia.fpgNmInteressado,
      IntToStr(poItemGuia.fpgQtdadeRecolhimentos)]);
  //jcf:format=on

  if poOpInfoRecol = oirMostrarInfoRecol then
  begin
    result := result + #13#10;
    for i := 0 to poItemGuia.fpgQtdadeRecolhimentos - 1 do
    begin
      result := result + 'fpgRecolhimento[' + IntToStr(i) + ']:' +
        ObterTextoObjeto(TfpgVincRecolMandItemRecolhimento(poItemGuia.fpgRecolhimento[i])) +
        #13#10;
    end;
  end;
  result := result + sFIM_GUIA;
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.SetUp;
begin
  inherited;
  FoListaObjetos := TObjectList.Create(True); //pc_ok

  FoItem := TfpgVincRecolMandItemRecolhimentoFake.Create; //pc_ok
  CriarGuiaDoRecolhimento;
  //AdicListaObjeto(FoItem); //o recolhiemtno é destruido pela guia, se for desvinc. da guia no teste
  //ai sim deve ser adicioan a lista
  AtribuirValoresDefault;
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoListaObjetos); //pc_ok
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarAtribuir;
begin
  CheckEqualsString(ObterTextoObjetoReclDefault, ObterTextoObjeto(FoItem));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorAdicionaVinculoComGuiaDados;
var
  sOperacaoGuiaEsperada, sOperacaoGuiaObtida: string;
begin
  //Este método é testado de forma indireta, ou seja: Sabendo que o item de mandado ao ter um recolhimento
  //adicionado, adiciona este como observador do item de mandados (que é observavel e já manda uma
  //mensagem de atualziação apra que este item de recolhiemento atualize seu valor de efpgMandado
  //e tome outras providencias.
  FoItem.fpgGuia := nil;
  AdicListaObjeto(FoItem);

  ExecutarOperacaoAdicionarAgupadorEItemComObservador(CriarObjetoGuiaComDadosDefault,
    sOperacaoGuiaEsperada, sOperacaoGuiaObtida);

  CheckEqualsString(sOperacaoGuiaEsperada, sOperacaoGuiaObtida);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorAdicionaVinculoComMandadoDados;
var
  sOperacaoMandEsperada, sOperacaoMandObtida: string;
begin
  //Este método é testado de forma indireta, ou seja: Sabendo que o item de mandado ao ter um recolhimento
  //adicionado, adiciona este como observador do item de mandados (que é observavel e já manda uma
  //mensagem de atualziação apra que este item de recolhiemento atualize seu valor de efpgMandado
  //e tome outras providencias.
  ExecutarOperacaoAdicionarAgupadorEItemComObservador(CriarObjetoMandComDadosDefault,
    sOperacaoMandEsperada, sOperacaoMandObtida);

  CheckEqualsString(sOperacaoMandEsperada, sOperacaoMandObtida);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorRemoveVinculoComGuiaDados;
var
  sOperacaoGuiaEsperada, sOperacaoGuiaObtida: string;
begin
  //No setup uma guia é criada e associada ao recolhiemnto: FoItem.fpgGuia
  ExecutarOperacaoRemoverAgrupadorComObservador(FoItem.fpgGuia, sOperacaoGuiaEsperada,
    sOperacaoGuiaObtida);

  CheckEqualsString(sOperacaoGuiaEsperada, sOperacaoGuiaObtida);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorRemoveVinculoComMandadoDados;
var
  sOperacaoMandEsperada, sOperacaoMandObtida: string;
begin
  //Teste feito de forma indireta: Mudando a vinculação de mandado ao recolhimento (removendo
  // o recolhiemnto do mandado) observa-se que a propriedade fpgMandado do rec. é limpa (via
  // AtualizarObservador
  ExecutarOperacaoRemoverAgrupadorComObservador(AdicionarMandado, sOperacaoMandEsperada,
    sOperacaoMandObtida);

  CheckEqualsString(sOperacaoMandEsperada, sOperacaoMandObtida);
end;

//18/01/2013 - maxback - SALT 125613/7/1 - Tranferido para o projeto de débito técnico até qeu o erro
//encontrado neste método seja corrigido...
{
procedure TfpgVincRecolMandItemRecolhimentoTests.TestarCopiar;
begin
  CheckEqualsString(ObterTextoObjeto(FoItem, oigOmitirInfoGuia), //ql
    ObterTextoObjeto(CopiarRecolhimento, oigOmitirInfoGuia));
end;
}

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarDefinirInformacoesPainelChamouAtualizar;
var
  oPainel: TfpgPainelInformoItemVincGuiaRecolMandFake;
begin
  oPainel := TfpgPainelInformoItemVincGuiaRecolMandFake.Create(nil); //pc_ok
  AdicListaObjeto(oPainel);
  oPainel.FbChamouAtualizar := False;

  FoItem.AtualizarInformacoesPainel(oPainel);

  CheckTrue(oPainel.FbChamouAtualizar);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgCdCalculo;
begin
  CheckEquals(nITEMRECOL_CDCALCULO, FoItem.fpgCdCalculo);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgCdForoCalculo;
begin
  CheckEquals(nITEMRECOL_CDFOROCALCULO, FoItem.fpgCdForoCalculo);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgCdTipoRecol;
begin
  CheckEquals(nITEMRECOL_CDTIPORECOL, FoItem.fpgCdTipoRecol);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgCdUsuVincValor;
begin
  CheckEqualsString(sITEMRECOL_CDUSUVINCVALOR, FoItem.fpgCdUsuVincValor);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgDeTipoRecol;
begin
  CheckEqualsString(sITEMRECOL_DETIPORECOL, FoItem.fpgDeTipoRecol);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgDtFechamento;
begin
  CheckEqualsString(ObterStrDateTime(nITEMRECOL_DTFECHAMENTO),
    ObterStrDateTime(FoItem.fpgDtFechamento));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgDtUsuVincValor;
begin
  CheckEqualsString(ObterStrDateTime(nITEMRECOL_DTUSUVINCVALOR),
    ObterStrDateTime(FoItem.fpgDtUsuVincValor));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgGuiaDesmarcandoESaindoDaListaRel;
var
  oGuia: TfpgVincRecolMandItemGuia;
  nContadorRecolhimentos: integer;
begin
  oGuia := CriarGuiaDoRecolhimento;
  nContadorRecolhimentos := oGuia.fpgQtdadeRecolhimentos;

  FoItem.fpgGuia := nil;
  AdicListaObjeto(FoItem);

  CheckEquals(1, nContadorRecolhimentos - oGuia.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgGuiaSetandoPelaPrimeiraVez;
var
  oGuia: TfpgVincRecolMandItemGuia;
begin
  oGuia := CriarGuiaDoRecolhimento;
  //verifica se a guia incluida encontra-se associada ao recolhimento
  CheckEqualsString(ObterTextoObjetoGuia(oGuia, oirMostrarInfoRecol), //ql
    ObterTextoObjetoGuia(FoItem.fpgGuia, oirMostrarInfoRecol));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgGuiaTrocandoGuia;
var
  oGuia1, oGuia2: TfpgVincRecolMandItemGuia;
begin
  oGuia1 := CriarGuiaDoRecolhimento;
  oGuia2 := CriarGuiaDoRecolhimento;

  CheckEquals(1, oGuia2.fpgQtdadeRecolhimentos - oGuia1.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarfpgHouveAlteracaoDePropriedadesValorIniFalso;
begin
  CheckFalse(FoItem.fpgHouveAlteracaoDePropriedades);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgIndexImagemNenhumaDefinida;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_ABERTO;
  CheckEquals(nINDEX_IMAGEM_NENHUM, FoItem.fpgIndexImagem);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarfpgIndexImagemParaTpVincValorConfirmacaoComDataFechamento;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_CONFIRMACAO;
  FoItem.fpgDtFechamento := Date;

  CheckEquals(nINDEX_IMAGEM_CONFIRMADO_DESABILITADO, FoItem.fpgIndexImagem);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarfpgIndexImagemParaTpVincValorConfirmacaoSemDataFechamento;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_CONFIRMACAO;
  FoItem.fpgDtFechamento := DATA_INDEFINIDA;

  CheckEquals(nINDEX_IMAGEM_CONFIRMADO, FoItem.fpgIndexImagem);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgIndexImagemParaTpVincValorDevolucao;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_DEVOLUCAO;

  CheckEquals(nINDEX_IMAGEM_DEVOLVIDO_PARA_PARTE, FoItem.fpgIndexImagem);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgIndexImagemParaTpVincValorReserva;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_RESERVA;
  CheckEquals(nINDEX_IMAGEM_RESERVADO, FoItem.fpgIndexImagem);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgMandadoDesmarcandoESaindoDaListaRel;
var
  oMand: TfpgVincRecolMandItemMandado;
  nContadorRecolhimentos: integer;
begin
  oMand := AdicionarMandado;
  nContadorRecolhimentos := oMand.fpgQtdadeRecolhimentos;

  FoItem.fpgMandado := nil;

  CheckEquals(1, nContadorRecolhimentos - oMand.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgMandadoOriginalDefinido;
begin
  AdicionarMandado;
  FoItem.fpgMandadoOriginal := FoItem.fpgMandado;
  FoItem.fpgMandado := nil;

  CheckEqualsString(ObterTextoObjetoMandDefault, //ql
    ObterTextoObjetoMand(FoItem.fpgMandadoOriginal, oirMostrarInfoRecol));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgMandadoOriginalIndefinido;
begin
  CheckFalse(Assigned(FoItem.fpgMandadoOriginal));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgMandadoSetandoPelaPrimeiraVez;
var
  oMand: TfpgVincRecolMandItemMandado;
begin
  oMand := AdicionarMandado;
  //verifica se no mandado incluido encontra-se o recolhiemnto
  CheckEqualsString(ObterTextoObjetoMand(oMand, oirMostrarInfoRecol), //ql
    ObterTextoObjetoMand(FoItem.fpgMandado, oirMostrarInfoRecol));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgMandadoTrocandoMandado;
var
  oMand1, oMand2: TfpgVincRecolMandItemMandado;
begin
  //notar que o método AdicionarMandado atrobui o mandado criado a FoItem.fpgMandado
  oMand1 := AdicionarMandado;
  oMand2 := AdicionarMandado;

  CheckEquals(1, oMand2.fpgQtdadeRecolhimentos - oMand1.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgNuSeqDivisao;
begin
  AtribuirValoresDivisao;

  CheckEquals(nITEMRECOL_NUSEQDIVISAO_ALTERNATIVO, FoItem.fpgNuSeqDivisao);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgNuSeqRecol;
begin
  CheckEquals(nITEMRECOL_NUSEQRECOL, FoItem.fpgNuSeqRecol);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgNuSeqVincPrincipal;
begin
  AtribuirValoresDivisao;

  CheckEquals(nITEMRECOL_NUSEQVINCPRINCIPAL_ALTERNATIVO, FoItem.fpgNuSeqVincPrincipal);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgNuSeqVincRecolMand;
begin
  CheckEquals(nITEMRECOL_NUSEQVINCRECOLMAND, FoItem.fpgNuSeqVincRecolMand);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgRecolhimentoEmEdicaoEstandoEmEdicao;
begin
  FoItem.fpgRecolhimentoEmEdicao := True;
  CheckTrue(FoItem.fpgRecolhimentoEmEdicao);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgRecolhimentoEmEdicaoNaoEstandoEmEdicao;
begin
  CheckFalse(FoItem.fpgRecolhimentoEmEdicao);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarfpgTpVincValorAlterandoHouveAlteracaoDePropriedades;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_ABERTO;
  CheckTrue(FoItem.fpgHouveAlteracaoDePropriedades);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgTpVincValorAoAtribuir;
begin
  CheckEqualsString(sITEMRECOL_TPVINCVALOR, FoItem.fpgTpVincValor);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarfpgVlRecolGrj;
begin
  CheckEquals(nITEMRECOL_VLRECOLGRJ, FoItem.fpgVlRecolGrj);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarPegarDescricaoComMandadoVinculado;
begin
  AdicionarMandado;
  CheckEqualsString(RetornarDescRecolComGuia, FoItem.PegarDescricao);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarPegarDescricaoSemMandadoVinculado;
begin
  CheckEqualsString(FoItem.fpgDeTipoRecol, FoItem.PegarDescricao);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarTestarDisponivelParaVincularDesvincularComMandadoDisponivel;
begin
  AdicionarMandado;
  FoItem.fpgDtFechamento := DATA_INDEFINIDA;
  CheckTrue(FoItem.TestarDisponivelParaVincularDesvincular);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarTestarDisponivelParaVincularDesvincularComMandadoNaoDisponivel;
begin
  AdicionarMandado;
  FoItem.fpgDtFechamento := Date;
  CheckFalse(FoItem.TestarDisponivelParaVincularDesvincular);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoReclDefault: string;
begin
  //jcf:format=off
  Result :=
    FormataDadosRecl(nITEMRECOL_DTFECHAMENTO,
      nITEMRECOL_DTUSUVINCVALOR,
      sITEMRECOL_CDUSUVINCVALOR,
      nITEMRECOL_NUSEQVINCRECOLMAND,
      sITEMRECOL_TPVINCVALOR,
      nITEMRECOL_VLRECOLGRJ,
      sITEMRECOL_DETIPORECOL,
      nITEMRECOL_CDFOROCALCULO,
      nITEMRECOL_CDCALCULO,
      nITEMRECOL_CDTIPORECOL,
      nITEMRECOL_NUSEQRECOL,
      nITEMRECOL_NUSEQDIVISAO,
      nITEMRECOL_NUSEQVINCPRINCIPAL,
      ObterTextoObjetoMand(FoItem.fpgMandado, oirOmitirInfoRecol),
      ObterTextoObjetoGuia(FoItem.fpgGuia, oirOmitirInfoRecol));
  //jcf:format=on
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.AtribuirValoresDefault;
begin
  FoItem.Atribuir(nITEMRECOL_DTFECHAMENTO, nITEMRECOL_DTUSUVINCVALOR,
    sITEMRECOL_CDUSUVINCVALOR, nITEMRECOL_NUSEQVINCRECOLMAND, sITEMRECOL_TPVINCVALOR,
    nITEMRECOL_VLRECOLGRJ, sITEMRECOL_DETIPORECOL, nITEMRECOL_CDFOROCALCULO,
    nITEMRECOL_CDCALCULO, nITEMRECOL_CDTIPORECOL, nITEMRECOL_NUSEQRECOL,
    nITEMRECOL_NUSEQDIVISAO, nITEMRECOL_NUSEQVINCPRINCIPAL);
end;

function TfpgVincRecolMandItemRecolhimentoTests.FormataDadosRecl(
  const pdtfpgDtFechamento, pdtfpgDtUsuVincValor: TDateTime; const psfpgCdUsuVincValor: string;
  const pnfpgNuSeqVincRecolMand: integer; const psfpgTpVincValor: string;
  const pnfpgVlRecolGrj: double; const psfpgDeTipoRecol: string;
  const pnfpgCdForoCalculo, pnfpgCdCalculo, pnfpgCdTipoRecol, pnfpgNuSeqRecol: double;
  const pnfpgNuSeqDivisao, pnfpgNuSeqVincPrincipal: integer;
  const psfpgMandado, psfpgGuia: string): string;
begin
  result := sCAB_RECOL + 'fpgDtFechamento:' + ObterStrDateTime(pdtfpgDtFechamento) +
    sSEP_PROP_TXT + 'fpgDtUsuVincValor:' + ObterStrDateTime(pdtfpgDtUsuVincValor) +
    sSEP_PROP_TXT + 'fpgCdUsuVincValor:' + psfpgCdUsuVincValor + sSEP_PROP_TXT +
    'fpgNuSeqVincRecolMand:' + IntToStr(pnfpgNuSeqVincRecolMand) + sSEP_PROP_TXT +
    'fpgTpVincValor:' + psfpgTpVincValor + sSEP_PROP_TXT + 'fpgVlRecolGrj:' +
    FloatToStr(pnfpgVlRecolGrj) + sSEP_PROP_TXT + 'fpgDeTipoRecol:' + psfpgDeTipoRecol +
    sSEP_PROP_TXT + 'fpgCdForoCalculo:' + FloatToStr(pnfpgCdForoCalculo) +
    sSEP_PROP_TXT + 'fpgCdCalculo:' + FloatToStr(pnfpgCdCalculo) + sSEP_PROP_TXT +
    'fpgCdTipoRecol:' + FloatToStr(pnfpgCdTipoRecol) + sSEP_PROP_TXT + 'fpgNuSeqRecol:' +
    FloatToStr(pnfpgNuSeqRecol) + sSEP_PROP_TXT + 'fpgNuSeqDivisao:' +
    IntToStr(pnfpgNuSeqDivisao) + sSEP_PROP_TXT + 'fpgNuSeqVincPrincipal:' +
    IntToStr(pnfpgNuSeqVincPrincipal) + sSEP_PROP_TXT + 'fpgMandado:' + psfpgMandado +
    sSEP_PROP_TXT + 'fpgGuia:' + psfpgGuia + sFIM_RECOL;
end;

function TfpgVincRecolMandItemRecolhimentoTests.AdicionarMandado: TfpgVincRecolMandItemMandado;
begin
  result := CriarObjetoMandComDadosDefault;
  FoItem.fpgMandado := result;
end;

function TfpgVincRecolMandItemRecolhimentoTests.AlterarValorNoTextoQtdRecolhimentos(
  const psTexto, psTagRecolhimentos: string;
  const pnQtdRecolhimentosAtual, pnQtdRecolhimentosNova: integer): string;
begin
  result := StringReplace(psTexto, psTagRecolhimentos + ':' + IntToStr(pnQtdRecolhimentosAtual),
    psTagRecolhimentos + ':' + IntToStr(pnQtdRecolhimentosNova), []);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.AtribuirValoresDivisao;
begin
  FoItem.Atribuir(nITEMRECOL_DTFECHAMENTO, nITEMRECOL_DTUSUVINCVALOR,
    sITEMRECOL_CDUSUVINCVALOR, nITEMRECOL_NUSEQVINCRECOLMAND, sITEMRECOL_TPVINCVALOR,
    nITEMRECOL_VLRECOLGRJ, sITEMRECOL_DETIPORECOL, nITEMRECOL_CDFOROCALCULO,
    nITEMRECOL_CDCALCULO, nITEMRECOL_CDTIPORECOL, nITEMRECOL_NUSEQRECOL,
    nITEMRECOL_NUSEQDIVISAO_ALTERNATIVO, nITEMRECOL_NUSEQVINCPRINCIPAL_ALTERNATIVO);
end;

function TfpgVincRecolMandItemRecolhimentoTests.RetornarDescRecolComGuia: string;
var
  sNuGuiaformadata: string;
begin
  sNuGuiaformadata := FormataNuGuia(FloatToStr(nITEMGUIA_NUGUIAEMITIDA_DEFAULT),
    IntToStr(nITEMGUIA_CDFOROGRJ_DEFAULT));
  result := Format(sMASCARA_DESC_RECOL_COM_MANDADO, [sNuGuiaformadata, sITEMRECOL_DETIPORECOL]);
end;

function TfpgVincRecolMandItemRecolhimentoTests.CriarGuiaDoRecolhimento: TfpgVincRecolMandItemGuia;
begin
  result := CriarObjetoGuiaComDadosDefault;

  FoItem.fpgGuia := result;
  ApagarObjRelListaSeAdicionandoGuia(FoItem.fpgGuia);
end;

//18/01/2013 - maxback - SALT 125613/7/1 - Retirado pois o método TestCopiar foi Tranferido para
//o projeto de débito técnico até qeu o erro
//encontrado neste método seja corrigido...
{
function TfpgVincRecolMandItemRecolhimentoTests.CopiarRecolhimento: TfpgVincRecolMandItemRecolhimento;
begin
  result := TfpgVincRecolMandItemRecolhimento(FoItem.Copiar);
  AdicListaObjeto(result);
end;
}

function TfpgVincRecolMandItemRecolhimentoTests.CriarDadosPainelEsperados: TClientDataSet;
begin
  result := TClientDataSet.Create(nil); //PC_OK
  AdicListaObjeto(result);

  result.FieldDefs.Add('fpgVincRecolMandItemRotulo', ftString, 256, True);
  result.FieldDefs.Add('fpgVincRecolMandItemInformacao', ftString, 1024);
  result.CreateDataSet;
  result.Active := True;

  //seguem registro do dataset
  AppendStringList(result, '"Recolhimento ' + sITEMRECOL_DETIPORECOL + ',');
  AppendStringList(result, 'Situação,"Pago para o oficial"');
  AppendStringList(result, 'Valor,"' + FloatToStr(nITEMRECOL_VLRECOLGRJ) + '"');
  AppendStringList(result, '"Pagamento da guia",' + DateToStr(nITEMMAND_DTEMISSAO_DEFAULT));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarTestarDisponivelParaVincularDesvincularSemMandadoDisponivel;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_ABERTO;
  CheckTrue(FoItem.TestarDisponivelParaVincularDesvincular);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarTestarDisponivelParaVincularDesvincularSemMandadoNaoDisponivel;
begin
  FoItem.fpgTpVincValor := sTP_VINC_VALOR_RESERVA;
  CheckFalse(FoItem.TestarDisponivelParaVincularDesvincular);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.TestarDefinirInformacoesPainelMudouDataset;
var
  oPainel: TfpgPainelInformoItemVincGuiaRecolMandFake;
  oDataSetDadosEsperado: TClientDataSet;
begin
  oPainel := TfpgPainelInformoItemVincGuiaRecolMandFake.Create(nil); //pc_ok

  AdicListaObjeto(oPainel);
  FoItem.AtualizarInformacoesPainel(oPainel);

  oDataSetDadosEsperado := CriarDadosPainelEsperados;

  CheckEqualsString(ObterStringDescricaoDataSet(oDataSetDadosEsperado), //ql
    ObterStringDescricaoDataSet(oPainel.fpgDataSetDados));
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.AppendStringList(poDataset: TClientDataSet;
  const psValores: string);
var
  i: integer;
  oStringList: TStringList;
begin
  oStringList := TStringList.Create;
  try
    oStringList.CommaText := psValores;
    poDataset.Append;
    for i := 0 to oStringList.Count - 1 do
    begin
      poDataset.Fields[i].AsString := oStringList[i];
    end;
    poDataset.Post;
  finally
    FreeAndNil(oStringList);
  end;
end;

function TfpgVincRecolMandItemRecolhimentoTests.CriarObjetoMandComDadosDefault: TfpgVincRecolMandItemMandado;
begin
  result := TfpgVincRecolMandItemMandado.Create; //PC_OK
  AdicListaObjeto(result);

  result.Atribuir(bITEMMAND_EMELABORACAO_DEFAULT, nITEMMAND_NUSEQDISTMANDADO_DEFAULT,
    nITEMMAND_CDSITUACAOMAND_DEFAULT, nITEMMAND_DTUSUVINCVALOR_DEFAULT,
    sITEMMAND_NUMANDADO_DEFAULT, sITEMMAND_DEFORMAPGTO_DEFAULT, nITEMMAND_DTDISTRIBUICAO_DEFAULT,
    nITEMMAND_DTEMISSAO_DEFAULT, nITEMMAND_DTRECEBPELACM_DEFAULT, sITEMMAND_CDMANDADO_DEFAULT,
    sITEMMAND_DESITUACAOMAND_DEFAULT, sITEMMAND_NMAGENTE_DEFAULT,
    sITEMMAND_FLCUMPRIDOOFICIAL_DEFAULT);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterStringDescricaoDataSet(
  poDataSet: TClientDataSet): string;
var
  i: integer;
  sDesc: string;
begin
  result := '<Dataset>';
  if not Assigned(poDataSet) then
  begin
    result := result + '<Result>not assigned</Result></Dataset>';
    Exit;
  end;

  if not poDataSet.Active then
  begin
    result := result + '<Result>not Active</Result></Dataset>';
    Exit;
  end;

  result := result + '<Result>OK</Result>' + #10#13;
  sDesc := '<FieldDefs><Count>' + IntToStr(poDataSet.FieldDefs.Count) + '</Cont><Items>';
  for i := 0 to poDataSet.FieldDefs.Count - 1 do
  begin
    sDesc := sDesc + #13#10 + '  <Item FieldNo="' +
      IntToStr(poDataSet.FieldDefs.Items[i].FieldNo) + '" ';
    sDesc := sDesc + 'Name="' + poDataSet.FieldDefs.Items[i].Name + '" ';
    sDesc := sDesc + 'DataType="' +
      IntToStr(integer(poDataSet.FieldDefs.Items[i].DataType)) + '" ';
    sDesc := sDesc + 'Size="' + IntToStr(poDataSet.FieldDefs.Items[i].Size) + '" ';
    sDesc := sDesc + 'Required="' +
      IntToStr(integer(poDataSet.FieldDefs.Items[i].Required)) + '" ';
    sDesc := sDesc + '</Item>';
  end;
  sDesc := sDesc + '</Items></FieldDefs>';
  result := result + #13#10 + sDesc + #13#10;

  if poDataSet.IsEmpty then
  begin
    result := result + '<RecordCount>0</RecordCount></Dataset>';
    Exit;
  end
  else
    result := result + '<RecordCount>' + IntToStr(poDataSet.RecordCount) + '</RecordCount>';

  result := result + #13#10 + '<Records>';
  poDataSet.First;
  while not poDataSet.EOF do
  begin
    result := result + #13#10 + '  <Record FieldNo=' + IntToStr(poDataSet.Recno) + ' >';
    sDesc := '';
    for i := 0 to poDataSet.FieldDefs.Count - 1 do
    begin
      sDesc := sDesc + '<' + poDataSet.FieldDefs.Items[i].Name + '>';
      sDesc := sDesc + poDataSet.FieldByName(poDataSet.FieldDefs.Items[i].Name).AsString;
      sDesc := sDesc + '</' + poDataSet.FieldDefs.Items[i].Name + '>';
    end;
    result := result + sDesc + '</Record>';
    poDataSet.Next;
  end;
  result := result + #13#10 + '</Records></Dataset>';
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoMandDefault: string;
begin
  result := ObterTextoObjetoMand(CriarObjetoMandComDadosDefault, oirOmitirInfoRecol);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoMandQtdRecolhimentos(
  const pnQtdRecolhimentos: integer): string;
begin
  result := ObterTextoObjetoMandDefault;

  //pega o default (que não tem qtd de recolhimentos e força ter pnQtdRecolhimentos
  //recolhimentos para simular o texto de um mandado associado a um recolhimento.
  result := AlterarValorNoTextoQtdRecolhimentos(result, sTEXTO_QTDRECOL, 0, pnQtdRecolhimentos);
  result := AlterarValorNoTextoQtdRecolhimentos(result, sTEXTO_QTDRECOLVINC,
    0, pnQtdRecolhimentos);
end;

function TfpgVincRecolMandItemRecolhimentoTests.CriarObjetoGuiaComDadosDefault: TfpgVincRecolMandItemGuia;
begin
  result := TfpgVincRecolMandItemGuia.Create; //PC_OK;
  AdicListaObjeto(result);

  result.Atribuir(nITEMGUIA_DTPAGAMENTO_DEFAULT, nITEMGUIA_CDFOROGRJ_DEFAULT,
    nITEMGUIA_NUGUIAEMITIDA_DEFAULT, sITEMGUIA_DETIPOCUSTA_DEFAULT,
    sITEMGUIA_NMINTERESSADO_DEFAULT);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorChamadoAoAdicionarVinculoComMandado;
begin
  //Este método é testado de forma indireta, ou seja: Sabendo que o item de mandado ao ter um recolhimento
  //adicionado, adiciona este como observador do item de mandados (que é observavel e já manda uma
  //mensagem de atualização para que este item de recolhiemento atualize seu valor de efpgMandado
  //e tome outras providências.
  //para saber que chamou o observado foi feita uma classe fake capaz de sinalziar por um flag
  //torna-se importante isto também pois testar se o mandado foi setado não dectar uma possivel mudança
  //que passaria a setar o amndado diretamente ao incluir, ao invés de usar o mecanism ode observação.
  ExecutarOperacaoAdicionarMandadoComObservador;

  CheckTrue(FoItem.FbChamouAtualizarObservador);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.ExecutarOperacaoAdicionarMandadoComObservador;
var
  sMandEsperadoDummy, sMandObtidoDummy: string;
begin
  ExecutarOperacaoAdicionarAgupadorEItemComObservador(CriarObjetoMandComDadosDefault,
    sMandEsperadoDummy, sMandObtidoDummy);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.ExecutarOperacaoRemoverAgrupadorComObservador(
  poObjAgrupador: TfpgVincRecolMandItens; var psEsperado, psObtido: string);
var
  aDados: TDadoApoioMontagemTextoAgupador;
begin
  aDados := RetornarDadosAuxiliares(poObjAgrupador);

  psEsperado := aDados.sTextPrefixo + aDados.oFuncTextRelAgrupador(1);
  psEsperado := psEsperado + aDados.sTextSufixo + aDados.sTextoItemNil;

  psObtido := aDados.sTextPrefixo + ObterTextoObjetoAgrupador(aDados.oClass,
    RetornaRefAgrupadorDoItem(poObjAgrupador), oirOmitirInfoRecol);

  //seta o objeto de mandado como objeto esperado para a classe fake
  FoItem.FoObjetoEsperadoOrigemAtualizacao := poObjAgrupador;
  FoItem.FbChamouAtualizarObservador := False;

  poObjAgrupador.RemoverRecolhimento(FoItem);

  //o item associado a guia é destruido por ela, mas ao ser removido deve ser destruido por si mesmo
  if (poObjAgrupador is TfpgVincRecolMandItemGuia) and (not Assigned(FoItem.fpgGuia)) then
    AdicListaObjeto(FoItem);

  psObtido := psObtido + aDados.sTextSufixo + ObterTextoObjetoAgrupador(
    aDados.oClass, RetornaRefAgrupadorDoItem(poObjAgrupador), oirOmitirInfoRecol);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorChamadoAoRemoverVinculoComMandado;
begin
  //ver TestAtualizarObservadorChamadoAoAdicionarVinculoComMandado
  ExecutarOperacaoRemoverMandadoComObservador;

  CheckTrue(FoItem.FbChamouAtualizarObservador);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.ExecutarOperacaoRemoverMandadoComObservador;
var
  sMandEsperadoDummy, sMandObtidoDummy: string;
begin
  ExecutarOperacaoRemoverAgrupadorComObservador(AdicionarMandado, sMandEsperadoDummy,
    sMandObtidoDummy);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.ExecutarOperacaoAdicionarGuiaComObservador;
var
  sMandEsperadoDummy, sMandObtidoDummy: string;
begin
  ExecutarOperacaoAdicionarAgupadorEItemComObservador(CriarObjetoGuiaComDadosDefault,
    sMandEsperadoDummy, sMandObtidoDummy);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.ExecutarOperacaoRemoverGuiaComObservador;
var
  sGuiaEsperadoDummy, sGuiaObtidoDummy: string;
begin
  //No setup uma guia é criada e associada ao recolhimento: FoItem.fpgGuia
  ExecutarOperacaoRemoverAgrupadorComObservador(FoItem.fpgGuia, sGuiaEsperadoDummy,
    sGuiaObtidoDummy);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoGuiaQtdRecolhimentos(
  const pnQtdRecolhimentos: integer): string;
begin
  result := ObterTextoObjetoGuiaDefault;

  //pega o default (que não tem qtd de recolhiemtnos e força ter pnQtdRecolhimentos
  //recolhiemntos para simular o texto de um mandado associado a um recolhiemtno
  result := AlterarValorNoTextoQtdRecolhimentos(result, sTEXTO_QTDRECOL, 0, pnQtdRecolhimentos);
  result := AlterarValorNoTextoQtdRecolhimentos(result, sTEXTO_QTDRECOLVINC,
    0, pnQtdRecolhimentos);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoGuiaDefault: string;
begin
  result := ObterTextoObjetoGuia(CriarObjetoGuiaComDadosDefault, oirOmitirInfoRecol);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorChamadoAoAdicionarVinculoComGuia;
begin
  //Este método é testado de forma indireta, ou seja: Sabendo que o item de mandado ao ter um recolhimento
  //adicionado, adiciona este como observador do item de mandados (que é observável e já manda uma
  //mensagem de atualização para que este item de recolhiemento atualize seu valor de efpgMandado
  //e tome outras providências.
  //para saber que chamou o observado foi feita uma classe fake capaz de sinalizar por um flag
  //torna-se importante isto também pois testar se o mandado foi setado não detecta uma possivel mudança
  //que passaria a setar o mandado diretamente ao incluir, ao invés de usar o mecanismo de observação.
  FoItem.fpgGuia := nil;
  AdicListaObjeto(FoItem);

  ExecutarOperacaoAdicionarGuiaComObservador;

  CheckTrue(FoItem.FbChamouAtualizarObservador);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.AdicionarAgrupadorEIncluirRecolhimento(
  poObjAgrupador: TfpgVincRecolMandItens);
begin
  FoItem.FoObjetoEsperadoOrigemAtualizacao := poObjAgrupador;
  poObjAgrupador.IncluirRecolhimento(FoItem);

  ApagarObjRelListaSeAdicionandoGuia(poObjAgrupador);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.ApagarObjRelListaSeAdicionandoGuia(
  poObjAgrupador: TfpgVincRecolMandItens);
begin
  //se for guia e esta estiver na lsitade opbjetos para destruir automaticamente, o recolhiemtn odeve
  //sair de tal lista pois a classe de guia destroi seus itens
  if not (poObjAgrupador is TfpgVincRecolMandItemGuia) then
    Exit;

  if FoListaObjetos.IndexOf(poObjAgrupador) < 0 then
    Exit;

  if FoListaObjetos.IndexOf(FoItem) >= 0 then
    FoListaObjetos.Extract(FoItem);
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
ExecutarOperacaoAdicionarAgupadorEItemComObservador(
  poObjAgrupador: TfpgVincRecolMandItens; var psEsperado, psObtido: string);
var
  aDados: TDadoApoioMontagemTextoAgupador;
begin
  aDados := RetornarDadosAuxiliares(poObjAgrupador);

  FoItem.FbChamouAtualizarObservador := False;

  psEsperado := aDados.sTextPrefixo + aDados.sTextoItemNil;
  psEsperado := psEsperado + aDados.sTextSufixo + aDados.oFuncTextRelAgrupador(1);

  psObtido := aDados.sTextPrefixo + ObterTextoObjetoAgrupador(aDados.oClass,
    RetornaRefAgrupadorDoItem(poObjAgrupador), oirOmitirInfoRecol);

  AdicionarAgrupadorEIncluirRecolhimento(poObjAgrupador);

  psObtido := psObtido + aDados.sTextSufixo + ObterTextoObjetoAgrupador(aDados.oClass,
    RetornaRefAgrupadorDoItem(poObjAgrupador), oirOmitirInfoRecol);
end;

function TfpgVincRecolMandItemRecolhimentoTests.ObterTextoObjetoAgrupador(
  const poClasse: TfpgVincRecolMandItemBasicoClass; poItemAgrupador: TfpgVincRecolMandItens;
  const poOpInfoRecol: TOpcaoInfoRecolhimento): string;
begin
  if poClasse = TfpgVincRecolMandItemMandado then
    result := ObterTextoObjetoMand(TfpgVincRecolMandItemMandado(poItemAgrupador), poOpInfoRecol)
  else if poClasse = TfpgVincRecolMandItemGuia then
    result := ObterTextoObjetoGuia(TfpgVincRecolMandItemGuia(poItemAgrupador), poOpInfoRecol)
  else if Assigned(poItemAgrupador) then
    result := poItemAgrupador.ClassName + '{?}'
  else
    result := '???';
end;

function TfpgVincRecolMandItemRecolhimentoTests.RetornarDadosAuxiliares(
  poObjAgrupador: TfpgVincRecolMandItens): TDadoApoioMontagemTextoAgupador;
const
  //jcf:format=off
  aContDados: array[nINDEX_MAND..nINDEX_GUIA] of TDadoApoioMontagemTextoAgupador =
        ((oClass:TfpgVincRecolMandItemMandado; sTextPrefixo: sPREFIXO_ANTES_ITEMMAND;
          sTextoItemNil: sCAB_MANDADO + sTEXTO_OBJ_NIL + sFIM_MANDADO;
          sTextSufixo: sPREFIXO_DEPOIS_ITEMMAND;
          oFuncTextRelAgrupador: nil;
          ),

         (oClass:TfpgVincRecolMandItemGuia;    sTextPrefixo: sPREFIXO_ANTES_ITEMGUIA;
          sTextoItemNil: sCAB_GUIA + sTEXTO_OBJ_NIL + sFIM_GUIA;
          sTextSufixo: sPREFIXO_DEPOIS_ITEMGUIA;
          oFuncTextRelAgrupador: nil;
         )
        );
  //jcf:format=on
begin
  if poObjAgrupador is TfpgVincRecolMandItemMandado then
  begin
    result := aContDados[nINDEX_MAND];
    result.oFuncTextRelAgrupador := ObterTextoObjetoMandQtdRecolhimentos;
  end
  else
  begin
    result := aContDados[nINDEX_GUIA];
    result.oFuncTextRelAgrupador := ObterTextoObjetoGuiaQtdRecolhimentos;
  end;
end;

function TfpgVincRecolMandItemRecolhimentoTests.RetornaRefAgrupadorDoItem(
  poObjAgrupador: TfpgVincRecolMandItens): TfpgVincRecolMandItens;
begin
  if poObjAgrupador is TfpgVincRecolMandItemMandado then
    result := FoItem.fpgMandado
  else
    result := FoItem.fpgGuia;
end;

procedure TfpgVincRecolMandItemRecolhimentoTests.
TestarAtualizarObservadorChamadoAoRemoverVinculoComGuiaDados;
begin
  FoItem.FbChamouAtualizarObservador := False;

  ExecutarOperacaoRemoverGuiaComObservador;

  CheckTrue(FoItem.FbChamouAtualizarObservador);
end;

{ TfpgPainelInformoItemVincGuiaRecolMandFake }

procedure TfpgPainelInformoItemVincGuiaRecolMandFake.AdicionarItem(
  const psValorRotulo, psValorInformacao: string);
begin
  //inherited;
  Inc(FContadorFake);
end;

procedure TfpgPainelInformoItemVincGuiaRecolMandFake.Atualizar;
begin
  inherited;
  FbChamouAtualizar := True;
end;

procedure TfpgPainelInformoItemVincGuiaRecolMandFake.MontarItensDoDataSet;
begin
  //inherited;
  Inc(FContadorFake);
end;

procedure TfpgPainelInformoItemVincGuiaRecolMandFake.RemoverItens(pnQtdItensManter: integer);
begin
  //inherited;
  Dec(FContadorFake);
end;

{ TfpgVincRecolMandItemRecolhimentoFake }

procedure TfpgVincRecolMandItemRecolhimentoFake.AtualizarObservador(poObservavel: IfpgObservavel);
var
  vParam: olevariant;
  oObjItens: TfpgVincRecolMandItens;
  OItemDoParam: TfpgVincRecolMandItemBasico;
begin
  //pega a classe do observavel (assumindo que seja TfpgVincRecolMandItens)
  vParam := poObservavel.RetornarParametro();

  //se a origem é do objeto esperado e o destino é o objeto de rec.atual seta flag
  oObjItens := TfpgVincRecolMandItens.RetornarObjetoObservaveldoParametro(vParam);
  OItemDoParam := TfpgVincRecolMandItens.RetornarObjetoItemDoParametro(vParam);

  if (FoObjetoEsperadoOrigemAtualizacao = oObjItens) and //ql
    (OItemDoParam = Self) then
  begin
    FbChamouAtualizarObservador := True;
  end;

  inherited;
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgVincRecolMandItemRecolhimentoTests',
    TfpgVincRecolMandItemRecolhimentoTests.Suite);

end.

