unit ufpgRegraBemNaoBaixadoModelTests;

interface

uses
  uspDataModelTests;

type
  TfpgRegraBemNaoBaixadoModelTests = class(TspDataModelTests)
  private
    FsCodigoCategoria: string;
    FsListaCategorias: string;
    /// <summary>
    ///  Retorna o código da categoria
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    function GetfpgCodigoCategoria: string;
    /// <summary>
    ///  Retorna a lista de categorias
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    function GetfpgListaCategorias: string;
    /// <summary>
    ///  Define o código da categoria
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure SetfpgCodigoCategoria(const Value: string);
    /// <summary>
    ///  Define a lista de categorias
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    procedure SetfpgListaCategorias(const Value: string);
  published
    /// <summary>
    ///  Código da categoria
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    property fpgCodigoCategoria: string read GetfpgCodigoCategoria write SetfpgCodigoCategoria;
    /// <summary>
    ///  Lista de categorias
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/08/2014 - rodrigo.db1 - SALT: 109652/1
    /// </remarks>
    property fpgListaCategorias: string read GetfpgListaCategorias write SetfpgListaCategorias;
  end;

implementation

{ TfpgRegraBemNaoBaixadoModelTests }

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
function TfpgRegraBemNaoBaixadoModelTests.GetfpgCodigoCategoria: string;
begin
  result := FsCodigoCategoria;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
function TfpgRegraBemNaoBaixadoModelTests.GetfpgListaCategorias: string;
begin
  result := FsListaCategorias;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgRegraBemNaoBaixadoModelTests.SetfpgCodigoCategoria(const Value: string);
begin
  FsCodigoCategoria := Value;
end;

// 28/08/2014 - rodrigo.db1 - SALT: 109652/1
procedure TfpgRegraBemNaoBaixadoModelTests.SetfpgListaCategorias(const Value: string);
begin
  FsListaCategorias := Value;
end;

end.

