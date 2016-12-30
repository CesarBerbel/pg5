unit ufpgProcessoBemListTests;

interface

uses
  SysUtils, DB, uspTestCase, uspClientDataSet, ufpgProcessoBemList,
  ufpgProcessoBemListModelTests, ufpgProcessoBemItem;

type
  TfpgProcessoBemListTests = class(TspTestCase)
  private
    FoProcessoBemList: TfpgProcessoBemList;
    /// <summary>
    ///  Executa o teste AdicionarProcesso
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure ExecutarTesteAdicionarProcesso;
    /// <summary>
    ///  Executa o teste PegarItemLista
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure ExecutarTestePegarItemLista;
    /// <summary>
    ///  Executa o teste RetornarTamanho
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure ExecutarTesteRetornarTamanho;
    /// <summary>
    ///  Executa o teste RetornarListaProcessos
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure ExecutarTesteRetornarListaProcessos;
    /// <summary>
    ///  Executar o teste AtualizarBensNaoBaixados
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure ExecutarTesteAtualizarBensNaoBaixados;
    /// <summary>
    ///  M�todo padr�o para adicionar um processo na lista
    /// </summary>
    /// <param name="psCodigoProcesso">
    ///  C�digo do processo
    /// </param>
    /// <param name="psNumeroProcesso">
    ///  N�mero do processo
    /// </param>
    /// <param name="pbPossuiBemNaoBaixado">
    ///  Processo possui bem n�o baixado
    /// </param>
    /// <param name="poModel">
    ///  Model dos testes
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure AdicionarProcesso(var psCodigoProcesso, psNumeroProcesso: string;
      var pbPossuiBemNaoBaixado: boolean; var poModel: TfpgProcessoBemListModelTests);
    /// <summary>
    ///  Retorna o data de um TspClientDataSet contendo processos com bens n�o baixados
    /// </summary>
    /// <param name="psCodigoProcesso">
    ///  C�digo do processo que ser� atualizado
    /// </param>
    /// <returns>
    ///  TspClientDataSet.Data contendo os processos com bens n�o baixados
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    function PegarDadosBensNaoBaixados(const psCodigoProcesso: string): olevariant;
  protected
    /// <summary>
    ///  M�todo executado ao iniciar os testes
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure SetUp; override;
    /// <summary>
    ///  M�todo executado ao finalizar os testes
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure TearDown; override;
  published
    /// <summary>
    ///  Testa o m�todo AdicionarProcesso
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure TestarAdicionarProcesso;
    /// <summary>
    ///  Testa o m�todo PegarItemLista
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure TestarPegarItemLista;
    /// <summary>
    ///  Testa o m�todo RetornarTamanho
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure TestarRetornarTamanho;
    /// <summary>
    ///  Testa o m�todo RetornarListaProcessos
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure TestarRetornarListaProcessos;
    /// <summary>
    ///  Testa o m�todo AtualizarBensNaoBaixados
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure TestarAtualizarBensNaoBaixados;
  end;

implementation

uses
  usajConstante;

{ TfpgProcessoBemListTests }

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.SetUp;
begin
  spCarregarDadosSetUp := False;
  inherited;
  FoProcessoBemList := TfpgProcessoBemList.Create(False); //PC_OK
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.TearDown;
begin
  inherited;
  FreeAndNil(FoProcessoBemList); //PC_OK
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.AdicionarProcesso(
  var psCodigoProcesso, psNumeroProcesso: string; var pbPossuiBemNaoBaixado: boolean;
  var poModel: TfpgProcessoBemListModelTests);
begin
  poModel := TfpgProcessoBemListModelTests(FoModelTests);

  psCodigoProcesso := poModel.fpgCodigoProcesso;
  psNumeroProcesso := poModel.fpgNumeroProcesso;
  pbPossuiBemNaoBaixado := poModel.fpgPossuiBemNaoBaixado;

  FoProcessoBemList.AdicionarProcesso(psCodigoProcesso, psNumeroProcesso, pbPossuiBemNaoBaixado);
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
function TfpgProcessoBemListTests.PegarDadosBensNaoBaixados(
  const psCodigoProcesso: string): olevariant;
var
  ocdsDadosBensNaoBaixados: TspClientDataSet;
begin
  ocdsDadosBensNaoBaixados := TspClientDataSet.Create(nil);
  try
    ocdsDadosBensNaoBaixados.FieldDefs.Add('cdProcesso', ftString, 25);
    ocdsDadosBensNaoBaixados.CreateDataSet;

    ocdsDadosBensNaoBaixados.Insert;
    ocdsDadosBensNaoBaixados.FieldByName('cdProcesso').AsString := psCodigoProcesso;
    ocdsDadosBensNaoBaixados.Post;

    result := ocdsDadosBensNaoBaixados.Data;
  finally
    FreeAndNil(ocdsDadosBensNaoBaixados);
  end;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.ExecutarTesteAdicionarProcesso;
var
  oModel: TfpgProcessoBemListModelTests;
  sCodigoProcesso: string;
  sNumeroProcesso: string;
  bPossuiBemNaoBaixado: boolean;
begin
  AdicionarProcesso(sCodigoProcesso, sNumeroProcesso, bPossuiBemNaoBaixado, oModel);

  CheckTrue((FoProcessoBemList.pg5cCount > 0), 'N�o adicionou o processo na lista');
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.ExecutarTestePegarItemLista;
var
  oModel: TfpgProcessoBemListModelTests;
  ofpgProcessoBemItem: TfpgProcessoBemItem;
  sCodigoProcesso: string;
  sNumeroProcesso: string;
  bPossuiBemNaoBaixado: boolean;
begin
  ofpgProcessoBemItem := TfpgProcessoBemItem.Create;
  try
    AdicionarProcesso(sCodigoProcesso, sNumeroProcesso, bPossuiBemNaoBaixado, oModel);

    ofpgProcessoBemItem := FoProcessoBemList.PegarItemLista(oModel.fpgPosicaoLista);

    CheckTrue(sCodigoProcesso = ofpgProcessoBemItem.fpgCodigoProcesso,
      'C�digo do processo diferente do esperado');

    CheckTrue((sNumeroProcesso = ofpgProcessoBemItem.fpgNumeroProcesso),
      'N�mero do processo diferente do esperado');

    CheckTrue((bPossuiBemNaoBaixado = ofpgProcessoBemItem.fpgPossuiBemNaoBaixado),
      'Processo possui bem n�o baixado diferente do esperado');
  finally
    FreeAndNil(ofpgProcessoBemItem);
  end;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.ExecutarTesteRetornarTamanho;
var
  oModel: TfpgProcessoBemListModelTests;
  sCodigoProcesso: string;
  sNumeroProcesso: string;
  bPossuiBemNaoBaixado: boolean;
  nTamanho: integer;
begin
  AdicionarProcesso(sCodigoProcesso, sNumeroProcesso, bPossuiBemNaoBaixado, oModel);

  nTamanho := FoProcessoBemList.RetornarTamanho;

  CheckTrue((nTamanho = 1), 'N�o retornou o tamanho da lista');
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.ExecutarTesteRetornarListaProcessos;
var
  oModel: TfpgProcessoBemListModelTests;
  sCodigoProcesso: string;
  sNumeroProcesso: string;
  bPossuiBemNaoBaixado: boolean;
  sListaProcessos: string;
begin
  AdicionarProcesso(sCodigoProcesso, sNumeroProcesso, bPossuiBemNaoBaixado, oModel);

  sListaProcessos := FoProcessoBemList.RetornarListaProcessos;

  CheckTrue((sListaProcessos <> STRING_INDEFINIDO), 'N�o retornou a lista de processos');
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.ExecutarTesteAtualizarBensNaoBaixados;
var
  oModel: TfpgProcessoBemListModelTests;
  sCodigoProcesso: string;
  sNumeroProcesso: string;
  bPossuiBemNaoBaixado: boolean;
  vDadosBensNaoBaixados: olevariant;
  ofpgProcessoBemItem: TfpgProcessoBemItem;
begin
  AdicionarProcesso(sCodigoProcesso, sNumeroProcesso, bPossuiBemNaoBaixado, oModel);

  vDadosBensNaoBaixados := PegarDadosBensNaoBaixados(sCodigoProcesso);

  FoProcessoBemList.AtualizarBensNaoBaixados(vDadosBensNaoBaixados);
  ofpgProcessoBemItem := FoProcessoBemList.PegarItemLista(oModel.fpgPosicaoLista);

  CheckTrue(ofpgProcessoBemItem.fpgPossuiBemNaoBaixado, 'Item n�o foi atualizado');
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.TestarAdicionarProcesso;
begin
  ExecutarRoteiroTestes(ExecutarTesteAdicionarProcesso);
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.TestarPegarItemLista;
begin
  ExecutarRoteiroTestes(ExecutarTestePegarItemLista);
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.TestarRetornarTamanho;
begin
  ExecutarRoteiroTestes(ExecutarTesteRetornarTamanho);
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.TestarRetornarListaProcessos;
begin
  ExecutarRoteiroTestes(ExecutarTesteRetornarListaProcessos);
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgProcessoBemListTests.TestarAtualizarBensNaoBaixados;
begin
  ExecutarRoteiroTestes(ExecutarTesteAtualizarBensNaoBaixados);
end;

initialization
  TspTestCase.RegisterTestXLS('Unit�rio\PG5\Componentes\pg5Componentes\ufpgProcessoBemListTests',
    TfpgProcessoBemListTests, 'DadosProcessoBemItem', TfpgProcessoBemListModelTests);

end.

