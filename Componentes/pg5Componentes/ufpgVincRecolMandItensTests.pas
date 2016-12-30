unit ufpgVincRecolMandItensTests;

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

  //class observadora para testes de passagem de parametro para observadores
  TObservadorItens = class(TObject, IfpgObservador)
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: integer; stdcall;
    function _Release: integer; stdcall;
  public
    FvParametroParaObservador: olevariant;
    FoObjItensObservado: TfpgVincRecolMandItens;
    FnQtdOcorrenciasbObservadorChamado: integer;
    procedure AtualizarObservador(poObservavel: IfpgObservavel);
  end;

  TfpgVincRecolMandItensTests = class(TTestCase)
  private
    FoItem: TfpgVincRecolMandItensFake;
    FoListaObjetos: TObjectList;
    FnQtdRecolCriados: integer;
    procedure AdicionarLoteRecolhimentos(const pnQtdRecolimentos: integer);
    procedure AdicionarMandadoRecol(poItemRecol: TfpgVincRecolMandItemRecolhimento);

    function RetornarTextoRecolhimentosEsperado(pnIndiceItensExcluidos: array of integer): string;
    function RetornarTextoRecolhimentos(poObjItens: TfpgVincRecolMandItens): string;

    function AdicionarRecolhimento(
      const pbAdicionarNoAgrupador: boolean = True): TfpgVincRecolMandItemRecolhimento;
    procedure AdicListaObjeto(poObj: TObject);
    function CriarObservadorItens: TObservadorItens;
    function ExecutarAcaoInclusaoPegandoParamObservador: olevariant;
    function ExecutarAcaoInclusaoVerifChamouObservador(const pnQtdObservadoresInicial: integer;
      const pnQtdObservadoresRemoverAntes: integer = 0): integer;
    //24/01/2013 - maxback - SALT 125613/10/1 - Retirado para poe no projeto de débito técnico  
    //function ExecutarCopia: string;
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
    function ObterTextoObjetoRecolEsperado(const pnIndiceCriacao: integer): string;
    procedure RemoverRecolhimento(const pnIndiceRecol: integer);
    procedure RemoverRecolhimentos(const pnListaIndiceRecol: array of integer);
    function RetornarParamEsperado(const pnIndiceRecol: integer): string; overload;
    function RetornarParamEsperado(poItemRecol: TfpgVincRecolMandItemRecolhimento): string;
      overload;
    function TestarIndiceNoArray(const pnIndexOrig: integer;
      pnIndiceItensExcluidos: array of integer): boolean;

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarRetornarClasseObservaveldoParametroVazio;
    procedure TestarRetornarClasseObservaveldoParametro;
    procedure TestarRetornarObjetoObservavelDoParametroVazio;
    procedure TestarRetornarObjetoObservavelDoParametro;
    procedure TestarRetornarObjetoItemDoParametroVazio;
    procedure TestarRetornarObjetoItemDoParametro;
    procedure TestarAdicionarObservador;
    procedure TestarNotificarObservadores;
    procedure TestarRemoverObservador;
    procedure TestarRetornarParametroAoIncluirRecolhimento1;
    procedure TestarRetornarParametroAoExcluirRecolhimento;
    procedure TestarIncluirRecolhimentoUnico;
    procedure TestarIncluirRecolhimentoUnicoDados;
    procedure TestarIncluirRecolhimentoVarios;
    procedure TestarIncluirRecolhimentoVariosDados;
    procedure TestarRemoverRecolhimentoUnico;
    procedure TestarRemoverRecolhimentoVarios;
    procedure TestarRemoverRecolhimentoVariosDados;

    procedure TestarTestarRecolhimentoVinculadoEstandoVinculado;
    procedure TestarTestarRecolhimentoVinculadoNaoEstandoVinculado;
    //24/01/2013 - maxback - SALT 125613/10/1 - Retirado para poe no projeto de débito técnico
    //procedure TestCopiar;
    procedure TestarfpgRecolhimento;
    procedure TestarfpgQtdadeRecolhimentos;
    procedure TestarfpgQtdadeRecolhimentosVinculadosComUmVinc;
    procedure TestarfpgQtdadeRecolhimentosVinculadosSemVinc;
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

procedure TfpgVincRecolMandItensTests.AdicionarMandadoRecol(poItemRecol:
  TfpgVincRecolMandItemRecolhimento);
var
  oItemMandado: TfpgVincRecolMandItemMandado;
begin
  oItemMandado := TfpgVincRecolMandItemMandado.Create; //PC_OK
  AdicListaObjeto(oItemMandado);

  poItemRecol.fpgMandado := oItemMandado;
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

function TfpgVincRecolMandItensTests.CriarObservadorItens: TObservadorItens;
begin
  result := TObservadorItens.Create; //PC_OK
  result.FvParametroParaObservador := sPARAM_PARA_OBSERVADOR_INI_INVALIDO;
  result.FnQtdOcorrenciasbObservadorChamado := 0;
  result.FoObjItensObservado := FoItem;
  FoItem.AdicionarObservador(result);
end;

function TfpgVincRecolMandItensTests.ExecutarAcaoInclusaoPegandoParamObservador: olevariant;
var
  oObservador: TObservadorItens;
begin
  oObservador := CriarObservadorItens;
  try
    //adiciona um recol. para o observador receber algo
    AdicionarRecolhimento;

    result := oObservador.FvParametroParaObservador;
  finally
    //destroi observador antes de sair do teste
    FoItem.RemoverObservador(oObservador);
    FreeAndNil(oObservador); //pc_ok
  end;
end;

function TfpgVincRecolMandItensTests.ExecutarAcaoInclusaoVerifChamouObservador(
  const pnQtdObservadoresInicial: integer; const
  pnQtdObservadoresRemoverAntes: integer = 0): integer;
var
  oObservadores: array of TObservadorItens;
  i: integer;
begin
  result := 0;
  SetLength(oObservadores, pnQtdObservadoresInicial);
  for i := 0 to pnQtdObservadoresInicial - 1 do
  begin
    oObservadores[i] := CriarObservadorItens;
    AdicListaObjeto(oObservadores[i]);
  end;

  if pnQtdObservadoresRemoverAntes > 0 then
  begin
    for i := 0 to pnQtdObservadoresRemoverAntes - 1 do
    begin
      FoItem.RemoverObservador(oObservadores[i]);
    end;
  end;

  //adiciona um recol. para o observador receber algo
  AdicionarRecolhimento;

  for i := 0 to pnQtdObservadoresInicial - 1 do
  begin
    if oObservadores[i].FnQtdOcorrenciasbObservadorChamado = 1 then
      Inc(result);
    FoItem.RemoverObservador(oObservadores[i]);
  end;
end;

//24/01/2013 - maxback - SALT 125613/10/1 - Retirado para poe no projeto de débito técnico
{
function TfpgVincRecolMandItensTests.ExecutarCopia: string;
var
  oItemCopiado: TfpgVincRecolMandItens;
begin
  oItemCopiado := TfpgVincRecolMandItens(FoItem.Copiar(False));
  AdicListaObjeto(oItemCopiado);
  result := RetornarTextoRecolhimentos(oItemCopiado);
end;
}
function TfpgVincRecolMandItensTests.FormataDadosRecl(
  const pdtfpgDtFechamento, pdtfpgDtUsuVincValor: TDateTime; const psfpgCdUsuVincValor: string;
  const pnfpgNuSeqVincRecolMand: integer; const psfpgTpVincValor: string;
  const pnfpgVlRecolGrj: double; const psfpgDeTipoRecol: string;
  const pnfpgCdForoCalculo, pnfpgCdCalculo, pnfpgCdTipoRecol, pnfpgNuSeqRecol: double;
  const pnfpgNuSeqDivisao, pnfpgNuSeqVincPrincipal: integer): string;
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

function TfpgVincRecolMandItensTests.ObterStrDateTime(const pdtValor: TDateTime;
  const psFormatString: string): string;
begin
  result := FormatDateTime(psFormatString, pdtValor);
end;

function TfpgVincRecolMandItensTests.ObterTextoObjeto(poItemRecolhimento: TfpgVincRecolMandItemRecolhimento): string;
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

function TfpgVincRecolMandItensTests.ObterTextoObjetoRecolEsperado(
  const pnIndiceCriacao: integer): string;
begin
  //jcf:format=off
  Result :=
    FormataDadosRecl(nITEMRECOL_DTFECHAMENTO+pnIndiceCriacao,
      nITEMRECOL_DTUSUVINCVALOR+pnIndiceCriacao,
      sITEMRECOL_CDUSUVINCVALOR,
      nITEMRECOL_NUSEQVINCRECOLMAND+pnIndiceCriacao,
      sITEMRECOL_TPVINCVALOR,
      nITEMRECOL_VLRECOLGRJ+ pnIndiceCriacao * nMULTIPLICADOR_VLRECOLGRJ,
      sITEMRECOL_DETIPORECOL,
      nITEMRECOL_CDFOROCALCULO+pnIndiceCriacao,
      nITEMRECOL_CDCALCULO+pnIndiceCriacao,
      nITEMRECOL_CDTIPORECOL+pnIndiceCriacao,
      nITEMRECOL_NUSEQRECOL+pnIndiceCriacao,
      nITEMRECOL_NUSEQDIVISAO,
      nITEMRECOL_NUSEQVINCPRINCIPAL);
  //jcf:format=on
end;

procedure TfpgVincRecolMandItensTests.RemoverRecolhimento(const pnIndiceRecol: integer);
var
  OItemARemover: TfpgVincRecolMandItemRecolhimento;
begin
  OItemARemover := TfpgVincRecolMandItemRecolhimento(FoItem.fpgRecolhimento[pnIndiceRecol]);
  FoItem.RemoverRecolhimento(OItemARemover);
  AdicListaObjeto(OItemARemover);
end;

{ TfpgVincRecolMandItensTests }

procedure TfpgVincRecolMandItensTests.RemoverRecolhimentos(
  const pnListaIndiceRecol: array of integer);
var
  OItensARemover: array of TfpgVincRecolMandItemRecolhimento;
  i: integer;
begin
  SetLength(OItensARemover, Length(pnListaIndiceRecol));
  for i := Low(pnListaIndiceRecol) to High(pnListaIndiceRecol) do
  begin
    OItensARemover[i] := TfpgVincRecolMandItemRecolhimento(
      FoItem.fpgRecolhimento[pnListaIndiceRecol[i]]);
  end;

  for i := Low(OItensARemover) to High(OItensARemover) do
  begin
    FoItem.RemoverRecolhimento(OItensARemover[i]);
    AdicListaObjeto(OItensARemover[i]);
  end;
end;

function TfpgVincRecolMandItensTests.RetornarParamEsperado(const pnIndiceRecol: integer): string;
begin
  result := RetornarParamEsperado(TfpgVincRecolMandItemRecolhimento(
    FoItem.fpgRecolhimento[pnIndiceRecol]));
end;

function TfpgVincRecolMandItensTests.RetornarParamEsperado(
  poItemRecol: TfpgVincRecolMandItemRecolhimento): string;
begin
  result := Format('%d,%d,%s', [integer(FoItem), integer(poItemRecol), FoItem.ClassName]);
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

function TfpgVincRecolMandItensTests.RetornarTextoRecolhimentosEsperado(
  pnIndiceItensExcluidos: array of integer): string;
var
  nIndex: integer;
  i: integer;
  bExcluido: boolean;
begin
  result := sCAB_RET_LISTA_RECOL + 'fpgQtdadeRecolhimentos:' +
    IntToStr(FoItem.fpgQtdadeRecolhimentos);

  nIndex := 0;
  for i := 0 to FoItem.fpgQtdadeRecolhimentos + Length(pnIndiceItensExcluidos) - 1 do
  begin
    bExcluido := TestarIndiceNoArray(i, pnIndiceItensExcluidos);
    if bExcluido then
      Continue;

    result := result + #13#10 + '[' + IntToStr(nIndex) + ']:' + ObterTextoObjetoRecolEsperado(i);

    Inc(nIndex);
  end;
  result := result + #13#10 + sFIM_RET_LISTA_RECOL;
end;

procedure TfpgVincRecolMandItensTests.SetUp;
begin
  inherited;
  FoListaObjetos := TObjectList.Create(True); //pc_ok

  FoItem := TfpgVincRecolMandItensFake.Create; //pc_ok
  AdicListaObjeto(FoItem);

  FnQtdRecolCriados := 0;
end;

procedure TfpgVincRecolMandItensTests.TearDown;
begin
  inherited;
  FreeAndNil(FoListaObjetos); //PC_OK
end;

procedure TfpgVincRecolMandItensTests.TestarAdicionarObservador;
begin
  CheckTrue(ExecutarAcaoInclusaoVerifChamouObservador(nADIC_1_OBSERV) = 1);
end;

function TfpgVincRecolMandItensTests.TestarIndiceNoArray(const pnIndexOrig: integer;
  pnIndiceItensExcluidos: array of integer): boolean;
var
  i: integer;
begin
  result := False;
  for I := Low(pnIndiceItensExcluidos) to High(pnIndiceItensExcluidos) do
  begin
    if pnIndexOrig = pnIndiceItensExcluidos[I] then
    begin
      result := True;
      break;
    end;
  end;
end;

//24/01/2013 - maxback - SALT 125613/10/1 - Retirado para poe no projeto de débito técnico
{
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
}

procedure TfpgVincRecolMandItensTests.TestarfpgQtdadeRecolhimentos;
begin
  AdicionarLoteRecolhimentos(2);
  CheckEquals(2, FoItem.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItensTests.TestarfpgQtdadeRecolhimentosVinculadosComUmVinc;
begin
  AdicionarMandadoRecol(AdicionarRecolhimento);
  CheckEquals(1, FoItem.fpgQtdadeRecolhimentosVinculados);
end;

procedure TfpgVincRecolMandItensTests.TestarfpgQtdadeRecolhimentosVinculadosSemVinc;
begin
  CheckEquals(0, FoItem.fpgQtdadeRecolhimentosVinculados);
end;

procedure TfpgVincRecolMandItensTests.TestarfpgRecolhimento;
var
  sRecolEsperado: string;
  sRecolObtido: string;

begin
  AdicionarLoteRecolhimentos(nQTDRECOL_TESTE_VARIOS);

  sRecolEsperado := ObterTextoObjetoRecolEsperado(nINDEX_ITEM_COMPARACAO);
  sRecolObtido := ObterTextoObjeto(TfpgVincRecolMandItemRecolhimento( //ql
    FoItem.fpgRecolhimento[nINDEX_ITEM_COMPARACAO]));

  CheckEqualsString(sRecolEsperado, sRecolObtido);
end;

procedure TfpgVincRecolMandItensTests.TestarIncluirRecolhimentoUnico;
begin
  AdicionarRecolhimento;
  CheckEquals(FnQtdRecolCriados, FoItem.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItensTests.TestarIncluirRecolhimentoUnicoDados;
begin
  CheckEqualsString(ObterTextoObjetoRecolEsperado(FnQtdRecolCriados - 1), //ql
    ObterTextoObjeto(AdicionarRecolhimento));
end;

procedure TfpgVincRecolMandItensTests.TestarIncluirRecolhimentoVarios;
begin
  AdicionarLoteRecolhimentos(nQTDRECOL_TESTE_VARIOS);
  CheckEquals(FnQtdRecolCriados, FoItem.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItensTests.TestarIncluirRecolhimentoVariosDados;
begin
  AdicionarLoteRecolhimentos(nQTDRECOL_TESTE_VARIOS);

  CheckEqualsString(RetornarTextoRecolhimentosEsperado([]), //ql
    RetornarTextoRecolhimentos(FoItem));
end;

procedure TfpgVincRecolMandItensTests.TestarNotificarObservadores;
begin
  CheckEquals(nQTD_OBSEVADORES_TESTE, //ql
    ExecutarAcaoInclusaoVerifChamouObservador(nQTD_OBSEVADORES_TESTE));
end;

procedure TfpgVincRecolMandItensTests.TestarRemoverObservador;
begin
  //Adiciona nQTD_OBSEVADORES_TESTE observadores mas antes da ação remove 2 por isso tem 2 chamadas
  // a menos.
  CheckEquals(nQTD_OBSEVADORES_TESTE - 2, //ql
    ExecutarAcaoInclusaoVerifChamouObservador(nQTD_OBSEVADORES_TESTE, 2));
end;

procedure TfpgVincRecolMandItensTests.TestarRemoverRecolhimentoUnico;
begin
  FoItem.RemoverRecolhimento(AdicionarRecolhimento);
  //eperado: FnQtdRecolCriados = 1 e após apagar FoItem.fpgQtdadeRecolhimentos = 0, por isso 1-0 = 1
  CheckEquals(1, FnQtdRecolCriados - FoItem.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItensTests.TestarRemoverRecolhimentoVarios;
begin
  AdicionarLoteRecolhimentos(nQTDRECOL_TESTE_VARIOS);

  RemoverRecolhimentos([nINDEX_ITEM_REMOVER_1, nINDEX_ITEM_REMOVER_2, nINDEX_ITEM_REMOVER_3]);

  //Esperado que FnQtdRecolCriados = nQTDRECOL_TESTE_VARIOS e
  //FoItem.fpgQtdadeRecolhimentos = nQTDRECOL_TESTE_VARIOS - 3 por isso espera no teste
  //FnQtdRecolCriados - 3

  CheckEquals(FnQtdRecolCriados - 3, FoItem.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItensTests.TestarRemoverRecolhimentoVariosDados;
var
  sDadosListaEsperado, sDadosListaObtido: string;
begin
  AdicionarLoteRecolhimentos(nQTDRECOL_TESTE_VARIOS);

  RemoverRecolhimentos([nINDEX_ITEM_REMOVER_1, nINDEX_ITEM_REMOVER_2, nINDEX_ITEM_REMOVER_3]);

  //Esperado que o texto tenha valores montados com base nas constantes e no indice, pulando os
  //removidos
  sDadosListaEsperado := RetornarTextoRecolhimentosEsperado(
    [nINDEX_ITEM_REMOVER_1, nINDEX_ITEM_REMOVER_2, nINDEX_ITEM_REMOVER_3]);

  sDadosListaObtido := RetornarTextoRecolhimentos(FoItem);

  CheckEqualsString(sDadosListaEsperado, sDadosListaObtido);
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarClasseObservaveldoParametro;
var
  vParam: olevariant;
begin
  vParam := ExecutarAcaoInclusaoPegandoParamObservador;

  CheckEqualsString(sNOME_CLASS_OBSERVAVEL_ESPERADA, //ql
    FoItem.RetornarClasseObservaveldoParametro(vParam));
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarClasseObservaveldoParametroVazio;
begin
  CheckEqualsString(STRING_INDEFINIDO, FoItem.RetornarClasseObservaveldoParametro(
    STRING_INDEFINIDO));
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarObjetoItemDoParametro;
var
  vParam: olevariant;
begin
  vParam := ExecutarAcaoInclusaoPegandoParamObservador;

  CheckTrue(FoItem.RetornarObjetoItemDoParametro(vParam) = FoItem.fpgRecolhimento[0]);
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarObjetoItemDoParametroVazio;
begin
  CheckFalse(Assigned(FoItem.RetornarObjetoItemDoParametro(STRING_INDEFINIDO)));
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarObjetoObservavelDoParametro;
var
  vParam: olevariant;
begin
  vParam := ExecutarAcaoInclusaoPegandoParamObservador;

  CheckTrue(FoItem.RetornarObjetoObservavelDoParametro(vParam) = FoItem);
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarObjetoObservavelDoParametroVazio;
begin
  CheckFalse(Assigned(FoItem.RetornarObjetoObservavelDoParametro(STRING_INDEFINIDO)));
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarParametroAoExcluirRecolhimento;
var
  oItemObservador: TObservadorItens;
  sParamEsperado: string;
begin
  AdicionarLoteRecolhimentos(nQTDRECOL_TESTE_VARIOS);

  oItemObservador := CriarObservadorItens;
  try
    sParamEsperado := RetornarParamEsperado(nINDEX_ITEM_REMOVER_2);

    //teste para pegar a notificação excluir um item
    RemoverRecolhimento(nINDEX_ITEM_REMOVER_2);

    CheckEqualsString(sParamEsperado, VarToStr(oItemObservador.FvParametroParaObservador));
  finally
    //destroi observador antes de sair do teste
    FoItem.RemoverObservador(oItemObservador);
    FreeAndNil(oItemObservador); //pc_ok
  end;
end;

procedure TfpgVincRecolMandItensTests.TestarRetornarParametroAoIncluirRecolhimento1;
var
  oItemObservador: TObservadorItens;
  oItemRecol: TfpgVincRecolMandItemRecolhimento;
  sParamEsperado: string;
begin
  oItemRecol := TfpgVincRecolMandItemRecolhimento.Create; //PC_OK
  oItemObservador := CriarObservadorItens;
  try
    sParamEsperado := RetornarParamEsperado(oItemRecol);

    //teste para pegar a notificação incluir um item
    FoItem.IncluirRecolhimento(oItemRecol);

    CheckEqualsString(sParamEsperado, VarToStr(oItemObservador.FvParametroParaObservador));
  finally
    //destroi observador antes de sair do teste
    FoItem.RemoverObservador(oItemObservador);
    FreeAndNil(oItemObservador); //PC_OK
  end;
end;

procedure TfpgVincRecolMandItensTests.TestarTestarRecolhimentoVinculadoEstandoVinculado;
begin
  CheckTrue(FoItem.TestarRecolhimentoVinculado(AdicionarRecolhimento));
end;

procedure TfpgVincRecolMandItensFake.DefinirInformacoesPainel;
begin
  FoDataSetDadosInfoPainel.FieldDefs.Clear;
end;

function TfpgVincRecolMandItensFake.GetClass: TfpgVincRecolMandItemBasicoClass;
begin
  result := inherited GetClass;
  //result := TfpgVincRecolMandItensFake;
end;

function TfpgVincRecolMandItensFake.PegarDescricao: string;
begin
  result := 'Objeto da classe TfpgVincRecolMandItensFake';
end;

procedure TfpgVincRecolMandItensTests.TestarTestarRecolhimentoVinculadoNaoEstandoVinculado;
var
  oItemRecol: TfpgVincRecolMandItemRecolhimento;
begin
  oItemRecol := TfpgVincRecolMandItemRecolhimento.Create; //PC_OK
  AdicListaObjeto(oItemRecol);

  CheckFalse(FoItem.TestarRecolhimentoVinculado(oItemRecol));
end;

{ TObservadorItens }

procedure TObservadorItens.AtualizarObservador(poObservavel: IfpgObservavel);
begin
  FvParametroParaObservador := poObservavel.RetornarParametro;
  FnQtdOcorrenciasbObservadorChamado := FnQtdOcorrenciasbObservadorChamado + 1;
end;

//09/08/2012 - MB - SALT 107600/22/23 -
function TObservadorItens.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  QueryInterface := 0;
end;

//09/08/2012 - MB - SALT 107600/22/23 -
function TObservadorItens._AddRef: integer;
begin
  _AddRef := 0;
end;

//09/08/2012 - MB - SALT 107600/22/23 -
function TObservadorItens._Release: integer;
begin
  _Release := 0;
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgVincRecolMandItensTests',
    TfpgVincRecolMandItensTests.Suite);

end.

