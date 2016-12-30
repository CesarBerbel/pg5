unit ufpgVincRecolMandItemRecolhimentoDebitoTecnicoTests;

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


  TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests = class(TTestCase)
  private
    FoItem: TfpgVincRecolMandItemRecolhimento;
    FoListaObjetos: TObjectList;

    procedure AdicListaObjeto(poObj: TObject); //usado
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

    function ObterTextoObjeto(poItemRecolhimento: TfpgVincRecolMandItemRecolhimento;
      poOpcaoInfoGuia: TOpcaoInfoGuia = oigMostrarInfoGuia;
      poOpcaoInfoMandado: TOpcaoInfoMandado = oimMostrarInfoMand): string; overload;

    function ObterTextoObjetoMand(poItemMandado: TfpgVincRecolMandItemMandado;
      const poOpInfoRecol: TOpcaoInfoRecolhimento): string;
    function ObterTextoObjetoGuia(poItemGuia: TfpgVincRecolMandItemGuia;
      const poOpInfoRecol: TOpcaoInfoRecolhimento): string;

    function CriarObjetoGuiaComDadosDefault: TfpgVincRecolMandItemGuia;
    procedure ApagarObjRelListaSeAdicionandoGuia(poObjAgrupador: TfpgVincRecolMandItens);

    function CopiarRecolhimento: TfpgVincRecolMandItemRecolhimento; //usado
    function CriarGuiaDoRecolhimento: TfpgVincRecolMandItemGuia;

  protected

    procedure SetUp; override;
    procedure TearDown; override;

  published

    procedure TestCopiar;
  end;

implementation

uses
  SysUtils, Classes, uccpGeral;

const
  sTEXTO_OBJ_NIL = 'nil';

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

{ TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests }

procedure TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.AdicListaObjeto(poObj: TObject);
begin
  if not Assigned(poObj) then
    Exit;
  FoListaObjetos.Add(poObj);
end;

function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.ObterTextoObjeto(
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

function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.ObterTextoObjetoMand(
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
    result := result + #13#10;
    for i := 0 to poItemMandado.fpgQtdadeRecolhimentos - 1 do
    begin
      result := result + 'fpgRecolhimento[' + IntToStr(i) + ']:' +
        ObterTextoObjeto(TfpgVincRecolMandItemRecolhimento(poItemMandado.fpgRecolhimento[i])) +
        #13#10;
    end;
  end;
  result := result + sFIM_MANDADO;
end;

function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.ObterStrDateTime(
  const pdtValor: TDateTime; const psFormatString: string): string;
begin
  result := FormatDateTime(psFormatString, pdtValor);
end;

function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.ObterTextoObjetoGuia(
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

procedure TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.SetUp;
begin
  inherited;
  FoListaObjetos := TObjectList.Create(True); //PC_OK

  FoItem := TfpgVincRecolMandItemRecolhimento.Create; //PC_OK
  CriarGuiaDoRecolhimento;
  //AdicListaObjeto(FoItem); //o recolhiemtno é destruido pela guia, se for desvinc. da guia no teste
  //ai sim deve ser adicioan a lista
  AtribuirValoresDefault;
end;

procedure TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoListaObjetos); //pc_ok
end;

procedure TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.TestCopiar;
begin
  CheckEqualsString(ObterTextoObjeto(FoItem, oigOmitirInfoGuia), //ql
    ObterTextoObjeto(CopiarRecolhimento, oigOmitirInfoGuia));
end;


procedure TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.AtribuirValoresDefault;
begin
  FoItem.Atribuir(nITEMRECOL_DTFECHAMENTO, nITEMRECOL_DTUSUVINCVALOR,
    sITEMRECOL_CDUSUVINCVALOR, nITEMRECOL_NUSEQVINCRECOLMAND, sITEMRECOL_TPVINCVALOR,
    nITEMRECOL_VLRECOLGRJ, sITEMRECOL_DETIPORECOL, nITEMRECOL_CDFOROCALCULO,
    nITEMRECOL_CDCALCULO, nITEMRECOL_CDTIPORECOL, nITEMRECOL_NUSEQRECOL,
    nITEMRECOL_NUSEQDIVISAO, nITEMRECOL_NUSEQVINCPRINCIPAL);
end;

function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.FormataDadosRecl(
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

function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.CopiarRecolhimento: TfpgVincRecolMandItemRecolhimento;
begin
  result := TfpgVincRecolMandItemRecolhimento(FoItem.Copiar);
  AdicListaObjeto(result);
end;


function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.CriarGuiaDoRecolhimento: TfpgVincRecolMandItemGuia;
begin
  result := CriarObjetoGuiaComDadosDefault;

  FoItem.fpgGuia := result;
  ApagarObjRelListaSeAdicionandoGuia(FoItem.fpgGuia);
end;

function TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.CriarObjetoGuiaComDadosDefault: TfpgVincRecolMandItemGuia;
begin
  result := TfpgVincRecolMandItemGuia.Create; //pc_ok;
  AdicListaObjeto(result);

  result.Atribuir(nITEMGUIA_DTPAGAMENTO_DEFAULT, nITEMGUIA_CDFOROGRJ_DEFAULT,
    nITEMGUIA_NUGUIAEMITIDA_DEFAULT, sITEMGUIA_DETIPOCUSTA_DEFAULT,
    sITEMGUIA_NMINTERESSADO_DEFAULT);
end;

procedure TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.ApagarObjRelListaSeAdicionandoGuia(
  poObjAgrupador: TfpgVincRecolMandItens);
begin
  //se for guia e esta estiver na lista de objetos para destruir automaticamente, o recolhimento
  // deve sair de tal lista pois a classe de guia destroi seus itens.
  if not (poObjAgrupador is TfpgVincRecolMandItemGuia) then
    Exit;

  if FoListaObjetos.IndexOf(poObjAgrupador) < 0 then
    Exit;

  if FoListaObjetos.IndexOf(FoItem) >= 0 then
    FoListaObjetos.Extract(FoItem);
end;

initialization

  TestFramework.RegisterTest('Unitário\ufpgVincRecolMandItemRecolhimentoTests Suite',
    TfpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.Suite);

end.

