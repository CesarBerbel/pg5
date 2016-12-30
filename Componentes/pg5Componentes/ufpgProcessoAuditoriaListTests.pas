unit ufpgProcessoAuditoriaListTests;

interface

uses
  uspTestCase, ufpgProcessoAuditoriaList, ufpgProcessoAuditoriaListModelTests,
  SysUtils, ufpgProcessoAuditoriaItem;

type
  TfpgProcessoAuditoriaListTests = class(TspTestCase)
  private
    FofpgProcessoAuditoriaList: TfpgProcessoAuditoriaList;
    /// <summary>
    ///  Executa método adicionar processo na lista
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure ExecutarTesteAdicionarProcessoLista;
    /// <summary>
    ///  Executa teste pegar item da lista
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure ExecutarTestePegarItemLista;
    /// <summary>
    ///  Executa teste retorna tamanho da lista
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure ExecutarTesteRetornarTamanho;
    /// <summary>
    ///  Executa teste retornar lista de processos
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure ExecutarTesteRetornarListaProcessos;
    /// <summary>
    ///  Método padrão para adicionar processo na lista
    /// </summary>
    /// <param name="pscdProcesso">
    /// </param>
    /// <param name="pnqtEtiquetasImpressa">
    /// </param>
    /// <param name="poModel">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure AdicionarProcessoNaLista(var pscdProcesso: string;
      var pnqtEtiquetasImpressa: integer; var poModel: TfpgProcessoAuditoriaListModelTests);
  protected
    /// <summary>
    ///  Método executado ao criar teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure SetUp; override;
    /// <summary>
    ///  Método executado quando finaliza os testes
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure TearDown; override;
  published
    /// <summary>
    ///  Testar método que adiciona processo na lista
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure TestarAdicionarProcessoLista;
    /// <summary>
    ///  Testar método que retorna item da lista de processos
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure TestarPegarItemLista;
    /// <summary>
    ///  Testa método que retorna tamanho da lista
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure TestarRetornarTamanho;
    /// <summary>
    ///  Testa método retorna lista de processos
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 27/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure TestarRetornarListaProcessos;

  end;

implementation

uses
  usajConstante;

{ TfpgProcessoAuditoriaListTests }

// 26/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.TestarAdicionarProcessoLista;
begin
  ExecutarRoteiroTestes(ExecutarTesteAdicionarProcessoLista);
end;

// 27/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.TestarPegarItemLista;
begin
  ExecutarRoteiroTestes(ExecutarTestePegarItemLista);
end;

// 27/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.TestarRetornarTamanho;
begin
  ExecutarRoteiroTestes(ExecutarTesteRetornarTamanho);
end;

// 27/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.TestarRetornarListaProcessos;
begin
  ExecutarRoteiroTestes(ExecutarTesteRetornarListaProcessos);
end;

// 26/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.AdicionarProcessoNaLista(var pscdProcesso: string;
  var pnqtEtiquetasImpressa: integer; var poModel: TfpgProcessoAuditoriaListModelTests);
begin
  poModel := TfpgProcessoAuditoriaListModelTests(FoModelTests);

  pscdProcesso := poModel.fpgcdProcesso;
  pnqtEtiquetasImpressa := poModel.fpgQtdeEtiquetas;

  FofpgProcessoAuditoriaList.AdicionarProcesso(pscdProcesso, pnqtEtiquetasImpressa);
end;

// 27/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.ExecutarTesteAdicionarProcessoLista;
var
  oModel: TfpgProcessoAuditoriaListModelTests;
  scdProcesso: string;
  nqtEtiquetasImpressa: integer;
begin
  AdicionarProcessoNaLista(scdProcesso, nqtEtiquetasImpressa, oModel);

  CheckTrue((FofpgProcessoAuditoriaList.pg5cCount > 0), 'Não adicionou processo na lista');
end;

// 26/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.ExecutarTestePegarItemLista;
var
  oModel: TfpgProcessoAuditoriaListModelTests;
  scdProcesso: string;
  nqtEtiquetasImpressa: integer;
  ofpgProcessoAuditoriaItem: TfpgProcessoAuditoriaItem;
begin
  ofpgProcessoAuditoriaItem := TfpgProcessoAuditoriaItem.Create;
  try
    AdicionarProcessoNaLista(scdProcesso, nqtEtiquetasImpressa, oModel);

    ofpgProcessoAuditoriaItem := FofpgProcessoAuditoriaList.PegarItemLista(oModel.fpgPosicaoLista);

    CheckTrue(scdProcesso = ofpgProcessoAuditoriaItem.fpgCodigoProcesso,
      'Processo diferente do esperado!');

    CheckTrue((nqtEtiquetasImpressa = ofpgProcessoAuditoriaItem.fpgQtdeImpressao),
      'Quantidade diferente da esperada!');
  finally
    FreeAndNil(ofpgProcessoAuditoriaItem);
  end;
end;

// 27/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.ExecutarTesteRetornarTamanho;
var
  oModel: TfpgProcessoAuditoriaListModelTests;
  scdProcesso: string;
  nqtEtiquetasImpressa: integer;
  nTamanhoLista: integer;
begin
  AdicionarProcessoNaLista(scdProcesso, nqtEtiquetasImpressa, oModel);

  nTamanhoLista := FofpgProcessoAuditoriaList.RetornarTamanho;

  CheckTrue((nTamanhoLista = 1), 'Não retornou tamanho da lista');
end;

// 27/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.SetUp;
begin
  spCarregarDadosSetUp := False;
  inherited;
  FofpgProcessoAuditoriaList := TfpgProcessoAuditoriaList.Create(False); //PC_OK
end;

// 26/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.TearDown;
begin
  inherited;
  FreeAndNil(FofpgProcessoAuditoriaList); //PC_OK
end;

// 27/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListTests.ExecutarTesteRetornarListaProcessos;
var
  oModel: TfpgProcessoAuditoriaListModelTests;
  scdProcesso: string;
  nqtEtiquetasImpressa: integer;
  sListaProcessos: string;
begin
  AdicionarProcessoNaLista(scdProcesso, nqtEtiquetasImpressa, oModel);

  sListaProcessos := FofpgProcessoAuditoriaList.RetornarListaProcessos;

  CheckTrue((sListaProcessos <> STRING_INDEFINIDO), 'Não retornou valor na lista de processo');
end;

initialization
  TspTestCase.RegisterTestXLS('Unitário\PG5\Componentes\pg5Componentes\ufpgProcessoAuditoriaListTests', TfpgProcessoAuditoriaListTests,
    'DadosPegarProcessos', TfpgProcessoAuditoriaListModelTests);

end.

