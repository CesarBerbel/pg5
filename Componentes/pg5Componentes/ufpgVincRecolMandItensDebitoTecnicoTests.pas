unit ufpgVincRecolMandItensDebitoTecnicoTests;

interface

uses
  contnrs, SysUtils, TestFrameWork, ufpgVincRecolMandItemBasico, ufpgVincRecolMandItens,
  ufpgVincRecolMandItemMandado, ufpgVincRecolMandItemRecolhimento, ufpgObservadorIntf,
  usajConstante;

type
  //para implementar metodos abstratos
  TfpgVincRecolMandItensFake = class(TfpgVincRecolMandItens)
  protected
    function GetClass: TfpgVincRecolMandItemBasicoClass; override;
    procedure DefinirInformacoesPainel; override;
  public
    function PegarDescricao: string; override;
  end;


  TfpgVincRecolMandItensTests = class(TTestCase)
  private
    FoItem: TfpgVincRecolMandItensFake;
    FoListaObjetos: TObjectList;
    FnQtdRecolCriados: integer;
    procedure AdicionarLoteRecolhimentos(const pnQtdRecolimentos: integer);
    function RetornarTextoRecolhimentos(poObjItens: TfpgVincRecolMandItens): string;
    function AdicionarRecolhimento(
      const pbAdicionarNoAgrupador: boolean = True): TfpgVincRecolMandItemRecolhimento;
    procedure AdicListaObjeto(poObj: TObject);
    function ExecutarCopia: string;
    function FormataDadosRecl(const pdtfpgDtFechamento, pdtfpgDtUsuVincValor: TDateTime;
      const psfpgCdUsuVincValor: string; const pnfpgNuSeqVincRecolMand: integer;
      const psfpgTpVincValor: string; const pnfpgVlRecolGrj: double;
      const psfpgDeTipoRecol: string; const pnfpgCdForoCalculo, pnfpgCdCalculo,
      pnfpgCdTipoRecol, pnfpgNuSeqRecol: double;
      const pnfpgNuSeqDivisao, pnfpgNuSeqVincPrincipal: integer): string;
    function ObterStrDateTime(const pdtValor: TDateTime;
      const psFormatString: string = 'dd/mm/yyyy hh:mm:ss:zzz'): string;
    function ObterTextoObjeto(poItemRecolhimento: TfpgVincRecolMandItemRecolhimento): string;
      overload;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopiar;
  end;


implementation

const
  nADIC_1_OBSERV = 1;
  nQTD_OBSEVADORES_TESTE = 10;
  sPARAM_PARA_OBSERVADOR_INI_INVALIDO = '$fe,$ff,(ClasseNaoDefinida)';
  sNOME_CLASS_OBSERVAVEL_ESPERADA = 'TfpgVincRecolMandItensFake';
  sFIM_RET_LISTA_RECOL = '}';
  sCAB_RET_LISTA_RECOL = 'RetornarTextoRecolhimentos{ ';
  nMULTIPLICADOR_VLRECOLGRJ = 1.11;
  nQTDRECOL_TESTE_VARIOS = 5;

  nINDEX_ITEM_COMPARACAO = 1;

  nINDEX_ITEM_REMOVER_1 = 0;
  nINDEX_ITEM_REMOVER_2 = 2;
  nINDEX_ITEM_REMOVER_3 = 3;

  nDATABASE = 41141.234;  //20/08/2012

  nITEMRECOL_DTFECHAMENTO = nDATABASE + 1;
  nITEMRECOL_DTUSUVINCVALOR = nDATABASE + 0;
  sITEMRECOL_CDUSUVINCVALOR = 'USUARIO';
  nITEMRECOL_NUSEQVINCRECOLMAND = 10;
  sITEMRECOL_TPVINCVALOR = '2';
  nITEMRECOL_VLRECOLGRJ: double = 123.45;
  sITEMRECOL_DETIPORECOL = '[TipoRecol]';
  nITEMRECOL_CDFOROCALCULO = 5;
  nITEMRECOL_CDCALCULO: double = 2;
  nITEMRECOL_CDTIPORECOL: double = 123;
  nITEMRECOL_NUSEQRECOL: double = 1;
  nITEMRECOL_NUSEQDIVISAO = -999;
  nITEMRECOL_NUSEQVINCPRINCIPAL = -999;

  sSEP_PROP_TXT = ', ';

  sCAB_RECOL = 'TfpgVincRecolMandItemRecolhimento{' + #13#10;
  sFIM_RECOL = #13#10 + '}';
  sTEXTO_OBJ_NIL = 'nil';


procedure TfpgVincRecolMandItensTests.AdicionarLoteRecolhimentos(const
  pnQtdRecolimentos: integer);
var
  i: integer;
begin
  for i := 0 to pnQtdRecolimentos - 1 do
    AdicionarRecolhimento;
end;

function TfpgVincRecolMandItensTests.AdicionarRecolhimento(const
  pbAdicionarNoAgrupador: boolean = True): TfpgVincRecolMandItemRecolhimento;
begin
  result := TfpgVincRecolMandItemRecolhimento.Create; //pc_ok

  result.Atribuir(nITEMRECOL_DTFECHAMENTO + FnQtdRecolCriados, nITEMRECOL_DTUSUVINCVALOR +
    FnQtdRecolCriados,
    sITEMRECOL_CDUSUVINCVALOR, nITEMRECOL_NUSEQVINCRECOLMAND + FnQtdRecolCriados,
    sITEMRECOL_TPVINCVALOR, nITEMRECOL_VLRECOLGRJ + FnQtdRecolCriados * nMULTIPLICADOR_VLRECOLGRJ,
    sITEMRECOL_DETIPORECOL,
    nITEMRECOL_CDFOROCALCULO + FnQtdRecolCriados, nITEMRECOL_CDCALCULO + FnQtdRecolCriados,
    nITEMRECOL_CDTIPORECOL + FnQtdRecolCriados, nITEMRECOL_NUSEQRECOL + FnQtdRecolCriados,
    nITEMRECOL_NUSEQDIVISAO, nITEMRECOL_NUSEQVINCPRINCIPAL);

  Inc(FnQtdRecolCriados);

  if pbAdicionarNoAgrupador then
    FoItem.IncluirRecolhimento(result);
end;

procedure TfpgVincRecolMandItensTests.AdicListaObjeto(poObj: TObject);
begin
  if not Assigned(poObj) then
    Exit;
  FoListaObjetos.Add(poObj);
end;

function TfpgVincRecolMandItensTests.ExecutarCopia: string;
var
  oItemCopiado: TfpgVincRecolMandItens;
begin
  oItemCopiado := TfpgVincRecolMandItens(FoItem.Copiar(False));
  AdicListaObjeto(oItemCopiado);
  result := RetornarTextoRecolhimentos(oItemCopiado);
end;

function TfpgVincRecolMandItensTests.FormataDadosRecl(const pdtfpgDtFechamento,
  pdtfpgDtUsuVincValor: TDateTime; const psfpgCdUsuVincValor: string; const
  pnfpgNuSeqVincRecolMand: integer; const psfpgTpVincValor: string; const
  pnfpgVlRecolGrj: double; const psfpgDeTipoRecol: string; const
  pnfpgCdForoCalculo, pnfpgCdCalculo, pnfpgCdTipoRecol, pnfpgNuSeqRecol:
  double; const pnfpgNuSeqDivisao, pnfpgNuSeqVincPrincipal: integer): string;
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
    IntToStr(pnfpgNuSeqVincPrincipal) + sFIM_RECOL;
end;

function TfpgVincRecolMandItensTests.ObterStrDateTime(const pdtValor:
  TDateTime; const psFormatString: string): string;
begin
  result := FormatDateTime(psFormatString, pdtValor);
end;

function TfpgVincRecolMandItensTests.ObterTextoObjeto(poItemRecolhimento:
  TfpgVincRecolMandItemRecolhimento): string;
begin
  if not Assigned(poItemRecolhimento) then
  begin
    result := sCAB_RECOL + sTEXTO_OBJ_NIL + sFIM_RECOL;
    Exit;
  end;

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
      poItemRecolhimento.fpgNuSeqVincPrincipal);
  //jcf:format=on
end;


function TfpgVincRecolMandItensTests.RetornarTextoRecolhimentos(
  poObjItens: TfpgVincRecolMandItens): string;
var
  i: integer;
begin
  result := sCAB_RET_LISTA_RECOL + 'fpgQtdadeRecolhimentos:' +
    IntToStr(poObjItens.fpgQtdadeRecolhimentos);
  for i := 0 to poObjItens.fpgQtdadeRecolhimentos - 1 do
  begin
    result := result + #13#10 + '[' + IntToStr(i) + ']:' +
      ObterTextoObjeto(TfpgVincRecolMandItemRecolhimento(poObjItens.fpgRecolhimento[i]));
  end;
  result := result + #13#10 + sFIM_RET_LISTA_RECOL;
end;


procedure TfpgVincRecolMandItensTests.SetUp;
begin
  inherited;
  FoListaObjetos := TObjectList.Create(True); //PC_OK

  FoItem := TfpgVincRecolMandItensFake.Create; //PC_OK
  AdicListaObjeto(FoItem);

  FnQtdRecolCriados := 0;
end;

procedure TfpgVincRecolMandItensTests.TearDown;
begin
  inherited;
  FreeAndNil(FoListaObjetos); //PC_OK
end;


procedure TfpgVincRecolMandItensTests.TestCopiar;
var
  sListaRecolEsperada: string;
  sListaRecolObtida: string;
begin
  AdicionarLoteRecolhimentos(3);
  sListaRecolEsperada := RetornarTextoRecolhimentos(FoItem);
  sListaRecolObtida := ExecutarCopia;
  //este item não propriedades significativas, bastando assim comparar os recolhimentos na origem
  //com o no destino
  CheckEqualsString(sListaRecolEsperada, sListaRecolObtida);

end;

procedure TfpgVincRecolMandItensFake.DefinirInformacoesPainel;
begin
  foDataSetDadosInfoPainel.FieldDefs.Clear;
end;

function TfpgVincRecolMandItensFake.GetClass: TfpgVincRecolMandItemBasicoClass;
begin
  result := inherited GetClass;
  if result = TfpgVincRecolMandItens then
    result := TfpgVincRecolMandItensFake;
end;

function TfpgVincRecolMandItensFake.PegarDescricao: string;
begin
  result := 'Objeto da classe TfpgVincRecolMandItensFake';
end;

initialization

  TestFramework.RegisterTest('Unitário\ufpgVincRecolMandItensTests Suite',
    TfpgVincRecolMandItensTests.Suite);

end.

