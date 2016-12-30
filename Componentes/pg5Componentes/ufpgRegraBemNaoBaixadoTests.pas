unit ufpgRegraBemNaoBaixadoTests;

interface

uses
  SysUtils, uspTestCase, ufpgRegraBemNaoBaixado, ufpgRegraBemNaoBaixadoModelTests;

type
  TfpgRegraBemNaoBaixadoTests = class(TspTestCase)
  private
    FoRegraBemNaoBaixado: TfpgRegraBemNaoBaixado;
    /// <summary>
    ///  Executa o teste VerificarCategoriaEmiteAviso
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure ExecutarTesteVerificarCategoriaEmiteAviso;
    /// <summary>
    ///  Método padrão para adicionar categorias
    /// </summary>
    /// <param name="psCodigoCategoria">
    ///  Código da categoria
    /// </param>
    /// <param name="psListaCategorias">
    ///  Lista de categorias para comparação
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
    procedure AdicionarCategoria(var psCodigoCategoria, psListaCategorias: string;
      var poModel: TfpgRegraBemNaoBaixadoModelTests);
  protected
    /// <summary>
    ///  Método executado ao iniciar os testes
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
    ///  Método executado ao finalizar os testes
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
    ///  Testa o método VerificarCategoriaEmiteAviso
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure TestarVerificarCategoriaEmiteAviso;
  end;

implementation

{ TfpgRegraBemNaoBaixadoTests }

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgRegraBemNaoBaixadoTests.SetUp;
begin
  spCarregarDadosSetUp := False;
  inherited;
  FoRegraBemNaoBaixado := TfpgRegraBemNaoBaixado.Create; //PC_OK
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgRegraBemNaoBaixadoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoRegraBemNaoBaixado); //PC_OK
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgRegraBemNaoBaixadoTests.ExecutarTesteVerificarCategoriaEmiteAviso;
var
  oModel: TfpgRegraBemNaoBaixadoModelTests;
  sCodigoCategoria: string;
  sListaCategorias: string;
  bCategoriaEmiteAviso: boolean;
begin
  AdicionarCategoria(sCodigoCategoria, sListaCategorias, oModel);

  bCategoriaEmiteAviso := FoRegraBemNaoBaixado.VerificarCategoriaEmiteAviso(
    sCodigoCategoria, sListaCategorias);

  CheckTrue(bCategoriaEmiteAviso, 'A categoria informada não emite aviso');
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgRegraBemNaoBaixadoTests.AdicionarCategoria(
  var psCodigoCategoria, psListaCategorias: string; var poModel: TfpgRegraBemNaoBaixadoModelTests);
begin
  poModel := TfpgRegraBemNaoBaixadoModelTests(FoModelTests);

  psCodigoCategoria := poModel.fpgCodigoCategoria;
  psListaCategorias := poModel.fpgListaCategorias;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgRegraBemNaoBaixadoTests.TestarVerificarCategoriaEmiteAviso;
begin
  ExecutarRoteiroTestes(ExecutarTesteVerificarCategoriaEmiteAviso);
end;

initialization
  TspTestCase.RegisterTestXLS(
    'Unitário\PG5\Componentes\pg5Componentes\ufpgRegraBemNaoBaixadoTests',
    TfpgRegraBemNaoBaixadoTests, 'DadosRegraBemNaoBaixado', TfpgRegraBemNaoBaixadoModelTests);

end.

