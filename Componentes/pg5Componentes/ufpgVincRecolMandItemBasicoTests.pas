unit ufpgVincRecolMandItemBasicoTests;

interface

uses
  ufpgVincRecolMandItemBasico, ufpgPainelInformoItemVincGuiaRecolMand, DBClient, DB, TestFrameWork;

type
  //herança apra retirar montagem de controles visuais do painel
  TfpgPainelInformoItemVincGuiaRecolMandFake = class(TfpgPainelInformoItemVincGuiaRecolMand)
  private
    //apenas para os métodos fazerem algo
    FContadorFake: integer;
  protected
    procedure RemoverItens(pnQtdItensManter: integer = 0); override;
    procedure MontarItensDoDataSet; override;
    procedure AdicionarItem(const psValorRotulo, psValorInformacao: string); override;
  public
  end;

  //herdando a classe básica para quebras epedenciade um herdeiro (tem métodos abstratos)
  TfpgVincRecolMandItemBasicoFake = class(TfpgVincRecolMandItemBasico)
  protected
    function GetClass: TfpgVincRecolMandItemBasicoClass; override;
  public
    function PegarDescricao: string; override;
    procedure DefinirInformacoesPainel; override;
    //para uso na classe fake e de testes
    procedure DefinirDadosPadrao(poDataSet: TClientDataSet);
  end;

  TfpgVincRecolMandItemBasicoTests = class(TTestCase)
  private
    FoDataSetDadosInfoPainelEsperado: TClientDataSet;
    FoItem: TfpgVincRecolMandItemBasicoFake;
    FoPainelInfo: TfpgPainelInformoItemVincGuiaRecolMandFake;
    procedure DefinirStringDatasetEsperado(var psDatasetEsperado: string);
    function ObterStringDescricaoDataSet(poDataSet: TClientDataSet): string;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  public
    procedure DefinirEstruturaPadrao;
  published
    // Test methods
    procedure TestarAtualizarInformacoesPainelNomeCampoRotulo;
    procedure TestarAtualizarInformacoesPainelNomeCampoInformacao;
    procedure TestarAtualizarInformacoesPainelDasetSetado;
    procedure TestarAtualizarInformacoesPainelDasetDadosCorretos;
    procedure TestarPegarDescricao;
    procedure TestarCopiarGeradoObjeto;
    procedure TestarCopiarPainelDataset;
  end;

implementation

uses
  SysUtils;

const
  sFPGVINCRECOLMANDITEMTAMANHOCAMPOROTULO = 256;
  sFPGVINCRECOLMANDITEMTAMANHOCAMPOINFORMACAO = 1024;
  sPAINEL_VALOR = 'Valor';
  sPAINEL_CAMPO = 'Campo';
  sPAINEL_TITULO = 'Título do painel';
  sDESCRICAO_PADRA_OITEM_BASICO = 'Descrição do item básico';

procedure TfpgVincRecolMandItemBasicoTests.DefinirEstruturaPadrao;
begin
  FoDataSetDadosInfoPainelEsperado.FieldDefs.Add(sFPGVINCRECOLMANDITEMNOMECAMPOROTULO,
    ftString, sFPGVINCRECOLMANDITEMTAMANHOCAMPOROTULO, True);
  FoDataSetDadosInfoPainelEsperado.FieldDefs.Add(sFPGVINCRECOLMANDITEMNOMECAMPOINFORMACAO,
    ftString, sFPGVINCRECOLMANDITEMTAMANHOCAMPOINFORMACAO, False);
  FoDataSetDadosInfoPainelEsperado.CreateDataSet;
  FoDataSetDadosInfoPainelEsperado.EmptyDataSet;
end;

procedure TfpgVincRecolMandItemBasicoTests.DefinirStringDatasetEsperado(
  var psDatasetEsperado: string);
begin
  FoItem.DefinirDadosPadrao(FoDataSetDadosInfoPainelEsperado);
  psDatasetEsperado := ObterStringDescricaoDataSet(FoDataSetDadosInfoPainelEsperado);
end;

function TfpgVincRecolMandItemBasicoTests.ObterStringDescricaoDataSet(
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

procedure TfpgVincRecolMandItemBasicoTests.SetUp;
begin
  inherited;
  FoItem := TfpgVincRecolMandItemBasicoFake.Create; //pc_ok
  FoPainelInfo := TfpgPainelInformoItemVincGuiaRecolMandFake.Create(nil); //pc_ok
  FoDataSetDadosInfoPainelEsperado := TClientDataSet.Create(nil); //pc_ok
  DefinirEstruturaPadrao;
end;

procedure TfpgVincRecolMandItemBasicoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoDataSetDadosInfoPainelEsperado); //pc_ok
  FreeAndNil(FoPainelInfo); //pc_ok
  FreeAndNil(FoItem); //pc_ok
end;

procedure TfpgVincRecolMandItemBasicoTests.TestarAtualizarInformacoesPainelDasetDadosCorretos;
var
  sDatasetEsperado, sDatasetRecebido: string;
begin
  DefinirStringDatasetEsperado(sDatasetEsperado);

  FoItem.AtualizarInformacoesPainel(FoPainelInfo);
  sDatasetRecebido := ObterStringDescricaoDataSet(FoPainelInfo.fpgDataSetDados);

  CheckEqualsString(sDatasetEsperado, sDatasetRecebido);
end;

procedure TfpgVincRecolMandItemBasicoTests.TestarAtualizarInformacoesPainelDasetSetado;
begin
  FoItem.AtualizarInformacoesPainel(FoPainelInfo);
  CheckTrue(Assigned(FoPainelInfo.fpgDataSetDados));
end;

procedure TfpgVincRecolMandItemBasicoTests.TestarAtualizarInformacoesPainelNomeCampoInformacao;
begin
  FoItem.AtualizarInformacoesPainel(FoPainelInfo);
  CheckEqualsString(sFPGVINCRECOLMANDITEMNOMECAMPOINFORMACAO, FoPainelInfo.fpgNomeCampoInformacao);
end;

procedure TfpgVincRecolMandItemBasicoTests.TestarAtualizarInformacoesPainelNomeCampoRotulo;
begin
  FoItem.AtualizarInformacoesPainel(FoPainelInfo);
  CheckEqualsString(sFPGVINCRECOLMANDITEMNOMECAMPOROTULO, FoPainelInfo.fpgNomeCampoRotulo);
end;

procedure TfpgVincRecolMandItemBasicoTests.TestarCopiarGeradoObjeto;
var
  oItemCopia: TfpgVincRecolMandItemBasico;
begin
  oItemCopia := nil;
  oItemCopia := FoItem.Copiar;
  try
    CheckTrue(Assigned(oItemCopia));
  finally
    if Assigned(oItemCopia) then
      FreeAndNil(oItemCopia); //pc_ok
  end;
end;

procedure TfpgVincRecolMandItemBasicoTests.TestarCopiarPainelDataset;
var
  sDatasetEsperado, sDatasetRecebido: string;
  oItemCopia: TfpgVincRecolMandItemBasico;
begin
  DefinirStringDatasetEsperado(sDatasetEsperado);
  FoItem.AtualizarInformacoesPainel(FoPainelInfo);

  oItemCopia := nil;
  oItemCopia := FoItem.Copiar;
  try
    sDatasetRecebido := ObterStringDescricaoDataSet(FoPainelInfo.fpgDataSetDados);
    CheckEqualsString(sDatasetEsperado, sDatasetRecebido);
  finally
    if Assigned(oItemCopia) then
      FreeAndNil(oItemCopia); //pc_ok
  end;
end;

procedure TfpgVincRecolMandItemBasicoTests.TestarPegarDescricao;
begin
  CheckEqualsString(sDESCRICAO_PADRA_OITEM_BASICO, FoItem.PegarDescricao);
end;

{ TfpgVincRecolMandItemBasicoHerdeiro }

procedure TfpgVincRecolMandItemBasicoFake.DefinirDadosPadrao(poDataSet: TClientDataSet);
begin
  poDataSet.EmptyDataSet;

  // Título do painel
  poDataSet.Append;
  poDataSet.FieldByName(sFPGVINCRECOLMANDITEMNOMECAMPOROTULO).AsString := sPAINEL_TITULO;
  poDataSet.Post;

  poDataSet.Append;
  poDataSet.FieldByName(sFPGVINCRECOLMANDITEMNOMECAMPOROTULO).AsString := sPAINEL_CAMPO;
  poDataSet.FieldByName(sFPGVINCRECOLMANDITEMNOMECAMPOINFORMACAO).AsString := sPAINEL_VALOR;
  poDataSet.Post;
end;

procedure TfpgVincRecolMandItemBasicoFake.DefinirInformacoesPainel;
begin
  DefinirDadosPadrao(FoDataSetDadosInfoPainel);
end;

function TfpgVincRecolMandItemBasicoFake.GetClass: TfpgVincRecolMandItemBasicoClass;
begin
  result := TfpgVincRecolMandItemBasicoFake;
end;

function TfpgVincRecolMandItemBasicoFake.PegarDescricao: string;
begin
  result := sDESCRICAO_PADRA_OITEM_BASICO;
end;

{ TfpgPainelInformoItemVincGuiaRecolMandFake }

procedure TfpgPainelInformoItemVincGuiaRecolMandFake.AdicionarItem(
  const psValorRotulo, psValorInformacao: string);
begin
  //inherited;
  Inc(FContadorFake);
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
  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgVincRecolMandItemBasicoTests',
    TfpgVincRecolMandItemBasicoTests.Suite);

end.

