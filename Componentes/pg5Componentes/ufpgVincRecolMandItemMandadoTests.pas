unit ufpgVincRecolMandItemMandadoTests;

interface

uses
  ufpgVincRecolMandItemMandado, ufpgVincRecolMandItemRecolhimento, TestFrameWork,
  contnrs, ufpgPainelInformoItemVincGuiaRecolMand, ufpgVincRecolMandItemBasico,
  DBClient, usajConstante, Classes;

type
  TfpgVincRecolMandItemMandadoTests = class(TTestCase)
  private
    FoListaObjetos: TObjectList;
    FoItem: TfpgVincRecolMandItemMandado;
    procedure AdicListaObjeto(poObj: TObject);

    procedure AppendStringList(poDataset: TClientDataSet; const psValores: string);
    procedure AtribuirDadosDefault;
    procedure AtribuirDadosAlternativos(const psNuMandado: string;
      const pnNuSeqdistribuicao: integer);
    procedure AtribuirDadosMandEmElaboracao;
    function CopiarObjetoMand: TfpgVincRecolMandItemMandado;
    function CriarDadosPainelEsperados: TClientDataSet;
    function ObterDescricaoNuMandadoEsperada: string;
    function ObterTextDefaultMand: string;
    function ObterTextoObjeto(poItemMandado: TfpgVincRecolMandItemMandado): string; overload;
    function ObterStrDateTime(const pdtValor: TDateTime;
      const psFormatString: string = 'dd/mm/yyyy hh:mm:ss:zzz'): string;
    function ObterStringDescricaoDataSet(poDataSet: TClientDataSet): string;
    procedure ObterTextosPainelInformacao(out psTextoPainelEsperado, psTextoOPainelObtido: string);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Test methods
    procedure TestarAtribuir;
    procedure TestarPegarDescricaoEmElaboracao;
    procedure TestarPegarDescricaoComNuMandado;
    procedure TestarCopiar;
    procedure TestarfpgEmElaboracao;
    procedure TestarfpgDtDistribuicao;
    procedure TestarfpgDtEmissao;
    procedure TestarfpgNuSeqDistMandado;
    procedure TestarfpgCdMandado;
    procedure TestarfpgDeFormaPgto;
    procedure TestarfpgDeSituacaoMand;
    procedure TestarfpgDtUsuVincValor;
    procedure TestarfpgNmAgente;
    procedure TestarfpgNuMandado;
    procedure TestarfpgFlCumpridoOficial;
    procedure TestarfpgDtRecebPelaCM;
    procedure TestarfpgCdSituacaoMand;

    procedure TestarDefinirInformacoesPainelChamouAtualizar;
    procedure TestarDefinirInformacoesPainelMudouDatasetDadosMandadoInformadoEdistribuido;
    procedure TestarDefinirInformacoesPainelMudouDatasetDadosMandadoNaoInformadoNaoDistribuido;
    procedure TestarDefinirInformacoesPainelMudouDatasetDadosMandadoNaoDistribuido;
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

{ TfpgVincRecolMandItemMandadoTests }

uses
  SysUtils, usmdFuncoes, DB;

const
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

  sSEP_PROP_TXT = ', ';

  sMASCARA_STR_CORPO_MANDADO = 'integer(fpgEmElaboracao):%s' + sSEP_PROP_TXT +
    'fpgNuSeqDistMandado:%s' + sSEP_PROP_TXT + 'fpgCdSituacaoMand:%s' + sSEP_PROP_TXT +
    'fpgDtUsuVincValor:%s' + sSEP_PROP_TXT + 'fpgNuMandado:%s' + sSEP_PROP_TXT +
    'fpgDeFormaPgto:%s' + sSEP_PROP_TXT + 'fpgDtDistribuicao:%s' + sSEP_PROP_TXT +
    'fpgDtEmissao:%s' + sSEP_PROP_TXT + 'fpgDtRecebPelaCM:%s' + sSEP_PROP_TXT +
    'fpgCdMandado:%s' + sSEP_PROP_TXT + 'fpgDeSituacaoMand:%s' + sSEP_PROP_TXT +
    'fpgNmAgente:%s' + sSEP_PROP_TXT + 'fpgFlCumpridoOficial:%s' + sSEP_PROP_TXT +
    'fpgQtdadeRecolhimentosVinculados:%s' + sSEP_PROP_TXT + 'fpgQtdadeRecolhimentos:%s';

  sCAB_MANDADO = 'TfpgVincRecolMandItemMandado{' + #13#10;
  sFIM_MANDADO = #13#10 + '}';

  sMASCARA_STR_COMPLETA_MANDADO = sCAB_MANDADO + sMASCARA_STR_CORPO_MANDADO +
    sFIM_MANDADO;

procedure TfpgVincRecolMandItemMandadoTests.AdicListaObjeto(poObj: TObject);
begin
  if not Assigned(poObj) then
    Exit;
  FoListaObjetos.Add(poObj);
end;

procedure TfpgVincRecolMandItemMandadoTests.AppendStringList(poDataset:
  TClientDataSet; const psValores: string);
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

procedure TfpgVincRecolMandItemMandadoTests.AtribuirDadosAlternativos(
  const psNuMandado: string; const pnNuSeqdistribuicao: integer);
begin
  FoItem.Atribuir(bITEMMAND_EMELABORACAO_DEFAULT, pnNuSeqdistribuicao,
    nITEMMAND_CDSITUACAOMAND_DEFAULT, nITEMMAND_DTUSUVINCVALOR_DEFAULT,
    psNuMandado, sITEMMAND_DEFORMAPGTO_DEFAULT, nITEMMAND_DTDISTRIBUICAO_DEFAULT,
    nITEMMAND_DTEMISSAO_DEFAULT, nITEMMAND_DTRECEBPELACM_DEFAULT, sITEMMAND_CDMANDADO_DEFAULT,
    sITEMMAND_DESITUACAOMAND_DEFAULT, sITEMMAND_NMAGENTE_DEFAULT,
    sITEMMAND_FLCUMPRIDOOFICIAL_DEFAULT);
end;

procedure TfpgVincRecolMandItemMandadoTests.AtribuirDadosDefault;
begin
  FoItem.Atribuir(bITEMMAND_EMELABORACAO_DEFAULT, nITEMMAND_NUSEQDISTMANDADO_DEFAULT,
    nITEMMAND_CDSITUACAOMAND_DEFAULT, nITEMMAND_DTUSUVINCVALOR_DEFAULT,
    sITEMMAND_NUMANDADO_DEFAULT, sITEMMAND_DEFORMAPGTO_DEFAULT, nITEMMAND_DTDISTRIBUICAO_DEFAULT,
    nITEMMAND_DTEMISSAO_DEFAULT, nITEMMAND_DTRECEBPELACM_DEFAULT, sITEMMAND_CDMANDADO_DEFAULT,
    sITEMMAND_DESITUACAOMAND_DEFAULT, sITEMMAND_NMAGENTE_DEFAULT,
    sITEMMAND_FLCUMPRIDOOFICIAL_DEFAULT);
end;

procedure TfpgVincRecolMandItemMandadoTests.AtribuirDadosMandEmElaboracao;
begin
  FoItem.Atribuir(True, nITEMMAND_NUSEQDISTMANDADO_DEFAULT,
    nITEMMAND_CDSITUACAOMAND_DEFAULT, nITEMMAND_DTUSUVINCVALOR_DEFAULT,
    sITEMMAND_NUMANDADO_DEFAULT, sITEMMAND_DEFORMAPGTO_DEFAULT, nITEMMAND_DTDISTRIBUICAO_DEFAULT,
    nITEMMAND_DTEMISSAO_DEFAULT, nITEMMAND_DTRECEBPELACM_DEFAULT, sITEMMAND_CDMANDADO_DEFAULT,
    sITEMMAND_DESITUACAOMAND_DEFAULT, sITEMMAND_NMAGENTE_DEFAULT,
    sITEMMAND_FLCUMPRIDOOFICIAL_DEFAULT);
end;

function TfpgVincRecolMandItemMandadoTests.CopiarObjetoMand: TfpgVincRecolMandItemMandado;
begin
  result := TfpgVincRecolMandItemMandado(FoItem.Copiar(False));
  AdicListaObjeto(result);
end;

function TfpgVincRecolMandItemMandadoTests.CriarDadosPainelEsperados: TClientDataSet;
var
  sMandado: string;
  sDistribuicao: string;
  sOficial: string;
begin
  result := TClientDataSet.Create(nil); //PC_OK
  AdicListaObjeto(result);

  result.FieldDefs.Add(sFPGVINCRECOLMANDITEMNOMECAMPOROTULO, ftString, 256, True);
  result.FieldDefs.Add(sFPGVINCRECOLMANDITEMNOMECAMPOINFORMACAO, ftString, 1024);
  result.CreateDataSet;
  result.Active := True;

  if FoItem.fpgNuMandado = STRING_INDEFINIDO then
    sMandado := 'Mandado '
  else
    sMandado := 'Mandado ' + NumeroMandadoFormatado(FoItem.fpgNuMandado);

  sDistribuicao := STRING_INDEFINIDO;
  sOficial := STRING_INDEFINIDO;

  if FoItem.fpgNuSeqDistMandado <> NUMERO_INDEFINIDO then
  begin
    sDistribuicao := ObterStrDateTime(nITEMMAND_DTDISTRIBUICAO_DEFAULT, 'dd/mm/yyyy') + ' (Seq ' +
      IntToStr(FoItem.fpgNuSeqDistMandado) + ')';
    sOficial := FoItem.fpgNmAgente;
  end;

  //seguem registro do dataset
  AppendStringList(result, '"' + sMandado + '",""');
  AppendStringList(result, 'Situação,"' + sITEMMAND_DESITUACAOMAND_DEFAULT + '"');
  AppendStringList(result, 'Emissão,"' + ObterStrDateTime(FoItem.fpgDtEmissao,
    'dd/mm/yyyy') + '"');
  AppendStringList(result, '"Forma de pagamento","' + sITEMMAND_DEFORMAPGTO_DEFAULT + '"');
  AppendStringList(result, 'Distribuição,"' + sDistribuicao + '"');
  AppendStringList(result, 'Oficial,"' + sOficial + '"');
end;

function TfpgVincRecolMandItemMandadoTests.ObterDescricaoNuMandadoEsperada:
string;
begin
  result := NumeroMandadoFormatado(sITEMMAND_NUMANDADO_DEFAULT);
end;

function TfpgVincRecolMandItemMandadoTests.ObterStrDateTime(
  const pdtValor: TDateTime; const psFormatString: string): string;
begin
  if pdtValor = 0.0 then
    result := STRING_INDEFINIDO
  else
    result := FormatDateTime(psFormatString, pdtValor);
end;

function TfpgVincRecolMandItemMandadoTests.ObterStringDescricaoDataSet(
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
    result := result + '<RecordCount>' + IntToStr(poDataSet.RecordCount) + '</RecordCount>';

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

function TfpgVincRecolMandItemMandadoTests.ObterTextDefaultMand: string;
begin
  //jcf:format=off
  Result :=
    Format(sMASCARA_STR_COMPLETA_MANDADO, [
    IntToStr(Integer(bITEMMAND_EMELABORACAO_DEFAULT)),
    IntToStr(nITEMMAND_NUSEQDISTMANDADO_DEFAULT),
    IntToStr(nITEMMAND_CDSITUACAOMAND_DEFAULT),
    ObterStrDateTime(nITEMMAND_DTUSUVINCVALOR_DEFAULT),
    sITEMMAND_NUMANDADO_DEFAULT,
    sITEMMAND_DEFORMAPGTO_DEFAULT,
    ObterStrDateTime(nITEMMAND_DTDISTRIBUICAO_DEFAULT),
    ObterStrDateTime(nITEMMAND_DTEMISSAO_DEFAULT),
    ObterStrDateTime(nITEMMAND_DTRECEBPELACM_DEFAULT),
    sITEMMAND_CDMANDADO_DEFAULT,
    sITEMMAND_DESITUACAOMAND_DEFAULT,
    sITEMMAND_NMAGENTE_DEFAULT,
    sITEMMAND_FLCUMPRIDOOFICIAL_DEFAULT,
    '0','0']);
  //jcf:format=on
end;

function TfpgVincRecolMandItemMandadoTests.ObterTextoObjeto(
  poItemMandado: TfpgVincRecolMandItemMandado): string;
begin
  if not Assigned(poItemMandado) then
  begin
    result := sCAB_MANDADO + 'nil' + sFIM_MANDADO;
    Exit;
  end;

  //jcf:format=off
  Result :=
    Format(sMASCARA_STR_COMPLETA_MANDADO, [
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
end;

procedure TfpgVincRecolMandItemMandadoTests.ObterTextosPainelInformacao(out
  psTextoPainelEsperado, psTextoOPainelObtido: string);
var
  oPainel: TfpgPainelInformoItemVincGuiaRecolMandFake;
  oDataSetDadosEsperado: TClientDataSet;
begin
  oPainel := TfpgPainelInformoItemVincGuiaRecolMandFake.Create(nil); //pc_ok
  AdicListaObjeto(oPainel);

  FoItem.AtualizarInformacoesPainel(oPainel);

  oDataSetDadosEsperado := CriarDadosPainelEsperados;

  psTextoPainelEsperado := ObterStringDescricaoDataSet(oDataSetDadosEsperado);
  psTextoOPainelObtido := ObterStringDescricaoDataSet(oPainel.fpgDataSetDados);
end;

procedure TfpgVincRecolMandItemMandadoTests.SetUp;
begin
  inherited;
  FoListaObjetos := TObjectList.Create(True); //PC_OK
  FoItem := TfpgVincRecolMandItemMandado.Create; //PC_OK
  AdicListaObjeto(FoItem);
  AtribuirDadosDefault;
end;

procedure TfpgVincRecolMandItemMandadoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoListaObjetos); //PC_OK
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarAtribuir;
begin
  CheckEqualsString(ObterTextDefaultMand, ObterTextoObjeto(FoItem));
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarCopiar;
begin
  CheckEqualsString(ObterTextoObjeto(FoItem), ObterTextoObjeto(CopiarObjetoMand));
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarDefinirInformacoesPainelChamouAtualizar;
var
  oPainel: TfpgPainelInformoItemVincGuiaRecolMandFake;
begin
  oPainel := TfpgPainelInformoItemVincGuiaRecolMandFake.Create(nil); //pc_ok
  AdicListaObjeto(oPainel);
  oPainel.FbChamouAtualizar := False;

  FoItem.AtualizarInformacoesPainel(oPainel);

  CheckTrue(oPainel.FbChamouAtualizar);
end;

procedure TfpgVincRecolMandItemMandadoTests.
TestarDefinirInformacoesPainelMudouDatasetDadosMandadoInformadoEdistribuido;
var
  sTextoPainelEsperado: string;
  sTextoOPainelObtido: string;
begin
  ObterTextosPainelInformacao(sTextoPainelEsperado, sTextoOPainelObtido);
  CheckEqualsString(sTextoPainelEsperado, sTextoOPainelObtido);
end;

procedure TfpgVincRecolMandItemMandadoTests.
TestarDefinirInformacoesPainelMudouDatasetDadosMandadoNaoDistribuido;
var
  sTextoPainelEsperado: string;
  sTextoOPainelObtido: string;
begin
  AtribuirDadosAlternativos(FoItem.fpgNuMandado, NUMERO_INDEFINIDO);

  ObterTextosPainelInformacao(sTextoPainelEsperado, sTextoOPainelObtido);
  CheckEqualsString(sTextoPainelEsperado, sTextoOPainelObtido);
end;

procedure TfpgVincRecolMandItemMandadoTests.
TestarDefinirInformacoesPainelMudouDatasetDadosMandadoNaoInformadoNaoDistribuido;
var
  sTextoPainelEsperado: string;
  sTextoOPainelObtido: string;
begin
  AtribuirDadosAlternativos(STRING_INDEFINIDO, NUMERO_INDEFINIDO);

  ObterTextosPainelInformacao(sTextoPainelEsperado, sTextoOPainelObtido);
  CheckEqualsString(sTextoPainelEsperado, sTextoOPainelObtido);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgCdMandado;
begin
  CheckEqualsString(sITEMMAND_CDMANDADO_DEFAULT, FoItem.fpgCdMandado);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgCdSituacaoMand;
begin
  CheckEquals(nITEMMAND_CDSITUACAOMAND_DEFAULT, FoItem.fpgCdSituacaoMand);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgDeFormaPgto;
begin
  CheckEqualsString(sITEMMAND_DEFORMAPGTO_DEFAULT, FoItem.fpgDeFormaPgto);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgDeSituacaoMand;
begin
  CheckEqualsString(sITEMMAND_DESITUACAOMAND_DEFAULT, FoItem.fpgDeSituacaoMand);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgDtDistribuicao;
begin
  CheckEqualsString(ObterStrDateTime(nITEMMAND_DTDISTRIBUICAO_DEFAULT),
    ObterStrDateTime(FoItem.fpgDtDistribuicao));
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgDtEmissao;
begin
  CheckEqualsString(ObterStrDateTime(nITEMMAND_DTEMISSAO_DEFAULT),
    ObterStrDateTime(FoItem.fpgDtEmissao));
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgDtRecebPelaCM;
begin
  CheckEqualsString(ObterStrDateTime(nITEMMAND_DTRECEBPELACM_DEFAULT),
    ObterStrDateTime(FoItem.fpgDtRecebPelaCM));
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgDtUsuVincValor;
begin
  CheckEqualsString(ObterStrDateTime(nITEMMAND_DTUSUVINCVALOR_DEFAULT),
    ObterStrDateTime(FoItem.fpgDtUsuVincValor));
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgEmElaboracao;
begin
  CheckEquals(bITEMMAND_EMELABORACAO_DEFAULT, FoItem.fpgEmElaboracao);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgFlCumpridoOficial;
begin
  CheckEqualsString(sITEMMAND_FLCUMPRIDOOFICIAL_DEFAULT, FoItem.fpgFlCumpridoOficial);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgNmAgente;
begin
  CheckEqualsString(sITEMMAND_NMAGENTE_DEFAULT, FoItem.fpgNmAgente);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgNuMandado;
begin
  CheckEqualsString(sITEMMAND_NUMANDADO_DEFAULT, FoItem.fpgNuMandado);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarfpgNuSeqDistMandado;
begin
  CheckEquals(nITEMMAND_NUSEQDISTMANDADO_DEFAULT, FoItem.fpgNuSeqDistMandado);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarPegarDescricaoComNuMandado;
begin
  CheckEqualsString(ObterDescricaoNuMandadoEsperada, FoItem.PegarDescricao);
end;

procedure TfpgVincRecolMandItemMandadoTests.TestarPegarDescricaoEmElaboracao;
begin
  AtribuirDadosMandEmElaboracao;
  CheckEqualsString(sDESC_ITEMMAND_EMELABORACAO, FoItem.PegarDescricao);
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
  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgVincRecolMandItemMandadoTests',
    TfpgVincRecolMandItemMandadoTests.Suite);

end.

