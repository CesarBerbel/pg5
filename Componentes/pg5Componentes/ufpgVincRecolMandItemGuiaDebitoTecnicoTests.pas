unit ufpgVincRecolMandItemGuiaDebitoTecnicoTests;

interface

uses
  contnrs, ufpgVincRecolMandItemBasico, ufpgVincRecolMandItemGuia, SysUtils,
  TestFrameWork, ufpgVincRecolMandItemRecolhimento, ufpgVincRecolMandItemMandado, Classes;

type
  TfpgVincRecolMandItemGuiaDebitoTecnicoTests = class(TTestCase)
  private
    FoItem: TfpgVincRecolMandItemGuia;
    FoListaObjetos: TObjectList;
    FoListaMandados: TList;
    procedure AtribuirValoresDefault;
    function ObterStrDateTime(const pdtValor: TDateTime;
      const psFormatString: string = 'dd/mm/yyyy hh:mm:ss:zzz'): string;
    function IncluirRecolhimento: TfpgVincRecolMandItemRecolhimento;
    procedure AdicListaObjeto(poObj: TObject);
    function CopiarItemGuia: TfpgVincRecolMandItemGuia;
    function ObterTextoObjeto(poItemRecolhimento: TfpgVincRecolMandItemRecolhimento): string;
      overload;
    function ObterTextoObjeto(poItemMandado: TfpgVincRecolMandItemMandado): string; overload;
  protected

    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestCopiarObjetoPropriedadesDadosRecolhimento;
  end;

implementation

uses
  uccpGeral;

const
  sITEM_NMINTERESSADO_DEFAULT = 'Nome do interessado';
  sITEM_DETIPOCUSTA_DEFAULT = 'Tipo custa paga';
  nITEM_NUGUIAEMITIDA_DEFAULT = 123456789;
  nITEM_CDFOROGRJ_DEFAULT = 10;
  nITEM_DTPAGAMENTO_DEFAULT = 41141.234;

  sMASCARA_DESCRICAO = '%s (%s)';

  nITEMRECOL_DTFECHAMENTO = nITEM_DTPAGAMENTO_DEFAULT + 2;
  nITEMRECOL_DTUSUVINCVALOR = nITEM_DTPAGAMENTO_DEFAULT + 1;
  sITEMRECOL_CDUSUVINCVALOR = 'USUARIO';
  nITEMRECOL_NUSEQVINCRECOLMAND = 10;
  sITEMRECOL_TPVINCVALOR = '2';
  nITEMRECOL_VLRECOLGRJ = 123.45;
  sITEMRECOL_DETIPORECOL = '[TipoRecol]';
  nITEMRECOL_CDFOROCALCULO = nITEM_CDFOROGRJ_DEFAULT;
  nITEMRECOL_CDCALCULO = 2;
  nITEMRECOL_CDTIPORECOL = 123;
  nITEMRECOL_NUSEQRECOL = 1;
  nITEMRECOL_NUSEQDIVISAO = -999;
  nITEMRECOL_NUSEQVINCPRINCIPAL = -999;

  sSEP_PROP_TXT = ', ';

procedure TfpgVincRecolMandItemGuiaDebitoTecnicoTests.AdicListaObjeto(poObj: TObject);
begin
  if not Assigned(poObj) then
    Exit;
  FoListaObjetos.Add(poObj);
end;

procedure TfpgVincRecolMandItemGuiaDebitoTecnicoTests.AtribuirValoresDefault;
begin
  FoItem.Atribuir(nITEM_DTPAGAMENTO_DEFAULT, nITEM_CDFOROGRJ_DEFAULT,
    nITEM_NUGUIAEMITIDA_DEFAULT, sITEM_DETIPOCUSTA_DEFAULT, sITEM_NMINTERESSADO_DEFAULT);
end;

function TfpgVincRecolMandItemGuiaDebitoTecnicoTests.CopiarItemGuia: TfpgVincRecolMandItemGuia;
begin
  result := TfpgVincRecolMandItemGuia(FoItem.Copiar(FoListaMandados, False));
  AdicListaObjeto(result);
end;

function TfpgVincRecolMandItemGuiaDebitoTecnicoTests.IncluirRecolhimento: TfpgVincRecolMandItemRecolhimento;
begin
  result := TfpgVincRecolMandItemRecolhimento.Create; //pc_ok

  result.Atribuir(nITEMRECOL_DTFECHAMENTO, nITEMRECOL_DTUSUVINCVALOR,
    sITEMRECOL_CDUSUVINCVALOR, nITEMRECOL_NUSEQVINCRECOLMAND, sITEMRECOL_TPVINCVALOR,
    nITEMRECOL_VLRECOLGRJ, sITEMRECOL_DETIPORECOL, nITEMRECOL_CDFOROCALCULO,
    nITEMRECOL_CDCALCULO, nITEMRECOL_CDTIPORECOL, nITEMRECOL_NUSEQRECOL,
    nITEMRECOL_NUSEQDIVISAO, nITEMRECOL_NUSEQVINCPRINCIPAL);

  FoItem.IncluirRecolhimento(result);
end;

function TfpgVincRecolMandItemGuiaDebitoTecnicoTests.ObterStrDateTime(
  const pdtValor: TDateTime; const psFormatString: string): string;
begin
  result := FormatDateTime(psFormatString, pdtValor);
end;

{ TfpgVincRecolMandItemGuiaDebitoTecnicoTests }

function TfpgVincRecolMandItemGuiaDebitoTecnicoTests.ObterTextoObjeto(
  poItemRecolhimento: TfpgVincRecolMandItemRecolhimento): string;
begin
  result := 'TfpgVincRecolMandItemRecolhimento{';
  if not Assigned(poItemRecolhimento) then
  begin
    result := result + 'nil}';
    Exit;
  end;
  //jcf:format=off
  Result := Result + #13#10+
    'integer(fpgRecolhimentoEmEdicao):'+IntToStr(Integer(poItemRecolhimento.fpgRecolhimentoEmEdicao))+sSEP_PROP_TXT+//
    'fpgMandado:' + ObterTextoObjeto(poItemRecolhimento.fpgMandado)+sSEP_PROP_TXT+
    //'integer(fpgGuia):' + IntToStr(integer(poItemRecolhimento.fpgGuia))+sSEP_PROP_TXT+    //retirado pois o end. mem´ria difere após copiar
    'fpgDtFechamento:' + ObterStrDateTime(poItemRecolhimento.fpgDtFechamento)+sSEP_PROP_TXT+
    'fpgDtUsuVincValor:' + ObterStrDateTime(poItemRecolhimento.fpgDtUsuVincValor)+sSEP_PROP_TXT+
    'fpgCdUsuVincValor:' + poItemRecolhimento.fpgCdUsuVincValor+sSEP_PROP_TXT+
    'fpgTpVincValor:' + poItemRecolhimento.fpgTpVincValor+sSEP_PROP_TXT+
    'fpgVlRecolGrj:' + FloatToStr(poItemRecolhimento.fpgVlRecolGrj)+sSEP_PROP_TXT+
    'fpgDeTipoRecol:' + poItemRecolhimento.fpgDeTipoRecol+sSEP_PROP_TXT+
    'fpgCdForoCalculo:' + IntToStr(Trunc(poItemRecolhimento.fpgCdForoCalculo))+sSEP_PROP_TXT+
    'fpgCdCalculo:' + IntToStr(Trunc(poItemRecolhimento.fpgCdCalculo))+sSEP_PROP_TXT+
    'fpgCdTipoRecol:' + IntToStr(Trunc(poItemRecolhimento.fpgCdTipoRecol))+sSEP_PROP_TXT+
    'fpgNuSeqRecol:' + IntToStr(Trunc(poItemRecolhimento.fpgNuSeqRecol))+sSEP_PROP_TXT+
    'fpgIndexImagem:' + IntToStr(integer(poItemRecolhimento.fpgIndexImagem))+sSEP_PROP_TXT+    //
    'fpgNuSeqDivisao:' + IntToStr(integer(poItemRecolhimento.fpgNuSeqDivisao))+sSEP_PROP_TXT+    //
    'fpgNuSeqVincPrincipal:' + IntToStr(integer(poItemRecolhimento.fpgNuSeqVincPrincipal))+#13#10+    //
    '}';
  //jcf:format=on
end;

function TfpgVincRecolMandItemGuiaDebitoTecnicoTests.ObterTextoObjeto(
  poItemMandado: TfpgVincRecolMandItemMandado): string;
begin
  result := 'TfpgVincRecolMandItemMandado{';
  if not Assigned(poItemMandado) then
  begin
    result := result + 'nil}';
    Exit;
  end;
  //jcf:format=off
  Result := Result + #13#10+
    'integer(fpgEmElaboracao):'+IntToStr(Integer(poItemMandado.fpgEmElaboracao))+sSEP_PROP_TXT+
    'fpgNuSeqDistMandado:' + IntToStr(poItemMandado.fpgNuSeqDistMandado)+sSEP_PROP_TXT+
    'fpgCdSituacaoMand:' + IntToStr(poItemMandado.fpgCdSituacaoMand)+sSEP_PROP_TXT+
    'fpgDtUsuVincValor:' + ObterStrDateTime(poItemMandado.fpgDtUsuVincValor)+sSEP_PROP_TXT+
    'fpgNuMandado:' + poItemMandado.fpgNuMandado+sSEP_PROP_TXT+
    'fpgDeFormaPgto:' + poItemMandado.fpgDeFormaPgto+sSEP_PROP_TXT+
    'fpgDtDistribuicao:' + ObterStrDateTime(poItemMandado.fpgDtDistribuicao)+sSEP_PROP_TXT+
    'fpgDtEmissao:' + ObterStrDateTime(poItemMandado.fpgDtEmissao)+sSEP_PROP_TXT+
    'fpgDtRecebPelaCM:' + ObterStrDateTime(poItemMandado.fpgDtRecebPelaCM)+sSEP_PROP_TXT+
    'fpgCdMandado:' + poItemMandado.fpgCdMandado+sSEP_PROP_TXT+
    'fpgDeSituacaoMand:' + poItemMandado.fpgDeSituacaoMand+sSEP_PROP_TXT+
    'fpgNmAgente:' + poItemMandado.fpgNmAgente+sSEP_PROP_TXT+
    'fpgFlCumpridoOficial:' + poItemMandado.fpgFlCumpridoOficial+#13#10+
    '}';
  //jcf:format=on
end;

procedure TfpgVincRecolMandItemGuiaDebitoTecnicoTests.SetUp;
begin
  inherited;
  FoListaObjetos := TObjectList.Create(True); //pc_ok

  FoItem := TfpgVincRecolMandItemGuia.Create; //pc_ok
  AdicListaObjeto(FoItem);

  FoListaMandados := TList.Create; //pc_ok
  AdicListaObjeto(FoListaMandados);

  AtribuirValoresDefault;
end;

procedure TfpgVincRecolMandItemGuiaDebitoTecnicoTests.TearDown;
begin
  inherited;
  FoListaObjetos.Clear;
  FreeAndNil(FoListaObjetos); //pc_ok
end;

procedure TfpgVincRecolMandItemGuiaDebitoTecnicoTests.
TestCopiarObjetoPropriedadesDadosRecolhimento;
var
  oItemCopia: TfpgVincRecolMandItemGuia;
  oItemRecolNovo: TfpgVincRecolMandItemRecolhimento;
  oItemRecolDaGuiaCopiada: TfpgVincRecolMandItemRecolhimento;
begin
  oItemRecolNovo := IncluirRecolhimento;

  oItemCopia := CopiarItemGuia;

  oItemRecolDaGuiaCopiada := TfpgVincRecolMandItemRecolhimento(oItemCopia.fpgRecolhimento[0]);

  CheckEqualsString(ObterTextoObjeto(oItemRecolNovo), ObterTextoObjeto(oItemRecolDaGuiaCopiada));
end;

initialization

  TestFramework.RegisterTest('Unitário\ufpgVincRecolMandItemGuiaDebitoTecnicoTests Suite',
    TfpgVincRecolMandItemGuiaDebitoTecnicoTests.Suite);

end.

