unit ufpgVincRecolMandItemGuiaTests;

interface

uses
  contnrs, ufpgVincRecolMandItemBasico, ufpgVincRecolMandItemGuia, SysUtils,
  TestFrameWork, ufpgVincRecolMandItemRecolhimento, ufpgVincRecolMandItemMandado,
  Classes, ufpgPainelInformoItemVincGuiaRecolMand, DBClient;

type
  TfpgVincRecolMandItemGuiaTests = class(TTestCase)
  private
    FoItem: TfpgVincRecolMandItemGuia;
    FoListaObjetos: TObjectList;
    procedure AtribuirValoresDefault;
    procedure AtribuirValoresAlternativos;
    function ObterStrDateTime(const pdtValor: TDateTime;
      const psFormatString: string = 'dd/mm/yyyy hh:mm:ss:zzz'): string;
    procedure IncluirMandado(poListaMandados: TList;
      poItemRecolimento: TfpgVincRecolMandItemRecolhimento = nil;
      const pbAdicionarAListaObjetos: boolean = True);
    function IncluirRecolhimento: TfpgVincRecolMandItemRecolhimento;
    procedure AdicListaObjeto(poObj: TObject);
    function CopiarItemGuia(poListaMandados: TList = nil): TfpgVincRecolMandItemGuia;
    procedure CriarListasMandadoOrigDestComRecol(
      out poListaMandadosOrig, poListaMandadosDest: TList;
      poItemRecol: TfpgVincRecolMandItemRecolhimento);
    function ObterTextoObjeto(poItemRecolhimento: TfpgVincRecolMandItemRecolhimento): string;
      overload;
    function ObterTextoObjeto(poItemMandado: TfpgVincRecolMandItemMandado): string; overload;
    procedure AppendStringList(poDataset: TClientDataSet; const psValores: string);
    function CriarDadosPainelEsperados: TClientDataSet;
    function MontarTextoTituloPainelGuiaDefault: string;
    function ObterStringDescricaoDataSet(poDataSet: TClientDataSet): string;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Test methods
    procedure TestarfpgDtPagamento;
    procedure TestarfpgCdForoGrj;
    procedure TestarfpgNuGrjEmitida;
    procedure TestarfpgDeTipoCusta;
    procedure TestarfpgNmInteressado;

    procedure TestarAtribuirDtPagamento;
    procedure TestarAtribuirCdForoGrj;
    procedure TestarAtribuirNuGrjEmitida;
    procedure TestarAtribuirDeTipoCusta;
    procedure TestarAtribuirNmInteressado;

    procedure TestarPegarDescricao;

    procedure TestarIncluirRecolhimento;

    procedure TestarCopiarObjetoCopiaCriado;

    procedure TestarCopiarObjetoPropriedadesDtPagamento;
    procedure TestarCopiarObjetoPropriedadesCdForoGrj;
    procedure TestarCopiarObjetoPropriedadesNuGrjEmitida;
    procedure TestarCopiarObjetoPropriedadesDeTipoCusta;
    procedure TestarCopiarObjetoPropriedadesNmInteressado;
    procedure TestarCopiarObjetoPropriedadesQtdadeRecolhimentos;
    procedure TestarCopiarObjetoAjusteMandadoAssociado;

    procedure TestarDefinirInformacoesPainelChamouAtualizar;
    procedure TestarDefinirInformacoesPainelMudouDatasetDados;
  end;

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

implementation

uses
  uccpGeral, DB;

const
  sITEM_NMINTERESSADO_DEFAULT = 'Nome do interessado';
  sITEM_DETIPOCUSTA_DEFAULT = 'Tipo custa paga';
  nITEM_NUGUIAEMITIDA_DEFAULT = 123456789;
  nITEM_CDFOROGRJ_DEFAULT = 10;
  nITEM_DTPAGAMENTO_DEFAULT = 41141.234;  //20/08/2012

  sITEM_NMINTERESSADO_ALTERNATIVO = 'Nome novo interessado';
  sITEM_DETIPOCUSTA_ALTERNATIVO = 'Tipo custa paga 2';
  nITEM_NUGUIAEMITIDA_ALTERNATIVO = 123456790;
  nITEM_CDFOROGRJ_ALTERNATIVO = 11;
  nITEM_DTPAGAMENTO_ALTERNATIVO = 29087.234; //20/08/1979

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

  bITEMMAND_EMELABORACAO = False;
  //nITEMMAND_NUSEQDISTMANDADO = 1; //não usado
  nITEMMAND_CDSITUACAOMAND = 3;
  nITEMMAND_DTUSUVINCVALOR = nITEMRECOL_DTUSUVINCVALOR;
  sITEMMAND_NUMANDADO = '01020120000013';
  sITEMMAND_DEFORMAPGTO = 'Porma. pag';
  nITEMMAND_DTDISTRIBUICAO = nITEM_DTPAGAMENTO_DEFAULT;
  nITEMMAND_DTEMISSAO = nITEM_DTPAGAMENTO_DEFAULT;
  nITEMMAND_DTRECEBPELACM = nITEM_DTPAGAMENTO_DEFAULT + 1;
  sITEMMAND_CDMANDADO = '0A000001';
  sITEMMAND_DESITUACAOMAND = 'Aguardando Cumprimento';
  sITEMMAND_NMAGENTE = 'Nome do agente do mandado';
  sITEMMAND_FLCUMPRIDOOFICIAL = 'N';

  sSEP_PROP_TXT = ', ';

function TfpgVincRecolMandItemGuiaTests.MontarTextoTituloPainelGuiaDefault: string;
begin
  result := 'Guia ' + FormataNuGuia(FloatToStr(nITEM_NUGUIAEMITIDA_DEFAULT),
    IntToStr(nITEM_CDFOROGRJ_default));
end;

function TfpgVincRecolMandItemGuiaTests.CriarDadosPainelEsperados: TClientDataSet;
begin
  result := TClientDataSet.Create(nil); //PC_OK
  AdicListaObjeto(result);

  result.FieldDefs.Add(sFPGVINCRECOLMANDITEMNOMECAMPOROTULO, ftString, 256, True);
  result.FieldDefs.Add(sFPGVINCRECOLMANDITEMNOMECAMPOINFORMACAO, ftString, 1024);
  result.CreateDataSet;
  result.Active := True;

  AppendStringList(result, '"' + MontarTextoTituloPainelGuiaDefault + '",""');
  AppendStringList(result, 'Interessado,"' + sITEM_NMINTERESSADO_DEFAULT + '"');
  AppendStringList(result, 'Tipo,"' + sITEM_DETIPOCUSTA_DEFAULT + '"');
  AppendStringList(result, '"Pagamento da guia","' + //ql
    FormatDateTime('DD/MM/YYYY', nITEM_DTPAGAMENTO_DEFAULT) + '"');
end;

procedure TfpgVincRecolMandItemGuiaTests.AppendStringList(poDataset: TClientDataSet;
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

procedure TfpgVincRecolMandItemGuiaTests.AdicListaObjeto(poObj: TObject);
begin
  if not Assigned(poObj) then
    Exit;
  FoListaObjetos.Add(poObj);
end;

procedure TfpgVincRecolMandItemGuiaTests.AtribuirValoresAlternativos;
begin
  FoItem.Atribuir(nITEM_DTPAGAMENTO_ALTERNATIVO, nITEM_CDFOROGRJ_ALTERNATIVO,
    nITEM_NUGUIAEMITIDA_ALTERNATIVO, sITEM_DETIPOCUSTA_ALTERNATIVO,
    sITEM_NMINTERESSADO_ALTERNATIVO);
end;

procedure TfpgVincRecolMandItemGuiaTests.AtribuirValoresDefault;
begin
  FoItem.Atribuir(nITEM_DTPAGAMENTO_DEFAULT, nITEM_CDFOROGRJ_DEFAULT,
    nITEM_NUGUIAEMITIDA_DEFAULT, sITEM_DETIPOCUSTA_DEFAULT, sITEM_NMINTERESSADO_DEFAULT);
end;

function TfpgVincRecolMandItemGuiaTests.CopiarItemGuia(poListaMandados: TList): TfpgVincRecolMandItemGuia;
var
  oListaMandados: TList;
begin
  oListaMandados := poListaMandados;
  if oListaMandados = nil then
  begin
    oListaMandados := TList.Create; //PC_OK
    AdicListaObjeto(oListaMandados);
  end;

  result := TfpgVincRecolMandItemGuia(FoItem.Copiar(oListaMandados, False));
  AdicListaObjeto(result);
end;

procedure TfpgVincRecolMandItemGuiaTests.CriarListasMandadoOrigDestComRecol(
  out poListaMandadosOrig, poListaMandadosDest: TList;
  poItemRecol: TfpgVincRecolMandItemRecolhimento);
const
  nINDEX_ITEM_ASSOC_REL = 1;
var
  oListas: array[0..1] of TList;
  i: integer;
  nLista: integer;
begin
  poListaMandadosOrig := TList.Create; //PC_OK
  poListaMandadosDest := TList.Create; //PC_OK

  oListas[0] := poListaMandadosOrig;
  oListas[1] := poListaMandadosDest;

  for nLista := Low(oListas) to High(oListas) do
  begin
    AdicListaObjeto(oListas[nLista]);

    for i := 0 to 2 do
    begin
      if i = nINDEX_ITEM_ASSOC_REL then
        IncluirMandado(oListas[nLista], poItemRecol)
      else
        IncluirMandado(oListas[nLista]);
    end;
  end;
end;

procedure TfpgVincRecolMandItemGuiaTests.IncluirMandado(poListaMandados: TList;
  poItemRecolimento: TfpgVincRecolMandItemRecolhimento = nil;
  const pbAdicionarAListaObjetos: boolean = True);
var
  oItemMandado: TfpgVincRecolMandItemMandado;
begin
  oItemMandado := TfpgVincRecolMandItemMandado.Create; //pc_ok
  poListaMandados.Add(oItemMandado);

  oItemMandado.Atribuir(bITEMMAND_EMELABORACAO, poListaMandados.Count,
    nITEMMAND_CDSITUACAOMAND, nITEMMAND_DTUSUVINCVALOR, sITEMMAND_NUMANDADO,
    sITEMMAND_DEFORMAPGTO, nITEMMAND_DTDISTRIBUICAO, nITEMMAND_DTEMISSAO,
    nITEMMAND_DTRECEBPELACM, sITEMMAND_CDMANDADO, sITEMMAND_DESITUACAOMAND,
    sITEMMAND_NMAGENTE, sITEMMAND_FLCUMPRIDOOFICIAL);

  if Assigned(poItemRecolimento) then
    poItemRecolimento.fpgMandado := oItemMandado;

  if pbAdicionarAListaObjetos then
    AdicListaObjeto(oItemMandado);
end;

function TfpgVincRecolMandItemGuiaTests.IncluirRecolhimento: TfpgVincRecolMandItemRecolhimento;
begin
  result := TfpgVincRecolMandItemRecolhimento.Create; //pc_ok

  result.Atribuir(nITEMRECOL_DTFECHAMENTO, nITEMRECOL_DTUSUVINCVALOR,
    sITEMRECOL_CDUSUVINCVALOR, nITEMRECOL_NUSEQVINCRECOLMAND, sITEMRECOL_TPVINCVALOR,
    nITEMRECOL_VLRECOLGRJ, sITEMRECOL_DETIPORECOL, nITEMRECOL_CDFOROCALCULO,
    nITEMRECOL_CDCALCULO, nITEMRECOL_CDTIPORECOL, nITEMRECOL_NUSEQRECOL,
    nITEMRECOL_NUSEQDIVISAO, nITEMRECOL_NUSEQVINCPRINCIPAL);

  FoItem.IncluirRecolhimento(result);
end;

function TfpgVincRecolMandItemGuiaTests.ObterStrDateTime(const pdtValor: TDateTime;
  const psFormatString: string): string;
begin
  result := FormatDateTime(psFormatString, pdtValor);
end;

function TfpgVincRecolMandItemGuiaTests.ObterStringDescricaoDataSet(
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
  sDesc := '<FieldDefs><Count>' + IntToStr(poDataSet.FieldDefs.Count) + '</Count><Items>';
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
  begin
    result := result + '<RecordCount>' + IntToStr(poDataSet.RecordCount) + '</RecordCount>';
  end;

  result := result + #13#10 + '<Records>';
  poDataSet.First;
  while not poDataSet.EOF do
  begin
    result := result + #13#10 + '  <Record RecNo=' + IntToStr(poDataSet.Recno) + ' >';
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

{ TfpgVincRecolMandItemGuiaTests }

function TfpgVincRecolMandItemGuiaTests.ObterTextoObjeto(poItemRecolhimento: TfpgVincRecolMandItemRecolhimento): string;
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

function TfpgVincRecolMandItemGuiaTests.ObterTextoObjeto(
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

procedure TfpgVincRecolMandItemGuiaTests.SetUp;
begin
  inherited;
  FoListaObjetos := TObjectList.Create(True); //pc_ok

  FoItem := TfpgVincRecolMandItemGuia.Create; //pc_ok
  AdicListaObjeto(FoItem);

  AtribuirValoresDefault;
end;

procedure TfpgVincRecolMandItemGuiaTests.TearDown;
begin
  inherited;
  FreeAndNil(FoListaObjetos); //pc_ok
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarAtribuirCdForoGrj;
begin
  AtribuirValoresAlternativos;
  CheckEquals(nITEM_CDFOROGRJ_ALTERNATIVO, FoItem.fpgCdForoGrj);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarAtribuirDeTipoCusta;
begin
  AtribuirValoresAlternativos;
  CheckEqualsString(sITEM_DETIPOCUSTA_ALTERNATIVO, FoItem.fpgDeTipoCusta);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarAtribuirDtPagamento;
begin
  AtribuirValoresAlternativos;
  CheckEqualsString(ObterStrDateTime(nITEM_DTPAGAMENTO_ALTERNATIVO),
    ObterStrDateTime(FoItem.fpgDtPagamento));
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarAtribuirNmInteressado;
begin
  AtribuirValoresAlternativos;
  CheckEqualsString(sITEM_NMINTERESSADO_ALTERNATIVO, FoItem.fpgNmInteressado);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarAtribuirNuGrjEmitida;
begin
  AtribuirValoresAlternativos;
  CheckEquals(nITEM_NUGUIAEMITIDA_ALTERNATIVO, FoItem.fpgNuGrjEmitida);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoAjusteMandadoAssociado;
var
  oItemCopia: TfpgVincRecolMandItemGuia;
  oItemRecolNovo: TfpgVincRecolMandItemRecolhimento;
  oItemRecolDaGuiaCopiada: TfpgVincRecolMandItemRecolhimento;
  oListaMandadosOrig, oListaMandadosDest: TList;
begin
  oItemRecolNovo := IncluirRecolhimento;

  CriarListasMandadoOrigDestComRecol(oListaMandadosOrig, oListaMandadosDest, oItemRecolNovo);

  oItemCopia := CopiarItemGuia(oListaMandadosDest);

  oItemRecolDaGuiaCopiada := TfpgVincRecolMandItemRecolhimento(oItemCopia.fpgRecolhimento[0]);

  CheckEqualsString(ObterTextoObjeto(oItemRecolNovo.fpgMandado),
    ObterTextoObjeto(oItemRecolDaGuiaCopiada.fpgMandado));
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoCopiaCriado;
begin
  CheckTrue(CopiarItemGuia <> nil);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoPropriedadesCdForoGrj;
begin
  CheckEquals(FoItem.fpgCdForoGrj, CopiarItemGuia.fpgCdForoGrj);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoPropriedadesDeTipoCusta;
begin
  CheckEqualsString(FoItem.fpgDeTipoCusta, CopiarItemGuia.fpgDeTipoCusta);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoPropriedadesDtPagamento;
begin
  CheckEqualsString(ObterStrDateTime(FoItem.fpgDtPagamento),
    ObterStrDateTime(CopiarItemGuia.fpgDtPagamento));
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoPropriedadesNmInteressado;
begin
  CheckEqualsString(FoItem.fpgNmInteressado, CopiarItemGuia.fpgNmInteressado);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoPropriedadesNuGrjEmitida;
begin
  CheckEquals(FoItem.fpgNuGrjEmitida, CopiarItemGuia.fpgNuGrjEmitida);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarCopiarObjetoPropriedadesQtdadeRecolhimentos;
begin
  IncluirRecolhimento;
  IncluirRecolhimento;

  CheckEquals(2, CopiarItemGuia.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarDefinirInformacoesPainelChamouAtualizar;
var
  oPainel: TfpgPainelInformoItemVincGuiaRecolMandFake;
begin
  oPainel := TfpgPainelInformoItemVincGuiaRecolMandFake.Create(nil); //pc_ok
  AdicListaObjeto(oPainel);
  oPainel.FbChamouAtualizar := False;

  FoItem.AtualizarInformacoesPainel(oPainel);

  CheckTrue(oPainel.FbChamouAtualizar);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarDefinirInformacoesPainelMudouDatasetDados;
var
  sTextoPainelEsperado, sTextoOPainelObtido: string;
  oPainel: TfpgPainelInformoItemVincGuiaRecolMandFake;
  oDataSetDadosEsperado: TClientDataSet;
begin
  oPainel := TfpgPainelInformoItemVincGuiaRecolMandFake.Create(nil); //pc_ok
  AdicListaObjeto(oPainel);

  FoItem.AtualizarInformacoesPainel(oPainel);

  oDataSetDadosEsperado := CriarDadosPainelEsperados;

  sTextoPainelEsperado := ObterStringDescricaoDataSet(oDataSetDadosEsperado);
  sTextoOPainelObtido := ObterStringDescricaoDataSet(oPainel.fpgDataSetDados);

  CheckEqualsString(sTextoPainelEsperado, sTextoOPainelObtido);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarfpgCdForoGrj;
begin
  CheckEquals(nITEM_CDFOROGRJ_default, FoItem.fpgCdForoGrj);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarfpgDeTipoCusta;
begin
  CheckEqualsString(sITEM_DETIPOCUSTA_DEFAULT, FoItem.fpgDeTipoCusta);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarfpgDtPagamento;
begin
  CheckEqualsString(ObterStrDateTime(nITEM_DTPAGAMENTO_DEFAULT),
    ObterStrDateTime(FoItem.fpgDtPagamento));
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarfpgNmInteressado;
begin
  CheckEqualsString(sITEM_NMINTERESSADO_DEFAULT, FoItem.fpgNmInteressado);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarfpgNuGrjEmitida;
begin
  CheckEquals(nITEM_NUGUIAEMITIDA_DEFAULT, FoItem.fpgNuGrjEmitida);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarIncluirRecolhimento;
begin
  IncluirRecolhimento;

  CheckEquals(1, FoItem.fpgQtdadeRecolhimentos);
end;

procedure TfpgVincRecolMandItemGuiaTests.TestarPegarDescricao;
var
  sGrjformatada: string;
  sDescEsperada: string;
begin
  sGrjformatada := FormataNuGuia(FloatToStr(nITEM_NUGUIAEMITIDA_DEFAULT),
    IntToStr(nITEM_CDFOROGRJ_DEFAULT));

  sDescEsperada := Format(sMASCARA_DESCRICAO, [sGrjformatada, sITEM_NMINTERESSADO_DEFAULT]);

  CheckEqualsString(sDescEsperada, FoItem.PegarDescricao);
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

initialization

  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgVincRecolMandItemGuiaTests',
    TfpgVincRecolMandItemGuiaTests.Suite);

end.

